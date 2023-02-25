import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/util/duration_util.dart';
import '../weight_training_view_model.dart';

class WeightTrainingStopwatch extends StatefulWidget {
  const WeightTrainingStopwatch({Key? key}) : super(key: key);

  @override
  State<WeightTrainingStopwatch> createState() =>
      _WeightTrainingStopwatchState();
}

class _WeightTrainingStopwatchState extends State<WeightTrainingStopwatch>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    )..addListener(() => setState(() {}));
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weightTrainingViewModel = context.watch<WeightTrainingViewModel>();
    return AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final weightTrainingUiState =
              weightTrainingViewModel.weightTrainingUiState;

          final startDateTime = weightTrainingUiState.run(
            onLoading: () => null,
            onSuccess: (success) =>
                success.editableWeightTraining.weightTraining.startDateTime,
            onError: () => null,
          );

          final duration = startDateTime == null
              ? Duration.zero
              : DateTime.now().difference(startDateTime);

          return Text(
            DurationUtil.displayText(context, duration),
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 85,
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          );
        });
  }
}
