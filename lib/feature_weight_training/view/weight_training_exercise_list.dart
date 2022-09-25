import 'package:flutter/material.dart';

import '../weight_training_view_model.dart';
import 'weight_training_exercise.dart';

class WeightTrainingExerciseList extends StatelessWidget {
  const WeightTrainingExerciseList({
    Key? key,
    required this.weightTrainingExerciseListState,
  }) : super(key: key);

  final WeightTrainingExerciseListUiState weightTrainingExerciseListState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: weightTrainingExerciseListState.exercises
          .map((exercise) => WeightTrainingExercise(
                weightTrainingExerciseState: exercise,
              ))
          .toList(),
    );
  }
}
