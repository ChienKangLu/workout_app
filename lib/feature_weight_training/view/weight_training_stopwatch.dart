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

  DateTime? _lapStartDateTime;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    )..repeat();

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
    final weightTrainingUiState = weightTrainingViewModel.weightTrainingUiState;

    return weightTrainingUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final editableWeightTraining = success.editableWeightTraining;
        final isWorkoutFinished = weightTrainingViewModel.isWorkoutFinished;

        if (isWorkoutFinished) {
          controller.stop();
          return _stopWatch(
            editableWeightTraining.duration,
            hasLap: !isWorkoutFinished,
          );
        }

        return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final startDateTime =
                  editableWeightTraining.weightTraining.startDateTime;

              final duration = startDateTime == null
                  ? Duration.zero
                  : DateTime.now().difference(startDateTime);

              return _stopWatch(
                duration,
                lapStartDateTime: _lapStartDateTime,
              );
            });
      },
      onError: () => const SizedBox(),
    );
  }

  Widget _stopWatch(
    Duration duration, {
    bool hasLap = true,
    DateTime? lapStartDateTime,
  }) {
    final lapDuration = lapStartDateTime != null
        ? DateTime.now().difference(lapStartDateTime)
        : duration;
    return _container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            _timer(duration, fontSize: 85),
            if (hasLap) _lapTimer(lapDuration),
          ],
        ),
      ),
    );
  }

  Widget _container({
    required Widget child,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          onTap: () {
            setState(() => _lapStartDateTime = DateTime.now());
          },
          child: child,
        ),
      ),
    );
  }

  Widget _lapTimer(Duration duration) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.timer_outlined),
        const SizedBox(width: 10),
        _timer(duration, fontSize: 20),
      ],
    );
  }

  Widget _timer(Duration duration, {double? fontSize}) {
    return Text(
      DurationUtil.displayText(context, duration),
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w100,
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }
}
