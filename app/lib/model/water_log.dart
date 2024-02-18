import 'package:equatable/equatable.dart';

class WaterLog extends Equatable {
  const WaterLog({
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