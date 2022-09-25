import 'package:flutter/material.dart';

import '../../core_view/workout_category.dart';
import '../../themes/workout_app_theme_data.dart';
import '../workout_list_view_model.dart';
import 'exercise_thumbnail_list.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    Key? key,
    required this.workoutListState,
    required this.onItemClick,
  }) : super(key: key);

  final WorkoutListUiState workoutListState;
  final void Function(WorkoutCategory, int) onItemClick;

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
        final workoutState = workoutListState.workouts[index];
        final category = workoutState.category;
        final workoutRecordId = workoutState.workoutRecordId;

        return Workout(
          workoutState: workoutState,
          onItemClick: () => onItemClick(category, workoutRecordId),
        );
      },
    );
  }
}

class Workout extends StatelessWidget {
  const Workout({
    Key? key,
    required this.workoutState,
    required this.onItemClick,
  }) : super(key: key);

  final WorkoutUiState workoutState;
  final void Function() onItemClick;

  @override
  Widget build(BuildContext context) {
    return _container(context);
  }

  Widget _container(BuildContext context) {
    return InkWell(
      child: Container(
        margin: WorkoutAppThemeData.workoutMargin,
        padding: WorkoutAppThemeData.workoutPadding,
        color: Theme.of(context).colorScheme.surface,
        child: _content(context),
      ),
      onTap: () => onItemClick(),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        WorkoutListItemTitle(workoutState: workoutState),
        Container(
          margin: WorkoutAppThemeData.exerciseThumbnailListMargin,
          height: WorkoutAppThemeData.exerciseThumbnailWidth,
          child: ExerciseThumbnailList(
              exerciseThumbnailListState: workoutState.exerciseThumbnailList),
        )
      ],
    );
  }
}

class WorkoutListItemTitle extends StatelessWidget {
  const WorkoutListItemTitle({Key? key, required this.workoutState})
      : super(key: key);

  final WorkoutUiState workoutState;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        "${WorkoutCategory.localizedString(context, workoutState.category)} ${workoutState.number}",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
