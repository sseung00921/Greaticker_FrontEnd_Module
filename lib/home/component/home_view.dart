import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/component/modal/only_close_modal.dart';
import 'package:greaticker/common/component/modal/yes_no_modal.dart';
import 'package:greaticker/common/component/text_style.dart';
import 'package:greaticker/common/constants/fonts.dart';
import 'package:greaticker/common/constants/language/button.dart';
import 'package:greaticker/common/constants/language/comment.dart';
import 'package:greaticker/common/constants/language/common.dart';
import 'package:greaticker/home/constants/project.dart';
import 'package:greaticker/home/model/enum/project_state_kind.dart';
import 'package:greaticker/home/model/project_model.dart';
import 'package:greaticker/home/provider/project_provider.dart';

class HomeView<T> extends ConsumerStatefulWidget {
  final StateNotifierProvider<ProjectStateNotifier, ProjectModelBase> provider;

  const HomeView({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  ConsumerState<HomeView> createState() => _HomeViewState<T>();
}

class _HomeViewState<T> extends ConsumerState<HomeView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(widget.provider);

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
              ref.read(widget.provider.notifier).getProjectModel();
            },
            child: Text(BUTTON_DICT[dotenv.get(LANGUAGE)]!['retry']!),
          ),
        ],
      );
    }

    projectState as ProjectModel;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 가운데 달력 (임시로 텍스트로 표시)
            Text(
              projectState.projectName!,
              style: YeongdeokSeaTextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            // 프로그레스 바와 그 오른쪽의 텍스트
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
                    '${(projectState.dayInARow! / COMPLETE_DAY_CNT * 30).round()}/${COMPLETE_DAY_CNT}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            _showOrHideGotStickerButton(projectState),
            _showAppropriateProjectActionButton(projectState),
          ],
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
          SizedBox(height: 10),
          // 두 번째 ElevatedButton
          _buildDeleteProjectButton(projectState),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 10),
          // 두 번째 ElevatedButton
          _buildCreateProjectButton(projectState),
        ],
      );
    }
  }

  ElevatedButton _buildGotStickerButton(ProjectModel projectState) {
    return ElevatedButton(
      onPressed: () {
        if (projectState.dayInARow == 30) {
          ref
              .read(widget.provider.notifier)
              .updateProjectState(projectState.copyWith(
                projectStateKind: ProjectStateKind.COMPLETED,
              ));
        } else {
          ref
              .read(widget.provider.notifier)
              .updateProjectState(projectState.copyWith(
                dayInARow: projectState.dayInARow! + 1,
              ));
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

  ElevatedButton _buildCreateProjectButton(ProjectModel projectState) {
    return ElevatedButton(
      onPressed: () {
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

  ElevatedButton _buildDeleteProjectButton(ProjectModel projectState) {
    return ElevatedButton(
      onPressed: () {
        showYesNoDialog(
          context: context,
          comment: COMMENT_DICT[dotenv.get(LANGUAGE)]!['delete_project_try']!,
          onYes: () {

            _changeProjectStateFromInProgressToNoExist(projectState);
          },
          afterModal: () {
            showOnlyCloseDialog(
                context: context,
                comment: COMMENT_DICT[dotenv.get(LANGUAGE)]![
                    'delete_project_complete']!);
          },
        );
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

  void _changeProjectStateFromInProgressToNoExist(ProjectModel projectState) {
    ref.read(widget.provider.notifier).updateProjectState(
          projectState.copyWith(
              projectStateKind: ProjectStateKind.NO_EXIST, dayInARow: 0),
        );
  }
}

class FavoriteStickerLimitOverAlertDialog extends StatelessWidget {
  const FavoriteStickerLimitOverAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        COMMENT_DICT[dotenv.get(LANGUAGE)]![
            'can_not_register_favorite_sticker_more_than_3']!,
        style: YeongdeokSeaTextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
