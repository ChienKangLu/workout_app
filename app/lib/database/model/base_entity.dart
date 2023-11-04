import 'package:equatable/equatable.dart';

abstract class BaseEntity extends Equatable {

  Map<String, dynamic> toMap();

  @override
  String toString() => toMap().toString();
}