import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/workout_status.dart';
import '../weight_training_view_model.dart';
import 'weight_training_timer.dart';

class WeightTrainingControlPanel extends StatefulWidget {
  const WeightTrainingControlPanel({
    Key? key,
    this.onPauseButtonClicked,
    this.onStopButtonClicked,
    this.onTimerButtonClicked,
    this.onAddButtonClicked,
  }) : super(key: key);

  final void Function()? onPauseButtonClicked;
  final void Function()? onStopButtonClicked;
  final void Function()? onTimerButtonClicked;
  final void Function()? onAddButtonClicked;

  @override
  State<WeightTrainingControlPanel> createState() =>
      _WeightTrainingControlPanelState();
}

class _WeightTrainingControlPanelState
    extends State<WeightTrainingControlPanel> {
  void Function()? get _onPauseButtonClicked => widget.onPauseButtonClicked;
  void Function()? get onStopButtonClicked => widget.onStopButtonClicked;
  void Function()? get onTimerButtonClicked => widget.onTimerButtonClicked;
  void Function()? get onAddButtonClicked => widget.onAddButtonClicked;

  @override
  Widget build(BuildContext context) {
    final weightTrainingViewModel = context.watch<WeightTrainingViewModel>();
    final weightTrainingUiState = weightTrainingViewModel.weightTrainingUiState;

    return weightTrainingUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final editableWeightTraining = success.editableWeightTraining;
        final workoutStatus = editableWeightTraining.workoutStatus;

        final isInProgress = workoutStatus == WorkoutStatus.inProgress;
        final duration = workoutStatus == WorkoutStatus.finished
            ? editableWeightTraining.duration
            : null;
        final isTicking = duration == null;
        final startDateTime =
            editableWeightTraining.weightTraining.startDateTime;

        final timer = isTicking
            ? WeightTrainingTimer.ticking(
                dateTime: startDateTime,
              )
            : WeightTrainingTimer.finished(
                duration: duration,
              );

        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              timer,
              if (isInProgress)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _onPauseButtonClicked,
                      icon: const Icon(Icons.pause),
                    ),
                    IconButton(
                      onPressed: onStopButtonClicked,
                      icon: const Icon(Icons.stop),
                    ),
                    IconButton(
                      onPressed: onTimerButtonClicked,
                      icon: const Icon(Icons.timer_outlined),
                    ),
                    IconButton(
                      onPressed: onAddButtonClicked,
                      icon: Icon(
                        Icons.add_box,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                )
            ],
          ),
        );
      },
      onError: () => const SizedBox(),
    );
  }
}
