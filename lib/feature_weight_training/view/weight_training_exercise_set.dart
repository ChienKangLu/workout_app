import 'package:flutter/material.dart';

import '../../core_view/util/weight_unit_display_helper.dart';
import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';
import '../ui_state/weight_training_ui_state.dart';

class WeightTrainingExerciseSet extends StatelessWidget {
  const WeightTrainingExerciseSet({
    Key? key,
    required this.editableExerciseSet,
  }) : super(key: key);

  final EditableExerciseSet editableExerciseSet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${editableExerciseSet.number}.",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(width: WorkoutAppThemeData.exerciseSetDataMargin),
        Text(
          "${editableExerciseSet.weight} ${WeightUnitDisplayHelper.toDisplayString(context, editableExerciseSet.weightUnit)}",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(width: WorkoutAppThemeData.exerciseSetDataMargin),
        Expanded(
          child: Text(
            LocalizationUtil.localize(context)
                .repetitionText(editableExerciseSet.repetition),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            print("TODO: WeightTrainingExerciseSet delete");
          },
        ),
      ],
    );
  }
}
