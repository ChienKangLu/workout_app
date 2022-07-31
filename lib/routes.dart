import 'package:flutter/material.dart';

import 'feature_weight_training/weight_training_page.dart';
import 'feature_workout_list/workout_list_page.dart';
import 'model/workout.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, Object?);

class Path {
  const Path({required this.name, required this.builder});

  final String name;
  final PathWidgetBuilder builder;
}

class RouteConfiguration {
  static String initialRoute = WorkoutListPage.routeName;

  static List<Path> paths = [
    Path(
      name: WorkoutListPage.routeName,
      builder: (context, arguments) => const WorkoutListPage(),
    ),
    Path(
      name: WeightTrainingPage.routeName,
      builder: (context, arguments) => WeightTrainingPage(
        weightTraining: arguments as WeightTraining,
      ),
    ),
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
