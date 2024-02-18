import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_app/repository/database_repository.dart';

import '../util/mock_db.dart';
import '../mock/database_observer.mocks.dart';

void main() {
  late MockDB mockDb;
  late DatabaseRepository tested;
  late MockDatabaseObserver mockDatabaseObserver;

  setUp(() {
    mockDb = MockDB()..setUp();
    mockDatabaseObserver = MockDatabaseObserver();

    tested = DatabaseRepository();
  });

  test('DB path', () {
    // WHEN
    final result = tested.dbPath;

    // THEN
    expect(result, MockDB.mockDbPath);
  });

  test('Restore backup and notify change', () async {
    // GIVEN
    final backup = File("backup");
    tested.addObserver(mockDatabaseObserver);

    // WHEN
    await tested.restoreBackup(backup);

    // THEN
    verify(mockDb.workoutDatabase.restoreBackup(backup)).called(1);
    verify(mockDatabaseObserver.didDatabaseBackupRestored()).called(1);
  });

  test('And and remove database observer', () {
    // GIVEN
    expect(tested.observers.length, 0);

    // WHEN
    tested.addObserver(mockDatabaseObserver);
    expect(tested.observers.length, 1);
    tested.removeObserver(mockDatabaseObserver);

    // THEN
    expect(tested.observers.length, 0);
  });
}
