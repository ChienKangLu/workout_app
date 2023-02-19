import 'package:flutter/material.dart';

import '../ui_state/weight_training_ui_state.dart';
import 'weight_training_exercise_set.dart';

class WeightTrainingExerciseSetList extends StatelessWidget {
  const WeightTrainingExerciseSetList({
    Key? key,
    required this.editableExerciseSets,
    required this.onEditSet,
  }) : super(key: key);

  final List<EditableExerciseSet> editableExerciseSets;
  final void Function(EditableExerciseSet) onEditSet;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: editableExerciseSets.length,
      itemBuilder: (content, index) {
        return WeightTrainingExerciseSet(
          editableExerciseSet: editableExerciseSets[index],
          onEditSet: onEditSet,
        );
      },
    );
  }
}
