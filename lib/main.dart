import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'routes.dart';
import 'themes/workout_app_theme_data.dart';
import 'util/localization_util.dart';

void main() {
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) {
        return LocalizationUtil.localize(context).appTitle;
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: WorkoutAppThemeData.lightThemeData,
      darkTheme: WorkoutAppThemeData.darkThemeData,
      initialRoute: RouteConfiguration.initialRoute,
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
    );
  }
}
