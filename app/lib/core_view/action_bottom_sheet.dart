import 'package:flutter/material.dart';

import '../../core_view/list_item.dart';

class ActionItem {
  const ActionItem({
    required this.title,
    required this.onItemClicked,
  });

  final String title;
  final void Function() onItemClicked;
}

class ActionBottomSheet extends StatelessWidget {
  const ActionBottomSheet({
    Key? key,
    required this.actionItems,
  }) : super(key: key);

  final List<ActionItem> actionItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: actionItems
              .map(
                (item) => ListItem(
                  text: item.title,
                  onTap: item.onItemClicked,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
