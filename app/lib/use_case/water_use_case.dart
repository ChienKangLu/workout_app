import 'dart:async';

import '../model/result.dart';
import '../model/water_goal.dart';
import '../model/water_log.dart';
import '../repository/repository_manager.dart';
import '../repository/water_repository.dart';

class WaterUseCase {
  static const _tag = "WaterUseCase";

  final WaterRepository _waterRepository =
      RepositoryManager.instance.waterRepository;

  Future<bool> setGoal(double volume) async {
    final result = await _waterRepository.createGoal(volume);
    if (result is Error) {
      return false;
    }

    return true;
  }

  Future<WaterGoal?> getWaterGoal() async {
    final result = await _waterRepository.goalOf(DateTime.now());
    if (result is Error) {
      return null;
    }

    return (result as Success<WaterGoal?>).data;
  }

  Future<List<WaterLog>> getLogsOf(DateTime dateTime) async {
    final result = await _waterRepository.getLogsOf(dateTime);
    if (result is Error) {
      return [];
    }

    return (result as Success<List<WaterLog>>).data;
  }

  Future<bool> addLog(double volume) async {
    final result = await _waterRepository.addLog(volume);
    if (result is Error) {
      return false;
    }

    return true;
  }

  Future<bool> deleteLog(int id) async {
    final result = await _waterRepository.deleteLog(id);
    if (result is Error) {
      return false;
    }

    return true;
  }

  Future<bool> updateLog(int id, double volume) async {
    final result = await _waterRepository.updateLog(id, volume);
    if (result is Error) {
      return false;
    }

    return true;
  }

  StreamSubscription observeWaterGoalChange(void Function() onChange) {
    return _waterRepository.waterGoalStream.listen((_) => onChange());
  }
}
