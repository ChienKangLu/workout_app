import 'package:equatable/equatable.dart';

class WaterGoal extends Equatable {
  const WaterGoal({
    required this.id,
    required this.volume,
    required this.dateTime,
  });

  final int id;
  final double volume;
  final DateTime dateTime;

  @override
  List<Object?> get props => [id, volume, dateTime.millisecondsSinceEpoch];
}
