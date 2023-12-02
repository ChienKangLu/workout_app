import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/model/unit.dart';

void main() {
  const exerciseId = 1;
  const name = "Squat";

  late Exercise tested;

  setUp(() {
    tested = Exercise(exerciseId: exerciseId, name: name);
  });

  test('Init', () async {
    // THEN
    expect(
      tested,
      Exercise(
        exerciseId: exerciseId,
        name: name,
      ),
    );
  });

  test('Add set to exercise', () async {
    // GIVEN
    final set = ExerciseSet(
      baseWeight: 10,
      sideWeight: 20,
      unit: WeightUnit.kilogram,
      repetition: 5,
    );
    expect(tested.sets.length, 0);

    // THEN
    tested.addSet(set);

    // THEN
    final sets = tested.sets;
    expect(sets.length, 1);
    expect(
      sets[0],
      ExerciseSet(
        baseWeight: 10,
        sideWeight: 20,
        unit: WeightUnit.kilogram,
        repetition: 5,
      ),
    );
  });
}
