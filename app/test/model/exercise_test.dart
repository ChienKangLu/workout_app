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
    expect(tested.exerciseId, exerciseId);
    expect(tested.name, name);
    expect(tested.sets.length, 0);
  });

  test('Add set to exercise', () async {
    // GIVEN
    final set = ExerciseSet(
      baseWeight: 10,
      sideWeight: 20,
      unit: WeightUnit.kilogram,
      repetition: 5,
    );

    // THEN
    tested.addSet(set);

    // THEN
    final sets = tested.sets;
    expect(sets.length, 1);
    expect(tested.sets[0], set);
    expect(tested.sets[0].totalWeight(), 50);
  });
}
