import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../util/log_util.dart';
import 'schema.dart';

class DatabaseInitializer {
  static const _tag = "DatabaseInitializer";
  static const _version = 1;
  static const _workoutDatabasePath = "workout_database.db";

  bool isFirstCreation = false;

  Future<Database> open() async {
    Log.d(_tag, "open");
    WidgetsFlutterBinding.ensureInitialized();

    return openDatabase(
      join(await getDatabasesPath(), _workoutDatabasePath),
      onConfigure: (database) async => await _onConfigure(database),
      onCreate: (database, version) async => await _onCreate(database, version),
      onOpen: (database) async => await _onOpen(database),
      version: _version,
    );
  }

  Future<void> _onConfigure(Database database) async {
    Log.d(_tag, "_onConfigure");
    await database.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> _onCreate(Database database, int version) async {
    Log.d(_tag, "_onCreate");
    await _createTables(database);
    isFirstCreation = true;
  }

  Future<void> _onOpen(Database database) async {
    Log.d(_tag, "_onOpen");

    final tables = await database
        .rawQuery("SELECT * FROM sqlite_master where type='table'");
    Log.d(_tag, tables.toString());
  }

  Future<void> _createTables(Database database) async {
    await database.execute(ExerciseTable.create);
    await database.execute(WorkoutTable.create);
    await database.execute(WorkoutDetailTable.create);
    await database.execute(WeightTrainingSetTable.create);
    await database.execute(RunningSetTable.create);
  }
}
