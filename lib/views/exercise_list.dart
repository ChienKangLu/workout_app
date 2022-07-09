import 'package:flutter/material.dart';

import '../themes/workout_app_theme_data.dart';
import 'exercise_item.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({Key? key, required this.exerciseItems}) : super(key: key);

  final List<ExerciseItem> exerciseItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: exerciseItems.length,
      itemBuilder: (content, index) {
        return ExerciseListItem(exerciseItem: exerciseItems[index]);
      },
    );
  }
}

class ExerciseListItem extends StatelessWidget {
  const ExerciseListItem({Key? key, required this.exerciseItem}) : super(key: key);

  final ExerciseItem exerciseItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: WorkoutAppThemeData.exerciseItemMargin,
      padding: WorkoutAppThemeData.exerciseItemPadding,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
        borderRadius: WorkoutAppThemeData.exerciseItemBorderRadius,
      ),
      // width: WorkoutAppThemeData.exerciseItemWidth,
      height: WorkoutAppThemeData.exerciseItemWidth,
      child: Center(
        child: Text(
          exerciseItem.name,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
    );
  }
}
