import '../database/model/workout_record_entity.dart';
import '../repository/factory/workout_type_entity_factory.dart';
import 'workout.dart';

extension WorkoutConversion on Workout {
  WorkoutRecordEntity asEntity() => WorkoutRecordEntity(
    workoutRecordId: workoutRecordId,
    workoutTypeId: WorkoutTypeEntityFactory.fromType(type).id,
    workoutTypeIndex: index,
    createDateTime: createDateTime.microsecondsSinceEpoch,
    startDateTime: startDateTime?.microsecondsSinceEpoch,
    endDateTime: endDateTime?.microsecondsSinceEpoch,
  );
}