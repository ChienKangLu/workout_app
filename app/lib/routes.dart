import 'package:flutter/material.dart';

import 'feature_root/view/root.dart';
import 'feature_setting/setting_page.dart';
import 'feature_setting_exercise/setting_exercise_page.dart';
import 'feature_weight_training/weight_training_page.dart';

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
      name: WeightTrainingPage.routeName,
      builder: (context, arguments) => WeightTrainingPage(
        workoutId: arguments as int,
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
