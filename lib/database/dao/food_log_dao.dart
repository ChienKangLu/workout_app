import '../model/food_log_entity.dart';
import '../schema.dart';
import 'simple_dao.dart';

class FoodLogDao extends SimpleDao<FoodLogEntity, FoodLogEntityFilter> {
  static const _tag = "FoodLogDao";

  @override
  String get tag => _tag;

  @override
  String get tableName => FoodLogTable.name;

  @override
  FoodLogEntity createEntityFromMap(Map<String, dynamic> map) =>
      FoodLogEntity.fromMap(map);

  @override
  FoodLogEntityFilter createUpdateFilter(FoodLogEntity entity) =>
      FoodLogEntityFilter(
        id: entity.id,
      );
}

class FoodLogEntityFilter extends SimpleEntityFilter {
  FoodLogEntityFilter({
    super.ids,
    super.id,
  });

  @override
  String get columnId => FoodLogTable.columnFoodLogId;
}
