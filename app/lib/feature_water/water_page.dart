import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/localization_util.dart';
import 'water_log_page.dart';
import 'water_progress_page.dart';
import 'water_view_model.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  @override
  State<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  late final WaterViewModel _model;

  @override
  void initState() {
    _model = WaterViewModel();

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _model),
      ],
      child: _waterView(),
    );
  }

  Widget _waterView() {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(LocalizationUtil.localize(context).waterProgressTodayTitle),
          bottom: TabBar(
            tabs: [
              Tab(
                text: LocalizationUtil.localize(context).waterProgressTabTitle,
              ),
              Tab(text: LocalizationUtil.localize(context).waterLogTabTitle),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            WaterProgressPage(),
            WaterLogPage(),
          ],
        ),
      ),
    );
  }
}
