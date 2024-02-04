import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_app/model/result.dart';
import 'package:workout_app/model/water_goal.dart';
import 'package:workout_app/model/water_log.dart';
import 'package:workout_app/repository/repository_manager.dart';
import 'package:workout_app/use_case/water_use_case.dart';

import '../mock/water_repository.mocks.dart';

void main() {
  late WaterUseCase tested;
  late MockWaterRepository mockWaterRepository;

  const goalId = 1;
  const goalVolume = 1000.0;
  final goalDateTime = DateTime(1970);
  final waterGoal = WaterGoal(
    id: goalId,
    volume: goalVolume,
    dateTime: goalDateTime,
  );

  const logId = 2;
  const logVolume = 500.0;
  final logDateTime = DateTime(1970);
  final waterLog = WaterLog(
    id: logId,
    volume: logVolume,
    dateTime: logDateTime,
  );

  setUp(() {
    mockWaterRepository = MockWaterRepository();
    RepositoryManager.setUpWaterRepository(mockWaterRepository);

    tested = WaterUseCase();
  });

  test('set goal fail', () async {
    // GIVEN
    when(mockWaterRepository.createGoal(goalVolume)).thenAnswer(
      (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.setGoal(goalVolume);

    // THEN
    expect(result, false);
  });

  test('set goal successfully', () async {
    // GIVEN
    const rowId = 1;
    when(mockWaterRepository.createGoal(goalVolume)).thenAnswer(
      (_) async => Success(rowId),
    );

    // WHEN
    final result = await tested.setGoal(goalVolume);

    // THEN
    expect(result, true);
  });

  test('get goal fail', () async {
    // GIVEN
    when(mockWaterRepository.goalOf(any)).thenAnswer(
      (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.getGoal();

    // THEN
    expect(result, null);
  });

  test('set goal successfully', () async {
    // GIVEN
    when(mockWaterRepository.goalOf(any)).thenAnswer(
      (_) async => Success(waterGoal),
    );

    // WHEN
    final result = await tested.getGoal();

    // THEN
    expect(result, waterGoal);
  });

  test('get logs fail', () async {
    // GIVEN
    when(mockWaterRepository.getLogsOf(goalDateTime)).thenAnswer(
      (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.getLogsOf(goalDateTime);

    // THEN
    expect(result, []);
  });

  test('set goal successfully', () async {
    // GIVEN
    when(mockWaterRepository.getLogsOf(logDateTime)).thenAnswer(
      (_) async => Success([waterLog]),
    );

    // WHEN
    final result = await tested.getLogsOf(logDateTime);

    // THEN
    expect(result, [waterLog]);
  });

  test('add log fail', () async {
    // GIVEN
    when(mockWaterRepository.addLog(logVolume)).thenAnswer(
          (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.addLog(logVolume);

    // THEN
    expect(result, false);
  });

  test('add log successfully', () async {
    // GIVEN
    const rowId = 1;
    when(mockWaterRepository.addLog(logVolume)).thenAnswer(
          (_) async => Success(rowId),
    );

    // WHEN
    final result = await tested.addLog(logVolume);

    // THEN
    expect(result, true);
  });

  test('delete log fail', () async {
    // GIVEN
    when(mockWaterRepository.deleteLog(logId)).thenAnswer(
          (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.deleteLog(logId);

    // THEN
    expect(result, false);
  });

  test('delete log successfully', () async {
    // GIVEN
    when(mockWaterRepository.deleteLog(logId)).thenAnswer(
          (_) async => Success(true),
    );

    // WHEN
    final result = await tested.deleteLog(logId);

    // THEN
    expect(result, true);
  });

  test('update log fail', () async {
    // GIVEN
    const newVolume = 2000.0;
    when(mockWaterRepository.updateLog(logId, newVolume)).thenAnswer(
          (_) async => Error(Exception()),
    );

    // WHEN
    final result = await tested.updateLog(logId, newVolume);

    // THEN
    expect(result, false);
  });

  test('update log successfully', () async {
    // GIVEN
    const newVolume = 2000.0;
    when(mockWaterRepository.updateLog(logId, newVolume)).thenAnswer(
          (_) async => Success(true),
    );

    // WHEN
    final result = await tested.updateLog(logId, newVolume);

    // THEN
    expect(result, true);
  });

  test('observe water goal changed', () async {
    // GIVEN
    final controller = StreamController<double>();
    final stream = controller.stream;
    when(mockWaterRepository.waterGoalStream).thenAnswer((_) => stream);

    // WHEN
    final mockCallback = TestCallback();
    tested.observeWaterGoalChange(mockCallback.onChange);
    controller.add(1000);

    // THEN
    await Future.delayed(Duration.zero);
    verify(mockCallback.onChange()).called(1);
  });
}

class TestCallback extends Mock {
  void onChange();
}
