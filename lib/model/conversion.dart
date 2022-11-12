import '../database/model/workout_entity.dart';
import '../repository/factory/workout_type_entity_factory.dart';
import 'workout.dart';

extension WorkoutConversion on Workout {
  WorkoutEntity asEntity() => WorkoutEntity(
        workoutId: workoutId,
        workoutTypeEntity: WorkoutTypeEntityFactory.fromType(type),
        workoutTypeNum: typeNum,
        createDateTime: createDateTime.millisecondsSinceEpoch,
        startDateTime: startDateTime?.millisecondsSinceEpoch,
        endDateTime: endDateTime?.millisecondsSinceEpoch,
      );
}
