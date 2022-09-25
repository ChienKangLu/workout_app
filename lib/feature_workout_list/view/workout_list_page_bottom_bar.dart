import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';

class WorkoutListPageBottomBar extends StatelessWidget {
  const WorkoutListPageBottomBar({
    Key? key,
    required this.onAddItemClicked,
  }) : super(key: key);

  final void Function() onAddItemClicked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WorkoutAppThemeData.bottomBarHeight,
      child: GestureDetector(
        onTap: onAddItemClicked,
        child: Icon(
          Icons.add,
          size: WorkoutAppThemeData.bottomBarIconSize,
        ),
      ),
    );
  }
}
