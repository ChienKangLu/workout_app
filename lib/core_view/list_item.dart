import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.text,
    this.color,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final Color? color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final titleLargeStyle = Theme.of(context).textTheme.titleLarge;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Text(
                  text,
                  style: titleLargeStyle?.copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
