import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greaticker/common/component/modal/image_with_confetti_animation_modal.dart';
import 'package:greaticker/common/component/modal/one_text_input_modal.dart';
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/component/modal/yes_no_modal.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/language/stickers.dart';
import 'package:greaticker/common/constants/params.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/utils/url_builder_utils.dart';
import 'package:greaticker/home/constants/project.dart';
import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:greaticker/home/model/got_sticker_model.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/model/request_dto/project_request_dto.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';
import 'package:greaticker/home/provider/project_api_response_provider.dart';
import 'package:greaticker/home/provider/project_provider.dart';
import 'package:greaticker/home/utils/got_sticker_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeView<T> extends ConsumerStatefulWidget {
  final StateNotifierProvider<ProjectStateNotifier,
      ProjectModelBase> projectProvider;
  final StateNotifierProvider<GotStickerStateNotifier,
      GotStickerModelBase> gotStickerProvider;
  final String? showPopUp;

  const HomeView({
    Key? key,
    required this.projectProvider,
    required this.gotStickerProvider,
    this.showPopUp,
  }) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState<T>();
}

class _HomeViewState<T> extends ConsumerState<HomeView>
    with SingleTickerProviderStateMixin {
  bool _isCalendarVisible = false;

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(widget.projectProvider);

    // 완전 처음 로딩일때
    if (projectState is ProjectModelLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (projectState is ProjectModelError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            projectState.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.projectProvider.notifier).getProjectModel();
            },
            child: Text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!),
          ),
        ],
      );
    }

    projectState as ProjectModel;

    //to be revised
    if (projectState.projectStateKind == ProjectStateKind.RESET) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showOnlyCloseDialog(
            context: context,
            comment:
            COMMENT_DICT[dotenv.get(LANGUAGE)]!['reset_project_notice']!);
      });
    }

    if (widget.showPopUp == LOG_OUT_COMPLETE ||
        widget.showPopUp == DELETE_ACCOUNT_COMPLETE) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showOnlyCloseDialog(
          context: context,
          comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
          widget.showPopUp == LOG_OUT_COMPLETE
              ? 'log_out_complete'
              : 'delete_account_complete']!,
        );
        context.go("/home");
      });
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          primary: false,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isCalendarVisible = !_isCalendarVisible;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.black,
                    ),
                    Text(
                      _isCalendarVisible
                          ? BUTTON_DICT[dotenv.get(LANGUAGE)]!['hide_calendar']!
                          : BUTTON_DICT[dotenv.get(LANGUAGE)]![
                      'show_calendar']!,
                      style: YeongdeokSeaTextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              // 달력 위젯, 조건에 따라 보여주기/숨기기
              _isCalendarVisible
                  ? _TableClanderForHomeView(
                startDay: projectState.startDay!,
                dayInARow: projectState.dayInARow!,
              )
                  : Container(),
              Text(
                projectState.projectName ??
                    COMMENT_DICT[dotenv.get(LANGUAGE)]!['no_goal_set']!,
                style: YeongdeokSeaTextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: projectState.dayInARow! / COMPLETE_DAY_CNT,
                        minHeight: 10,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${(projectState.dayInARow! / COMPLETE_DAY_CNT * 30)
                          .round()}/${COMPLETE_DAY_CNT}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              _showOrHideGotStickerButton(projectState),
              _showAppropriateProjectActionButton(projectState),
              _showRegisterHallOfFameButton(projectState),
            ],
          ),
        ),
      ),
    );
  }

  Column _showOrHideGotStickerButton(ProjectModel projectState) {
    if (projectState.projectStateKind == ProjectStateKind.IN_PROGRESS) {
      return Column(
        children: [
          SizedBox(height: 20),
          // 첫 번째 ElevatedButton
          _buildGotStickerButton(projectState),
        ],
      );
    } else {
      return Column(
        children: [],
      );
    }
  }

  Column _showAppropriateProjectActionButton(ProjectModel projectState) {
    if (projectState.projectStateKind == ProjectStateKind.IN_PROGRESS) {
      return Column(
        children: [
          SizedBox(height: 5),
          // 두 번째 ElevatedButton
          _buildDeleteProjectButton(projectState),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 20),
          // 두 번째 ElevatedButton
          _buildCreateProjectButton(projectState),
        ],
      );
    }
  }

  Widget _showRegisterHallOfFameButton(ProjectModel projectState) {
    if (projectState.projectStateKind == ProjectStateKind.COMPLETED) {
      return Column(
        children: [
          SizedBox(height: 5),
          // 두 번째 ElevatedButton
          _buildRegisterHallOfFameButton(projectState),
        ],
      );
    } else {
      return Container();
    }
  }

  ElevatedButton _buildGotStickerButton(ProjectModel projectState) {
    return ElevatedButton(
      onPressed: () async {
        await ref.read(widget.gotStickerProvider.notifier).getGotStickerModel();

        GotStickerModelBase gotStickerState = ref.read(
            widget.gotStickerProvider);
        gotStickerState as GotStickerModel;

        if (gotStickerState.isAlreadyGotTodaySticker == false) {
          await showImageWithConfettiAnimationDialog(
            context: context,
            comment: GotStickerUtils.gotStickerComment(projectState,
                STICKER_ID_STICKER_INFO_MAPPER[dotenv.get(
                    LANGUAGE)]![gotStickerState.id]!['name']!),
            imagePath: UrlBuilderUtils.imageUrlBuilderByStickerId(
                gotStickerState.id),
          );
          plusOneDayInARow(projectState);

          if (projectState.dayInARow == COMPLETE_DAY_CNT - 1) {
            updateProjectStateAsCompleted(projectState);
          }
        } else {
          await showOnlyCloseDialog(context: context,
              comment: COMMENT_DICT[dotenv.get(
                  LANGUAGE)]!['today_sticker_already_got']!);
        }
      },
      child: Text(
        BUTTON_DICT[dotenv.get(LANGUAGE)]!['get_sticker']!,
        style: YeongdeokSeaTextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(240, 30), // 너비 200, 높이 60
      ),
    );
  }

  void updateProjectStateAsCompleted(ProjectModel projectState) {
    ref.read(widget.projectProvider.notifier).updateProjectState(
      projectState.copyWith(
          projectStateKind: ProjectStateKind.COMPLETED,
          dayInARow: 30),
    );
    showOnlyCloseDialog(
        context: context,
        comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
        'complete_project_notice']!);
  }

  void plusOneDayInARow(ProjectModel projectState) {
    ref
        .read(widget.projectProvider.notifier)
        .updateProjectState(projectState.copyWith(
      dayInARow: projectState.dayInARow! + 1,
    ));
  }

  ElevatedButton _buildCreateProjectButton(ProjectModel projectState) {
    return ElevatedButton(
      onPressed: () {
        if (projectState.projectStateKind == ProjectStateKind.COMPLETED) {
          showYesNoDialog(
            context: context,
            comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
            'create_project_sticker_loss_notice']!,
            onYes: () async {
              showCreateProjectTextInputDialog(projectState);
            },
          );
        } else if (projectState.projectStateKind == ProjectStateKind.NO_EXIST) {
          showCreateProjectTextInputDialog(projectState);
        }
      },
      child: Text(
        BUTTON_DICT[dotenv.get(LANGUAGE)]!['create_project']!,
        style: YeongdeokSeaTextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(240, 30), // 너비 200, 높이 60
      ),
    );
  }

  Future<void> showCreateProjectTextInputDialog(ProjectModel projectState) {
    return showOneTextInputDialog(
        context: context,
        comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['create_project_try']!,
        onSubmitted: (s) async {
          ProjectRequestDto projectRequestDto = ProjectRequestDto(
              prevProjectState: ProjectStateKind.NO_EXIST,
              nextProjectState: ProjectStateKind.IN_PROGRESS);
          await ref
              .read(projectApiResponseProvider.notifier)
              .updateProjectState(projectRequestDto: projectRequestDto);
          //아래는 임시적 프론트 엔드 테스트를 위한 코드일 뿐 백엔드까지 구현된 이후 아래 코드들은 반드시 삭제되야 한다. ToBeDeleted"
          ref.read(widget.projectProvider.notifier).updateProjectState(
            projectState.copyWith(
                projectStateKind: ProjectStateKind.IN_PROGRESS,
                dayInARow: 28),
          );
        },
        afterModal: () {
          ApiResponseBase responseState = ref.read(projectApiResponseProvider);
          if (responseState is ApiResponseError ||
              responseState is ApiResponse && responseState.isError) {
            showOnlyCloseDialog(
              context: context,
              comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
            );
          } else {
            showOnlyCloseDialog(
                context: context,
                comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                'create_project_complete']!);
          }
        });
  }

  ElevatedButton _buildDeleteProjectButton(ProjectModel projectState) {
    return ElevatedButton(
      onPressed: () {
        showYesNoDialog(
            context: context,
            comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['delete_project_try']!,
            onYes: () async {
              ProjectRequestDto projectRequestDto = ProjectRequestDto(
                  prevProjectState: ProjectStateKind.IN_PROGRESS,
                  nextProjectState: ProjectStateKind.NO_EXIST);
              await ref
                  .read(projectApiResponseProvider.notifier)
                  .updateProjectState(projectRequestDto: projectRequestDto);
              //아래는 임시적 프론트 엔드 테스트를 위한 코드일 뿐 백엔드까지 구현된 이후 아래 코드들은 반드시 삭제되야 한다. ToBeDeleted"
              ref.read(widget.projectProvider.notifier).updateProjectState(
                projectState.copyWith(
                    projectStateKind: ProjectStateKind.NO_EXIST),
              );
            },
            afterModal: () {
              ApiResponseBase responseState =
              ref.read(projectApiResponseProvider);
              if (responseState is ApiResponseError ||
                  responseState is ApiResponse && responseState.isError) {
                showOnlyCloseDialog(
                  context: context,
                  comment:
                  COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
                );
              } else {
                showOnlyCloseDialog(
                    context: context,
                    comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                    'delete_project_complete']!);
              }
            });
      },
      child: Text(
        BUTTON_DICT[dotenv.get(LANGUAGE)]!['delete_project']!,
        style: YeongdeokSeaTextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(240, 30), // 너비 200, 높이 60
      ),
    );
  }

  ElevatedButton _buildRegisterHallOfFameButton(ProjectModel projectState) {
    return ElevatedButton(
      onPressed: () {
        if (projectState.projectStateKind == ProjectStateKind.COMPLETED) {
          showYesNoDialog(
            context: context,
            comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
            'create_project_sticker_loss_notice']!,
            onYes: () async {
              showCreateProjectTextInputDialog(projectState);
            },
          );
        } else if (projectState.projectStateKind == ProjectStateKind.NO_EXIST) {
          showCreateProjectTextInputDialog(projectState);
        }
      },
      child: Text(
        BUTTON_DICT[dotenv.get(LANGUAGE)]!['register_hall_of_fame']!,
        style: YeongdeokSeaTextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(240, 30), // 너비 200, 높이 60
      ),
    );
  }


}

class _TableClanderForHomeView extends StatelessWidget {
  final DateTime startDay;
  final int dayInARow;

  const _TableClanderForHomeView({
    required this.startDay,
    required this.dayInARow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime endDay = startDay.add(Duration(days: dayInARow - 1));

    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      locale: dotenv.get(LANGUAGE) == "KO" ? "ko_KR" : null,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      selectedDayPredicate: (day) {
        return day.isAfter(startDay.subtract(Duration(days: 1))) &&
            day.isBefore(endDay);
      },
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.lightBlue,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.transparent, // 배경을 투명하게 설정
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, day, focusedDay) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 아이콘 위치를 우상향으로 약간 이동
                Transform.translate(
                  offset: Offset(0.0, -16.0), // x축으로 5, y축으로 -5 이동
                  child: Icon(
                    Icons.check,
                    color: Colors.green[700], // 초록색 'V'자 체크 표시
                    size: 32.0, // 더 큰 아이콘 크기
                  ),
                ),
                Text(
                  '${day.day}', // 날짜 텍스트 표시
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black, // 날짜 텍스트 색상
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
