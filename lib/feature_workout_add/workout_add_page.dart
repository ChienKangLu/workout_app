import 'package:flutter/material.dart';

import '../util/snapshot_extension.dart';
import 'view/workout_add_close_button.dart';
import 'view/workout_add_title.dart';
import 'view/workout_category_list.dart';
import 'workout_add_view_model.dart';

class WorkoutAddPage extends StatefulWidget {
  static const routeName = "/workout_add";

  const WorkoutAddPage({Key? key}) : super(key: key);

  @override
  State<WorkoutAddPage> createState() => _WorkoutAddPageState();
}

class _WorkoutAddPageState extends State<WorkoutAddPage> {
  late final WorkoutAddViewModel _model;
  late Future<WorkoutAddUiState> _workoutAddUiState;

  @override
  void initState() {
    _model = WorkoutAddViewModel();
    _workoutAddUiState = _model.workoutAddUiState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              const WorkoutAddTitle(),
              FutureBuilder<WorkoutAddUiState>(
                future: _workoutAddUiState,
                builder: (context, snapshot) => snapshot.handle(
                    onWaiting: () => const SizedBox(),
                    onError: () => Text("${snapshot.error}"),
                    onEmptyData: () => const SizedBox(),
                    onDone: (data) => WorkoutCategoryList(
                          workoutCategories: data.workoutCategories,
                          onCategoryClicked: (category) async {
                            final navigator = Navigator.of(context);
                            await _model.createWorkout(category);
                            navigator.pop();
                          },
                        )),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            child: WorkoutAddCloseButton(
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
