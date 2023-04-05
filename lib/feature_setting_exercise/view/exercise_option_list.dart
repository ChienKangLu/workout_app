import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/list_item.dart';
import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../util/localization_util.dart';
import '../setting_exercise_view_model.dart';
import '../ui_state/exercise_option_list_ui_state.dart';
import 'exercise_option_list_item.dart';

class ExerciseOptionList extends StatelessWidget {
  const ExerciseOptionList({
    Key? key,
    required this.onNewExercise,
    required this.onItemClick,
    required this.onItemLongClick,
    required this.onMoreItemClick,
  }) : super(key: key);

  final void Function() onNewExercise;
  final void Function(ExerciseOption) onItemClick;
  final void Function(ExerciseOption) onItemLongClick;
  final void Function(ExerciseOption) onMoreItemClick;

  @override
  Widget build(BuildContext context) {
    final exerciseOptionListUiState =
        context.watch<SettingExerciseViewModel>().exerciseOptionListUiState;
    final uiMode = context.watch<UiModeViewModel>().uiMode;

    return exerciseOptionListUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final exerciseOptions = success.exerciseOptions;

        return ListView.builder(
          itemCount: exerciseOptions.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Opacity(
                opacity: uiMode == UiMode.normal ? 1 : 0.5,
                child: IgnorePointer(
                  ignoring: uiMode == UiMode.edit,
                  child: ListItem(
                    text: LocalizationUtil.localize(context)
                        .newExerciseOptionTitle,
                    color: Theme.of(context).colorScheme.primary,
                    onTap: onNewExercise,
                  ),
                ),
              );
            }

            final optionIndex = index - 1;
            final exerciseOption = exerciseOptions[optionIndex];
            final isSelected = exerciseOption.isSelected;

            return ExerciseOptionListItem(
              uiMode: uiMode,
              isSelected: isSelected,
              title: exerciseOption.name,
              onItemClick: () => onItemClick(exerciseOption),
              onItemLongClick: () => onItemLongClick(exerciseOption),
              onMoreItemClick: () => onMoreItemClick(exerciseOption),
            );
          },
        );
      },
      onError: () => const SizedBox(),
    );
  }
}
