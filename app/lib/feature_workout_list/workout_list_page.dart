import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core_view/ui_mode.dart';
import '../core_view/ui_mode_view_model.dart';
import '../core_view/workout_category.dart';
import '../feature_root/root_view_model.dart';
import '../feature_setting/setting_page.dart';
import '../feature_weight_training/weight_training_page.dart';
import '../themes/workout_app_theme_data.dart';
import '../util/log_util.dart';
import '../util/localization_util.dart';
import 'ui_state/workout_list_ui_state.dart';
import 'view/workout_list.dart';
import 'view/workout_list_page_app_bar.dart';
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

    _uiModeViewModel.addListener(() {
      final rootViewModel = context.read<RootViewModel>();
      rootViewModel.isNavigationVisible =
          _uiModeViewModel.uiMode != UiMode.edit;
    });

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
    _uiModeViewModel.dispose();
    super.dispose();
  }

  Future<void> _reload() async {
    await _model.reload();
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

  void _onAppBarSettingButtonClicked() async {
    await Navigator.pushNamed(
      context,
      SettingPage.routeName,
    );
    _reload();
  }

  void _onAddItemClicked() async {
    const category = WorkoutCategory.weightTraining;
    final workoutId = await _model.createWorkout(category);
    if (workoutId != null) {
      _openPage(category, workoutId);
    }
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
          onSettingButtonClicked: _onAppBarSettingButtonClicked,
        ),
        body: _view(),
        floatingActionButton: Consumer<UiModeViewModel>(
          builder: (_, viewModel, __) {
            return AnimatedOpacity(
              opacity: viewModel.uiMode == UiMode.normal ? 1.0 : 0.0,
              duration: WorkoutAppThemeData.animationDuration,
              child: FloatingActionButton(
                onPressed: _onAddItemClicked,
                child: const Icon(Icons.add),
              ),
            );
          },
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