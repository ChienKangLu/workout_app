import 'package:flutter/material.dart';

class WorkoutAddCloseButton extends StatelessWidget {
  const WorkoutAddCloseButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.close,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
