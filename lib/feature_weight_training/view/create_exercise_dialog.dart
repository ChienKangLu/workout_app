import 'package:flutter/material.dart';

import '../../core_view/custom_dialog.dart';
import '../../util/localization_util.dart';

class CreateExerciseDialog extends StatefulWidget {
  const CreateExerciseDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateExerciseDialog> createState() => _CreateExerciseDialogState();
}

class _CreateExerciseDialogState extends State<CreateExerciseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _exerciseNameController = TextEditingController();

  @override
  void dispose() {
    _exerciseNameController.dispose();
    super.dispose();
  }

  void onNegativeButtonClicked(BuildContext context) {
    Navigator.pop(context);
  }

  void onPositiveButtonClicked(BuildContext context) {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    Navigator.pop(context, _exerciseNameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: LocalizationUtil.localize(context).createExerciseDialogTitle,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: 48,
                child: TextFormField(
                  controller: _exerciseNameController,
                  decoration: InputDecoration(
                    labelText: LocalizationUtil.localize(context)
                        .exerciseNameTextFieldHint,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocalizationUtil.localize(context)
                          .exerciseNameTextFieldError;
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => onNegativeButtonClicked(context),
                  child: Text(LocalizationUtil.localize(context)
                      .createExerciseDialogNegativeBtn),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => onPositiveButtonClicked(context),
                  child: Text(LocalizationUtil.localize(context)
                      .createExerciseDialogPositiveBtn),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
