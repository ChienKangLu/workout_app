import 'package:flutter/material.dart';

import '../../core_view/workout_category.dart';
import '../../themes/workout_app_theme_data.dart';

class WorkoutCategoryListItem extends StatelessWidget {
  const WorkoutCategoryListItem({
    Key? key,
    required this.workoutCategory,
    required this.onCategoryClicked,
  }) : super(key: key);

  final WorkoutCategory workoutCategory;
  final void Function(WorkoutCategory) onCategoryClicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCategoryClicked(workoutCategory);
      },
      child: Container(
        margin: WorkoutAppThemeData.workoutPickerMargin,
        child: Text(
          WorkoutCategory.localizedString(context, workoutCategory),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
