import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../util/log_util.dart';
import 'schema.dart';

typedef OnInitData = Future<void> Function(Database database);

class DatabaseInitializer {
  static const _tag = "DatabaseInitializer";
  static const _version = 1;
  static const _workoutDatabasePath = "workout_database.db";

  DatabaseInitializer({required this.onInitData});

  final OnInitData onInitData;

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
    await onInitData(database);
  }

  Future<void> _onOpen(Database database) async {
    Log.d(_tag, "_onOpen");

    final tables = await database.rawQuery("SELECT * FROM sqlite_master where type='table'");
    Log.d(_tag, tables.toString());

    final workouts = await database.query(WorkoutTable.name);
    Log.d(_tag, workouts.toString());
  }

  Future<void> _createTables(Database database) async {
    await database.execute(WorkoutTable.create);
    await database.execute(ExerciseTable.create);
    await database.execute(RecordTable.create);
    await database.execute(WeightTrainingSetTable.create);
    await database.execute(RunningSetTable.create);
  }
}