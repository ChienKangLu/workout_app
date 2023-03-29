import '../model/water_goal_entity.dart';
import '../schema.dart';
import 'simple_dao.dart';

class WaterGoalDao extends SimpleDao<WaterGoalEntity, WaterGoalEntityFilter> {
  static const _tag = "WaterGoalDao";

  @override
  String get tag => _tag;

  @override
  String get tableName => WaterGoalTable.name;

  @override
  WaterGoalEntity createEntityFromMap(Map<String, dynamic> map) =>
      WaterGoalEntity.fromMap(map);

  @override
  WaterGoalEntityFilter createUpdateFilter(WaterGoalEntity entity) =>
      WaterGoalEntityFilter(
        id: entity.id,
      );
}

class WaterGoalEntityFilter extends SimpleEntityFilter {
  WaterGoalEntityFilter({
    super.ids,
    super.id,
  });

  @override
  String get columnId => WaterGoalTable.columnWaterGoalId;
}
