import 'package:equatable/equatable.dart';

class ExerciseStatistic extends Equatable {
  const ExerciseStatistic({
    required this.monthlyMaxWeightList,
  });

  final List<MonthlyMaxWeight> monthlyMaxWeightList;

  @override
  List<Object?> get props => [monthlyMaxWeightList];
}

class MonthlyMaxWeight extends Equatable {
  const MonthlyMaxWeight({
    required this.totalWeight,
    required this.endDateTime,
    required this.year,
    required this.month,
  });

  final double totalWeight;
  final int endDateTime;
  final int year;
  final int month;

  @override
  List<Object?> get props => [
        totalWeight,
        endDateTime,
        year,
        month,
      ];
}
