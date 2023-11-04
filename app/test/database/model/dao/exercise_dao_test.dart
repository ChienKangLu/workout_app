import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:workout_app/database/dao/exercise_dao.dart';
import 'package:workout_app/database/model/exercise_entity.dart';

import 'dao_test_util.dart';

void main() {
  late Future<Database> database;
  late ExerciseDao exerciseDao;

  setUpAll(() async {
    database = setUpDatabase();

    exerciseDao = ExerciseDao();
    await exerciseDao.init(database);
  });

  setUp(() async {
    // GIVEN
    final entity1 = ExerciseEntity.create(name: "Squat");
    final entity2 = ExerciseEntity.create(name: "Bench press");

    // WHEN
    final result1 = await exerciseDao.add(entity1);
    final result2 = await exerciseDao.add(entity2);

    // THEN
    expect(successData(result1), 1);
    expect(successData(result2), 2);
  });

  tearDown(() async {
    // GIVEN
    final filter = ExerciseEntityFilter(
      ids: [1, 2],
    );

    // WHEN
    final result = await exerciseDao.delete(filter);

    // THEN
    expect(successData(result), true);
  });

  test('Find all', () async {
    // WHEN
    final result = await exerciseDao.findAll();

    // THEN
    final data = successData(result);
    expect(data.length, 2);
    verifyExerciseEntity(
      data[0],
      expectedExerciseId: 1,
      expectedName: "Squat",
    );
    verifyExerciseEntity(
      data[1],
      expectedExerciseId: 2,
      expectedName: "Bench press",
    );
  });

  test('Find by filter', () async {
    // GIVEN
    final filter = ExerciseEntityFilter(id: 1);

    // WHEN
    final result = await exerciseDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 1);
    verifyExerciseEntity(
      data[0],
      expectedExerciseId: 1,
      expectedName: "Squat",
    );
  });

  test('Update', () async {
    // GIVEN
    const id = 1;
    await exerciseDao.verifyExerciseById(
      id,
      expectedExerciseId: 1,
      expectedName: "Squat",
    );

    // WHEN
    final entity = ExerciseEntity(
      exerciseId: 1,
      name: "Deadlift",
    );
    final result = await exerciseDao.update(entity);

    // THEN
    final data = successData(result);
    expect(data, true);
    await exerciseDao.verifyExerciseById(
      id,
      expectedExerciseId: 1,
      expectedName: "Deadlift",
    );
  });
}
