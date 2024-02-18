import '../base_entity.dart';
import '../monthly_max_weight_entity.dart';

class ExerciseStatisticEntity extends BaseEntity {
  ExerciseStatisticEntity({
    required this.monthlyMaxWeightEntities,
  });

  final List<MonthlyMaxWeightEntity> monthlyMaxWeightEntities;

  @override
  Map<String, dynamic> toMap() => {
    "monthlyMaxWeightEntities": monthlyMaxWeightEntities,
  };

  @override
  List<Object?> get props => [monthlyMaxWeightEntities];
}
