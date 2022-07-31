import 'package:flutter/material.dart';

import '../weight_training_view_model.dart';
import 'weight_training_exercise_set.dart';

class WeightTrainingExerciseSetList extends StatelessWidget {
  const WeightTrainingExerciseSetList({
    Key? key,
    required this.weightTrainingExerciseSetListState,
  }) : super(key: key);

  final WeightTrainingExerciseSetListUiState weightTrainingExerciseSetListState;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: weightTrainingExerciseSetListState.sets.length,
      itemBuilder: (content, index) {
        return WeightTrainingExerciseSet(
          weightTrainingExerciseSetState: weightTrainingExerciseSetListState.sets[index],
        );
      },
    );
  }
}
