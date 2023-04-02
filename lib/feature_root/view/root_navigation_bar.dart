import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/workout_app_theme_data.dart';
import '../destination.dart';
import '../root_view_model.dart';

class RootNavigationBar extends StatefulWidget {
  const RootNavigationBar({
    Key? key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  }) : super(key: key);

  final List<Destination> destinations;
  final int selectedIndex;
  final Function(int) onDestinationSelected;

  @override
  State<RootNavigationBar> createState() => _RootNavigationBarState();
}

class _RootNavigationBarState extends State<RootNavigationBar> {
  List<Destination> get _destinations => widget.destinations;
  int get _selectedIndex => widget.selectedIndex;
  Function(int) get _onDestinationSelected => widget.onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final isNavigationVisible =
        context.watch<RootViewModel>().isNavigationVisible;

    return _animatedContainer(
      isNavigationVisible: isNavigationVisible,
      child: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: _destinations
            .map(
              (destination) => NavigationDestination(
                icon: Icon(destination.icon),
                label: destination.title(context),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _animatedContainer({
    required Widget child,
    required bool isNavigationVisible,
  }) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final height = WorkoutAppThemeData.bottomBarHeight + bottomPadding;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isNavigationVisible ? height : 0,
      child: child,
    );
  }
}
