import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_view/action_bottom_sheet.dart';
import '../core_view/confirm_dialog.dart';
import '../core_view/ui_mode.dart';
import '../core_view/ui_mode_view_model.dart';
import '../core_view/util/sheet_util.dart';
import '../core_view/workout_status.dart';
import '../feature_exercise_statistic/exercise_statistic_page.dart';
import '../feature_setting_exercise/view/create_exercise_dialog.dart';
import '../themes/workout_app_theme_data.dart';
import '../util/localization_util.dart';
import '../util/weight_unit_convertor.dart';
import 'ui_state/workout_ui_state.dart';
import 'view/edit_set_sheet.dart';
import 'view/exercise_option_dialog.dart';
import 'view/exercise_list_view.dart';
import 'view/workout_page_app_bar.dart';
import 'view/workout_start_view.dart';
import 'view/workout_control_panel.dart';
import 'workout_view_model.dart';

class WorkoutPageArguments {
  WorkoutPageArguments({
    required this.workoutId,
    required this.number,
  });

  final int workoutId;
  final int number;
}

class WorkoutPage extends StatefulWidget {
  static const routeName = "/workout";

  const WorkoutPage({Key? key, required this.workoutPageArguments})
      : super(key: key);

  final WorkoutPageArguments workoutPageArguments;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late final WorkoutViewModel _model;
  late final UiModeViewModel _uiModeViewModel;

  int get workoutId => widget.workoutPageArguments.workoutId;
  int get number => widget.workoutPageArguments.number;

  @override
  void initState() {
    _model = WorkoutViewModel(workoutId: workoutId);
    _uiModeViewModel = UiModeViewModel();

    initViewModels();

    super.initState();
  }

  @override
  void dispose() {
    _model.release();
    super.dispose();
  }

  Future<void> initViewModels() async {
    await _model.init();

    _model.workoutUiState.run(
      onLoading: () {
        // Do nothing
      },
      onSuccess: (success) {
        final workoutStatus = success.editableWorkout.workoutStatus;
        switch (workoutStatus) {
          case WorkoutStatus.created:
          case WorkoutStatus.inProgress:
            _uiModeViewModel.switchTo(UiMode.edit);
            break;
          case WorkoutStatus.finished:
            break;
        }
      },
      onError: () {
        // Do nothing
      },
    );
  }

  void _onMoreItemClicked() {
    SheetUtil.showSheet(
      context: context,
      builder: (context) => ActionBottomSheet(actionItems: [
        ActionItem(
          title: LocalizationUtil.localize(context).actionItemEdit,
          onItemClicked: _onEditItemClicked,
        ),
      ]),
    );
  }

  void _onEditItemClicked() {
    Navigator.pop(context);
    _uiModeViewModel.switchTo(UiMode.edit);
  }

  void _onAppBarCloseButtonClicked() {
    _uiModeViewModel.switchTo(UiMode.normal);
  }

  void _onStartButtonClicked(EditableWorkout editableWorkout) {
    _model.startWorkout(editableWorkout);
  }

  void _onStopButtonClicked(EditableWorkout editableWorkout) {
    _model.finishWorkout(editableWorkout);
    _uiModeViewModel.switchTo(UiMode.normal);
  }

  void _onAddButtonClicked(EditableWorkout editableWorkout) async {
    showDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: _model,
        child: ExerciseOptionDialog(
          onNewExercise: _onNewExercise,
          onExerciseSelected: _onExerciseSelected,
        ),
      ),
    );
  }

  void _onNewExercise() async {
    final exerciseName = await showDialog<String>(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: _model,
        child: const CreateExerciseDialog(),
      ),
    );

    if (exerciseName == null) {
      return;
    }

    final exerciseId = await _model.createExercise(exerciseName);
    if (exerciseId != null) {
      await _model.addExercise(exerciseId);
    }
  }

  void _onExerciseSelected(int exerciseTypeId) async {
    await _model.addExercise(exerciseTypeId);
  }

  void _onAddSet(EditableExercise editableExercise) async {
    final editSetData = await SheetUtil.showSheet<EditSetData>(
      context: context,
      builder: (context) => EditSetSheet(
        title: LocalizationUtil.localize(context)
            .addExerciseSetTitle(editableExercise.name),
      ),
    );

    if (editSetData == null) {
      return;
    }

    final exerciseId = editableExercise.exerciseId;

    if (editSetData is CreateOrUpdateSetData) {
      _model.addExerciseSet(
        exerciseId: exerciseId,
        baseWeight: WeightUnitConvertor.convert(
            editSetData.baseWeight, editSetData.baseWeightUnit),
        sideWeight: WeightUnitConvertor.convert(
            editSetData.sideWeight, editSetData.sideWeightUnit),
        repetition: editSetData.repetition,
      );
    }
  }

  void _onEditSet(EditableExerciseSet editableExerciseSet) async {
    final editSetData = await SheetUtil.showSheet<EditSetData>(
      context: context,
      builder: (context) => EditSetSheet(
        title: LocalizationUtil.localize(context).editExerciseSetTitle,
        removeAllowed: true,
        repetition: editableExerciseSet.repetition,
        baseWeight: editableExerciseSet.set.baseWeight,
        sideWeight: editableExerciseSet.set.sideWeight,
      ),
    );

    if (editSetData == null) {
      return;
    }

    final exerciseId = editableExerciseSet.exerciseId;
    final number = editableExerciseSet.number;

    if (editSetData is CreateOrUpdateSetData) {
      _model.updateExerciseSet(
        exerciseId: exerciseId,
        setNum: number,
        baseWeight: WeightUnitConvertor.convert(
            editSetData.baseWeight, editSetData.baseWeightUnit),
        sideWeight: WeightUnitConvertor.convert(
            editSetData.sideWeight, editSetData.sideWeightUnit),
        repetition: editSetData.repetition,
      );
    } else if (editSetData is RemoveSetData) {
      _model.removeExerciseSet(
        exerciseId: exerciseId,
        setNum: number,
      );
    }
  }

  void _onRemoveExercise(int exerciseId) async {
    Navigator.of(context).pop();
    final shouldRemoveExercise = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        title:
            LocalizationUtil.localize(context).removeExerciseConfirmDialogTitle,
        positiveButtonTitle: LocalizationUtil.localize(context)
            .removeExerciseConfirmDialogPositiveBtn,
        negativeButtonTitle: LocalizationUtil.localize(context)
            .removeExerciseConfirmDialogNegativeBtn,
      ),
    );

    if (shouldRemoveExercise != true) {
      return;
    }

    _model.removeExerciseFromWorkout(exerciseId);
  }

  void _onStatisticButtonClicked(int exerciseId) async {
    Navigator.of(context).pop();
    _openExerciseStatisticPage(exerciseId);
  }

  void onExerciseListMoreButtonClicked(UiMode uiMode, int exerciseId) {
    SheetUtil.showSheet(
      context: context,
      builder: (context) => ActionBottomSheet(actionItems: [
        ActionItem(
          title: LocalizationUtil.localize(context).actionItemStatistic,
          onItemClicked: () => _onStatisticButtonClicked(exerciseId),
        ),
        if (uiMode == UiMode.edit)
          ActionItem(
            title: LocalizationUtil.localize(context).actionItemDelete,
            onItemClicked: () => _onRemoveExercise(exerciseId),
          ),
      ]),
    );
  }

  void _openExerciseStatisticPage(int exerciseId) async {
    await Navigator.pushNamed(
      context,
      ExerciseStatisticPage.routeName,
      arguments: exerciseId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _model),
        ChangeNotifierProvider.value(value: _uiModeViewModel),
      ],
      child: Scaffold(
        appBar: WorkoutPageAppBar(
          number: number,
          onMoreItemClicked: _onMoreItemClicked,
          onCloseButtonClicked: _onAppBarCloseButtonClicked,
        ),
        body: _workoutPageView(),
      ),
    );
  }

  Widget _workoutPageView() {
    return Consumer<WorkoutViewModel>(
      builder: (context, viewModel, child) {
        final workoutUiState = viewModel.workoutUiState;

        return workoutUiState.run(
          onLoading: () => const SizedBox(),
          onSuccess: (success) {
            final editableWorkout = success.editableWorkout;
            final workoutStatus = editableWorkout.workoutStatus;
            if (workoutStatus == WorkoutStatus.created) {
              return WorkoutStartView(
                onStartButtonClicked: () =>
                    _onStartButtonClicked(editableWorkout),
              );
            }

            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: WorkoutAppThemeData.pageMargin),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    WorkoutControlPanel(
                      onStopButtonClicked: () =>
                          _onStopButtonClicked(editableWorkout),
                      onAddButtonClicked: () =>
                          _onAddButtonClicked(editableWorkout),
                    ),
                    ExerciseListView(
                      editableExercises:
                          editableWorkout.editableExercises,
                      onAddSet: _onAddSet,
                      onEditSet: _onEditSet,
                      onMoreButtonClicked: onExerciseListMoreButtonClicked,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
          onError: () => const SizedBox(),
        );
      },
    );
  }
}
