import 'package:flutter/material.dart';

import '../../core_view/text_field_dialog.dart';
import '../../util/localization_util.dart';

class EditExerciseDialog extends StatelessWidget {
  const EditExerciseDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldDialog(
      title: LocalizationUtil.localize(context).editExerciseDialogTitle,
      hint: LocalizationUtil.localize(context).exerciseNameTextFieldHint,
    );
  }
}
