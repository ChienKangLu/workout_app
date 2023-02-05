import 'package:flutter/material.dart';

import '../../core_view/util/weight_unit_display_helper.dart';
import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';
import '../weight_training_view_model.dart';

class WeightTrainingExerciseSet extends StatelessWidget {
  const WeightTrainingExerciseSet({
    Key? key,
    required this.exerciseSetUiState,
  }) : super(key: key);

  final WeightTrainingExerciseSetUiState exerciseSetUiState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${exerciseSetUiState.number}.",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(width: WorkoutAppThemeData.exerciseSetDataMargin),
        Text(
          "${exerciseSetUiState.weight} ${WeightUnitDisplayHelper.toDisplayString(context, exerciseSetUiState.weightUnit)}",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(width: WorkoutAppThemeData.exerciseSetDataMargin),
        Text(
          LocalizationUtil.localize(context)
              .repetitionText(exerciseSetUiState.repetition),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
