import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/model/exercise_statistic.dart';

void main() {
  const monthlyMaxWeight1 = MonthlyMaxWeight(
    totalWeight: 50,
    endDateTime: 1,
    year: 1970,
    month: 1,
  );
  const monthlyMaxWeight2 = MonthlyMaxWeight(
    totalWeight: 70,
    endDateTime: 2,
    year: 1971,
    month: 2,
  );

  late ExerciseStatistic tested;

  setUp(() {
    tested = const ExerciseStatistic(
      monthlyMaxWeightList: [monthlyMaxWeight1, monthlyMaxWeight2],
    );
  });

  test('Init', () async {
    // THEN
    expect(
      tested,
      const ExerciseStatistic(
        monthlyMaxWeightList: [monthlyMaxWeight1, monthlyMaxWeight2],
      ),
    );
  });
}
