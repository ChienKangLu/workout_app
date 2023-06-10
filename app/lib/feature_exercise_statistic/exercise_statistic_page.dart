import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/workout_app_theme_data.dart';
import 'exercise_statistic_view_model.dart';
import 'view/exercise_statistic_page_app_bar.dart';
import 'view/max_weight_chart.dart';

class ExerciseStatisticPage extends StatefulWidget {
  static const routeName = "/exercise_statistic";

  const ExerciseStatisticPage({
    Key? key,
    required this.exerciseId,
  }) : super(key: key);

  final int exerciseId;

  @override
  State<ExerciseStatisticPage> createState() => _ExerciseStatisticPageState();
}

class _ExerciseStatisticPageState extends State<ExerciseStatisticPage> {
  late final ExerciseStatisticViewModel _model;

  int get exerciseId => widget.exerciseId;

  @override
  void initState() {
    _model = ExerciseStatisticViewModel(exerciseId: exerciseId);

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _model),
      ],
      child: Scaffold(
        appBar: const ExerciseStatisticPageAppBar(),
        body: _exerciseStatisticPageView(),
      ),
    );
  }

  Widget _exerciseStatisticPageView() {
    return Consumer<ExerciseStatisticViewModel>(
      builder: (context, viewModel, child) {
        final exerciseStatisticUiState = viewModel.exerciseStatisticUiState;

        return exerciseStatisticUiState.run(
          onLoading: () => const SizedBox(),
          onSuccess: (success) {
            final exerciseReport = success.exerciseReport;
            final monthlyMaxWeightChartData =
                exerciseReport.monthlyMaxWeightChartData;

            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: WorkoutAppThemeData.pageMargin),
              child: ListView(
                children: [
                  MaxWeightChart(
                    monthlyMaxWeightChartData: monthlyMaxWeightChartData,
                  ),
                ],
              ),
            );
          },
          onError: () => const SizedBox(),
        );
      },
    );
  }
}
