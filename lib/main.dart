import 'package:flutter/material.dart';
import 'package:workout_app/routes.dart';
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
      initialRoute: RouteConfiguration.initialRoute,
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
    );
  }
}
