import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:workout_app/database/dao/water_goal_dao.dart';
import 'package:workout_app/database/model/water_goal_entity.dart';

import 'dao_test_util.dart';

void main() {
  late Future<Database> database;
  late WaterGoalDao waterGoalDao;

  setUpAll(() async {
    database = setUpDatabase();

    waterGoalDao = WaterGoalDao();
    await waterGoalDao.init(database);
  });

  setUp(() async {
    // GIVEN
    final entity1 = WaterGoalEntity.create(
      volume: 2000,
      dateTime: 1,
    );
    final entity2 = WaterGoalEntity.create(
      volume: 3000,
      dateTime: 2,
    );

    // WHEN
    final result1 = await waterGoalDao.add(entity1);
    final result2 = await waterGoalDao.add(entity2);

    // THEN
    expect(successData(result1), 1);
    expect(successData(result2), 2);
  });

  tearDown(() async {
    // GIVEN
    final filter = WaterGoalEntityFilter(
      ids: [1, 2],
    );

    // WHEN
    final result = await waterGoalDao.delete(filter);

    // THEN
    expect(successData(result), true);
  });

  test('Find all', () async {
    // WHEN
    final result = await waterGoalDao.findAll();

    // THEN
    final data = successData(result);
    expect(data.length, 2);
    verifyWaterGaolEntity(
      data[0],
      expectedId: 1,
      expectedVolume: 2000,
      expectedDateTime: 1,
    );
    verifyWaterGaolEntity(
      data[1],
      expectedId: 2,
      expectedVolume: 3000,
      expectedDateTime: 2,
    );
  });

  test('Find by filter', () async {
    // GIVEN
    final filter = WaterGoalEntityFilter(id: 1);

    // WHEN
    final result = await waterGoalDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 1);
    verifyWaterGaolEntity(
      data[0],
      expectedId: 1,
      expectedVolume: 2000,
      expectedDateTime: 1,
    );
  });

  test('Update', () async {
    // GIVEN
    const id = 1;
    await waterGoalDao.verifyWaterGaolEntityById(
      id,
      expectedId: 1,
      expectedVolume: 2000,
      expectedDateTime: 1,
    );

    // WHEN
    final entity = WaterGoalEntity.update(
      id: id,
      volume: 2500,
    );
    final result = await waterGoalDao.update(entity);

    // THEN
    final data = successData(result);
    expect(data, true);
    await waterGoalDao.verifyWaterGaolEntityById(
      id,
      expectedId: 1,
      expectedVolume: 2500,
      expectedDateTime: 1,
    );
  });


  test('Goal has been set', () async {
    // GIVEN
    const dateTime = 10;

    // WHEN
    final result = await waterGoalDao.goalOf(dateTime);

    // THEN
    final data = successData(result);

    verifyWaterGaolEntity(
      data,
      expectedId: 2,
      expectedVolume: 3000,
      expectedDateTime: 2,
    );
  });

  test('Goal has not been set', () async {
    // GIVEN
    await waterGoalDao.delete(WaterGoalEntityFilter(
      ids: [1, 2],
    ));
    const dateTime = 10;

    // WHEN
    final result = await waterGoalDao.goalOf(dateTime);

    // THEN
    final data = successData(result);

    verifyWaterGaolEntity(
      data,
      expectedId: null,
      expectedVolume: null,
      expectedDateTime: null,
    );
  });
}
