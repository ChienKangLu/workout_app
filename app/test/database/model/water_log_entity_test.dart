import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/model/water_log_entity.dart';
import 'package:workout_app/database/schema.dart';

void main() {
  const id = 1;
  const volume = 500.0;
  const dateTime = 1;

  late WaterLogEntity tested;

  void verifyEntity({
    int? expectedId,
    double? expectedVolume,
    int? expectedDateTime,
  }) {
    expect(tested.id, expectedId);
    expect(tested.volume, expectedVolume);
    expect(tested.dateTime, expectedDateTime);
  }

  void verifyMap(
    Map actualMap, {
    int? expectedId,
    double? expectedVolume,
    int? expectedDateTime,
  }) {
    expect(actualMap[WaterLogTable.columnWaterLogId], expectedId);
    expect(actualMap[WaterLogTable.columnWaterLogVolume], expectedVolume);
    expect(actualMap[WaterLogTable.columnWaterLogDateTime], expectedDateTime);
  }

  test('Entity for creation', () {
    // GIVEN
    tested = WaterLogEntity.create(volume: volume, dateTime: dateTime);

    // WHEN
    final map = tested.toMap();

    // THEN
    verifyEntity(
      expectedId: ignored,
      expectedVolume: volume,
      expectedDateTime: dateTime,
    );
    verifyMap(
      map,
      expectedId: null,
      expectedVolume: volume,
      expectedDateTime: dateTime,
    );
  });

  test('Entity for update', () {
    // GIVEN
    tested = WaterLogEntity.update(id: id, volume: volume);

    // WHEN
    final map = tested.toMap();

    // THEN
    verifyEntity(
      expectedId: id,
      expectedVolume: volume,
      expectedDateTime: ignored,
    );
    verifyMap(
      map,
      expectedId: id,
      expectedVolume: volume,
      expectedDateTime: null,
    );
  });

  test('Entity from map', () {
    // GIVEN
    final map = {
      WaterLogTable.columnWaterLogId: id,
      WaterLogTable.columnWaterLogVolume: volume,
      WaterLogTable.columnWaterLogDateTime: dateTime,
    };

    // WHEN
    tested = WaterLogEntity.fromMap(map);

    // THEN
    verifyMap(
      map,
      expectedId: id,
      expectedVolume: volume,
      expectedDateTime: dateTime,
    );
  });

  test('Equality operation and hash code', () {
    // GIVEN
    tested = WaterLogEntity(id: id, volume: volume, dateTime: dateTime);
    final other = WaterLogEntity(id: id, volume: volume, dateTime: dateTime);

    // WHEN
    final equalityResult = tested == other;

    // THEN
    expect(equalityResult, true);
    expect(tested.hashCode, other.hashCode);
  });

  test('String representation of entity', () {
    // GIVEN
    final map = {
      WaterLogTable.columnWaterLogId: id,
      WaterLogTable.columnWaterLogVolume: volume,
      WaterLogTable.columnWaterLogDateTime: dateTime,
    };
    tested = WaterLogEntity.fromMap(map);

    // WHEN
    final result = tested.toString();

    // THEN
    expect(result, map.toString());
  });
}
