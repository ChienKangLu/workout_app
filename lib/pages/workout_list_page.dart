import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_app/model/Exercise.dart';
import 'package:workout_app/model/workout.dart';
import 'package:workout_app/views/exercise_item.dart';

import '../views/workout_item.dart';
import '../views/workout_list.dart';
import '../views/workout_list_page_bottom_bar.dart';

class WorkoutListPage extends StatefulWidget {
  static const routeName = "/workout_list";

  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {

  final List<Workout> _workoutList = <Workout>[
    Workout(
        name: "Weight training 1",
        exercises: [
          Exercise(name: "Squat"),
          Exercise(name: "Bench press"),
          Exercise(name: "Pectoral fly"),
        ]
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
      ),
      body: WorkoutList(
        workoutItems: _workoutList.map((workout) => workout.toWorkoutItem()).toList(),
      ),
      bottomNavigationBar: const WorkoutListPageBottomBar()
    );
  }
}

extension WorkoutExtension on Workout {
  WorkoutItem toWorkoutItem() {
    return WorkoutItem(
      name: name,
      exerciseItems: exercises.map((exercise) => exercise.toExerciseItem()).toList(),
    );
  }
}

extension ExerciseExtension on Exercise {
  ExerciseItem toExerciseItem() {
    return ExerciseItem(name: name);
  }
}