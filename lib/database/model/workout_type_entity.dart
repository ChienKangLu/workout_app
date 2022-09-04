import '../schema.dart';

class WorkoutTypeEntity {
  WorkoutTypeEntity(this.id, this.name);

  WorkoutTypeEntity.create(this.name) : id = ignoredId;

  final int id;
  final String name;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != ignoredId) {
      map[WorkoutTypeTable.columnId] = id;
    }
    map[WorkoutTypeTable.columnName] = name;
    return map;
  }

  WorkoutTypeEntity.fromMap(Map<String, dynamic> map)
      : id = map[WorkoutTypeTable.columnId],
        name = map[WorkoutTypeTable.columnName];

  @override
  String toString() {
    return "WorkoutTypeEntity{id: $id, name: $name}";
  }
}
