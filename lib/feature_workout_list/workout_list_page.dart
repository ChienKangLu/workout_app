import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_view/workout_category.dart';
import '../feature_weight_training/weight_training_page.dart';
import '../feature_workout_add/workout_add_page.dart';
import '../util/log_util.dart';
import '../util/localization_util.dart';
import 'view/workout_list.dart';
import 'view/workout_list_page_bottom_bar.dart';
import 'workout_list_view_model.dart';

class WorkoutListPage extends StatefulWidget {
  static const _tag = "WorkoutListPage";
  static const routeName = "/workout_list";

  WorkoutListPage({Key? key})
      : model = WorkoutListViewModel(),
        super(key: key);

  final WorkoutListViewModel model;

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  WorkoutListViewModel get _model => widget.model;

  @override
  void initState() {
    _model.init();
    super.initState();
  }

  Future<void> _reload() async {
    await _model.update();
  }

  void _onAddItemClicked() async {
    await Navigator.pushNamed(context, WorkoutAddPage.routeName);
    await _reload();
  }

  void _onItemClick(WorkoutCategory category, int workoutId) async {
    switch (category) {
      case WorkoutCategory.weightTraining:
        await Navigator.pushNamed(
          context,
          WeightTrainingPage.routeName,
          arguments: workoutId,
        );
        _reload();
        break;
      case WorkoutCategory.running:
        Log.d(WorkoutListPage._tag, "TODO: page for running");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationUtil.localize(context).appTitle),
      ),
      body: _view(),
      bottomNavigationBar: WorkoutListPageBottomBar(
        onAddItemClicked: _onAddItemClicked,
      ),
    );
  }

  Widget _view() {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Consumer<WorkoutListViewModel>(
        builder: (_, viewModel, __) {
          final state = viewModel.workoutListUiState;
          return state.run(
            onLoading: () =>
                Text(LocalizationUtil.localize(context).loadingWorkoutText),
            onSuccess: () => WorkoutList(
              workoutListState: state,
              onItemClick: _onItemClick,
            ),
            onError: () => const Text("Error"),
          );
        },
      ),
    );
  }
}
