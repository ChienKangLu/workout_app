import 'package:flutter/material.dart';
import 'package:workout_app/themes/workout_app_theme_data.dart';

void main() {
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout',
      theme: WorkoutAppThemeData.lightThemeData,
      darkTheme: WorkoutAppThemeData.darkThemeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Workout'),
        ),
        body: const Center(
          child: Text('Let\'s workout'),
        ),
      ),
    );
  }
}
