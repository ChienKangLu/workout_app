import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_app/database/dao/dao_result.dart';
import 'package:workout_app/database/dao/water_log_dao.dart';
import 'package:workout_app/database/model/water_goal_entity.dart';
import 'package:workout_app/database/model/water_log_entity.dart';
import 'package:workout_app/model/water_goal.dart';
import 'package:workout_app/model/water_log.dart';
import 'package:workout_app/repository/water_repository.dart';

import '../util/mock_db.dart';
import 'repository_test_util.dart';

void main() {
  late MockDB mockDb;
  late WaterRepository tested;

  setUp(() {
    mockDb = MockDB()..setUp();

    tested = WaterRepository();
  });

  test('Get logs by dateTime', () async {
    // GIVEN
    final dateTime = DateTime(1970, 1, 2);

    when(mockDb.waterLogDao.findByFilter(
      WaterLogEntityFilter(
        from: DateTime(dateTime.year, dateTime.month, dateTime.day)
            .millisecondsSinceEpoch,
        to: DateTime(dateTime.year, dateTime.month, dateTime.day + 1)
            .millisecondsSinceEpoch,
      ),
    )).thenAnswer(
      (_) async => DaoSuccess(
        [
          WaterLogEntity(
            id: 1,
            volume: 500,
            dateTime: 2,
          ),
          WaterLogEntity(
            id: 2,
            volume: 1500,
            dateTime: 3,
          ),
        ],
      ),
    );

    // WHEN
    final result = await tested.getLogsOf(dateTime);

    // THEN
    final data = successData(result);
    expect(
      data,
      [
        WaterLog(
          id: 1,
          volume: 500,
          dateTime: DateTime.fromMillisecondsSinceEpoch(2),
        ),
        WaterLog(
          id: 2,
          volume: 1500,
          dateTime: DateTime.fromMillisecondsSinceEpoch(3),
        ),
      ],
    );
  });

  test('Goal of dateTime', () async {
    // GIVEN
    final dateTime = DateTime(1970, 1, 2);

    when(mockDb.waterGoalDao.goalOf(
      dateTime.millisecondsSinceEpoch,
    )).thenAnswer(
      (_) async => DaoSuccess(
        WaterGoalEntity(
          id: 1,
          volume: 2500,
          dateTime: 2,
        ),
      ),
    );

    // WHEN
    final result = await tested.goalOf(dateTime);

    // THEN
    final data = successData(result);
    expect(
      data,
      WaterGoal(
        id: 1,
        volume: 2500,
        dateTime: DateTime.fromMillisecondsSinceEpoch(2),
      ),
    );
  });

  test('Create goal and notify change', () async {
    // GIVEN
    const volume = 2500.0;
    const rowId = 1;

    when(mockDb.waterGoalDao.add(
      any,
    )).thenAnswer(
      (_) async => DaoSuccess(rowId),
    );
    tested.waterGoalStream.listen(
      // THEN
      expectAsync1(
        (event) => expect(event, volume),
      ),
    );
    final waterGoalStream = tested.waterGoalStream;
    expectLater(
      waterGoalStream,
      emitsInOrder([volume]),
    );

    // WHEN
    final result = await tested.createGoal(volume);

    // THEN
    final data = successData(result);
    expect(
      data,
      rowId,
    );
  }, timeout: const Timeout(Duration(seconds: 1)));

  test('Add log', () async {
    // GIVEN
    const volume = 500.0;
    const rowId = 1;

    when(mockDb.waterLogDao.add(
      any,
    )).thenAnswer(
      (_) async => DaoSuccess(rowId),
    );

    // WHEN
    final result = await tested.addLog(volume);

    // THEN
    final data = successData(result);
    expect(
      data,
      rowId,
    );
  });

  test('Delete log', () async {
    // GIVEN
    const id = 1;

    when(mockDb.waterLogDao.delete(
      WaterLogEntityFilter(
        id: id,
      ),
    )).thenAnswer(
      (_) async => DaoSuccess(true),
    );

    // WHEN
    final result = await tested.deleteLog(id);

    // THEN
    final data = successData(result);
    expect(
      data,
      true,
    );
  });

  test('Update log', () async {
    // GIVEN
    const id = 1;
    const volume = 500.0;

    when(mockDb.waterLogDao.update(
      WaterLogEntity.update(id: id, volume: volume),
    )).thenAnswer(
      (_) async => DaoSuccess(true),
    );

    // WHEN
    final result = await tested.updateLog(id, volume);

    // THEN
    final data = successData(result);
    expect(
      data,
      true,
    );
  });
}
