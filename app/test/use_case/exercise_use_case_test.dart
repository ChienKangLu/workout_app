import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/model/exercise_statistic.dart';
import 'package:workout_app/model/result.dart';
import 'package:workout_app/repository/repository_manager.dart';
import 'package:workout_app/use_case/exercise_use_case.dart';

import '../mock/exercise_repository.mocks.dart';

void main() {
  late ExerciseUseCase tested;
  late MockExerciseRepository mockExerciseRepository;

  const squatId = 1;
  const squatName = "Squat";
  final squat = Exercise(exerciseId: squatId, name: squatName);

  setUp(() {
    mockExerciseRepository = MockExerciseRepository();
    RepositoryManager.setUpExerciseRepository(mockExerciseRepository);

    tested = ExerciseUseCase();
  });

  test('get exercise fail', () async {
    // GIVEN
    when(mockExerciseRepository.getExercise(squatId)).thenAnswer(
      (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.getExercise(squatId);

    // THEN
    expect(result, null);
  });

  test('get exercise successfully', () async {
    // GIVEN
    when(mockExerciseRepository.getExercise(squatId)).thenAnswer(
      (_) async => Success(squat),
    );

    // WHEN
    final result = await tested.getExercise(squatId);

    // THEN
    expect(result, squat);
  });

  test('get exercises fail', () async {
    // GIVEN
    when(mockExerciseRepository.getExercises()).thenAnswer(
      (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.getExercises();

    // THEN
    expect(result, null);
  });

  test('get exercises successfully', () async {
    // GIVEN
    when(mockExerciseRepository.getExercises()).thenAnswer(
      (_) async => Success([squat]),
    );

    // WHEN
    final result = await tested.getExercises();

    // THEN
    expect(result, [squat]);
  });

  test('create exercise fail', () async {
    // GIVEN
    when(mockExerciseRepository.createExercise(squatName)).thenAnswer(
      (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.createExercise(squatName);

    // THEN
    expect(result, null);
  });

  test('create exercise successfully', () async {
    // GIVEN
    const rowId = 1;
    when(mockExerciseRepository.createExercise(squatName)).thenAnswer(
      (_) async => Success(rowId),
    );

    // WHEN
    final result = await tested.createExercise(squatName);

    // THEN
    expect(result, rowId);
  });

  test('remove exercise fail', () async {
    // GIVEN
    final exerciseIds = [1, 2, 3];
    when(mockExerciseRepository.removeExercises(exerciseIds)).thenAnswer(
      (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.removeExercises(exerciseIds);

    // THEN
    expect(result, false);
  });

  test('create exercise successfully', () async {
    // GIVEN
    final exerciseIds = [1, 2, 3];
    when(mockExerciseRepository.removeExercises(exerciseIds)).thenAnswer(
      (_) async => Success(true),
    );

    // WHEN
    final result = await tested.removeExercises(exerciseIds);

    // THEN
    expect(result, true);
  });

  test('update exercise fail', () async {
    // GIVEN
    when(mockExerciseRepository.updateExercise(
      exerciseId: squatId,
      name: squatName,
    )).thenAnswer(
      (_) async => Error(Exception()),
    );

    // WHEN
    final result =
        await tested.updateExercise(exerciseId: squatId, name: squatName);

    // THEN
    expect(result, false);
  });

  test('create exercise successfully', () async {
    // GIVEN
    when(mockExerciseRepository.updateExercise(
      exerciseId: squatId,
      name: squatName,
    )).thenAnswer(
      (_) async => Success(true),
    );

    // WHEN
    final result =
        await tested.updateExercise(exerciseId: squatId, name: squatName);

    // THEN
    expect(result, true);
  });

  test('get statistic fail', () async {
    // GIVEN
    when(mockExerciseRepository.getStatistic(squatId)).thenAnswer(
      (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.getStatistic(squatId);

    // THEN
    expect(result, null);
  });

  test('create exercise successfully', () async {
    // GIVEN
    const exerciseStatistic = ExerciseStatistic(monthlyMaxWeightList: []);
    when(mockExerciseRepository.getStatistic(squatId)).thenAnswer(
      (_) async => Success(exerciseStatistic),
    );

    // WHEN
    final result = await tested.getStatistic(squatId);

    // THEN
    expect(result, exerciseStatistic);
  });
}
