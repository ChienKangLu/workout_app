import 'package:equatable/equatable.dart';

class PortFile extends Equatable {
  const PortFile(this.id, this.name);

  final String id;
  final String? name;

  @override
  List<Object?> get props => [id, name];
}