import 'package:flutter/material.dart';

import '../../core_view/custom_dialog.dart';
import '../../util/localization_util.dart';

class TextFieldDialog extends StatefulWidget {
  const TextFieldDialog({
    Key? key,
    required this.title,
    this.text = "",
    required this.hint,
  }) : super(key: key);

  final String title;
  final String text;
  final String hint;

  @override
  State<TextFieldDialog> createState() => _TextFieldDialogState();
}

class _TextFieldDialogState extends State<TextFieldDialog> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  String get _title => widget.title;
  String get _text => widget.text;
  String get _hint => widget.hint;

  @override
  void initState() {
    _textController.text = _text;
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void onNegativeButtonClicked(BuildContext context) {
    Navigator.pop(context);
  }

  void onPositiveButtonClicked(BuildContext context) {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    Navigator.pop(context, _textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: _title,
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
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: _hint,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocalizationUtil.localize(context)
                          .dialogEmptyTextError;
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
                  child: Text(
                      LocalizationUtil.localize(context).dialogNegativeBtn),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => onPositiveButtonClicked(context),
                  child: Text(
                      LocalizationUtil.localize(context).dialogPositiveBtn),
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
