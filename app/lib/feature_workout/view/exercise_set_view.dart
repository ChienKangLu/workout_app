import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../core_view/util/display_string_util.dart';
import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';
import '../ui_state/workout_ui_state.dart';

class ExerciseSetView extends StatelessWidget {
  const ExerciseSetView({
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
      constraints: const BoxConstraints.tightFor(
        height: WorkoutAppThemeData.exerciseSetHeight,
      ),
      child: Row(
        children: [
          Text(
            "${editableExerciseSet.number}.",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: WorkoutAppThemeData.exerciseSetDataMargin),
          Text(
            "${editableExerciseSet.displayWeight} ${editableExerciseSet.weightUnit.unitString(context)}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: WorkoutAppThemeData.exerciseSetDataMargin),
          Expanded(
            child: Text(
              LocalizationUtil.localize(context)
                  .repetitionText(editableExerciseSet.repetition),
              style: Theme.of(context).textTheme.titleMedium,
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
