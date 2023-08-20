import 'package:flutter/material.dart';

import '../../util/localization_util.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({
    super.key,
    required this.task,
    required this.inProgressTitle,
    required this.completeTitle,
  });

  final Future<bool> Function() task;
  final String inProgressTitle;
  final String completeTitle;

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  Future<bool> Function() get _behavior => widget.task;
  String get _inProgressTitle => widget.inProgressTitle;
  String get _completeTitle => widget.completeTitle;

  bool _isDone = false;

  @override
  void initState() {
    _performTask();
    super.initState();
  }

  Future<void> _performTask() async {
    await Future.delayed(const Duration(seconds: 3));
    final isDone = await _behavior();

    if (!mounted) {
      return;
    }

    setState(() {
      _isDone = isDone;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) {
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final titleLargeStyle = Theme.of(context).textTheme.titleLarge;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Center(
              child: _isDone
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 48,
                    )
                  : const CircularProgressIndicator(color: Colors.white),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            _isDone ? _completeTitle : _inProgressTitle,
            textAlign: TextAlign.center,
            style: titleLargeStyle?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
