import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../water_log_page.dart';
import '../water_progress_page.dart';
import '../water_view_model.dart';

class WaterTabBarView extends StatefulWidget {
  const WaterTabBarView({super.key});

  @override
  State<WaterTabBarView> createState() => _WaterTabBarViewState();
}

class _WaterTabBarViewState extends State<WaterTabBarView> {
  @override
  Widget build(BuildContext context) {
    final waterUiState = context.watch<WaterViewModel>().waterUiState;

    return waterUiState.run(
      onLoading: () => const SizedBox(),
      onSuccess: (success) {
        final waterData = success.waterData;
        final goal = waterData.goal;

        return TabBarView(
          physics: goal == null ? const NeverScrollableScrollPhysics() : null,
          children: const [
            WaterProgressPage(),
            WaterLogPage(),
          ],
        );
      },
      onError: () => const SizedBox(),
    );
  }
}
