import '../schema.dart';
import 'base_entity.dart';

class FoodLogEntity extends BaseEntity {
  FoodLogEntity({
    required this.id,
    required this.foodId,
    required this.dateTime,
  });

  FoodLogEntity.create({
    required int foodId,
    required int dateTime,
  }) : this(
    id: ignored,
    foodId: foodId,
    dateTime: dateTime,
  );

  FoodLogEntity.fromMap(Map<String, dynamic> map)
      : this(
          id: map[FoodLogTable.columnFoodLogId],
          foodId: map[FoodLogTable.columnFoodId],
          dateTime: map[FoodLogTable.columnFoodLogDateTime],
        );

  final int id;
  final int foodId;
  final int dateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != ignored) {
      map[FoodLogTable.columnFoodLogId] = id;
    }
    map[FoodLogTable.columnFoodId] = foodId;
    map[FoodLogTable.columnFoodLogDateTime] = dateTime;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodLogEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          foodId == other.foodId &&
          dateTime == other.dateTime;

  @override
  int get hashCode => id.hashCode ^ foodId.hashCode ^ dateTime.hashCode;
}
