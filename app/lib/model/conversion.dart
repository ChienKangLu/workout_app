import '../database/model/workout_entity.dart';
import 'workout.dart';

extension WorkoutConversion on Workout {
  WorkoutEntity asEntity() => WorkoutEntity(
        workoutId: workoutId,
        createDateTime: createDateTime.millisecondsSinceEpoch,
        startDateTime: startDateTime?.millisecondsSinceEpoch,
        endDateTime: endDateTime?.millisecondsSinceEpoch,
      );
}
