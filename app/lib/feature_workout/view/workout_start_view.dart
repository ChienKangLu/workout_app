import 'package:flutter/material.dart';

import '../../util/localization_util.dart';

class WorkoutStartView extends StatelessWidget {
  const WorkoutStartView({
    Key? key,
    required this.onStartButtonClicked,
  }) : super(key: key);

  final void Function() onStartButtonClicked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Spacer(flex: 1),
          Text(
            LocalizationUtil.localize(context).workoutStartMessage,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 30),
          FilledButton(
            onPressed: onStartButtonClicked,
            child: Text(
              LocalizationUtil.localize(context).workoutStartButtonTitle,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
