import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:workout_app/database/dao/water_log_dao.dart';
import 'package:workout_app/database/model/water_log_entity.dart';

import 'dao_test_util.dart';

void main() {
  late Future<Database> database;
  late WaterLogDao waterLogDao;

  setUpAll(() async {
    database = setUpDatabase();

    waterLogDao = WaterLogDao();
    await waterLogDao.init(database);
  });

  setUp(() async {
    // GIVEN
    final entity1 = WaterLogEntity.create(
      volume: 500,
      dateTime: 1,
    );
    final entity2 = WaterLogEntity.create(
      volume: 250,
      dateTime: 2,
    );

    // WHEN
    final result1 = await waterLogDao.add(entity1);
    final result2 = await waterLogDao.add(entity2);

    // THEN
    expect(successData(result1), 1);
    expect(successData(result2), 2);
  });

  tearDown(() async {
    // GIVEN
    final filter = WaterLogEntityFilter(
      ids: [1, 2],
    );

    // WHEN
    final result = await waterLogDao.delete(filter);

    // THEN
    expect(successData(result), true);
  });

  test('Find all', () async {
    // WHEN
    final result = await waterLogDao.findAll();

    // THEN
    final data = successData(result);
    expect(data.length, 2);
    verifyWaterLogEntity(
      data[0],
      expectedId: 1,
      expectedVolume: 500,
      expectedDateTime: 1,
    );
    verifyWaterLogEntity(
      data[1],
      expectedId: 2,
      expectedVolume: 250,
      expectedDateTime: 2,
    );
  });

  test('Find by filter', () async {
    // GIVEN
    final filter = WaterLogEntityFilter(id: 1);

    // WHEN
    final result = await waterLogDao.findByFilter(filter);

    // THEN
    final data = successData(result);
    expect(data.length, 1);
    verifyWaterLogEntity(
      data[0],
      expectedId: 1,
      expectedVolume: 500,
      expectedDateTime: 1,
    );
  });

  test('Update', () async {
    // GIVEN
    const id = 1;
    await waterLogDao.verifyWaterLogEntityById(
      id,
      expectedId: 1,
      expectedVolume: 500,
      expectedDateTime: 1,
    );

    // WHEN
    final entity = WaterLogEntity.update(
      id: id,
      volume: 700,
    );
    final result = await waterLogDao.update(entity);

    // THEN
    final data = successData(result);
    expect(data, true);
    await waterLogDao.verifyWaterLogEntityById(
      id,
      expectedId: 1,
      expectedVolume: 700,
      expectedDateTime: 1,
    );
  });
}
