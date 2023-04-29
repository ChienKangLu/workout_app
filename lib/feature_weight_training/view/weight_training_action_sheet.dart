import 'package:flutter/material.dart';

import '../../util/localization_util.dart';
import '../../core_view/list_item.dart';

class WeightTrainingActionSheet extends StatelessWidget {
  const WeightTrainingActionSheet({
    Key? key,
    required this.onEditItemClicked,
  }) : super(key: key);

  final void Function() onEditItemClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListItem(
              text: LocalizationUtil.localize(context).actionItemEdit,
              onTap: onEditItemClicked,
            ),
          ],
        ),
      ),
    );
  }
}
