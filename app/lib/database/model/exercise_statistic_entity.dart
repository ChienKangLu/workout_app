import '../schema.dart';
import 'base_entity.dart';

class ExerciseStatisticEntity extends BaseEntity {
  ExerciseStatisticEntity({
    required this.monthlyMaxWeightEntities,
  });

  final List<MonthlyMaxWeightEntity> monthlyMaxWeightEntities;

  @override
  Map<String, dynamic> toMap() => {};
}

class MonthlyMaxWeightEntity extends BaseEntity {
  static const columnTotalWeight = "total_weight";
  static const columnYear = "year";
  static const columnMonth = "month";

  MonthlyMaxWeightEntity({
    required this.totalWeight,
    required this.endDateTime,
    required this.year,
    required this.month,
  });

  final double totalWeight;
  final int endDateTime;
  final int year;
  final int month;

  MonthlyMaxWeightEntity.fromMap(Map<String, dynamic> map)
      : this(
          totalWeight: map[columnTotalWeight],
          endDateTime: map[WeightTrainingSetTable.columnSetEndDateTime],
          year: map[columnYear],
          month: map[columnMonth],
        );

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map[columnTotalWeight] = totalWeight;
    map[WeightTrainingSetTable.columnSetEndDateTime] = endDateTime;
    map[columnYear] = year;
    map[columnMonth] = month;
    return map;
  }
}