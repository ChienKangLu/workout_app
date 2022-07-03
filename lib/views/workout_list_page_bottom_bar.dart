import 'package:flutter/material.dart';
import 'package:workout_app/themes/workout_app_theme_data.dart';

class WorkoutListPageBottomBar extends StatelessWidget {
  const WorkoutListPageBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WorkoutAppThemeData.bottomBarHeight,
      child: Center(
        child: Icon(
          Icons.add,
          size: WorkoutAppThemeData.bottomBarIconSize,
        ),
      ),
    );
  }
}
