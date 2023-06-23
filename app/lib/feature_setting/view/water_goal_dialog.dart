import 'package:flutter/material.dart';

import '../../core_view/text_field_dialog.dart';
import '../../util/localization_util.dart';

class WaterGoalDialog extends StatelessWidget {
  const WaterGoalDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldDialog(
      keyboardType: TextInputType.number,
      title: LocalizationUtil.localize(context).waterGoalDialogTitle,
      hint: LocalizationUtil.localize(context).waterGoalTextFieldHint,
    );
  }
}
