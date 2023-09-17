import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';
import '../water_view_model.dart';

class WaterTabBar extends StatefulWidget implements PreferredSizeWidget {
  const WaterTabBar({super.key});

  @override
  State<WaterTabBar> createState() => _WaterTabBarState();

  @override
  Size get preferredSize =>
      const Size.fromHeight(WorkoutAppThemeData.tabHeight);
}

class _WaterTabBarState extends State<WaterTabBar>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    final waterUiState = context.watch<WaterViewModel>().waterUiState;

    return waterUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final waterData = success.waterData;
        final goal = waterData.goal;

        return IgnorePointer(
          ignoring: goal == null,
          child: TabBar(
            tabs: [
              Tab(
                text: LocalizationUtil.localize(context).waterProgressTabTitle,
              ),
              Opacity(
                opacity: goal == null ? WorkoutAppThemeData.opacityDisabled : 1,
                child: Tab(
                  text: LocalizationUtil.localize(context).waterLogTabTitle,
                ),
              ),
            ],
          ),
        );
      },
      onError: () => const SizedBox(),
    );
  }
}
