import 'package:flutter/material.dart';

import '../../core_view/custom_dialog.dart';
import '../util/localization_util.dart';

class ConfirmDialog extends StatefulWidget {
  const ConfirmDialog({
    Key? key,
    required this.title,
    this.positiveButtonTitle,
    this.negativeButtonTitle,
  }) : super(key: key);

  final String title;
  final String? positiveButtonTitle;
  final String? negativeButtonTitle;

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  String get _title => widget.title;
  String? get _positiveButtonTitle => widget.positiveButtonTitle;
  String? get _negativeButtonTitle => widget.negativeButtonTitle;

  @override
  void dispose() {
    super.dispose();
  }

  void onNegativeButtonClicked(BuildContext context) {
    Navigator.pop(context, false);
  }

  void onPositiveButtonClicked(BuildContext context) {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: _title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => onNegativeButtonClicked(context),
                child: Text(
                  _negativeButtonTitle ??
                      LocalizationUtil.localize(context)
                          .confirmDialogNegativeBtn,
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => onPositiveButtonClicked(context),
                child: Text(
                  _positiveButtonTitle ??
                      LocalizationUtil.localize(context)
                          .confirmDialogPositiveBtn,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
