import 'package:flutter/material.dart';

import '../model/workout.dart';
import '../util/localization_util.dart';

enum WorkoutCategory {
  weightTraining(WorkoutType.weightTraining),
  running(WorkoutType.running);

  const WorkoutCategory(this.type);

  final WorkoutType type;

  static WorkoutCategory fromType(WorkoutType type) {
    return values.firstWhere(
      (category) => category.type == type,
      orElse: () => throw Exception("$type is not supported"),
    );
  }

  static String localizedString(
    BuildContext context,
    WorkoutCategory category,
  ) {
    switch (category) {
      case WorkoutCategory.weightTraining:
        return LocalizationUtil.localize(context)
            .workoutCategoryWeightTrainingTitle;
      case WorkoutCategory.running:
        return LocalizationUtil.localize(context).workoutCategoryRunningTitle;
    }
  }
}
