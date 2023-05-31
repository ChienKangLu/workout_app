import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_view/action_bottom_sheet.dart';
import '../core_view/confirm_dialog.dart';
import '../core_view/ui_mode.dart';
import '../core_view/ui_mode_view_model.dart';
import '../core_view/util/sheet_util.dart';
import '../core_view/workout_status.dart';
import '../feature_setting_exercise/view/create_exercise_dialog.dart';
import '../themes/workout_app_theme_data.dart';
import '../util/localization_util.dart';
import '../util/weight_unit_convertor.dart';
import 'ui_state/weight_training_ui_state.dart';
import 'view/edit_set_sheet.dart';
import 'view/exercise_info_dialog.dart';
import 'view/exercise_option_dialog.dart';
import 'view/weight_training_control_panel.dart';
import 'view/weight_training_exercise_list.dart';
import 'view/weight_training_page_app_bar.dart';
import 'view/weight_training_start_view.dart';
import 'weight_training_view_model.dart';

class WeightTrainingPage extends StatefulWidget {
  static const routeName = "/weight_training";

  const WeightTrainingPage({Key? key, required this.workoutId})
      : super(key: key);

  final int workoutId;

  @override
  State<WeightTrainingPage> createState() => _WeightTrainingPageState();
}

class _WeightTrainingPageState extends State<WeightTrainingPage> {
  late final WeightTrainingViewModel _model;
  late final UiModeViewModel _uiModeViewModel;

  int get workoutId => widget.workoutId;

  @override
  void initState() {
    _model = WeightTrainingViewModel(workoutId: workoutId);
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

    _model.weightTrainingUiState.run(
      onLoading: () {
        // Do nothing
      },
      onSuccess: (success) {
        final workoutStatus = success.editableWeightTraining.workoutStatus;
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

  void _onStartButtonClicked(EditableWeightTraining editableWeightTraining) {
    _model.startWorkout(editableWeightTraining);
  }

  void _onStopButtonClicked(EditableWeightTraining editableWeightTraining) {
    _model.finishWorkout(editableWeightTraining);
    _uiModeViewModel.switchTo(UiMode.normal);
  }

  void _onAddButtonClicked(
    EditableWeightTraining editableWeightTraining,
  ) async {
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

    await _model.createExercise(exerciseName);
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

  void _onInfoButtonClicked(int exerciseId) async {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (context) => ExerciseInfoDialog(
        exerciseId: exerciseId,
      ),
    );
  }

  void onExerciseListMoreButtonClicked(int exerciseId) {
    SheetUtil.showSheet(
      context: context,
      builder: (context) => ActionBottomSheet(actionItems: [
        ActionItem(
          title: LocalizationUtil.localize(context).actionItemInfo,
          onItemClicked: () => _onInfoButtonClicked(exerciseId),
        ),
        ActionItem(
          title: LocalizationUtil.localize(context).actionItemDelete,
          onItemClicked: () => _onRemoveExercise(exerciseId),
        ),
      ]),
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
        appBar: WeightTrainingPageAppBar(
          onMoreItemClicked: _onMoreItemClicked,
          onCloseButtonClicked: _onAppBarCloseButtonClicked,
        ),
        body: _weightTrainingPageView(),
      ),
    );
  }

  Widget _weightTrainingPageView() {
    return Consumer<WeightTrainingViewModel>(
      builder: (context, viewModel, child) {
        final weightTrainingUiState = viewModel.weightTrainingUiState;

        return weightTrainingUiState.run(
          onLoading: () => const SizedBox(),
          onSuccess: (success) {
            final editableWeightTraining = success.editableWeightTraining;
            final workoutStatus = editableWeightTraining.workoutStatus;
            if (workoutStatus == WorkoutStatus.created) {
              return WeightTrainingStartView(
                onStartButtonClicked: () =>
                    _onStartButtonClicked(editableWeightTraining),
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
                    WeightTrainingControlPanel(
                      onStopButtonClicked: () =>
                          _onStopButtonClicked(editableWeightTraining),
                      onAddButtonClicked: () =>
                          _onAddButtonClicked(editableWeightTraining),
                    ),
                    WeightTrainingExerciseList(
                      editableExercises:
                          editableWeightTraining.editableExercises,
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
