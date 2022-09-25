import 'package:flutter/material.dart';

import '../core_view/workout_category.dart';
import '../themes/workout_app_theme_data.dart';
import '../util/localization_util.dart';
import '../util/snapshot_extension.dart';
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
  Future<WeightTrainingUiState>? _weightTrainingState;

  WeightTrainingViewModel get _model => widget.model;

  @override
  void initState() {
    _weightTrainingState = _model.weightTrainingState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<WeightTrainingUiState>(
          future: _weightTrainingState,
          builder: (context, snapshot) => snapshot.handle(
            onDone: (data) => Text(
              "${WorkoutCategory.localizedString(context, data.category)} ${data.number}",
            ),
          ),
        ),
      ),
      body: FutureBuilder<WeightTrainingUiState>(
        future: _weightTrainingState,
        builder: (context, snapshot) => snapshot.handle(
          onDone: (data) => Container(
            margin: WorkoutAppThemeData.exerciseListContainerMargin,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.dateTime),
                  Text(_durationString(context, data.duration)),
                  WeightTrainingExerciseList(
                    weightTrainingExerciseListState: data.exerciseListUiState,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _durationString(BuildContext context, Duration duration) {
    List<String> displayTexts = <String>[];
    int hours = duration.inHours.remainder(24);
    if (hours > 0) {
      displayTexts
          .add("$hours ${LocalizationUtil.localize(context).hourUnitText}");
    }
    int minutes = duration.inMinutes.remainder(60);
    if (minutes > 0) {
      displayTexts
          .add("$minutes ${LocalizationUtil.localize(context).minuteUnitText}");
    }
    int seconds = duration.inSeconds.remainder(60);
    if (seconds > 0) {
      displayTexts
          .add("$seconds ${LocalizationUtil.localize(context).secondUnitText}");
    }
    int milliseconds = duration.inMilliseconds.remainder(1000);
    if (milliseconds > 0) {
      displayTexts.add(
          "$milliseconds ${LocalizationUtil.localize(context).millisecondUnitText}");
    }
    return displayTexts.join(" ");
  }
}
