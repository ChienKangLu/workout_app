import 'package:flutter/material.dart';
import 'package:workout_app/pages/workout_list_page.dart';

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
  ];

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    for (final path in paths) {
      if (settings.name == path.name) {
        return MaterialPageRoute(
            builder: (context) => path.builder(context, settings.arguments),
            settings: settings
        );
      }
    }
    return null;
  }
}
