import 'package:flutter/material.dart';

import 'package:workout_app/themes/workout_app_theme_data.dart';

import 'exercise_list.dart';
import 'workout_item.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({Key? key, required this.workoutItems}) : super(key: key);

  final List<WorkoutItem> workoutItems;

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
      itemCount: workoutItems.length,
      itemBuilder: (content, index) {
        return WorkoutListItem(workoutItem: workoutItems[index]);
      },
    );
  }
}

class WorkoutListItem extends StatelessWidget {
  const WorkoutListItem({Key? key, required this.workoutItem}) : super(key: key);

  final WorkoutItem workoutItem;

  @override
  Widget build(BuildContext context) {
    return _listItemContainer(context, workoutItem);
  }

  Widget _listItemContainer(BuildContext context, WorkoutItem workoutItem) {
    return Container(
      margin: WorkoutAppThemeData.listItemMargin,
      padding: WorkoutAppThemeData.listItemPadding,
      color: Theme.of(context).colorScheme.surface,
      child: _listItem(context, workoutItem),
    );
  }

  Widget _listItem(BuildContext context, WorkoutItem workoutItem) {
    return Column(
      children: [
        WorkoutListItemTitle(workoutItem: workoutItem),
        Container(
          margin: WorkoutAppThemeData.exerciseListMargin,
          height: WorkoutAppThemeData.exerciseItemWidth,
          child: ExerciseList(exerciseItems: workoutItem.exerciseItems),
        )
      ],
    );
  }
}

class WorkoutListItemTitle extends StatelessWidget {
  const WorkoutListItemTitle({Key? key, required this.workoutItem}) : super(key: key);

  final WorkoutItem workoutItem;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        workoutItem.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
