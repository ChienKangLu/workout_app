import '../database/dao/composed_workout_dao.dart';
import '../database/dao/dao_provider_mixin.dart';
import '../database/model/workout_entity.dart';
import '../database/model/workout_type_entity.dart';
import '../model/conversion.dart';
import '../model/workout.dart';
import 'factory/workout_factory.dart';
import 'factory/workout_type_entity_factory.dart';
import 'factory/workout_type_factory.dart';

class WorkoutRepository with DaoProviderMixin {
  Future<List<WorkoutType>> get workoutTypes async => WorkoutTypeEntity.values
      .map((entity) => WorkoutTypeFactory.fromEntity(entity))
      .toList(growable: false);

  Future<int> createWorkout(WorkoutType type) async {
    final workoutTypeEntity = WorkoutTypeEntityFactory.fromType(type);
    return await workoutDao.add(
      WorkoutEntity.create(
        workoutTypeEntity: workoutTypeEntity,
        createDateTime: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<bool> updateWorkout(Workout workout) async {
    return await workoutDao.update(workout.asEntity());
  }

  Future<List<Workout>> getWorkouts({
    int? workoutId,
  }) async {
    final workoutWithExercisesAndSetsEntities =
        await composedWorkoutDao.findByFilter(
      WorkoutWithExercisesAndSetsEntityFilter(
        workoutId: workoutId,
      ),
    );
    return WorkoutFactory.createWorkouts(workoutWithExercisesAndSetsEntities);
  }
}
