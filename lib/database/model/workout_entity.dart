import '../schema.dart';

class WorkoutEntity {
  WorkoutEntity(this.id, this.name);

  final int id;
  final String name;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != ignoredId) {
      map[WorkoutTable.columnId] = id;
    }
    map[WorkoutTable.columnName] = name;
    return map;
  }

  WorkoutEntity.fromMap(Map<String, dynamic> map)
      : id = map[WorkoutTable.columnId],
        name = map[WorkoutTable.columnName];

  @override
  String toString() {
    return "WorkoutEntity{id: $id, name: $name}";
  }
}