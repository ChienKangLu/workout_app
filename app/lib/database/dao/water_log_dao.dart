import '../model/water_log_entity.dart';
import '../schema.dart';
import 'simple_dao.dart';

class WaterLogDao extends SimpleDao<WaterLogEntity, WaterLogEntityFilter> {
  static const _tag = "WaterLogDao";

  @override
  String get tag => _tag;

  @override
  String get tableName => WaterLogTable.name;

  @override
  WaterLogEntity createEntityFromMap(Map<String, dynamic> map) =>
      WaterLogEntity.fromMap(map);

  @override
  WaterLogEntityFilter createUpdateFilter(WaterLogEntity entity) =>
      WaterLogEntityFilter(
        id: entity.id,
      );
}

class WaterLogEntityFilter extends SimpleEntityFilter {
  WaterLogEntityFilter({
    super.ids,
    super.id,
  });

  @override
  String get columnId => WaterLogTable.columnWaterLogId;
}
