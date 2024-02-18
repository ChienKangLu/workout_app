import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/repository/repository_manager.dart';

void main() {
  late RepositoryManager tested;

  setUp(() {
    tested = RepositoryManager.instance;
  });

  test('Should get all repository', () {
    expect(tested.workoutRepository, isNotNull);
    expect(tested.exerciseRepository, isNotNull);
    expect(tested.waterRepository, isNotNull);
    expect(tested.googleRepository, isNotNull);
    expect(tested.databaseRepository, isNotNull);
  });
}
