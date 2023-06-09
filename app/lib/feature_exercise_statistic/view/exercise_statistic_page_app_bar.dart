import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exercise_statistic_view_model.dart';

class ExerciseStatisticPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ExerciseStatisticPageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exerciseStatisticViewModel = context.watch<ExerciseStatisticViewModel>();
    final exerciseStatisticUiState = exerciseStatisticViewModel.exerciseStatisticUiState;

    return exerciseStatisticUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final exerciseReport = success.exerciseReport;
        return AppBar(
          title: Text(exerciseReport.exerciseName),
          toolbarHeight: 56,
        );
      },
      onError: () => const SizedBox(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
