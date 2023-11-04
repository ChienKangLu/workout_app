import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../util/log_util.dart';
import 'schema.dart';

class MigrationStep {
  MigrationStep({
    required this.scripts,
  });

  final List<String> scripts;

  Future<void> execute(Database database) async {
    for (final script in scripts) {
      await database.execute(script);
    }
  }
}

class DatabaseInitializer {
  static const _tag = "DatabaseInitializer";
  static const _version = 1;
  static const _workoutDatabaseName = "workout_database.db";

  final _migrationSteps = [
    MigrationStep(
      scripts: [
        ExerciseTable.create,
        WorkoutTable.create,
        WorkoutDetailTable.create,
        ExerciseSetTable.create,
        WaterLogTable.create,
        WaterGoalTable.create,
      ],
    ),
  ];

  late String _dbPath;
  String get dbPath => _dbPath;
  int get version => _version;

  Future<Database> open() async {
    Log.d(_tag, "open");
    WidgetsFlutterBinding.ensureInitialized();

    _dbPath = join(await getDatabasesPath(), _workoutDatabaseName);

    return openDatabase(
      _dbPath,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: _onOpen,
      version: _version,
    );
  }

  Future<void> _onConfigure(Database database) async {
    Log.d(_tag, "_onConfigure");
    await database.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> _onCreate(Database database, int version) async {
    Log.d(_tag, "_onCreate");
    for (var i = 0; i < version; i++) {
      await _migrationSteps[i].execute(database);
    }
  }

  Future<void> _onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) async {
    Log.d(_tag, "_onUpgrade from $oldVersion to $newVersion");
    for (var i = oldVersion; i < newVersion; i++) {
      await _migrationSteps[i].execute(database);
    }
  }

  Future<void> _onOpen(Database database) async {
    Log.d(_tag, "_onOpen");

    final tables = await database
        .rawQuery("SELECT * FROM sqlite_master where type='table'");
    Log.d(_tag, tables.toString());
  }

  void setUpDbPath(String dbPath) {
    _dbPath = dbPath;
  }

  @visibleForTesting
  Future<void> onConfigure(Database database) {
    return _onConfigure(database);
  }

  @visibleForTesting
  Future<void> onCreate(Database database, int version) {
    return _onCreate(database, version);
  }

  @visibleForTesting
  Future<void> onUpgrade(Database database, int oldVersion, int newVersion) {
    return _onUpgrade(database, oldVersion, newVersion);
  }

  @visibleForTesting
  Future<void> onOpen(Database database) {
    return _onOpen(database);
  }
}
