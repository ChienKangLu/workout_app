import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:workout_app/database/dao/exercise_dao.dart';
import 'package:workout_app/database/dao/exercise_set_dao.dart';
import 'package:workout_app/database/dao/workout_dao.dart';
import 'package:workout_app/database/dao/workout_detail_dao.dart';
import 'package:workout_app/database/model/embedded_object/exercise_statistic_entity.dart';
import 'package:workout_app/database/model/exercise_entity.dart';
import 'package:workout_app/database/model/exercise_set_entity.dart';
import 'package:workout_app/database/model/monthly_max_weight_entity.dart';
import 'package:workout_app/database/model/workout_detail_entity.dart';
import 'package:workout_app/database/model/workout_entity.dart';

import 'dao_test_util.dart';

void main() {
  late Future<Database> database;
  late ExerciseDao exerciseDao;
  late WorkoutDao workoutDao;
  late WorkoutDetailDao workoutDetailDao;
  late ExerciseSetDao exerciseSetDao;

  setUpAll(() async {
    database = setUpDatabase();

    exerciseDao = ExerciseDao();
    await exerciseDao.init(database);
    workoutDao = WorkoutDao();
    await workoutDao.init(database);
    workoutDetailDao = WorkoutDetailDao();
    await workoutDetailDao.init(database);
    exerciseSetDao = ExerciseSetDao();
    await exerciseSetDao.init(database);
  });

  setUp(() async {
    // GIVEN
    await exerciseDao.add(ExerciseEntity.create(
      name: "Squat",
    ));
    await exerciseDao.add(
      ExerciseEntity.create(name: "Bench press"),
    );
    await workoutDao.add(
      WorkoutEntity.create(
        createDateTime: 1,
        startDateTime: 2,
        endDateTime: 7,
      ),
    );
    await workoutDetailDao.add(
      WorkoutDetailEntity(
        workoutId: 1,
        exerciseId: 1,
        createDateTime: 3,
      ),
    );
    await workoutDetailDao.add(
      WorkoutDetailEntity(
        workoutId: 1,
        exerciseId: 2,
        createDateTime: 6,
      ),
    );

    final entity1 = ExerciseSetEntity.create(
      workoutId: 1,
      exerciseId: 1,
      baseWeight: 20,
      sideWeight: 0,
      repetition: 5,
      endDateTime: 4,
    );
    final entity2 = ExerciseSetEntity.create(
      workoutId: 1,
      exerciseId: 1,
      baseWeight: 20,
      sideWeight: 10,
      repetition: 5,
      endDateTime: 5,
    );
    final entity3 = ExerciseSetEntity.create(
      workoutId: 1,
      exerciseId: 2,
      baseWeight: 0,
      sideWeight: 10,
      repetition: 5,
      endDateTime: 7,
    );
    final entity4 = ExerciseSetEntity.create(
      workoutId: 1,
      exerciseId: 2,
      baseWeight: 0,
      sideWeight: 12.5,
      repetition: 5,
      endDateTime: 8,
    );

    // WHEN
    final result1 = await exerciseSetDao.add(entity1);
    final result2 = await exerciseSetDao.add(entity2);
    final result3 = await exerciseSetDao.add(entity3);
    final result4 = await exerciseSetDao.add(entity4);

    // THEN
    expect(successData(result1), 1);
    expect(successData(result2), 2);
    expect(successData(result3), 3);
    expect(successData(result4), 4);
  });

  tearDown(() async {
    // GIVEN
    final filter = ExerciseSetEntityFilter(workoutId: 1);

    // WHEN
    final result = await exerciseSetDao.delete(filter);

    // THEN
    expect(successData(result), true);
  });

  test('Find all', () async {
    // WHEN
    final result = await exerciseSetDao.findAll();

    // THEN
    final data = successData(result);
    expect(data.length, 4);
    verifyExerciseSetEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 1,
      expectedBaseWeight: 20,
      expectedSideWeight: 0,
      expectedRepetition: 5,
      expectedEndDateTime: 4,
    );
    verifyExerciseSetEntity(
      data[1],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 2,
      expectedBaseWeight: 20,
      expectedSideWeight: 10,
      expectedRepetition: 5,
      expectedEndDateTime: 5,
    );
    verifyExerciseSetEntity(
      data[2],
      expectedWorkoutId: 1,
      expectedExerciseId: 2,
      expectedSetNum: 1,
      expectedBaseWeight: 0,
      expectedSideWeight: 10,
      expectedRepetition: 5,
      expectedEndDateTime: 7,
    );
    verifyExerciseSetEntity(
      data[3],
      expectedWorkoutId: 1,
      expectedExerciseId: 2,
      expectedSetNum: 2,
      expectedBaseWeight: 0,
      expectedSideWeight: 12.5,
      expectedRepetition: 5,
      expectedEndDateTime: 8,
    );
  });

  test('Find by filter with workoutId and exerciseId', () async {
    // GIVEN
    final filter = ExerciseSetEntityFilter(workoutId: 1, exerciseId: 1);

    // WHEN
    final result = await exerciseSetDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 2);
    verifyExerciseSetEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 1,
      expectedBaseWeight: 20,
      expectedSideWeight: 0,
      expectedRepetition: 5,
      expectedEndDateTime: 4,
    );
    verifyExerciseSetEntity(
      data[1],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 2,
      expectedBaseWeight: 20,
      expectedSideWeight: 10,
      expectedRepetition: 5,
      expectedEndDateTime: 5,
    );
  });

  test('Find by filter with workoutId and exerciseId and setNum', () async {
    // GIVEN
    final filter = ExerciseSetEntityFilter(
      workoutId: 1,
      exerciseId: 1,
      setNum: 1,
    );

    // WHEN
    final result = await exerciseSetDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 1);
    verifyExerciseSetEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 1,
      expectedBaseWeight: 20,
      expectedSideWeight: 0,
      expectedRepetition: 5,
      expectedEndDateTime: 4,
    );
  });

  test('Find by filter with workoutIds', () async {
    // GIVEN
    final filter = ExerciseSetEntityFilter(workoutIds: [1]);

    // WHEN
    final result = await exerciseSetDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 4);
    verifyExerciseSetEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 1,
      expectedBaseWeight: 20,
      expectedSideWeight: 0,
      expectedRepetition: 5,
      expectedEndDateTime: 4,
    );
    verifyExerciseSetEntity(
      data[1],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 2,
      expectedBaseWeight: 20,
      expectedSideWeight: 10,
      expectedRepetition: 5,
      expectedEndDateTime: 5,
    );
    verifyExerciseSetEntity(
      data[2],
      expectedWorkoutId: 1,
      expectedExerciseId: 2,
      expectedSetNum: 1,
      expectedBaseWeight: 0,
      expectedSideWeight: 10,
      expectedRepetition: 5,
      expectedEndDateTime: 7,
    );
    verifyExerciseSetEntity(
      data[3],
      expectedWorkoutId: 1,
      expectedExerciseId: 2,
      expectedSetNum: 2,
      expectedBaseWeight: 0,
      expectedSideWeight: 12.5,
      expectedRepetition: 5,
      expectedEndDateTime: 8,
    );
  });

  test('Find by filter with exerciseIds', () async {
    // GIVEN
    final filter = ExerciseSetEntityFilter(exerciseIds: [1, 2]);

    // WHEN
    final result = await exerciseSetDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 4);
    verifyExerciseSetEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 1,
      expectedBaseWeight: 20,
      expectedSideWeight: 0,
      expectedRepetition: 5,
      expectedEndDateTime: 4,
    );
    verifyExerciseSetEntity(
      data[1],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 2,
      expectedBaseWeight: 20,
      expectedSideWeight: 10,
      expectedRepetition: 5,
      expectedEndDateTime: 5,
    );
    verifyExerciseSetEntity(
      data[2],
      expectedWorkoutId: 1,
      expectedExerciseId: 2,
      expectedSetNum: 1,
      expectedBaseWeight: 0,
      expectedSideWeight: 10,
      expectedRepetition: 5,
      expectedEndDateTime: 7,
    );
    verifyExerciseSetEntity(
      data[3],
      expectedWorkoutId: 1,
      expectedExerciseId: 2,
      expectedSetNum: 2,
      expectedBaseWeight: 0,
      expectedSideWeight: 12.5,
      expectedRepetition: 5,
      expectedEndDateTime: 8,
    );
  });

  test('Update', () async {
    // GIVEN
    const workoutId = 1;
    const exerciseId = 1;
    const setNum = 1;
    await exerciseSetDao.verifyExerciseSetByPrimaryKey(
      workoutId,
      exerciseId,
      setNum,
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 1,
      expectedBaseWeight: 20,
      expectedSideWeight: 0,
      expectedRepetition: 5,
      expectedEndDateTime: 4,
    );

    // WHEN
    final entity = ExerciseSetEntity.update(
      workoutId: 1,
      exerciseId: 1,
      setNum: 1,
      baseWeight: 20,
      sideWeight: 10,
      repetition: 8,
    );
    final result = await exerciseSetDao.update(entity);

    // THEN
    final data = successData(result);
    expect(data, true);
    await exerciseSetDao.verifyExerciseSetByPrimaryKey(
      workoutId,
      exerciseId,
      setNum,
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedSetNum: 1,
      expectedBaseWeight: 20,
      expectedSideWeight: 10,
      expectedRepetition: 8,
      expectedEndDateTime: 4,
    );
  });

  test('Get statistic', () async {
    // GIVEN
    const exerciseId = 1;

    // WHEN
    final result = await exerciseSetDao.getStatistic(exerciseId);

    // THEN
    final data = successData(result);
    verifyExerciseStatisticEntity(
      data,
      expectedEntity: ExerciseStatisticEntity(
        monthlyMaxWeightEntities: [
          MonthlyMaxWeightEntity(
            totalWeight: 40,
            endDateTime: 5,
            year: 1970,
            month: 1,
          ),
        ],
      ),
    );
  });
}
