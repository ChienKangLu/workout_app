import '../schema.dart';
import 'base_entity.dart';

class WaterGoalEntity extends BaseEntity {
  WaterGoalEntity({
    required this.id,
    required this.volume,
    required this.dateTime,
  });

  WaterGoalEntity.create({
    required double volume,
    required int dateTime,
  }) : this(
          id: ignored,
          volume: volume,
          dateTime: dateTime,
        );

  WaterGoalEntity.update({
    required int id,
    required double volume,
  }) : this(
          id: id,
          volume: volume,
          dateTime: ignored,
        );

  WaterGoalEntity.fromMap(Map<String, dynamic> map)
      : this(
          id: map[WaterGoalTable.columnWaterGoalId],
          volume: map[WaterGoalTable.columnWaterGoalVolume],
          dateTime: map[WaterGoalTable.columnWaterGoalDateTime],
        );

  final int id;
  final double volume;
  final int dateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != ignored) {
      map[WaterGoalTable.columnWaterGoalId] = id;
    }
    map[WaterGoalTable.columnWaterGoalVolume] = volume;
    if (dateTime != ignored) {
      map[WaterGoalTable.columnWaterGoalDateTime] = dateTime;
    }
    return map;
  }

  @override
  List<Object?> get props => [id, volume, dateTime];
}
