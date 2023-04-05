import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../core_view/workout_status.dart';
import '../../util/localization_util.dart';
import '../../core_view/list_item.dart';
import '../ui_state/weight_training_ui_state.dart';
import '../weight_training_view_model.dart';

class WeightTrainingActionSheet extends StatelessWidget {
  const WeightTrainingActionSheet({
    Key? key,
    required this.onStartItemClicked,
    required this.onAddExerciseItemClicked,
    required this.onFinishItemClicked,
    required this.onEditItemClicked
  }) : super(key: key);

  final void Function(EditableWeightTraining) onStartItemClicked;
  final void Function(EditableWeightTraining) onAddExerciseItemClicked;
  final void Function(EditableWeightTraining) onFinishItemClicked;
  final void Function() onEditItemClicked;

  @override
  Widget build(BuildContext context) {
    final weightTrainingUiState =
        context.watch<WeightTrainingViewModel>().weightTrainingUiState;
    final uiMode = context.watch<UiModeViewModel>().uiMode;

    return weightTrainingUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final editableWeightTraining = success.editableWeightTraining;

        final isCreated =
            editableWeightTraining.workoutStatus == WorkoutStatus.created;
        final isInProgress =
            editableWeightTraining.workoutStatus == WorkoutStatus.inProgress;
        final isFinished =
            editableWeightTraining.workoutStatus == WorkoutStatus.finished;

        return _view(
          context,
          editableWeightTraining: editableWeightTraining,
          hasStartItem: isCreated,
          hasAddExerciseItm: isInProgress,
          hasFinishItemItem: isInProgress,
          hasEditItem: isFinished && uiMode == UiMode.normal,
        );
      },
      onError: () => const SizedBox(),
    );
  }

  Widget _view(
    BuildContext context, {
    required EditableWeightTraining editableWeightTraining,
    required bool hasStartItem,
    required bool hasAddExerciseItm,
    required bool hasFinishItemItem,
    required bool hasEditItem,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (hasStartItem)
              ListItem(
                text: LocalizationUtil.localize(context).actionItemStart,
                onTap: () => onStartItemClicked(editableWeightTraining),
              ),
            if (hasAddExerciseItm)
              ListItem(
                text: LocalizationUtil.localize(context).actionItemAddExercise,
                onTap: () => onAddExerciseItemClicked(editableWeightTraining),
              ),
            if (hasFinishItemItem)
              ListItem(
                text: LocalizationUtil.localize(context).actionItemFinish,
                onTap: () => onFinishItemClicked(editableWeightTraining),
              ),
            if (hasEditItem)
              ListItem(
                text: LocalizationUtil.localize(context).actionItemEdit,
                onTap: onEditItemClicked,
              ),
          ],
        ),
      ),
    );
  }
}