import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/workout_category.dart';
import '../weight_training_view_model.dart';

class WeightTrainingTitle extends StatelessWidget {
  const WeightTrainingTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weightTrainingUiState =
        context.watch<WeightTrainingViewModel>().weightTrainingUiState;

    return weightTrainingUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final editableWeightTraining = success.editableWeightTraining;
        final category = editableWeightTraining.category;
        final number = editableWeightTraining.number;

        return Text(
          "${WorkoutCategory.localizedString(context, category)} $number",
        );
      },
      onError: () => const SizedBox(),
    );
  }
}
