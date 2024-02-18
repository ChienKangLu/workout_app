import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/model/water_goal_entity.dart';
import 'package:workout_app/database/schema.dart';

void main() {
  const id = 1;
  const volume = 500.0;
  const dateTime = 1;

  late WaterGoalEntity tested;

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
    expect(actualMap[WaterGoalTable.columnWaterGoalId], expectedId);
    expect(actualMap[WaterGoalTable.columnWaterGoalVolume], expectedVolume);
    expect(actualMap[WaterGoalTable.columnWaterGoalDateTime], expectedDateTime);
  }

  test('Entity for creation', () {
    // GIVEN
    tested = WaterGoalEntity.create(volume: volume, dateTime: dateTime);

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
    tested = WaterGoalEntity.update(id: id, volume: volume);

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
      WaterGoalTable.columnWaterGoalId: id,
      WaterGoalTable.columnWaterGoalVolume: volume,
      WaterGoalTable.columnWaterGoalDateTime: dateTime,
    };

    // WHEN
    tested = WaterGoalEntity.fromMap(map);

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
    tested = WaterGoalEntity(id: id, volume: volume, dateTime: dateTime);
    final other = WaterGoalEntity(id: id, volume: volume, dateTime: dateTime);

    // WHEN
    final equalityResult = tested == other;

    // THEN
    expect(equalityResult, true);
    expect(tested.hashCode, other.hashCode);
  });

  test('String representation of entity', () {
    // GIVEN
    final map = {
      WaterGoalTable.columnWaterGoalId: id,
      WaterGoalTable.columnWaterGoalVolume: volume,
      WaterGoalTable.columnWaterGoalDateTime: dateTime,
    };
    tested = WaterGoalEntity.fromMap(map);

    // WHEN
    final result = tested.toString();

    // THEN
    expect(result, map.toString());
  });
}
