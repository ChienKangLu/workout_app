import 'package:flutter/material.dart';

import '../weight_training_view_model.dart';
import 'weight_training_exercise.dart';

class WeightTrainingExerciseList extends StatelessWidget {
  const WeightTrainingExerciseList({
    Key? key,
    required this.exerciseListUiState,
  }) : super(key: key);

  final WeightTrainingExerciseListUiState exerciseListUiState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: exerciseListUiState.exerciseUiStates
          .map((exercise) => WeightTrainingExercise(
                exerciseUiStates: exercise,
              ))
          .toList(),
    );
  }
}
