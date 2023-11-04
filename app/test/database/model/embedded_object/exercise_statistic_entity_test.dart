import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/model/embedded_object/exercise_statistic_entity.dart';
import 'package:workout_app/database/model/monthly_max_weight_entity.dart';

void main() {
  const totalWeight = 70.0;
  const endDateTime = 1;
  const year = 2023;
  const month = 2;

  late ExerciseStatisticEntity tested;

  test('Entity for creation', () {
    // GIVEN
    final monthlyMaxWeightEntities = [
      MonthlyMaxWeightEntity(
        totalWeight: totalWeight,
        endDateTime: endDateTime,
        year: year,
        month: month,
      )
    ];
    tested = ExerciseStatisticEntity(
      monthlyMaxWeightEntities: monthlyMaxWeightEntities,
    );

    // WHEN
    tested = ExerciseStatisticEntity(
      monthlyMaxWeightEntities: monthlyMaxWeightEntities,
    );

    // THEN
    expect(tested.monthlyMaxWeightEntities, monthlyMaxWeightEntities);
  });

  test('Equality operation and hash code', () {
    // GIVEN
    tested = ExerciseStatisticEntity(
      monthlyMaxWeightEntities: [
        MonthlyMaxWeightEntity(
          totalWeight: totalWeight,
          endDateTime: endDateTime,
          year: year,
          month: month,
        )
      ],
    );
    final other = ExerciseStatisticEntity(
      monthlyMaxWeightEntities: [
        MonthlyMaxWeightEntity(
          totalWeight: totalWeight,
          endDateTime: endDateTime,
          year: year,
          month: month,
        )
      ],
    );

    // WHEN
    final equalityResult = tested == other;

    // THEN
    expect(equalityResult, true);
    expect(tested.hashCode, other.hashCode);
  });

  test('String representation of entity', () {
    // GIVEN
    tested = ExerciseStatisticEntity(
      monthlyMaxWeightEntities: [
        MonthlyMaxWeightEntity(
          totalWeight: totalWeight,
          endDateTime: endDateTime,
          year: year,
          month: month,
        )
      ],
    );

    // WHEN
    final result = tested.toString();

    // THEN
    expect(result, tested.toMap().toString());
  });
}
