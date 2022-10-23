import 'package:flutter/material.dart';

import '../weight_training_view_model.dart';
import 'weight_training_exercise_set.dart';

class WeightTrainingExerciseSetList extends StatelessWidget {
  const WeightTrainingExerciseSetList({
    Key? key,
    required this.exerciseSetListUiState,
  }) : super(key: key);

  final WeightTrainingExerciseSetListUiState exerciseSetListUiState;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: exerciseSetListUiState.exerciseSetUiStates.length,
      itemBuilder: (content, index) {
        return WeightTrainingExerciseSet(
          exerciseSetUiState: exerciseSetListUiState.exerciseSetUiStates[index],
        );
      },
    );
  }
}
