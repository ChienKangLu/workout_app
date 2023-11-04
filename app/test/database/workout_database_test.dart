import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_app/database/workout_database.dart';

import '../mock/database.mocks.dart';
import '../mock/database_initializer.mocks.dart';

void main() {
  const dbPath = "dbPath";

  late MockDatabaseInitializer mockDatabaseInitializer;
  late MockDatabase mockDatabase;
  late WorkoutDatabase tested;

  setUp(() async {
    mockDatabaseInitializer = MockDatabaseInitializer();
    mockDatabase = MockDatabase();
    when(mockDatabaseInitializer.open()).thenAnswer((_) async => mockDatabase);
    when(mockDatabaseInitializer.dbPath).thenReturn(dbPath);

    tested = WorkoutDatabase.instance;
    tested.setUpDatabaseInitializer(mockDatabaseInitializer);

    await tested.init();
  });

  tearDown(() async {
    await tested.close();
  });

  test('DAOs should be initialized', () async {
    // THEN
    expect(tested.workoutDao, isNotNull);
    expect(tested.exerciseDao, isNotNull);
    expect(tested.workoutDetailDao, isNotNull);
    expect(tested.exerciseSetDao, isNotNull);
    expect(tested.composedWorkoutDao, isNotNull);
    expect(tested.waterGoalDao, isNotNull);
    expect(tested.waterLogDao, isNotNull);
  });

  test('Get path of database', () async {
    // WHEN
    final result = tested.dbPath;

    // THEN
    expect(result, dbPath);
  });

  test('Restore backup', () async {
    // GIVEN
    const originDb = "origin_content";
    const backupDb = "backup_content";
    final dbFile = await _fileWithContent(dbPath, originDb);
    final backup = await _fileWithContent("backup", backupDb);
    expect(await dbFile.readAsString(), originDb);

    // WHEN
    await tested.restoreBackup(backup);

    // THEN
    verify(mockDatabase.close()).called(1);
    verify(mockDatabaseInitializer.open()).called(2);
    expect(await backup.readAsString(), backupDb);
    await dbFile.delete();
    await backup.delete();
  });
}

Future<File> _fileWithContent(String path, String content) async {
  final file = File(path);
  await file.writeAsString(content, flush: true);
  return file;
}
