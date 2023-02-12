import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core_view/ui_mode.dart';
import '../../core_view/ui_mode_view_model.dart';
import '../../themes/workout_app_theme_data.dart';
import 'bottom_bar_item.dart';

class WorkoutListPageBottomBar extends StatelessWidget {
  const WorkoutListPageBottomBar({
    Key? key,
    required this.onAddItemClicked,
  }) : super(key: key);

  final void Function() onAddItemClicked;

  @override
  Widget build(BuildContext context) {
    final uiMode = context.watch<UiModeViewModel>().uiMode;

    return _animatedContainer(
      uiMode: uiMode,
      child: Wrap(
        children: [
          Container(
            height: WorkoutAppThemeData.bottomBarHeight,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomBarItem(
                    onTap: onAddItemClicked,
                    icon: Icons.add_box,
                    text: "Workout",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _animatedContainer({required child, required uiMode}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: uiMode == UiMode.edit ? 0 : WorkoutAppThemeData.bottomBarHeight,
      child: child,
    );
  }
}
