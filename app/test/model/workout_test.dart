import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/model/workout.dart';

void main() {
  const workoutId = 1;
  final createDateTime = DateTime(1970);
  final exercise = Exercise(exerciseId: 1, name: "Squat");

  late Workout tested;

  setUp(() {
    tested = Workout(workoutId: workoutId, createDateTime: createDateTime);
  });

  test('Init', () async {
    // THEN
    expect(
      tested,
      Workout(
        workoutId: workoutId,
        createDateTime: createDateTime,
      ),
    );
  });

  test('Add exercise', () async {
    // WHEN
    tested.addExercise(exercise);

    // THEN
    expect(tested.exercises, [exercise]);
  });
}
