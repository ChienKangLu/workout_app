import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../core_view/workout_category.dart';
import '../../core_view/workout_status.dart';
import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';
import '../ui_state/workout_list_ui_state.dart';
import 'exercise_thumbnail_list.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    Key? key,
    required this.workoutListState,
    required this.onItemClick,
    required this.onItemLongClick,
  }) : super(key: key);

  final WorkoutListSuccessUiState workoutListState;
  final void Function(ReadableWorkout) onItemClick;
  final void Function(ReadableWorkout) onItemLongClick;

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
      itemCount: workoutListState.readableWorkouts.length,
      itemBuilder: (content, index) {
        final readableWorkout = workoutListState.readableWorkouts[index];

        return WorkoutListItem(
          readableWorkout: readableWorkout,
          onItemClick: () => onItemClick(readableWorkout),
          onItemLongClick: () => onItemLongClick(readableWorkout),
        );
      },
    );
  }
}

class WorkoutListItem extends StatelessWidget {
  const WorkoutListItem({
    Key? key,
    required this.readableWorkout,
    required this.onItemClick,
    required this.onItemLongClick,
  }) : super(key: key);

  final ReadableWorkout readableWorkout;
  final void Function() onItemClick;
  final void Function() onItemLongClick;

  @override
  Widget build(BuildContext context) {
    final uiMode = context.watch<UiModeViewModel>().uiMode;
    final isSelected = readableWorkout.isSelected;

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
      "${WorkoutCategory.localizedString(context, readableWorkout.category)} ${readableWorkout.number}",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _body(BuildContext context) {
    final status = readableWorkout.workoutStatus;

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
          exerciseThumbnails: readableWorkout.exerciseThumbnails,
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
