import 'package:flutter/material.dart';

import '../../core_view/custom_dialog.dart';
import '../../core_view/list_item.dart';
import '../../util/localization_util.dart';
import '../weight_training_view_model.dart';

enum ExerciseOptionActionType {
  newExercise,
  selectExercise,
}

class ExerciseOptionAction {
  ExerciseOptionAction({
    required this.type,
    this.data,
  });

  ExerciseOptionAction.newExercise()
      : this(type: ExerciseOptionActionType.newExercise);

  ExerciseOptionAction.selectExercise(int exerciseTypeId)
      : this(
          type: ExerciseOptionActionType.selectExercise,
          data: exerciseTypeId,
        );

  final ExerciseOptionActionType type;
  dynamic data;
}

class ExerciseOptionDialog extends StatelessWidget {
  const ExerciseOptionDialog({
    Key? key,
    required this.exerciseOptionListUiState,
  }) : super(key: key);

  final ExerciseOptionListUiState exerciseOptionListUiState;

  void onItemClicked(BuildContext context, ExerciseOptionAction action) {
    Navigator.pop(context, action);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: LocalizationUtil.localize(context).exerciseOptionDialogTitle,
      child: ListView.builder(
        itemCount: exerciseOptionListUiState.exerciseOptionUiStates.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ListItem(
              text: LocalizationUtil.localize(context).newExerciseOptionTitle,
              color: Theme.of(context).colorScheme.primary,
              onTap: () => onItemClicked(
                context,
                ExerciseOptionAction.newExercise(),
              ),
            );
          }
          final exerciseOptionUiState =
              exerciseOptionListUiState.exerciseOptionUiStates[index - 1];

          return ListItem(
            text: exerciseOptionUiState.name,
            onTap: () => onItemClicked(
              context,
              ExerciseOptionAction.selectExercise(
                exerciseOptionUiState.exerciseTypeId,
              ),
            ),
          );
        },
      ),
    );
  }
}
