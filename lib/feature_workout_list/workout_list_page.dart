import 'package:flutter/material.dart';

import '../core_view/workout_category.dart';
import '../feature_weight_training/weight_training_page.dart';
import '../feature_workout_add/workout_add_page.dart';
import '../util/snapshot_extension.dart';
import '../util/localization_util.dart';
import 'view/workout_list.dart';
import 'view/workout_list_page_bottom_bar.dart';
import 'workout_list_view_model.dart';

class WorkoutListPage extends StatefulWidget {
  static const routeName = "/workout_list";

  WorkoutListPage({Key? key})
      : model = WorkoutListViewModel(),
        super(key: key);

  final WorkoutListViewModel model;

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  Future<WorkoutListUiState>? _workoutListUiState;

  WorkoutListViewModel get _model => widget.model;

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() {
    _workoutListUiState = _model.workoutListState;
  }

  void _onAddItemClicked() async {
    await Navigator.pushNamed(context, WorkoutAddPage.routeName);
    setState(() => _load());
  }

  void _onItemClick(WorkoutCategory category, int workoutRecordId) async {
    switch (category) {
      case WorkoutCategory.weightTraining:
        await Navigator.pushNamed(
          context,
          WeightTrainingPage.routeName,
          arguments: workoutRecordId,
        );
        setState(() => _load());
        break;
      case WorkoutCategory.running:
        // TODO: page for running
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationUtil.localize(context).appTitle),
      ),
      body: FutureBuilder<WorkoutListUiState>(
        future: _workoutListUiState,
        builder: (context, snapshot) => snapshot.handle(
          onWaiting: () =>
              Text(LocalizationUtil.localize(context).loadingWorkoutText),
          onError: () => Text("${snapshot.error}"),
          onEmptyData: () =>
              Text(LocalizationUtil.localize(context).emptyWorkoutText),
          onDone: (data) => WorkoutList(
            workoutListState: data,
            onItemClick: _onItemClick,
          ),
        ),
      ),
      bottomNavigationBar: WorkoutListPageBottomBar(
        onAddItemClicked: _onAddItemClicked,
      ),
    );
  }
}
