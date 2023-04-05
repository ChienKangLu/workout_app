import 'package:flutter/material.dart';

import '../../core_view/list_item.dart';
import '../../core_view/ui_mode.dart';

class ExerciseOptionListItem extends StatelessWidget {
  const ExerciseOptionListItem({
    Key? key,
    required this.uiMode,
    required this.isSelected,
    required this.title,
    required this.onItemClick,
    required this.onItemLongClick,
    required this.onMoreItemClick,
  }) : super(key: key);

  final UiMode uiMode;
  final bool isSelected;
  final String title;
  final void Function() onItemClick;
  final void Function() onItemLongClick;
  final void Function() onMoreItemClick;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;

    return ListItem(
      heading: uiMode == UiMode.edit
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? primaryColor : onSurfaceColor,
                ),
                const SizedBox(width: 16),
              ],
            )
          : null,
      trailing: uiMode == UiMode.normal
          ? IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: onMoreItemClick,
            )
          : null,
      text: title,
      onTap: onItemClick,
      onLongPress: onItemLongClick,
    );
  }
}
