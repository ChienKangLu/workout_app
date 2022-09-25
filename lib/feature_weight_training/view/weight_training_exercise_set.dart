import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';
import '../weight_training_view_model.dart';

class WeightTrainingExerciseSet extends StatelessWidget {
  const WeightTrainingExerciseSet({
    Key? key,
    required this.weightTrainingExerciseSetState,
  }) : super(key: key);

  final WeightTrainingExerciseSetUiState weightTrainingExerciseSetState;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${weightTrainingExerciseSetState.number}.",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(width: WorkoutAppThemeData.exerciseSetDataMargin),
        Text(
          "${weightTrainingExerciseSetState.weight} ${weightTrainingExerciseSetState.weightUnit}",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(width: WorkoutAppThemeData.exerciseSetDataMargin),
        Text(
          LocalizationUtil.localize(context)
              .repetitionText(weightTrainingExerciseSetState.repetition),
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
