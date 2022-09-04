import 'package:flutter/material.dart';

import 'view/workout_add_close_button.dart';
import 'view/workout_add_title.dart';
import 'view/workout_category_list.dart';
import 'workout_add_view_model.dart';

class WorkoutAddPage extends StatelessWidget {
  static const routeName = "/workout_add";

  WorkoutAddPage({Key? key})
      : _model = WorkoutAddViewModel(),
        super(key: key);

  final WorkoutAddViewModel _model;

  @override
  Widget build(BuildContext context) {
    final workoutAddUiState = _model.workoutAddUiState;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              const WorkoutAddTitle(),
              FutureBuilder<WorkoutAddUiState>(
                future: workoutAddUiState,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return WorkoutCategoryList(
                      workoutCategories: snapshot.data!.workoutCategories,
                      onCategoryClicked: (category) async {
                        final navigator = Navigator.of(context);
                        await _model.createRecord(category);
                        navigator.pop();
                      },
                    );
                  }
                  return Container();
                },
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
