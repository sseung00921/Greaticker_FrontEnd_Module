import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greaticker/common/component/modal/image_with_confetti_animation_modal.dart';
import 'package:greaticker/common/component/modal/one_text_input_modal.dart';
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/component/modal/select_one_between_two_modal.dart';
import 'package:greaticker/common/component/modal/yes_no_modal.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/error_message/error_message.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/common/constants/language/stickers.dart';
import 'package:greaticker/common/constants/params.dart';
import 'package:greaticker/common/model/api_response.dart';
import 'package:greaticker/common/utils/url_builder_utils.dart';
import 'package:greaticker/hall_of_fame/model/request_dto/hall_of_fame_request_dto.dart';
import 'package:greaticker/hall_of_fame/provider/hall_of_fame_api_response_provider.dart';
import 'package:greaticker/home/constants/project.dart';
import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/model/request_dto/project_request_dto.dart';
import 'package:greaticker/home/provider/got_sticker_provider.dart';
import 'package:greaticker/home/provider/project_api_response_provider.dart';
import 'package:greaticker/home/provider/project_provider.dart';
import 'package:greaticker/home/utils/got_sticker_utils.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeView<T> extends ConsumerStatefulWidget {
  final StateNotifierProvider<ProjectStateNotifier, ApiResponseBase>
      projectProvider;
  final StateNotifierProvider<ProjectApiResponseStateNotifier, ApiResponseBase>
      projectApiResponseProvider;
  final StateNotifierProvider<GotStickerStateNotifier, ApiResponseBase>
      gotStickerProvider;
  final StateNotifierProvider<HallOfFameApiResponseStateNotifier,
      ApiResponseBase> hallOfFameApiResponseProvider;
  final String? showPopUp;

  const HomeView({
    Key? key,
    required this.projectProvider,
    required this.gotStickerProvider,
    required this.projectApiResponseProvider,
    required this.hallOfFameApiResponseProvider,
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
    final state = ref.watch(widget.projectProvider);

    // 완전 처음 로딩일때
    if (state is ApiResponseLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (state is ApiResponseError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
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

    state as ApiResponse;
    final projectState = state.data as ProjectModel;

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
                      startDay: projectState.startDate,
                      dayInARow: projectState.dayInARow,
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
                      '${projectState.dayInARow!}/${COMPLETE_DAY_CNT}',
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
        if (projectState.dayInARow == COMPLETE_DAY_CNT) {
          //혹시 스티커는 얻고 나서 완료처리를 하는 도중에 네트워크 에러가 났을 상황을 위한 코드
          await _processToCompleteState(projectState);
        } else {
          final responseState = await ref
              .read(widget.gotStickerProvider.notifier)
              .getGotStickerModel(context: context);
          if (responseState is ApiResponseError ||
              responseState is ApiResponse && !responseState.isSuccess) {
            if (responseState is ApiResponse && !responseState.isSuccess) {
              if (responseState.message == TODAY_STICKER_ALREADY_GOT) {
                await showOnlyCloseDialog(
                    context: context,
                    comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                        'today_sticker_already_got']!);
              }
            } else {
              showOnlyCloseDialog(
                context: context,
                comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
              );
            }
          } else if (responseState is ApiResponse && responseState.isSuccess) {
            String gotStickerId = responseState.data;

            await showImageWithConfettiAnimationDialog(
              context: context,
              comment: GotStickerUtils.gotStickerComment(
                  projectState,
                  STICKER_ID_STICKER_INFO_MAPPER[dotenv.get(LANGUAGE)]![
                      gotStickerId]!['name']!),
              imagePath:
                  UrlBuilderUtils.imageUrlBuilderByStickerId(gotStickerId),
            );
            projectState = plusDayInARow(projectState);
            if (projectState.dayInARow == COMPLETE_DAY_CNT) {
              await _processToCompleteState(projectState);
            }
          }
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

  Future<void> _processToCompleteState(ProjectModel projectState) async {
    ProjectRequestDto projectRequestDto = ProjectRequestDto(
        prevProjectState: projectState.projectStateKind,
        nextProjectState: ProjectStateKind.COMPLETED);
    final responseState = await ref
        .read(widget.projectApiResponseProvider.notifier)
        .updateProjectState(
            projectRequestDto: projectRequestDto, context: context);
    if (responseState is ApiResponseError ||
        responseState is ApiResponse && !responseState.isSuccess) {
      showOnlyCloseDialog(
        context: context,
        comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
      );
    } else if (responseState is ApiResponse && responseState.isSuccess) {
      showOnlyCloseDialog(
          context: context,
          comment:
              COMMENT_DICT[dotenv.get(LANGUAGE)]!['complete_project_notice']!);
    }
  }

  ProjectModel plusDayInARow(ProjectModel projectState) {
    ref
        .read(widget.projectProvider.notifier)
        .updateProjectState(projectState.copyWith(
          dayInARow: projectState.dayInARow! + 1,
        ));

    final state = ref.read(widget.projectProvider);
    state as ApiResponse;
    projectState = state.data;

    return projectState;
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
            projectName: s,
            prevProjectState: projectState.projectStateKind,
            nextProjectState: ProjectStateKind.IN_PROGRESS,);
        final responseState = await ref
            .read(widget.projectApiResponseProvider.notifier)
            .updateProjectState(
                projectRequestDto: projectRequestDto, context: context);
        if (responseState is ApiResponseError ||
            responseState is ApiResponse && !responseState.isSuccess) {
          if (responseState is ApiResponse && !responseState.isSuccess) {
            if (responseState.message == NOT_ALLOWED_CHARACTER) {
              showOnlyCloseDialog(
                  context: context,
                  comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                      'not_allowed_character']!);
            } else if (responseState.message == TOO_LONG_PROJECT_NAME) {
              showOnlyCloseDialog(
                  context: context,
                  comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                      'over_project_name_length']!);
            } else if (responseState.message == TOO_SHORT_PROJECT_NAME) {
              showOnlyCloseDialog(
                  context: context,
                  comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                      'under_project_name_length']!);
            }
          } else {
            showOnlyCloseDialog(
              context: context,
              comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
            );
          }
        } else if (responseState is ApiResponse && responseState.isSuccess) {
          showOnlyCloseDialog(
            context: context,
            comment:
                COMMENT_DICT[dotenv.get(LANGUAGE)]!['create_project_complete']!,
          );
        }
      },
    );
  }

  ElevatedButton _buildDeleteProjectButton(ProjectModel projectState) {
    return ElevatedButton(
      onPressed: () async {
        showYesNoDialog(
            context: context,
            comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['delete_project_try']!,
            onYes: () async {
              ProjectRequestDto projectRequestDto = ProjectRequestDto(
                  prevProjectState: projectState.projectStateKind,
                  nextProjectState: ProjectStateKind.NO_EXIST);
              final responseState = await ref
                  .read(widget.projectApiResponseProvider.notifier)
                  .updateProjectState(
                      projectRequestDto: projectRequestDto, context: context);
              if (responseState is ApiResponseError ||
                  responseState is ApiResponse && !responseState.isSuccess) {
                showOnlyCloseDialog(
                  context: context,
                  comment:
                      COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
                );
              } else if (responseState is ApiResponse &&
                  responseState.isSuccess) {
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

  Widget _buildRegisterHallOfFameButton(ProjectModel projectState) {
    return SizedBox(
      width: 240,
      child: ElevatedButton(
        onPressed: () {
          showSelectOneBetweenTwoModal(
            context: context,
            option1: COMMENT_DICT[dotenv.get(LANGUAGE)]!['only_nickname']!,
            option2: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                'both_nickname_and_auth_id']!,
            onNext: () async {
              HallOfFameRequestDto hallOfFameRequestDto =
                  HallOfFameRequestDto(projectId: "1");
              final responseState = await ref
                  .read(widget.hallOfFameApiResponseProvider.notifier)
                  .registerHallOfFame(
                      hallOfFameRequestDto: hallOfFameRequestDto,
                      context: context);
              if (responseState is ApiResponseError ||
                  responseState is ApiResponse && !responseState.isSuccess) {
                if (responseState is ApiResponse &&
                    responseState.message == DUPLICATED_HALL_OF_FAME) {
                  showOnlyCloseDialog(
                      context: context,
                      comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                          'duplicated_hall_of_fame']!);
                } else {
                  showOnlyCloseDialog(
                    context: context,
                    comment:
                        COMMENT_DICT[dotenv.get(LANGUAGE)]!['network_error']!,
                  );
                }
              } else if (responseState is ApiResponse &&
                  responseState.isSuccess) {
                showOnlyCloseDialog(
                  context: context,
                  comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                      'register_hall_of_fame_complete']!,
                );
                ref.read(widget.projectProvider.notifier).updateProjectState(
                      projectState.copyWith(
                          projectStateKind: ProjectStateKind.COMPLETED,
                          dayInARow: 30),
                    );
              }
              ;
            },
          );
        },
        child: Text(
          textAlign: TextAlign.center,
          BUTTON_DICT[dotenv.get(LANGUAGE)]!['register_hall_of_fame']!,
          style: YeongdeokSeaTextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _TableClanderForHomeView extends StatelessWidget {
  final DateTime? startDay;
  final int? dayInARow;

  const _TableClanderForHomeView({
    this.startDay,
    this.dayInARow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      locale: dotenv.get(LANGUAGE) == "KO" ? "ko_KR" : null,
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      selectedDayPredicate: (day) {
        if (startDay != null) {
          DateTime endDay = startDay!.add(Duration(days: dayInARow! - 1));
          return day.isAfter(startDay!.subtract(Duration(days: 1))) &&
              day.isBefore(endDay);
        } else {
          return false;
        }
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
