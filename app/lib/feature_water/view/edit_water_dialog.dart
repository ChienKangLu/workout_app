import 'package:flutter/material.dart';

import '../../core_view/text_field_dialog.dart';
import '../../util/localization_util.dart';

class EditWaterDialog extends StatelessWidget {
  const EditWaterDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextFieldDialog(
      keyboardType: TextInputType.number,
      title: LocalizationUtil.localize(context).editWaterDialogTitle,
      text: text,
      hint: LocalizationUtil.localize(context).editWaterDialogTextFieldHint,
    );
  }
}
