import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:workout_app/core_view/ui_mode.dart';
import 'package:workout_app/core_view/ui_mode_view_model.dart';
import 'package:workout_app/repository/repository_manager.dart';

import '../mock/test_callback.mocks.dart';

void main() {
  late UiModeViewModel tested;
  late MockTestCallback mockTestCallback;

  setUp(() {
    mockTestCallback = MockTestCallback();

    tested = UiModeViewModel();
    tested.addListener(mockTestCallback.voidCallback);

    tested.init();
  });

  test('View model should be initialized', () {
    // THEN
    expect(
      RepositoryManager.instance.databaseRepository.observers.contains(tested),
      true,
    );
  });

  test('View model should be released', () {
    // WHEN
    tested.release();

    // THEN
    expect(
      RepositoryManager.instance.databaseRepository.observers.contains(tested),
      false,
    );
  });

  test('Switch UI mode from normal to edit', () {
    // GIVEN
    expect(tested.uiMode, UiMode.normal);

    // WHEN
    tested.switchTo(UiMode.edit);

    // THEN
    expect(tested.uiMode, UiMode.edit);
    verify(mockTestCallback.voidCallback()).called(1);
  });

  test('Do nothing when reload', () {
    // WHEN
    tested.reload();

    // THEN
    verifyNever(mockTestCallback.voidCallback());
  });

  test('Do nothing when database backup is restored', () {
    // WHEN
    tested.didDatabaseBackupRestored();

    // THEN
    verifyNever(mockTestCallback.voidCallback());
  });
}
