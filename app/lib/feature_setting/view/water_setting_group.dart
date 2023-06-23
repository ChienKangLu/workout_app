import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/localization_util.dart';
import '../water_setting_view_model.dart';
import 'water_goal_dialog.dart';
import 'setting_group_view.dart';
import 'setting_list_tile.dart';

class WaterSettingGroup extends StatefulWidget {
  const WaterSettingGroup({super.key});

  @override
  State<WaterSettingGroup> createState() => _WaterSettingGroupState();
}

class _WaterSettingGroupState extends State<WaterSettingGroup> {
  late final WaterSettingViewModel _model;

  @override
  void initState() {
    _model = WaterSettingViewModel();

    _initViewModels();

    super.initState();
  }

  @override
  void dispose() {
    _model.release();
    super.dispose();
  }

  Future<void> _initViewModels() async {
    await _model.init();
  }

  void _onGoalSettingClicked() async {
    final goal = await showDialog<String>(
      context: context,
      builder: (context) => const WaterGoalDialog(),
    );

    if (goal == null) {
      return;
    }

    await _model.setGoal(double.parse(goal));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _model),
      ],
      child: _view(),
    );
  }

  Widget _view() {
    return Consumer<WaterSettingViewModel>(
      builder: (context, viewModel, child) {
        final waterSettingUiState = viewModel.waterSettingUiState;

        return waterSettingUiState.run(
          onLoading: () => const SizedBox(),
          onSuccess: (success) {
            final waterSetting = success.waterSetting;
            final goal = waterSetting.goal;
            final goalText = goal == null
                ? LocalizationUtil.localize(context).settingWaterGoalEmptyText
                : "${goal.toInt()}ml";

            return SettingGroup(
              title: LocalizationUtil.localize(context).settingWaterTitle,
              settingList: [
                SettingListTitle(
                  title:
                      LocalizationUtil.localize(context).settingWaterGoalTitle,
                  text: goalText,
                  onTap: _onGoalSettingClicked,
                ),
              ],
            );
          },
          onError: () => const SizedBox(),
        );
      },
    );
  }
}
