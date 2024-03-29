import 'dart:io';

import 'package:meta/meta.dart';

import '../database/workout_database.dart';

class DatabaseRepository {
  final List<DatabaseObserver> _observers = <DatabaseObserver>[];
  @visibleForTesting
  List<DatabaseObserver> get observers => _observers;

  String get dbPath => WorkoutDatabase.instance.dbPath;

  Future<void> restoreBackup(File backup) async {
    await WorkoutDatabase.instance.restoreBackup(backup);
    _notifyDatabaseBackupRestored();
  }

  void addObserver(DatabaseObserver observer) => _observers.add(observer);

  bool removeObserver(DatabaseObserver observer) => _observers.remove(observer);

  void _notifyDatabaseBackupRestored() {
    for (final observer in _observers) {
      observer.didDatabaseBackupRestored();
    }
  }
}

abstract class DatabaseObserver {
  Future<void> didDatabaseBackupRestored();
}
