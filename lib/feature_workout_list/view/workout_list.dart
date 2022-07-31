import 'dart:developer';

import 'package:flutter/material.dart';

import '../../feature_weight_training/weight_training_page.dart';
import '../../model/workout.dart';
import '../../themes/workout_app_theme_data.dart';
import '../workout_list_view_model.dart';
import 'exercise_thumbnail_list.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({Key? key, required this.workoutListState}) : super(key: key);

  final WorkoutListUiState workoutListState;

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
        return Workout(workoutState:  workoutListState.workouts[index]);
      },
    );
  }
}

class Workout extends StatelessWidget {
  const Workout({Key? key, required this.workoutState}) : super(key: key);

  final WorkoutUiState workoutState;

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
      onTap: () {
        if (workoutState.workout is WeightTraining) {
          Navigator.pushNamed(context, WeightTrainingPage.routeName,
              arguments: workoutState.workout);
        } else if (workoutState.workout is Running) {
          // TODO: page for running
        }
      },
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        WorkoutListItemTitle(workoutState: workoutState),
        Container(
          margin: WorkoutAppThemeData.exerciseThumbnailListMargin,
          height: WorkoutAppThemeData.exerciseThumbnailWidth,
          child: ExerciseThumbnailList(exerciseThumbnailListState: workoutState.exerciseThumbnailList),
        )
      ],
    );
  }
}

class WorkoutListItemTitle extends StatelessWidget {
  const WorkoutListItemTitle({Key? key, required this.workoutState}) : super(key: key);

  final WorkoutUiState workoutState;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        workoutState.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
