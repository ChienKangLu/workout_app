import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../weight_training_view_model.dart';
import 'weight_training_more_action_item.dart';
import 'weight_training_title.dart';

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

    if (weightTrainingViewModel.isWorkoutFinished && uiMode == UiMode.edit) {
      return _appBarInEditMode(context);
    }

    return _appBarInNormalMode(context);
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

  Widget _appBarInNormalMode(BuildContext context) {
    return AppBar(
      title: const WeightTrainingTitle(),
      actions: [
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
