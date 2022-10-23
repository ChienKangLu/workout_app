import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../weight_training_view_model.dart';
import 'weight_training_exercise_set_list.dart';

class WeightTrainingExercise extends StatelessWidget {
  const WeightTrainingExercise({
    Key? key,
    required this.exerciseUiStates,
  }) : super(key: key);

  final WeightTrainingExerciseUiState exerciseUiStates;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: WorkoutAppThemeData.exerciseContainerMargin,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Text(
            exerciseUiStates.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          WeightTrainingExerciseSetList(
            exerciseSetListUiState: exerciseUiStates.exerciseSetListUiState,
          ),
        ],
      ),
    );
  }
}
