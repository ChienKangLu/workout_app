import 'package:flutter/material.dart';

import 'feature_exercise_statistic/exercise_statistic_page.dart';
import 'feature_root/view/root.dart';
import 'feature_setting/setting_page.dart';
import 'feature_setting_exercise/setting_exercise_page.dart';
import 'feature_workout/workout_page.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, Object?);

class Path {
  const Path({required this.name, required this.builder});

  final String name;
  final PathWidgetBuilder builder;
}

class RouteConfiguration {
  static String initialRoute = Root.routeName;

  static List<Path> paths = [
    Path(
      name: Root.routeName,
      builder: (context, arguments) => const Root(),
    ),
    Path(
      name: WorkoutPage.routeName,
      builder: (context, arguments) => WorkoutPage(
        workoutPageArguments: arguments as WorkoutPageArguments,
      ),
    ),
    Path(
      name: SettingPage.routeName,
      builder: (context, arguments) => const SettingPage(),
    ),
    Path(
      name: SettingExercisePage.routeName,
      builder: (context, arguments) => const SettingExercisePage(),
    ),
    Path(
      name: ExerciseStatisticPage.routeName,
      builder: (context, arguments) => ExerciseStatisticPage(
        exerciseId: arguments as int,
      ),
    )
  ];

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    for (final path in paths) {
      if (settings.name == path.name) {
        return MaterialPageRoute(
          builder: (context) => path.builder(context, settings.arguments),
          settings: settings,
        );
      }
    }
    return null;
  }
}
