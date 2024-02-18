import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/database/dao/dao_result.dart';

void main() {
  test('Success result', () async {
    // GIVEN
    const data = true;

    // WHEN
    final result = DaoSuccess(data);

    // THEN
    expect(result.data, data);
  });

  test('Error result', () async {
    // GIVEN
    const message = "error";
    final exception = Exception(message);

    // WHEN
    final result = DaoError(exception);

    // THEN
    expect(result.exception, exception);
  });
}
