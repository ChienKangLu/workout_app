import 'dart:async';

import '../database/dao/dao_provider_mixin.dart';
import '../database/dao/dao_result.dart';
import '../database/dao/water_log_dao.dart';
import '../database/model/water_goal_entity.dart';
import '../database/model/water_log_entity.dart';
import '../model/result.dart';
import '../model/water_goal.dart';
import '../model/water_log.dart';
import 'conversion.dart';
import 'factory/water_goal_factory.dart';

class WaterRepository with DaoProviderMixin {
  final _waterGoalStreamController = StreamController<double>.broadcast();
  Stream<double> get waterGoalStream => _waterGoalStreamController.stream;

  Future<Result<List<WaterLog>>> getLogsOf(DateTime dateTime) async {
    final from = DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    final to = DateTime(dateTime.year, dateTime.month, dateTime.day + 1)
        .millisecondsSinceEpoch;

    final DaoResult<List<WaterLogEntity>> daoResult =
        await waterLogDao.findByFilter(
      WaterLogEntityFilter(
        from: from,
        to: to,
      ),
    );

    return daoResult.asResult(
      convert: (data) => data
          .map(
            (entity) => WaterGoalFactory.createWaterLog(entity),
          )
          .toList(),
    );
  }

  Future<Result<WaterGoal?>> goalOf(DateTime dateTime) async {
    final DaoResult<WaterGoalEntity?> daoResult =
        await waterGoalDao.goalOf(dateTime.millisecondsSinceEpoch);

    return daoResult.asResult(
      convert: (data) {
        if (data == null) {
          return null;
        }
        return WaterGoalFactory.createWaterGoal(data);
      },
    );
  }

  Future<Result<int>> createGoal(double volume) async {
    final DaoResult<int> daoResult = await waterGoalDao.add(
      WaterGoalEntity.create(
        volume: volume,
        dateTime: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    _waterGoalStreamController.sink.add(volume);
    return daoResult.asResult();
  }

  Future<Result<int>> addLog(double volume) async {
    final DaoResult<int> daoResult = await waterLogDao.add(
      WaterLogEntity.create(
        volume: volume,
        dateTime: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    return daoResult.asResult();
  }

  Future<Result<bool>> deleteLog(int id) async {
    final DaoResult<bool> daoResult = await waterLogDao.delete(
      WaterLogEntityFilter(
        id: id,
      ),
    );

    return daoResult.asResult();
  }

  Future<Result<bool>> updateLog(int id, double volume) async {
    final DaoResult<bool> daoResult = await waterLogDao.update(
      WaterLogEntity.update(id: id, volume: volume),
    );

    return daoResult.asResult();
  }
}
