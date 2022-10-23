import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_view/ui_state.dart';
import '../core_view/util/duration_util.dart';
import '../core_view/workout_category.dart';
import '../core_view/workout_status.dart';
import '../themes/workout_app_theme_data.dart';
import '../core_view/action_sheet.dart';
import 'view/weight_training_exercise_list.dart';
import 'weight_training_view_model.dart';

class WeightTrainingPage extends StatefulWidget {
  static const routeName = "/weight_training";

  WeightTrainingPage({Key? key, required int workoutRecordId})
      : model = WeightTrainingViewModel(workoutRecordId: workoutRecordId),
        super(key: key);

  final WeightTrainingViewModel model;

  @override
  State<WeightTrainingPage> createState() => _WeightTrainingPageState();
}

class _WeightTrainingPageState extends State<WeightTrainingPage> {
  WeightTrainingViewModel get _model => widget.model;

  @override
  void initState() {
    _model.initModel();
    super.initState();
  }

  void _onMoreItemClicked() {
    showActionSheet(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: _model,
        child: Consumer<WeightTrainingViewModel>(
          builder: (context, model, child) {
            final weightTrainingState = model.weightTrainingUiState;
            final isCreated =
                weightTrainingState?.workoutStatus == WorkoutStatus.created;
            final isInProgress =
                weightTrainingState?.workoutStatus == WorkoutStatus.inProgress;

            return ActionSheet(
              hasStartItem: isCreated,
              hasAddExerciseItm: isInProgress,
              hasFinishItemItem: isInProgress,
              onStartItemClicked: _onStartItemClicked,
              onAddExerciseItemClicked: _onAddExerciseItemClicked,
              onFinishItemClicked: _onFinishItemClicked,
            );
          },
        ),
      ),
    );
  }

  void _onStartItemClicked() {
    _model.start();
    Navigator.pop(context);
  }

  void _onAddExerciseItemClicked() {
    Navigator.pop(context);
  }

  void _onFinishItemClicked() {
    _model.finish();
    Navigator.pop(context);
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
        if (model.uiState != UiState.success || weightTrainingUiState == null) {
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
      final enabled =
          model.uiState == UiState.success && weightTrainingUiState != null;

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
        if (model.uiState != UiState.success || weightTrainingUiState == null) {
          return const SizedBox();
        }

        return Container(
          margin: WorkoutAppThemeData.exerciseListContainerMargin,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weightTrainingUiState.startDateTime),
                Text(DurationUtil.displayText(
                    context, weightTrainingUiState.duration)),
                WeightTrainingExerciseList(
                  exerciseListUiState:
                      weightTrainingUiState.exerciseListUiState,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
