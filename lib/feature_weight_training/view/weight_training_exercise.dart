import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../weight_training_view_model.dart';
import 'weight_training_exercise_set_list.dart';

class WeightTrainingExercise extends StatelessWidget {
  const WeightTrainingExercise({
    Key? key,
    required this.weightTrainingExerciseState,
  }) : super(key: key);

  final WeightTrainingExerciseUiState weightTrainingExerciseState;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: WorkoutAppThemeData.exerciseContainerMargin,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Text(
            weightTrainingExerciseState.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          WeightTrainingExerciseSetList(
            weightTrainingExerciseSetListState:
                weightTrainingExerciseState.setList,
          ),
        ],
      ),
    );
  }
}
