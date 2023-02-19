import 'package:flutter/material.dart';

import '../ui_state/weight_training_ui_state.dart';
import 'weight_training_exercise.dart';

class WeightTrainingExerciseList extends StatelessWidget {
  const WeightTrainingExerciseList({
    Key? key,
    required this.editableExercises,
    required this.onAddSet,
    required this.onRemoveExercise,
  }) : super(key: key);

  final List<EditableExercise> editableExercises;
  final void Function(int) onAddSet;
  final void Function(int) onRemoveExercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: editableExercises
          .map(
            (exercise) => WeightTrainingExercise(
              editableExercise: exercise,
              onAddSet: onAddSet,
              onRemoveExercise: onRemoveExercise,
            ),
          )
          .toList(),
    );
  }
}
