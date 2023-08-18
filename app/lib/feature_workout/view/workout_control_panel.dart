import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/workout_status.dart';
import '../workout_view_model.dart';
import 'workout_timer.dart';

class WorkoutControlPanel extends StatefulWidget {
  const WorkoutControlPanel({
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
  State<WorkoutControlPanel> createState() =>
      _WorkoutControlPanelState();
}

class _WorkoutControlPanelState
    extends State<WorkoutControlPanel> {
  void Function()? get _onPauseButtonClicked => widget.onPauseButtonClicked;
  void Function()? get onStopButtonClicked => widget.onStopButtonClicked;
  void Function()? get onTimerButtonClicked => widget.onTimerButtonClicked;
  void Function()? get onAddButtonClicked => widget.onAddButtonClicked;

  @override
  Widget build(BuildContext context) {
    final workoutViewModel = context.watch<WorkoutViewModel>();
    final workoutUiState = workoutViewModel.workoutUiState;

    return workoutUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final editableWorkout = success.editableWorkout;
        final workoutStatus = editableWorkout.workoutStatus;

        final isInProgress = workoutStatus == WorkoutStatus.inProgress;
        final duration = workoutStatus == WorkoutStatus.finished
            ? editableWorkout.duration
            : null;
        final isTicking = duration == null;
        final startDateTime =
            editableWorkout.workout.startDateTime;

        final timer = isTicking
            ? WorkoutTimer.ticking(
                dateTime: startDateTime,
              )
            : WorkoutTimer.finished(
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
