import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core_view/ui_mode.dart';
import '../../../core_view/ui_mode_view_model.dart';
import '../../../util/localization_util.dart';
import '../setting_exercise_view_model.dart';

class SettingExercisePageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SettingExercisePageAppBar({
    Key? key,
    required this.onCloseButtonClicked,
    required this.onDeleteButtonClicked,
  }) : super(key: key);

  final void Function() onCloseButtonClicked;
  final void Function() onDeleteButtonClicked;

  @override
  Widget build(BuildContext context) {
    final uiMode = context.watch<UiModeViewModel>().uiMode;
    final selectedItemCount =
        context.watch<SettingExerciseViewModel>().selectedItemCount;

    if (uiMode == UiMode.edit) {
      return _appBarInEditMode(context, selectedItemCount);
    }

    return _appBarInNormalMode(context);
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);

  Widget _appBarInNormalMode(BuildContext context) {
    return AppBar(
      title: Text(
          LocalizationUtil.localize(context).settingWorkoutEditExerciseTitle),
      toolbarHeight: 56,
    );
  }

  Widget _appBarInEditMode(BuildContext context, int selectedWorkoutCount) {
    return AppBar(
      leading: _closeButton(context),
      title: Text(selectedWorkoutCount.toString()),
      actions: [deleteButton(context)],
      toolbarHeight: 56,
    );
  }

  Widget deleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: onDeleteButtonClicked,
    );
  }

  Widget _closeButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: onCloseButtonClicked,
    );
  }
}
