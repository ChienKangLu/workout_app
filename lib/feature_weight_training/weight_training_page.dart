import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_view/util/duration_util.dart';
import '../core_view/workout_category.dart';
import '../core_view/workout_status.dart';
import '../themes/workout_app_theme_data.dart';
import '../core_view/action_sheet.dart';
import '../util/weight_unit_convertor.dart';
import 'view/add_set_sheet.dart';
import 'view/create_exercise_dialog.dart';
import 'view/exercise_option_dialog.dart';
import 'view/weight_training_exercise_list.dart';
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
  int get workoutId => widget.workoutId;

  @override
  void initState() {
    _model = WeightTrainingViewModel(workoutId: workoutId)..initModel();
    super.initState();
  }

  void _onMoreItemClicked() async {
    final actionType = await showActionSheet<ActionType>(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: _model,
        child: Consumer<WeightTrainingViewModel>(
          builder: (_, model, __) {
            final weightTrainingState = model.weightTrainingUiState;
            final isCreated =
                weightTrainingState?.workoutStatus == WorkoutStatus.created;
            final isInProgress =
                weightTrainingState?.workoutStatus == WorkoutStatus.inProgress;

            return ActionSheet(
              hasStartItem: isCreated,
              hasAddExerciseItm: isInProgress,
              hasFinishItemItem: isInProgress,
            );
          },
        ),
      ),
    );

    if (actionType == null) {
      return;
    }

    switch (actionType) {
      case ActionType.startWorkout:
        _onStartItemClicked();
        break;
      case ActionType.addExercise:
        _onAddExerciseItemClicked();
        break;
      case ActionType.finishWorkout:
        _onFinishItemClicked();
        break;
    }
  }

  void _onStartItemClicked() {
    _model.startWorkout();
  }

  void _onFinishItemClicked() {
    _model.finishWorkout();
  }

  void _onAddExerciseItemClicked() async {
    final exerciseOptionAction = await showDialog<ExerciseOptionAction>(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: _model,
        child: Consumer<WeightTrainingViewModel>(
          builder: (_, model, __) {
            final exerciseOptionListUiState = model.exerciseOptionListUiState;
            if (exerciseOptionListUiState == null) {
              return const SizedBox();
            }

            return ExerciseOptionDialog(
              exerciseOptionListUiState: exerciseOptionListUiState,
            );
          },
        ),
      ),
    );

    if (exerciseOptionAction == null) {
      return;
    }

    switch (exerciseOptionAction.type) {
      case ExerciseOptionActionType.newExercise:
        onNewExercise();
        break;
      case ExerciseOptionActionType.selectExercise:
        onExerciseSelected(exerciseOptionAction.data);
        break;
    }
  }

  void onNewExercise() async {
    final exerciseName = await showDialog<String>(
      context: context,
      builder: (context) => const CreateExerciseDialog(),
    );

    if (exerciseName == null) {
      return;
    }

    await _model.createExercise(exerciseName);
  }

  void onExerciseSelected(int exerciseTypeId) async {
    await _model.addExercise(exerciseTypeId);
  }

  void onAddSet(int exerciseId) async {
    final addSetData = await showActionSheet<AddSetData>(
      context: context,
      builder: (context) => const AddSetSheet(),
    );

    if (addSetData == null) {
      return;
    }

    _model.addExerciseSet(
      exerciseId: exerciseId,
      baseWeight: WeightUnitConvertor.convert(addSetData.baseWeight, addSetData.baseWeightUnit),
      sideWeight: WeightUnitConvertor.convert(addSetData.sideWeight, addSetData.sideWeightUnit),
      repetition: addSetData.repetition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Scaffold(
        appBar: AppBar(title: _title(), actions: [
          _moreItem(),
        ]),
        body: _weightTrainingPageView(),
      ),
    );
  }

  Widget _title() {
    return Consumer<WeightTrainingViewModel>(
      builder: (context, model, child) {
        final weightTrainingUiState = model.weightTrainingUiState;
        if (weightTrainingUiState == null) {
          return const SizedBox();
        }

        return Text(
          "${WorkoutCategory.localizedString(context, weightTrainingUiState.category)} ${weightTrainingUiState.number}",
        );
      },
    );
  }

  Widget _moreItem() {
    return Consumer<WeightTrainingViewModel>(builder: (context, model, child) {
      final weightTrainingUiState = model.weightTrainingUiState;
      final enabled = weightTrainingUiState != null;

      return IconButton(
        icon: const Icon(Icons.more_horiz),
        onPressed: enabled ? _onMoreItemClicked : null,
      );
    });
  }

  Widget _weightTrainingPageView() {
    return Consumer<WeightTrainingViewModel>(
      builder: (context, model, child) {
        final weightTrainingUiState = model.weightTrainingUiState;
        if (weightTrainingUiState == null) {
          return const SizedBox();
        }

        return Container(
          margin: WorkoutAppThemeData.exerciseListContainerMargin,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weightTrainingUiState.startDateTime),
                Text(
                  DurationUtil.displayText(
                    context,
                    weightTrainingUiState.duration,
                  ),
                ),
                WeightTrainingExerciseList(
                  exerciseListUiState:
                      weightTrainingUiState.exerciseListUiState,
                  onAddSet: onAddSet,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
