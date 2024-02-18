import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/util/number_util.dart';

void main() {
  test('truncate digit', () {
    // GIVEN
    const value = 1.553;
    const digits = 2;

    // WHEN
    final result = NumberUtil.toPrecision(value, digits);

    // THEN
    expect(result, 1.55);
  });

  test('round to digit', () {
    // GIVEN
    const value = 1.556;
    const digits = 2;

    // WHEN
    final result = NumberUtil.toPrecision(value, digits);

    // THEN
    expect(result, 1.56);
  });
}
