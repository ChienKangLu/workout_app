import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';
import '../workout_add_view_model.dart';

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
          _workoutCategoryString(context, workoutCategory),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  String _workoutCategoryString(
      BuildContext context, WorkoutCategory category) {
    switch (category) {
      case WorkoutCategory.weightTraining:
        return LocalizationUtil.localize(context)
            .workoutCategoryWeightTrainingTitle;
      case WorkoutCategory.running:
        return LocalizationUtil.localize(context).workoutCategoryRunningTitle;
    }
  }
}
