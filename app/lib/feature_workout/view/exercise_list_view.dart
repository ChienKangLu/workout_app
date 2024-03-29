import 'package:flutter/material.dart';

import '../../core_view/ui_mode.dart';
import '../ui_state/workout_ui_state.dart';
import 'exercise_view.dart';

class ExerciseListView extends StatelessWidget {
  const ExerciseListView({
    Key? key,
    required this.editableExercises,
    required this.onAddSet,
    required this.onEditSet,
    required this.onMoreButtonClicked,
  }) : super(key: key);

  final List<EditableExercise> editableExercises;
  final void Function(EditableExercise) onAddSet;
  final void Function(EditableExerciseSet) onEditSet;
  final void Function(UiMode, int) onMoreButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: editableExercises
          .map(
            (exercise) => ExerciseView(
              editableExercise: exercise,
              onAddSet: onAddSet,
              onEditSet: onEditSet,
              onMoreButtonClicked: onMoreButtonClicked,
            ),
          )
          .toList(),
    );
  }
}
