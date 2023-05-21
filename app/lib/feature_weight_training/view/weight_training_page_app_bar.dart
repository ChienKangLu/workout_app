import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../core_view/workout_status.dart';
import '../weight_training_view_model.dart';
import 'weight_training_more_action_item.dart';

class WeightTrainingPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const WeightTrainingPageAppBar({
    Key? key,
    required this.onMoreItemClicked,
    required this.onCloseButtonClicked,
  }) : super(key: key);

  final void Function() onMoreItemClicked;
  final void Function() onCloseButtonClicked;

  @override
  Widget build(BuildContext context) {
    final uiMode = context.watch<UiModeViewModel>().uiMode;
    final weightTrainingViewModel = context.watch<WeightTrainingViewModel>();
    final weightTrainingUiState = weightTrainingViewModel.weightTrainingUiState;

    return weightTrainingUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final editableWeightTraining = success.editableWeightTraining;
        final workoutStatus = editableWeightTraining.workoutStatus;
        if (workoutStatus == WorkoutStatus.finished && uiMode == UiMode.edit) {
          return _appBarInEditMode(context);
        }

        final title = "#${success.editableWeightTraining.number}";
        final startDateTimeTitle = editableWeightTraining.startDateTimeText;
        return _appBarInNormalMode(
          context,
          workoutStatus == WorkoutStatus.finished,
          title,
          startDateTimeTitle,
        );
      },
      onError: () => const SizedBox(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

  Widget _appBarInNormalMode(
    BuildContext context,
    bool isFinished,
    String title,
    String startDateTimeTitle,
  ) {
    return AppBar(
      title: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          if (startDateTimeTitle.isNotEmpty)
            Text(
              startDateTimeTitle,
              style: Theme.of(context).textTheme.bodySmall,
            )
        ],
      ),
      actions: [
        if (isFinished)
          WeightTrainingAppBarActionItem(
            iconData: Icons.more_horiz,
            onClick: onMoreItemClicked,
          ),
      ],
    );
  }

  Widget _appBarInEditMode(BuildContext context) {
    return AppBar(
      leading: _closeButton(context),
    );
  }

  Widget _closeButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: onCloseButtonClicked,
    );
  }
}
