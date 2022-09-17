abstract class BaseEntity {

  Map<String, dynamic> toMap();

  @override
  String toString() => toMap().toString();
}