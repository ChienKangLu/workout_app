import '../database/dao/exercise_dao.dart';
import '../database/dao/running_dao.dart';
import '../database/dao/weight_training_dao.dart';
import '../database/dao/workout_record_dao.dart';
import '../database/model/workout_record_entity.dart';
import '../database/model/workout_type_entity.dart';
import '../database/workout_database.dart';
import '../model/conversion.dart';
import '../model/workout.dart';
import 'factory/workout_factory.dart';
import 'factory/workout_type_entity_factory.dart';
import 'factory/workout_type_factory.dart';

class WorkoutRepository {
  WorkoutDatabase get _db => WorkoutDatabase.instance;
  ExerciseDao get exerciseDao => _db.exerciseDao;
  WorkoutRecordDao get workoutRecordDao => _db.workoutRecordDao;
  WeightTrainingDao get weightTrainingDao => _db.weightTrainingDao;
  RunningDao get runningDao => _db.runningDao;

  Future<List<WorkoutType>> get workoutTypes async => WorkoutTypeEntity.values
      .map((entity) => WorkoutTypeFactory.fromEntity(entity))
      .toList(growable: false);

  Future<int> createWorkout(WorkoutType type) async {
    final workoutTypeId = WorkoutTypeEntityFactory.fromType(type).id;
    return await workoutRecordDao.insertWorkoutRecord(
      WorkoutRecordEntity.create(
        workoutTypeId: workoutTypeId,
        createDateTime: DateTime.now().microsecondsSinceEpoch,
      ),
    );
  }

  Future<bool> updateWorkout(Workout workout) async {
    return await workoutRecordDao.update(workout.asEntity());
  }

  Future<List<Workout>> getWorkouts({
    int? workoutRecordId,
  }) async {
    final workoutRecordEntities =
        await workoutRecordDao.getWorkoutRecordEntities(
      workoutRecordId: workoutRecordId,
    );
    final weightTrainingWithExerciseEntities =
        await weightTrainingDao.getWeightTrainingWithExerciseEntities(
      workoutRecordId: workoutRecordId,
    );
    final runningWithExerciseEntities =
        await runningDao.getRunningWithExerciseEntities(
      workoutRecordId: workoutRecordId,
    );

    return WorkoutFactory.createWorkouts(
      workoutRecordEntities,
      [
        ...weightTrainingWithExerciseEntities,
        ...runningWithExerciseEntities,
      ],
    );
  }
}
