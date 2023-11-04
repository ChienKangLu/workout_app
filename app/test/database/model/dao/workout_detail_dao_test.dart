import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:workout_app/database/dao/exercise_dao.dart';
import 'package:workout_app/database/dao/workout_dao.dart';
import 'package:workout_app/database/dao/workout_detail_dao.dart';
import 'package:workout_app/database/model/exercise_entity.dart';
import 'package:workout_app/database/model/workout_detail_entity.dart';
import 'package:workout_app/database/model/workout_entity.dart';

import 'dao_test_util.dart';

void main() {
  late Future<Database> database;
  late ExerciseDao exerciseDao;
  late WorkoutDao workoutDao;
  late WorkoutDetailDao workoutDetailDao;

  setUpAll(() async {
    database = setUpDatabase();

    exerciseDao = ExerciseDao();
    await exerciseDao.init(database);
    workoutDao = WorkoutDao();
    await workoutDao.init(database);
    workoutDetailDao = WorkoutDetailDao();
    await workoutDetailDao.init(database);
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
        endDateTime: 5,
      ),
    );

    final entity1 = WorkoutDetailEntity(
      workoutId: 1,
      exerciseId: 1,
      createDateTime: 3,
    );
    final entity2 = WorkoutDetailEntity(
      workoutId: 1,
      exerciseId: 2,
      createDateTime: 4,
    );

    // WHEN
    final result1 = await workoutDetailDao.add(entity1);
    final result2 = await workoutDetailDao.add(entity2);

    // THEN
    expect(successData(result1), 1);
    expect(successData(result2), 2);
  });

  tearDown(() async {
    // GIVEN
    final filter = WorkoutDetailEntityFilter(workoutId: 1);

    // WHEN
    final result = await workoutDetailDao.delete(filter);

    // THEN
    expect(successData(result), true);
  });

  test('Find all', () async {
    // WHEN
    final result = await workoutDetailDao.findAll();

    // THEN
    final data = successData(result);
    expect(data.length, 2);
    verifyWorkoutDetailEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedCreateDateTime: 3,
    );
    verifyWorkoutDetailEntity(
      data[1],
      expectedWorkoutId: 1,
      expectedExerciseId: 2,
      expectedCreateDateTime: 4,
    );
  });

  test('Find by filter with workoutId and exerciseId', () async {
    // GIVEN
    final filter = WorkoutDetailEntityFilter(workoutId: 1, exerciseId: 1);

    // WHEN
    final result = await workoutDetailDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 1);
    verifyWorkoutDetailEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedCreateDateTime: 3,
    );
  });

  test('Find by filter with workoutIds', () async {
    // GIVEN
    final filter = WorkoutDetailEntityFilter(workoutIds: [1]);

    // WHEN
    final result = await workoutDetailDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 2);
    verifyWorkoutDetailEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedCreateDateTime: 3,
    );
    verifyWorkoutDetailEntity(
      data[1],
      expectedWorkoutId: 1,
      expectedExerciseId: 2,
      expectedCreateDateTime: 4,
    );
  });

  test('Find by filter with exerciseIds', () async {
    // GIVEN
    final filter = WorkoutDetailEntityFilter(exerciseIds: [1]);

    // WHEN
    final result = await workoutDetailDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 1);
    verifyWorkoutDetailEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedExerciseId: 1,
      expectedCreateDateTime: 3,
    );
  });

  test('Update (unimplemented)', () async {
    await expectLater(
      () => workoutDetailDao.update(
        WorkoutDetailEntity(
          workoutId: 1,
          exerciseId: 1,
          createDateTime: 1,
        ),
      ),
      throwsA(isA<UnimplementedError>()),
    );
  });
}
