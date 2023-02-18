import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core_view/ui_mode.dart';
import '../core_view/ui_mode_view_model.dart';
import '../core_view/workout_category.dart';
import '../feature_weight_training/weight_training_page.dart';
import '../feature_workout_add/workout_add_page.dart';
import '../util/log_util.dart';
import '../util/localization_util.dart';
import 'ui_state/workout_list_ui_state.dart';
import 'view/workout_list.dart';
import 'view/workout_list_page_app_bar.dart';
import 'view/workout_list_page_bottom_bar.dart';
import 'workout_list_view_model.dart';

class WorkoutListPage extends StatefulWidget {
  static const _tag = "WorkoutListPage";
  static const routeName = "/workout_list";

  const WorkoutListPage({Key? key}) : super(key: key);

  @override
  State<WorkoutListPage> createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  late final WorkoutListViewModel _model;
  late final UiModeViewModel _uiModeViewModel;

  @override
  void initState() {
    _model = WorkoutListViewModel();
    _uiModeViewModel = UiModeViewModel();

    initViewModels();

    super.initState();
  }

  Future<void> initViewModels() async {
    await _model.init();
    await _uiModeViewModel.init();
  }

  @override
  void dispose() {
    _model.release();
    super.dispose();
  }

  Future<void> _reload() async {
    await _model.reload();
  }

  void _onAddItemClicked() async {
    await Navigator.pushNamed(context, WorkoutAddPage.routeName);
    await _reload();
  }

  void _onItemClick(ReadableWorkout readableWorkout) async {
    final uiMode = _uiModeViewModel.uiMode;
    final category = readableWorkout.category;
    final workoutId = readableWorkout.workoutId;

    switch (uiMode) {
      case UiMode.normal:
        _openPage(category, workoutId);
        break;
      case UiMode.edit:
        _model.selectWorkout(readableWorkout);
        HapticFeedback.selectionClick();

        final selectedWorkoutCount = _model.selectedWorkoutCount;
        if (selectedWorkoutCount == 0) {
          _uiModeViewModel.switchTo(UiMode.normal);
        }
        break;
    }
  }

  void _openPage(WorkoutCategory category, int workoutId) async {
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

  void _onItemLongClick(ReadableWorkout readableWorkout) {
    final uiMode = _uiModeViewModel.uiMode;
    if (uiMode == UiMode.edit) {
      return;
    }

    _model.selectWorkout(readableWorkout);
    _uiModeViewModel.switchTo(UiMode.edit);
    HapticFeedback.selectionClick();
  }

  void _onAppBarCloseButtonClicked() {
    _model.unselectWorkouts();
    _uiModeViewModel.switchTo(UiMode.normal);
  }

  void _onAppBarDeleteButtonClicked() async {
    await _model.deleteSelectedWorkouts();
    _uiModeViewModel.switchTo(UiMode.normal);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _model),
        ChangeNotifierProvider.value(value: _uiModeViewModel),
      ],
      child: Scaffold(
        appBar: WorkoutListPageAppBar(
          onCloseButtonClicked: _onAppBarCloseButtonClicked,
          onDeleteButtonClicked: _onAppBarDeleteButtonClicked,
        ),
        body: _view(),
        bottomNavigationBar: WorkoutListPageBottomBar(
          onAddItemClicked: _onAddItemClicked,
        ),
      ),
    );
  }

  Widget _view() {
    return Consumer<WorkoutListViewModel>(
      builder: (_, viewModel, __) {
        final workoutListUiState = viewModel.workoutListUiState;

        return workoutListUiState.run(
          onLoading: () =>
              Text(LocalizationUtil.localize(context).loadingWorkoutText),
          onSuccess: (successState) => WorkoutList(
            workoutListState: successState,
            onItemClick: _onItemClick,
            onItemLongClick: _onItemLongClick,
          ),
          onError: () => const Text("Error"),
        );
      },
    );
  }
}
