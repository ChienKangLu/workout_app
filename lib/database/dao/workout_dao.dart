import '../schema.dart';

class WorkoutDao {
  WorkoutDao(this.id, this.name);

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

  WorkoutDao.fromMap(Map<String, dynamic> map)
      : id = map[WorkoutTable.columnId],
        name = map[WorkoutTable.columnName];
}