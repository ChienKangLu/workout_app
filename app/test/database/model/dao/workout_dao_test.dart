import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:workout_app/database/dao/workout_dao.dart';
import 'package:workout_app/database/model/workout_entity.dart';

import 'dao_test_util.dart';

void main() {
  late Future<Database> database;
  late WorkoutDao workoutDao;

  setUpAll(() async {
    database = setUpDatabase();

    workoutDao = WorkoutDao();
    await workoutDao.init(database);
  });

  setUp(() async {
    // GIVEN
    final entity1 = WorkoutEntity.create(
      createDateTime: 1,
      startDateTime: 2,
      endDateTime: 3,
    );
    final entity2 = WorkoutEntity.create(
      createDateTime: 4,
      startDateTime: 5,
      endDateTime: 6,
    );

    // WHEN
    final result1 = await workoutDao.add(entity1);
    final result2 = await workoutDao.add(entity2);

    // THEN
    expect(successData(result1), 1);
    expect(successData(result2), 2);
  });

  tearDown(() async {
    // GIVEN
    final filter = WorkoutEntityFilter(
      ids: [1, 2],
    );

    // WHEN
    final result = await workoutDao.delete(filter);

    // THEN
    expect(successData(result), true);
  });

  test('Find all', () async {
    // WHEN
    final result = await workoutDao.findAll();

    // THEN
    final data = successData(result);
    expect(data.length, 2);
    verifyWorkoutEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedCreateDateTime: 1,
      expectedStartDateTime: 2,
      expectedEndDateTime: 3,
    );
    verifyWorkoutEntity(
      data[1],
      expectedWorkoutId: 2,
      expectedCreateDateTime: 4,
      expectedStartDateTime: 5,
      expectedEndDateTime: 6,
    );
  });

  test('Find by filter', () async {
    // GIVEN
    final filter = WorkoutEntityFilter(id: 1);

    // WHEN
    final result = await workoutDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 1);
    verifyWorkoutEntity(
      data[0],
      expectedWorkoutId: 1,
      expectedCreateDateTime: 1,
      expectedStartDateTime: 2,
      expectedEndDateTime: 3,
    );
  });

  test('Update', () async {
    // GIVEN
    const id = 1;
    await workoutDao.verifyWorkoutEntityById(
      id,
      expectedWorkoutId: 1,
      expectedCreateDateTime: 1,
      expectedStartDateTime: 2,
      expectedEndDateTime: 3,
    );

    // WHEN
    final entity = WorkoutEntity(
      workoutId: 1,
      createDateTime: 1,
      startDateTime: 3,
      endDateTime: 3,
    );
    final result = await workoutDao.update(entity);

    // THEN
    final data = successData(result);
    expect(data, true);
    await workoutDao.verifyWorkoutEntityById(
      id,
      expectedWorkoutId: 1,
      expectedCreateDateTime: 1,
      expectedStartDateTime: 3,
      expectedEndDateTime: 3,
    );
  });
}
