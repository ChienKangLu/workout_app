import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../weight_training_view_model.dart';

class WeightTrainingAppBarActionItem extends StatelessWidget {
  const WeightTrainingAppBarActionItem({
    Key? key,
    required this.iconData,
    required this.onClick,
  }) : super(key: key);

  final void Function() onClick;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final weightTrainingUiState =
        context.watch<WeightTrainingViewModel>().weightTrainingUiState;

    return weightTrainingUiState.run(
      onLoading: () => _iconButton(false),
      onSuccess: (success) => _iconButton(true),
      onError: () => _iconButton(false),
    );
  }

  Widget _iconButton(bool isEnabled) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: isEnabled ? () => onClick() : null,
    );
  }
}
