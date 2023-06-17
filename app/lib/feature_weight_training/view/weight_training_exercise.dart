import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../themes/workout_app_theme_data.dart';
import '../ui_state/weight_training_ui_state.dart';
import 'weight_training_exercise_set_list.dart';

class WeightTrainingExercise extends StatelessWidget {
  const WeightTrainingExercise({
    Key? key,
    required this.editableExercise,
    required this.onAddSet,
    required this.onEditSet,
    required this.onMoreButtonClicked,
  }) : super(key: key);

  final EditableExercise editableExercise;
  final void Function(EditableExercise) onAddSet;
  final void Function(EditableExerciseSet) onEditSet;
  final void Function(UiMode, int) onMoreButtonClicked;

  @override
  Widget build(BuildContext context) {
    final uiMode = context.watch<UiModeViewModel>().uiMode;

    return ListView(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  height: WorkoutAppThemeData.exerciseTitleHeight,
                ),
                child: Row(
                  children: [
                    Text(
                      editableExercise.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz),
                      onPressed: () => onMoreButtonClicked(
                        uiMode,
                        editableExercise.exerciseId,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (uiMode == UiMode.edit)
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => onAddSet(editableExercise),
              ),
          ],
        ),
        WeightTrainingExerciseSetList(
          editableExerciseSets: editableExercise.editableExerciseSets,
          onEditSet: onEditSet,
        ),
      ],
    );
  }
}
