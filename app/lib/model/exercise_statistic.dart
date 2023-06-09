class ExerciseStatistic {
  ExerciseStatistic({
    required this.monthlyMaxWeightList,
  });

  final List<MonthlyMaxWeight> monthlyMaxWeightList;
}

class MonthlyMaxWeight {
  MonthlyMaxWeight({
    required this.totalWeight,
    required this.endDateTime,
    required this.year,
    required this.month,
  });

  final double totalWeight;
  final int endDateTime;
  final int year;
  final int month;
}