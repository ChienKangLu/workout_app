import '../../database/model/water_goal_entity.dart';
import '../../database/model/water_log_entity.dart';
import '../../model/water_goal.dart';
import '../../model/water_log.dart';

class WaterGoalFactory {
  static WaterGoal createWaterGoal(
    WaterGoalEntity waterGoalEntity,
  ) {
    return WaterGoal(
      id: waterGoalEntity.id,
      volume: waterGoalEntity.volume,
      dateTime: DateTime.fromMillisecondsSinceEpoch(waterGoalEntity.dateTime),
    );
  }

  static WaterLog createWaterLog(
    WaterLogEntity waterLogEntity,
  ) {
    return WaterLog(
      id: waterLogEntity.id,
      volume: waterLogEntity.volume,
      dateTime: DateTime.fromMillisecondsSinceEpoch(waterLogEntity.dateTime),
    );
  }
}
