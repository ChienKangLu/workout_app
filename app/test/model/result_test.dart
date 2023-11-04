import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/model/result.dart';

void main() {
  test('Success result', () async {
    // GIVEN
    const data = true;

    // WHEN
    final result = Success(data);

    // THEN
    expect(result.data, data);
  });

  test('Error result', () async {
    // GIVEN
    const message = "error";
    final exception = Exception(message);

    // WHEN
    final result = Error(exception);

    // THEN
    expect(result.exception, exception);
  });
}
