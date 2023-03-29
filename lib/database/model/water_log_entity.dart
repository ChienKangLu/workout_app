import '../schema.dart';
import 'base_entity.dart';

class WaterLogEntity extends BaseEntity {
  WaterLogEntity({
    required this.id,
    required this.volume,
    required this.dateTime,
  });

  WaterLogEntity.create({
    required double volume,
    required int dateTime,
  }) : this(
          id: ignored,
          volume: volume,
          dateTime: dateTime,
        );

  WaterLogEntity.update({
    required int id,
    required double volume,
  }) : this(
          id: id,
          volume: volume,
          dateTime: ignored,
        );

  WaterLogEntity.fromMap(Map<String, dynamic> map)
      : this(
          id: map[WaterLogTable.columnWaterLogId],
          volume: map[WaterLogTable.columnWaterLogVolume],
          dateTime: map[WaterLogTable.columnWaterLogDateTime],
        );

  final int id;
  final double volume;
  final int dateTime;

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != ignored) {
      map[WaterLogTable.columnWaterLogId] = id;
    }
    map[WaterLogTable.columnWaterLogVolume] = volume;
    if (dateTime != ignored) {
      map[WaterLogTable.columnWaterLogDateTime] = dateTime;
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterLogEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          volume == other.volume &&
          dateTime == other.dateTime;

  @override
  int get hashCode => id.hashCode ^ volume.hashCode ^ dateTime.hashCode;
}
