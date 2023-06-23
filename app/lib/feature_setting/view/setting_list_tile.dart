import 'package:flutter/material.dart';

class SettingListTitle extends StatelessWidget {
  const SettingListTitle({
    Key? key,
    required this.title,
    this.text,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String? text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final text = this.text;

    return ListTile(
      title: Row(
        children: [
          Expanded(child: Text(title)),
          if (text != null)
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
