import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/custom_dialog.dart';
import '../../core_view/empty_view.dart';
import '../../core_view/list_item.dart';
import '../../util/assets.dart';
import '../../util/localization_util.dart';
import '../workout_view_model.dart';

class ExerciseOptionDialog extends StatelessWidget {
  const ExerciseOptionDialog({
    Key? key,
    required this.onNewExercise,
    required this.onExerciseSelected,
  }) : super(key: key);

  final void Function() onNewExercise;
  final void Function(int) onExerciseSelected;

  @override
  Widget build(BuildContext context) {
    final exerciseOptionListUiState =
        context.watch<WorkoutViewModel>().exerciseOptionListUiState;

    return exerciseOptionListUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final exerciseOptions = success.exerciseOptions;

        return CustomDialog(
          title: LocalizationUtil.localize(context).exerciseOptionDialogTitle,
          child: exerciseOptions.isEmpty
              ? ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: EmptyView(
                    assetName: Assets.exerciseListEmpty,
                    header: LocalizationUtil.localize(context)
                        .exerciseListEmptyHeader,
                    body: LocalizationUtil.localize(context)
                        .exerciseListEmptyBody,
                    buttonTitle: LocalizationUtil.localize(context)
                        .createExerciseButton,
                    onAction: () {
                      Navigator.pop(context);
                      onNewExercise();
                    },
                  ),
                ),
              )
              : ListView.builder(
                  itemCount: exerciseOptions.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ListItem(
                        text: LocalizationUtil.localize(context)
                            .newExerciseOptionTitle,
                        color: Theme.of(context).colorScheme.primary,
                        onTap: () {
                          Navigator.pop(context);
                          onNewExercise();
                        },
                      );
                    }

                    final exerciseOption = exerciseOptions[index - 1];
                    return ListItem(
                        text: exerciseOption.name,
                        onTap: () {
                          Navigator.pop(context);
                          onExerciseSelected(exerciseOption.exerciseId);
                        });
                  },
                ),
        );
      },
      onError: () => const SizedBox(),
    );
  }
}
