import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';

class WorkoutAddTitle extends StatelessWidget {
  const WorkoutAddTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: WorkoutAppThemeData.workoutPickerTitleMargin,
      child: Text(
        LocalizationUtil.localize(context).workoutAddPageTitle,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
