import 'package:flutter/material.dart';

import '../../core_view/text_field_dialog.dart';
import '../../util/localization_util.dart';

class EditExerciseDialog extends StatelessWidget {
  const EditExerciseDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextFieldDialog(
      title: LocalizationUtil.localize(context).editExerciseDialogTitle,
      text: text,
      hint: LocalizationUtil.localize(context).exerciseNameTextFieldHint,
    );
  }
}
