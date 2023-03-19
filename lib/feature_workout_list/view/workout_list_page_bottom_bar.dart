import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../themes/workout_app_theme_data.dart';
import '../../util/localization_util.dart';

class WorkoutListPageBottomBar extends StatefulWidget {
  const WorkoutListPageBottomBar({
    Key? key,
    required this.onAddItemClicked,
  }) : super(key: key);

  final void Function() onAddItemClicked;

  @override
  State<WorkoutListPageBottomBar> createState() =>
      _WorkoutListPageBottomBarState();
}

class _WorkoutListPageBottomBarState extends State<WorkoutListPageBottomBar> {
  int currentPageIndex = 0;

  void onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
    if (index == 0) {
      widget.onAddItemClicked();
    }
  }

  @override
  Widget build(BuildContext context) {
    final uiMode = context.watch<UiModeViewModel>().uiMode;

    return _animatedContainer(
      uiMode: uiMode,
      child: NavigationBar(
        onDestinationSelected: onDestinationSelected,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: LocalizationUtil.localize(context).navigationHomeTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.water_drop_rounded),
            label: LocalizationUtil.localize(context).navigationWaterTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.local_fire_department),
            label: LocalizationUtil.localize(context).navigationFoodTitle,
          ),
        ],
      ),
    );
  }

  Widget _animatedContainer({required child, required uiMode}) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final height = WorkoutAppThemeData.bottomBarHeight + bottomPadding;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: uiMode == UiMode.edit ? 0 : height,
      child: child,
    );
  }
}
