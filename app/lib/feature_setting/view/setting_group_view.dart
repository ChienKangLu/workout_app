import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';

class SettingGroup extends StatelessWidget {
  const SettingGroup({
    Key? key,
    required this.title,
    required this.settingList,
  }) : super(key: key);

  final String title;
  final List<Widget> settingList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ...settingList,
      ],
    );
  }
}
