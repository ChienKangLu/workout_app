import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:workout_app/database/dao/dao_result.dart';
import 'package:workout_app/database/dao/exercise_dao.dart';
import 'package:workout_app/database/dao/exercise_set_dao.dart';
import 'package:workout_app/database/dao/water_goal_dao.dart';
import 'package:workout_app/database/dao/water_log_dao.dart';
import 'package:workout_app/database/dao/workout_dao.dart';
import 'package:workout_app/database/database_initializer.dart';
import 'package:workout_app/database/model/embedded_object/exercise_statistic_entity.dart';
import 'package:workout_app/database/model/embedded_object/workout_with_exercises_and_sets_entity.dart';
import 'package:workout_app/database/model/exercise_entity.dart';
import 'package:workout_app/database/model/exercise_set_entity.dart';
import 'package:workout_app/database/model/water_goal_entity.dart';
import 'package:workout_app/database/model/water_log_entity.dart';
import 'package:workout_app/database/model/workout_detail_entity.dart';
import 'package:workout_app/database/model/workout_entity.dart';

Future<Database> setUpDatabase() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  final dbInitializer = DatabaseInitializer();

  return databaseFactory.openDatabase(
    inMemoryDatabasePath,
    options: OpenDatabaseOptions(
      onConfigure: dbInitializer.onConfigure,
      onCreate: dbInitializer.onCreate,
      onUpgrade: dbInitializer.onUpgrade,
      onOpen: dbInitializer.onOpen,
      version: dbInitializer.version,
    ),
  );
}

void verifyWorkoutEntity(
  WorkoutEntity entity, {
  int? expectedWorkoutId,
  int? expectedCreateDateTime,
  int? expectedStartDateTime,
  int? expectedEndDateTime,
}) {
  expect(entity.workoutId, expectedWorkoutId);
  expect(entity.createDateTime, expectedCreateDateTime);
  expect(entity.startDateTime, expectedStartDateTime);
  expect(entity.endDateTime, expectedEndDateTime);
}

extension WorkoutDaoExtension on WorkoutDao {
  Future<void> verifyWorkoutEntityById(
    int id, {
    int? expectedWorkoutId,
    int? expectedCreateDateTime,
    int? expectedStartDateTime,
    int? expectedEndDateTime,
  }) async {
    verifyWorkoutEntity(
      successData(
        await findByFilter(WorkoutEntityFilter(id: id)),
      ).first,
      expectedWorkoutId: expectedWorkoutId,
      expectedCreateDateTime: expectedCreateDateTime,
      expectedStartDateTime: expectedStartDateTime,
      expectedEndDateTime: expectedEndDateTime,
    );
  }
}

void verifyExerciseEntity(
  ExerciseEntity entity, {
  int? expectedExerciseId,
  String? expectedName,
}) {
  expect(entity.exerciseId, expectedExerciseId);
  expect(entity.name, expectedName);
}

extension ExerciseDaoExtension on ExerciseDao {
  Future<void> verifyExerciseById(
    int id, {
    int? expectedExerciseId,
    String? expectedName,
  }) async {
    verifyExerciseEntity(
      successData(
        await findByFilter(ExerciseEntityFilter(id: id)),
      ).first,
      expectedExerciseId: expectedExerciseId,
      expectedName: expectedName,
    );
  }
}

void verifyWorkoutDetailEntity(
  WorkoutDetailEntity entity, {
  int? expectedWorkoutId,
  int? expectedExerciseId,
  int? expectedCreateDateTime,
}) {
  expect(entity.workoutId, expectedWorkoutId);
  expect(entity.exerciseId, expectedExerciseId);
  expect(entity.createDateTime, expectedCreateDateTime);
}

T successData<T>(DaoResult<T> result) {
  expect(result, isA<DaoSuccess<T>>());
  return (result as DaoSuccess<T>).data;
}

void verifyExerciseSetEntity(
  ExerciseSetEntity entity, {
  int? expectedWorkoutId,
  int? expectedExerciseId,
  int? expectedSetNum,
  double? expectedBaseWeight,
  double? expectedSideWeight,
  int? expectedRepetition,
  int? expectedEndDateTime,
}) {
  expect(entity.workoutId, expectedWorkoutId);
  expect(entity.exerciseId, expectedExerciseId);
  expect(entity.setNum, expectedSetNum);
  expect(entity.baseWeight, expectedBaseWeight);
  expect(entity.sideWeight, expectedSideWeight);
  expect(entity.repetition, expectedRepetition);
  expect(entity.endDateTime, expectedEndDateTime);
}

extension ExerciseSetDaoExtension on ExerciseSetDao {
  Future<void> verifyExerciseSetByPrimaryKey(
    int workoutId,
    int exerciseId,
    int setNum, {
    int? expectedWorkoutId,
    int? expectedExerciseId,
    int? expectedSetNum,
    double? expectedBaseWeight,
    double? expectedSideWeight,
    int? expectedRepetition,
    int? expectedEndDateTime,
  }) async {
    verifyExerciseSetEntity(
      successData(
        await findByFilter(ExerciseSetEntityFilter(
          workoutId: workoutId,
          exerciseId: exerciseId,
          setNum: setNum,
        )),
      ).first,
      expectedWorkoutId: expectedWorkoutId,
      expectedExerciseId: expectedExerciseId,
      expectedSetNum: expectedSetNum,
      expectedBaseWeight: expectedBaseWeight,
      expectedSideWeight: expectedSideWeight,
      expectedRepetition: expectedRepetition,
      expectedEndDateTime: expectedEndDateTime,
    );
  }
}

void verifyExerciseStatisticEntity(
  ExerciseStatisticEntity entity, {
  ExerciseStatisticEntity? expectedEntity,
}) {
  expect(entity, expectedEntity);
}

void verifyWaterGaolEntity(
  WaterGoalEntity? entity, {
  int? expectedId,
  double? expectedVolume,
  int? expectedDateTime,
}) {
  expect(entity?.id, expectedId);
  expect(entity?.volume, expectedVolume);
  expect(entity?.dateTime, expectedDateTime);
}

extension WaterGoalDaoExtension on WaterGoalDao {
  Future<void> verifyWaterGaolEntityById(
    int id, {
    int? expectedId,
    double? expectedVolume,
    int? expectedDateTime,
  }) async {
    verifyWaterGaolEntity(
      successData(
        await findByFilter(WaterGoalEntityFilter(id: id)),
      ).first,
      expectedId: expectedId,
      expectedVolume: expectedVolume,
      expectedDateTime: expectedDateTime,
    );
  }
}

void verifyWaterLogEntity(
  WaterLogEntity? entity, {
  int? expectedId,
  double? expectedVolume,
  int? expectedDateTime,
}) {
  expect(entity?.id, expectedId);
  expect(entity?.volume, expectedVolume);
  expect(entity?.dateTime, expectedDateTime);
}

extension WaterLogDaoExtension on WaterLogDao {
  Future<void> verifyWaterLogEntityById(
    int id, {
    int? expectedId,
    double? expectedVolume,
    int? expectedDateTime,
  }) async {
    verifyWaterLogEntity(
      successData(
        await findByFilter(WaterLogEntityFilter(id: id)),
      ).first,
      expectedId: expectedId,
      expectedVolume: expectedVolume,
      expectedDateTime: expectedDateTime,
    );
  }
}

void verifyWorkoutWithExercisesAndSetsEntity(
  WorkoutWithExercisesAndSetsEntity entity, {
  WorkoutWithExercisesAndSetsEntity? expectedEntity,
}) {
  expect(entity, expectedEntity);
}
