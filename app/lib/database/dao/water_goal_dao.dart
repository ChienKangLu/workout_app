import '../../util/log_util.dart';
import '../model/water_goal_entity.dart';
import '../schema.dart';
import 'dao_result.dart';
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

  Future<DaoResult<WaterGoalEntity?>> goalOf(int dateTime) async {
    try {
      final maps = await database.rawQuery("""
      SELECT * FROM ${WaterGoalTable.name} 
      WHERE ${WaterGoalTable.columnWaterGoalDateTime} <= $dateTime 
      ORDER BY ${WaterGoalTable.columnWaterGoalDateTime}
      DESC
      LIMIT 1
      """);

      if (maps.isEmpty) {
        return DaoSuccess(null);
      }

      return DaoSuccess(WaterGoalEntity.fromMap(maps.first));
    } on Exception catch (e) {
      Log.e(tag, "Cannot get goalOf at date'$dateTime'", e);
      return DaoError(e);
    }
  }
}

class WaterGoalEntityFilter extends SimpleEntityFilter {
  WaterGoalEntityFilter({
    super.ids,
    super.id,
  });

  @override
  String get columnId => WaterGoalTable.columnWaterGoalId;
}
