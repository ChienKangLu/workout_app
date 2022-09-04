import 'package:flutter/material.dart';

import '../workout_add_view_model.dart';
import 'workout_category_list_item.dart';

class WorkoutCategoryList extends StatelessWidget {
  const WorkoutCategoryList({
    Key? key,
    required this.workoutCategories,
    required this.onCategoryClicked,
  }) : super(key: key);

  final List<WorkoutCategory> workoutCategories;
  final void Function(WorkoutCategory) onCategoryClicked;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workoutCategories.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Center(
          child: WorkoutCategoryListItem(
            workoutCategory: workoutCategories[index],
            onCategoryClicked: onCategoryClicked,
          ),
        );
      },
    );
  }
}
