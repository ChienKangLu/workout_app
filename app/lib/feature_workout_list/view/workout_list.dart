import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../core_view/workout_status.dart';
import '../../themes/workout_app_theme_data.dart';
import '../../util/assets.dart';
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

  bool get _isEmpty => workoutListState.readableWorkouts.isEmpty;

  @override
  Widget build(BuildContext context) {
    return _listContainer(
      context,
      child: _isEmpty ? _emptyView(context) : _listView(context),
    );
  }

  Widget _listContainer(BuildContext context, {required Widget child}) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: child,
    );
  }

  Widget _emptyView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.kettlebells,
            width: 150,
          ),
          const SizedBox(height: 10),
          Text(
            LocalizationUtil.localize(context).workoutListEmptyDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return ListView.builder(
      itemCount: workoutListState.readableWorkouts.length,
      itemBuilder: (content, index) {
        final readableWorkout = workoutListState.readableWorkouts[index];

        return Column(
          children: [
            WorkoutListItem(
              readableWorkout: readableWorkout,
              onItemClick: () => onItemClick(readableWorkout),
              onItemLongClick: () => onItemLongClick(readableWorkout),
            ),
            if (index != workoutListState.readableWorkouts.length - 1)
              Divider(
                height: 1,
                color: Theme.of(context).colorScheme.surfaceVariant,
              )
          ],
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

    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
        color: Theme.of(context).colorScheme.surface,
        child: Row(children: [
          _date(context, uiMode),
          const SizedBox(width: 16),
          _number(context),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: WorkoutAppThemeData.exerciseThumbnailHeight,
                  child: _body(context),
                )
              ],
            ),
          ),
        ]),
      ),
      onTap: () => onItemClick(),
      onLongPress: () => onItemLongClick(),
    );
  }

  Widget _date(BuildContext context, UiMode uiMode) {
    final isSelected = readableWorkout.isSelected;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;

    return SizedBox(
      width: 24,
      child: uiMode == UiMode.edit
          ? Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? primaryColor : onSurfaceColor,
            )
          : Column(
              children: [
                Text(
                  readableWorkout.day,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  readableWorkout.date,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
    );
  }

  Widget _number(BuildContext context) {
    return Text(
      "#${readableWorkout.number}",
      style: Theme.of(context).textTheme.bodySmall,
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
