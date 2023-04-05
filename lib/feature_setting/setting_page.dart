import 'package:flutter/material.dart';

import '../feature_setting_exercise/setting_exercise_page.dart';
import '../util/localization_util.dart';
import 'view/setting_group_view.dart';
import 'view/setting_list_tile.dart';

class SettingPage extends StatefulWidget {
  static const routeName = "/setting_page";

  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationUtil.localize(context).settingPageTitle),
        toolbarHeight: 56,
      ),
      body: _view(),
    );
  }

  Widget _view() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SettingGroup(
          title: LocalizationUtil.localize(context).settingWorkoutTitle,
          settingList: [
            SettingListTitle(
              title: LocalizationUtil.localize(context)
                  .settingWorkoutEditExerciseTitle,
              onTap: () {
                Navigator.pushNamed(context, SettingExercisePage.routeName);
              },
            ),
          ],
        ),
      ],
    );
  }
}
