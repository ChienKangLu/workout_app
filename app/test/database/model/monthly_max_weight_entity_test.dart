import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/model/monthly_max_weight_entity.dart';
import 'package:workout_app/database/schema.dart';

void main() {
  const totalWeight = 70.0;
  const endDateTime = 10;
  const year = 2023;
  const month = 7;

  late MonthlyMaxWeightEntity tested;

  void verifyMap(
    Map actualMap, {
    double? expectedTotalWeight,
    int? expectedEndDateTime,
    int? expectedYear,
    int? expectedMonth,
  }) {
    expect(
      actualMap[MonthlyMaxWeightEntity.columnTotalWeight],
      expectedTotalWeight,
    );
    expect(
      actualMap[ExerciseSetTable.columnSetEndDateTime],
      expectedEndDateTime,
    );
    expect(actualMap[MonthlyMaxWeightEntity.columnYear], expectedYear);
    expect(actualMap[MonthlyMaxWeightEntity.columnMonth], expectedMonth);
  }

  test('Entity from map', () {
    // GIVEN
    final map = {
      MonthlyMaxWeightEntity.columnTotalWeight: totalWeight,
      ExerciseSetTable.columnSetEndDateTime: endDateTime,
      MonthlyMaxWeightEntity.columnYear: year,
      MonthlyMaxWeightEntity.columnMonth: month,
    };

    // WHEN
    tested = MonthlyMaxWeightEntity.fromMap(map);

    // THEN
    verifyMap(
      map,
      expectedTotalWeight: totalWeight,
      expectedEndDateTime: endDateTime,
      expectedYear: year,
      expectedMonth: month,
    );
  });

  test('Equality operation and hash code', () {
    // GIVEN
    tested = MonthlyMaxWeightEntity(
      totalWeight: totalWeight,
      endDateTime: endDateTime,
      year: year,
      month: month,
    );
    final other = MonthlyMaxWeightEntity(
      totalWeight: totalWeight,
      endDateTime: endDateTime,
      year: year,
      month: month,
    );
    // WHEN
    final equalityResult = tested == other;

    // THEN
    expect(equalityResult, true);
    expect(tested.hashCode, other.hashCode);
  });

  test('String representation of entity', () {
    // GIVEN
    final map = {
      MonthlyMaxWeightEntity.columnTotalWeight: totalWeight,
      ExerciseSetTable.columnSetEndDateTime: endDateTime,
      MonthlyMaxWeightEntity.columnYear: year,
      MonthlyMaxWeightEntity.columnMonth: month,
    };
    tested = MonthlyMaxWeightEntity.fromMap(map);

    // WHEN
    final result = tested.toString();

    // THEN
    expect(result, map.toString());
  });
}
