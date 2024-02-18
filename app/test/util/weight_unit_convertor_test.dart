import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/model/unit.dart';
import 'package:workout_app/util/weight_unit_convertor.dart';

void main() {
  test('convert pound to kilogram', () {
    // GIVEN
    const weight = 10.0;
    const from = WeightUnit.pound;
    const to = WeightUnit.kilogram;

    // WHEN
    final converted = WeightUnitConvertor.convert(weight, from, to: to);

    // THEN
    expect(converted, 4.535923700100354);
  });

  test('convert kilogram to pound', () {
    // GIVEN
    const weight = 10.0;
    const from = WeightUnit.kilogram;
    const to = WeightUnit.pound;

    // WHEN
    final converted = WeightUnitConvertor.convert(weight, from, to: to);

    // THEN
    expect(converted, 22.046226218);
  });

  test('convert same unit', () {
    // GIVEN
    const weight = 10.0;
    const from = WeightUnit.kilogram;
    const to = WeightUnit.kilogram;

    // WHEN
    final converted = WeightUnitConvertor.convert(weight, from, to: to);

    // THEN
    expect(converted, 10);
  });
}