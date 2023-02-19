import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../ui_state/weight_training_ui_state.dart';
import 'weight_training_exercise_set_list.dart';

class WeightTrainingExercise extends StatelessWidget {
  const WeightTrainingExercise({
    Key? key,
    required this.editableExercise,
    required this.onAddSet,
    required this.onRemoveExercise,
  }) : super(key: key);

  final EditableExercise editableExercise;
  final void Function(int) onAddSet;
  final void Function(int) onRemoveExercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: WorkoutAppThemeData.exerciseContainerMargin,
      child: ListView(
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      editableExercise.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onRemoveExercise(editableExercise.exerciseId),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => onAddSet(editableExercise.exerciseId),
              ),
            ],
          ),
          WeightTrainingExerciseSetList(
            editableExerciseSets: editableExercise.editableExerciseSets,
          ),
        ],
      ),
    );
  }
}
