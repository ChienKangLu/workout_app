import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    this.heading,
    this.trailing,
    required this.text,
    this.color,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final Widget? heading;
  final Widget? trailing;
  final String text;
  final Color? color;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    final titleLargeStyle = Theme.of(context).textTheme.titleLarge;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                heading ?? const SizedBox(),
                Expanded(
                  child: Text(
                    text,
                    style: titleLargeStyle?.copyWith(
                      color: color,
                    ),
                  ),
                ),
                trailing ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
