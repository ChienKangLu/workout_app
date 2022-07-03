import 'package:flutter/material.dart';

import 'package:workout_app/model/workout.dart';
import 'package:workout_app/themes/workout_app_theme_data.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({Key? key, required this.workoutList}) : super(key: key);

  final List<Workout> workoutList;

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
      itemCount: workoutList.length,
      itemBuilder: (content, index) {
        return _listItemContainer(context, workoutList[index]);
      },
    );
  }

  Widget _listItemContainer(BuildContext context, Workout workout) {
    return Container(
      margin: WorkoutAppThemeData.listItemMargin,
      padding: WorkoutAppThemeData.listItemPadding,
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: _listItem(context, workout),
    );
  }

  Widget _listItem(BuildContext context, Workout workout) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            workout.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}


