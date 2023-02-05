import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../weight_training_view_model.dart';
import 'weight_training_exercise_set_list.dart';

class WeightTrainingExercise extends StatelessWidget {
  const WeightTrainingExercise({
    Key? key,
    required this.exerciseUiStates,
    required this.onAddSet,
  }) : super(key: key);

  final WeightTrainingExerciseUiState exerciseUiStates;
  final void Function(int) onAddSet;

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
                child: Text(
                  exerciseUiStates.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => onAddSet(exerciseUiStates.exerciseId),
              ),
            ],
          ),
          WeightTrainingExerciseSetList(
            exerciseSetListUiState: exerciseUiStates.exerciseSetListUiState,
          ),
        ],
      ),
    );
  }
}
