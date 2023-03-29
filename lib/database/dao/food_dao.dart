import '../model/food_entity.dart';
import '../schema.dart';
import 'simple_dao.dart';

class FoodDao extends SimpleDao<FoodEntity, FoodEntityFilter> {
  static const _tag = "FoodDao";

  @override
  String get tag => _tag;

  @override
  String get tableName => FoodTable.name;

  @override
  FoodEntity createEntityFromMap(Map<String, dynamic> map) =>
      FoodEntity.fromMap(map);

  @override
  FoodEntityFilter createUpdateFilter(FoodEntity entity) => FoodEntityFilter(
        id: entity.id,
      );
}

class FoodEntityFilter extends SimpleEntityFilter {
  FoodEntityFilter({
    super.ids,
    super.id,
  });

  @override
  String get columnId => FoodTable.columnFoodId;
}
