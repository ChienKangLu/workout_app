import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/util/string_util.dart';

void main() {
  test('trim trailing zero without decimal place', () {
    // GIVEN
    const s = "25.00";

    // WHEN
    final result = s.trimTrailingZero(2);

    // THEN
    expect(result, "25");
  });

  test('trim trailing zero round to one decimal place', () {
    // GIVEN
    const s = "25.20";

    // WHEN
    final result = s.trimTrailingZero(2);

    // THEN
    expect(result, "25.2");
  });

  test('trim trailing zero round to two decimal places', () {
    // GIVEN
    const s = "25.35";

    // WHEN
    final result = s.trimTrailingZero(2);

    // THEN
    expect(result, "25.35");
  });
}
