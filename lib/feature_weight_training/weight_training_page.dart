import 'package:flutter/material.dart';

import '../model/workout.dart';
import '../themes/workout_app_theme_data.dart';
import '../util/localization_util.dart';
import 'view/weight_training_exercise_list.dart';
import 'weight_training_view_model.dart';

class WeightTrainingPage extends StatelessWidget {
  static const routeName = "/weight_training";

  WeightTrainingPage({
    Key? key,
    required this.weightTraining,
  }) : _model = WeightTrainingViewModel(weightTraining: weightTraining),
        super(key: key);

  final WeightTraining weightTraining;
  final WeightTrainingViewModel _model;

  @override
  Widget build(BuildContext context) {
    final WeightTrainingUiState weightTrainingState = _model.weightTrainingState;
    return Scaffold(
      appBar: AppBar(
        title: Text(weightTrainingState.name),
      ),
      body: Container(
        margin: WorkoutAppThemeData.exerciseListContainerMargin,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(weightTrainingState.dateTime),
              Text(_durationString(context, weightTrainingState.duration)),
              WeightTrainingExerciseList(
                weightTrainingExerciseListState: weightTrainingState.exerciseListUiState,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _durationString(BuildContext context, Duration duration) {
    List<String> displayTexts = <String>[];
    int hours = duration.inHours.remainder(24);
    if (hours > 0) {
      displayTexts.add("$hours ${LocalizationUtil.localize(context).hourUnitText}");
    }
    int minutes = duration.inMinutes.remainder(60);
    if (minutes > 0) {
      displayTexts.add("$minutes ${LocalizationUtil.localize(context).minuteUnitText}");
    }
    int seconds = duration.inSeconds.remainder(60);
    if (seconds > 0) {
      displayTexts.add("$seconds ${LocalizationUtil.localize(context).secondUnitText}");
    }
    int milliseconds = duration.inMilliseconds.remainder(1000);
    if (milliseconds > 0) {
      displayTexts.add("$milliseconds ${LocalizationUtil.localize(context).millisecondUnitText}");
    }
    return displayTexts.join(" ");
  }
}