import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:workout_app/database/database_initializer.dart';
import 'package:workout_app/database/schema.dart';

void main() {
  const dbPath = "dbPath";

  late DatabaseInitializer tested;
  late Database database;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    tested = DatabaseInitializer()..setUpDbPath(dbPath);

    database = await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        onConfigure: tested.onConfigure,
        onCreate: tested.onCreate,
        onUpgrade: tested.onUpgrade,
        onOpen: tested.onOpen,
        version: tested.version,
      ),
    );
  });

  test('Database should be initialized with expected table and version',
      () async {
    // THEN
    database.verifyColumn(ExerciseTable.name, [
      ExerciseTable.columnExerciseId,
      ExerciseTable.columnExerciseName,
    ]);

    database.verifyColumn(WorkoutTable.name, [
      WorkoutTable.columnWorkoutId,
      WorkoutTable.columnWorkoutCreateDateTime,
      WorkoutTable.columnWorkoutStartDateTime,
      WorkoutTable.columnWorkoutEndDateTime,
    ]);

    database.verifyColumn(WorkoutDetailTable.name, [
      WorkoutDetailTable.columnWorkoutId,
      WorkoutDetailTable.columnExerciseId,
      WorkoutDetailTable.columnExerciseCreateDateTime,
    ]);

    database.verifyColumn(ExerciseSetTable.name, [
      ExerciseSetTable.columnWorkoutId,
      ExerciseSetTable.columnExerciseId,
      ExerciseSetTable.columnSetNum,
      ExerciseSetTable.columnBaseWeight,
      ExerciseSetTable.columnSideWeight,
      ExerciseSetTable.columnRepetition,
      ExerciseSetTable.columnSetEndDateTime,
    ]);

    database.verifyColumn(WaterLogTable.name, [
      WaterLogTable.columnWaterLogId,
      ExerciseSetTable.columnSetEndDateTime,
      WaterLogTable.columnWaterLogDateTime,
    ]);

    database.verifyColumn(WaterGoalTable.name, [
      WaterGoalTable.columnWaterGoalId,
      WaterGoalTable.columnWaterGoalVolume,
      WaterGoalTable.columnWaterGoalDateTime,
    ]);

    expect(tested.version, 1);
  });

  test('Get DB path', () {
    // WHEN
    final result = tested.dbPath;

    // THEN
    expect(result, dbPath);
  });
}

extension DatabaseExtension on Database {
  Future<void> verifyColumn(String table, List<String> columns) async {
    final result = await database.rawQuery(
        "SELECT name from pragma_table_info('$table') where name in (${columns.map((raw) => "'$raw'").join(",")})");
    expect(result.length == result.length, true);
  }
}
