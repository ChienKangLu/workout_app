import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_view/empty_view.dart';
import '../feature_setting/view/water_goal_dialog.dart';
import '../util/assets.dart';
import '../util/localization_util.dart';
import 'view/water_dialog.dart';
import 'view/water_indicator.dart';
import 'view/water_shortcut_list.dart';
import 'water_view_model.dart';

class WaterProgressPage extends StatefulWidget {
  const WaterProgressPage({super.key});

  @override
  State<WaterProgressPage> createState() => _WaterProgressPageState();
}

class _WaterProgressPageState extends State<WaterProgressPage> {
  WaterViewModel get _viewModel =>
      Provider.of<WaterViewModel>(context, listen: false);

  void _onGoalButtonClicked() async {
    final goal = await showDialog<String>(
      context: context,
      builder: (context) => const WaterGoalDialog(),
    );

    if (goal == null) {
      return;
    }

    await _viewModel.setGoal(double.parse(goal));
  }

  void _onShortcutItemTap(double? volume) async {
    if (volume == null) {
      final custom = await showDialog<String>(
        context: context,
        builder: (context) => const WaterDialog(),
      );

      if (custom == null) {
        return;
      }

      await _viewModel.addLog(double.parse(custom));
      return;
    }

    await _viewModel.addLog(volume);
  }

  @override
  Widget build(BuildContext context) {
    final waterUiState = context.watch<WaterViewModel>().waterUiState;

    return waterUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final waterData = success.waterData;
        final goal = waterData.goal;
        if (goal == null) {
          return EmptyView(
            assetName: Assets.waterProgressInit,
            header: LocalizationUtil.localize(context).waterProgressInitHeader,
            body: LocalizationUtil.localize(context).waterProgressInitBody,
            buttonTitle: LocalizationUtil.localize(context).waterGoalButton,
            onAction: _onGoalButtonClicked,
          );
        }

        final value = waterData.total ?? 0;

        return Column(
          children: [
            const Spacer(flex: 1),
            WaterIndicator(
              size: const Size(250, 250),
              trackColor: Theme.of(context).colorScheme.surfaceVariant,
              indicatorColor: Theme.of(context).colorScheme.primary,
              goal: goal,
              value: value,
            ),
            const Spacer(flex: 1),
            WaterShortcutList(
              onItemTap: _onShortcutItemTap,
            ),
            const Spacer(flex: 1),
          ],
        );
      },
      onError: () => const SizedBox(),
    );
  }
}
