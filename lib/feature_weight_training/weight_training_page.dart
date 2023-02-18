import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_view/util/duration_util.dart';
import '../themes/workout_app_theme_data.dart';
import 'ui_state/weight_training_ui_state.dart';
import 'view/weight_training_action_sheet.dart';
import '../util/weight_unit_convertor.dart';
import 'view/add_set_sheet.dart';
import 'view/create_exercise_dialog.dart';
import 'view/exercise_option_dialog.dart';
import 'view/weight_training_exercise_list.dart';
import 'view/weight_training_more_action_item.dart';
import 'view/weight_training_title.dart';
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
    _model = WeightTrainingViewModel(workoutId: workoutId);

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
  }

  void _onMoreItemClicked() {
    showActionSheet(
        context: context,
        builder: (context) => ChangeNotifierProvider.value(
              value: _model,
              child: WeightTrainingActionSheet(
                onStartItemClicked: _onStartItemClicked,
                onAddExerciseItemClicked: _onAddExerciseItemClicked,
                onFinishItemClicked: _onFinishItemClicked,
              ),
            ));
  }

  void _onStartItemClicked(EditableWeightTraining editableWeightTraining) {
    Navigator.pop(context);
    _model.startWorkout(editableWeightTraining);
  }

  void _onFinishItemClicked(EditableWeightTraining editableWeightTraining) {
    Navigator.pop(context);
    _model.finishWorkout(editableWeightTraining);
  }

  void _onAddExerciseItemClicked(
    EditableWeightTraining editableWeightTraining,
  ) async {
    Navigator.pop(context);
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
            ));

    if (exerciseName == null) {
      return;
    }

    await _model.createExercise(exerciseName);
  }

  void _onExerciseSelected(int exerciseTypeId) async {
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
      baseWeight: WeightUnitConvertor.convert(
          addSetData.baseWeight, addSetData.baseWeightUnit),
      sideWeight: WeightUnitConvertor.convert(
          addSetData.sideWeight, addSetData.sideWeightUnit),
      repetition: addSetData.repetition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Scaffold(
        appBar: AppBar(
          title: const WeightTrainingTitle(),
          actions: [
            WeightTrainingAppBarActionItem(
              iconData: Icons.more_horiz,
              onClick: _onMoreItemClicked,
            ),
          ],
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

            return Container(
              margin: WorkoutAppThemeData.exerciseListContainerMargin,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(editableWeightTraining.startDateTime),
                    Text(
                      DurationUtil.displayText(
                        context,
                        editableWeightTraining.duration,
                      ),
                    ),
                    WeightTrainingExerciseList(
                      editableExercises:
                          editableWeightTraining.editableExercises,
                      onAddSet: onAddSet,
                    ),
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
