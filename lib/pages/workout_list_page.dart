import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_app/model/Exercise.dart';
import 'package:workout_app/model/workout.dart';

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
        exerciseList: [
          Exercise(name: "Squat"),
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
        workoutList: _workoutList,
      ),
      bottomNavigationBar: const WorkoutListPageBottomBar()
    );
  }
}
