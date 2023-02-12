import 'package:flutter/material.dart';

import '../../themes/workout_app_theme_data.dart';
import '../workout_list_view_model.dart';

class ExerciseThumbnailList extends StatelessWidget {
  const ExerciseThumbnailList({
    Key? key,
    required this.exerciseThumbnailListState,
  }) : super(key: key);

  final ExerciseThumbnailListUiState exerciseThumbnailListState;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: exerciseThumbnailListState.exerciseThumbnails.length,
      itemBuilder: (content, index) {
        return ExerciseThumbnail(
          exerciseThumbnailState:
              exerciseThumbnailListState.exerciseThumbnails[index],
        );
      },
    );
  }
}

class ExerciseThumbnail extends StatelessWidget {
  const ExerciseThumbnail({
    Key? key,
    required this.exerciseThumbnailState,
  }) : super(key: key);

  final ExerciseThumbnailUiState exerciseThumbnailState;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: WorkoutAppThemeData.exerciseThumbnailMargin,
      padding: WorkoutAppThemeData.exerciseThumbnailPadding,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
        borderRadius: WorkoutAppThemeData.exerciseThumbnailBorderRadius,
      ),
      height: WorkoutAppThemeData.exerciseThumbnailWidth,
      child: Center(
        child: Text(
          exerciseThumbnailState.name,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
    );
  }
}
