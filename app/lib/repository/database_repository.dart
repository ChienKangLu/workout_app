import 'dart:io';

import '../database/workout_database.dart';

class DatabaseRepository {
  final List<DatabaseObserver> _observers = <DatabaseObserver>[];

  String get dbPath => WorkoutDatabase.instance.dbPath;

  Future<void> restoreBackup(File backup) async {
    await WorkoutDatabase.instance.restoreBackup(backup);
    handleDatabaseBackupRestored();
  }

  void addObserver(DatabaseObserver observer) => _observers.add(observer);

  bool removeObserver(DatabaseObserver observer) => _observers.remove(observer);

  void handleDatabaseBackupRestored() {
    for (final observer in _observers) {
      observer.didDatabaseBackupRestored();
    }
  }
}

abstract class DatabaseObserver {
  Future<void> didDatabaseBackupRestored();
}
