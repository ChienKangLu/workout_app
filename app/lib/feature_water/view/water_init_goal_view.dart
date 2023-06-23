import 'package:flutter/material.dart';

import '../../util/localization_util.dart';

class WaterInitGoalView extends StatelessWidget {
  const WaterInitGoalView({
    super.key,
    required this.onGoalButtonClicked,
  });

  final void Function() onGoalButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(flex: 1),
          const Icon(
            Icons.water_drop_sharp,
            size: 100,
          ),
          const SizedBox(height: 10),
          Text(
            LocalizationUtil.localize(context).waterInitDescription,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 40),
          FilledButton.tonal(
            onPressed: onGoalButtonClicked,
            child: Text(
              LocalizationUtil.localize(context).waterSetButtonTitle,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
