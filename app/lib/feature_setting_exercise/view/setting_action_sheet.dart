import 'package:flutter/material.dart';

import '../../util/localization_util.dart';
import '../../core_view/list_item.dart';

class SettingActionSheet extends StatelessWidget {
  const SettingActionSheet({
    Key? key,
    required this.onRenameItemClicked,
    required this.onDeleteItemClicked,
  }) : super(key: key);

  final void Function() onRenameItemClicked;
  final void Function() onDeleteItemClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListItem(
              text: LocalizationUtil.localize(context).actionItemRename,
              onTap: onRenameItemClicked,
            ),
            ListItem(
              text: LocalizationUtil.localize(context).actionItemDelete,
              onTap: onDeleteItemClicked,
            ),
          ],
        ),
      ),
    );
  }
}
