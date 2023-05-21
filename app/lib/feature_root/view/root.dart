import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feature_workout_list/workout_list_page.dart';
import '../../util/localization_util.dart';
import '../destination.dart';
import '../root_view_model.dart';
import 'root_navigation_bar.dart';

class Root extends StatefulWidget {
  static const routeName = "/";

  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  static final List<Destination> _destinations = <Destination>[
    Destination(
      (context) => LocalizationUtil.localize(context).navigationHomeTitle,
      Icons.home,
      const WorkoutListPage(),
    ),
    Destination(
      (context) => LocalizationUtil.localize(context).navigationWaterTitle,
      Icons.water_drop_rounded,
      const Center(child: Text("TODO: Water")),
    ),
    Destination(
      (context) => LocalizationUtil.localize(context).navigationFoodTitle,
      Icons.local_fire_department,
      const Center(child: Text("TODO: Food")),
    ),
  ];

  int _selectedIndex = 0;

  late final RootViewModel _rootViewModel;

  @override
  void initState() {
    _rootViewModel = RootViewModel();

    initViewModels();

    super.initState();
  }

  Future<void> initViewModels() async {
    await _rootViewModel.init();
  }

  @override
  void dispose() {
    _rootViewModel.release();
    super.dispose();
  }

  void _onDestinationSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _rootViewModel),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: _destinations.mapIndexed((index, destination) {
              final widget = destination.widget;
              return Offstage(offstage: index != _selectedIndex, child: widget);
            }).toList(),
          ),
        ),
        bottomNavigationBar: RootNavigationBar(
          selectedIndex: _selectedIndex,
          destinations: _destinations,
          onDestinationSelected: _onDestinationSelected,
        ),
      ),
    );
  }
}
