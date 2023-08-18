import 'package:flutter/material.dart';

import '../ui_state/workout_ui_state.dart';
import 'exercise_set_view.dart';

class ExerciseSetListView extends StatelessWidget {
  const ExerciseSetListView({
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
        return ExerciseSetView(
          editableExerciseSet: editableExerciseSets[index],
          onEditSet: onEditSet,
        );
      },
    );
  }
}
