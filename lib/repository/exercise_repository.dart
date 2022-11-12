import '../database/dao/dao_provider_mixin.dart';
import '../database/dao/exercise_dao.dart';
import '../database/model/exercise_entity.dart';
import '../model/exercise.dart';
import '../model/workout.dart';
import 'factory/exercise_factory.dart';
import 'factory/workout_type_entity_factory.dart';

class ExerciseRepository with DaoProviderMixin {
  Future<List<Exercise>> getExercises(WorkoutType type) async {
    final workoutTypeEntity = WorkoutTypeEntityFactory.fromType(type);
    final exerciseEntities = await exerciseDao.findByFilter(
      ExerciseEntityFilter(
        workoutTypeEntity: workoutTypeEntity,
      ),
    );
    return exerciseEntities
        .map((entity) => ExerciseFactory.createExercise(entity))
        .toList();
  }

  Future<int> createExercise(WorkoutType type, String name) async {
    final workoutTypeEntity = WorkoutTypeEntityFactory.fromType(type);
    return await exerciseDao.add(
      ExerciseEntity.create(
        name: name,
        workoutType: workoutTypeEntity,
      ),
    );
  }
}
