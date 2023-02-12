import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../core_view/workout_category.dart';
import '../../core_view/workout_status.dart';
import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';
import '../workout_list_view_model.dart';
import 'exercise_thumbnail_list.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    Key? key,
    required this.workoutListState,
    required this.onItemClick,
    required this.onItemLongClick,
  }) : super(key: key);

  final WorkoutListUiState workoutListState;
  final void Function(WorkoutUiState) onItemClick;
  final void Function(WorkoutUiState) onItemLongClick;

  @override
  Widget build(BuildContext context) {
    return _listContainer(
      context,
      child: _listView(context),
    );
  }

  Widget _listContainer(BuildContext context, {required Widget child}) {
    return Container(
      color: Theme.of(context).colorScheme.listBackgroundColor,
      child: child,
    );
  }

  Widget _listView(BuildContext context) {
    return ListView.builder(
      itemCount: workoutListState.workouts.length,
      itemBuilder: (content, index) {
        final workoutUiState = workoutListState.workouts[index];

        return WorkoutListItem(
          workoutState: workoutUiState,
          onItemClick: () => onItemClick(workoutUiState),
          onItemLongClick: () => onItemLongClick(workoutUiState),
        );
      },
    );
  }
}

class WorkoutListItem extends StatelessWidget {
  const WorkoutListItem({
    Key? key,
    required this.workoutState,
    required this.onItemClick,
    required this.onItemLongClick,
  }) : super(key: key);

  final WorkoutUiState workoutState;
  final void Function() onItemClick;
  final void Function() onItemLongClick;

  @override
  Widget build(BuildContext context) {
    final uiMode = context.watch<UiModeViewModel>().uiMode;
    final isSelected = workoutState.isSelected;

    return InkWell(
      child: Container(
        margin: WorkoutAppThemeData.workoutMargin,
        padding: WorkoutAppThemeData.workoutPadding,
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _title(context)),
                if (uiMode == UiMode.edit)
                  Icon(isSelected ? Icons.check_circle : Icons.circle),
              ],
            ),
            Container(
              margin: WorkoutAppThemeData.exerciseThumbnailListMargin,
              height: WorkoutAppThemeData.exerciseThumbnailWidth,
              child: _body(context),
            )
          ],
        ),
      ),
      onTap: () => onItemClick(),
      onLongPress: () => onItemLongClick(),
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      "${WorkoutCategory.localizedString(context, workoutState.category)} ${workoutState.number}",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _body(BuildContext context) {
    final status = workoutState.workoutStatus;

    switch (status) {
      case WorkoutStatus.created:
        return _statusText(
          context,
          text: LocalizationUtil.localize(context).workoutStatusCreated,
        );
      case WorkoutStatus.inProgress:
        return _statusText(
          context,
          text: LocalizationUtil.localize(context).workoutStatusInProgress,
        );
      case WorkoutStatus.finished:
        return ExerciseThumbnailList(
          exerciseThumbnailListState: workoutState.exerciseThumbnailList,
        );
    }
  }

  Widget _statusText(BuildContext context, {required String text}) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
