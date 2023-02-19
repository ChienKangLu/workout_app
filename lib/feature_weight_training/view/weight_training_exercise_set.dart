import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../core_view/util/weight_unit_display_helper.dart';
import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';
import '../ui_state/weight_training_ui_state.dart';

class WeightTrainingExerciseSet extends StatelessWidget {
  const WeightTrainingExerciseSet({
    Key? key,
    required this.editableExerciseSet,
    required this.onEditSet,
  }) : super(key: key);

  final EditableExerciseSet editableExerciseSet;
  final void Function(EditableExerciseSet) onEditSet;

  @override
  Widget build(BuildContext context) {
    final uiMode = context.watch<UiModeViewModel>().uiMode;

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: WorkoutAppThemeData.exerciseSetHeight,
      ),
      child: Row(
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
          if (uiMode == UiMode.edit)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                onEditSet(editableExerciseSet);
              },
            ),
        ],
      ),
    );
  }
}
