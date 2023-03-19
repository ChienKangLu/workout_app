import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../ui_state/workout_list_ui_state.dart';

class ExerciseThumbnailList extends StatelessWidget {
  const ExerciseThumbnailList({
    Key? key,
    required this.exerciseThumbnails,
  }) : super(key: key);

  final List<ExerciseThumbnail> exerciseThumbnails;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: exerciseThumbnails.length,
      itemBuilder: (content, index) {
        return ExerciseThumbnailCard(
          exerciseThumbnail: exerciseThumbnails[index],
        );
      },
    );
  }
}

class ExerciseThumbnailCard extends StatelessWidget {
  const ExerciseThumbnailCard({
    Key? key,
    required this.exerciseThumbnail,
  }) : super(key: key);

  final ExerciseThumbnail exerciseThumbnail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: WorkoutAppThemeData.exerciseThumbnailMargin,
      padding: WorkoutAppThemeData.exerciseThumbnailPadding,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
        borderRadius: WorkoutAppThemeData.exerciseThumbnailBorderRadius,
      ),
      height: WorkoutAppThemeData.exerciseThumbnailHeight,
      child: Center(
        child: Text(
          exerciseThumbnail.name,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
    );
  }
}
