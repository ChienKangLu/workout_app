import 'dart:math';

import '../model/unit.dart';

class WeightUnitConvertor {
  static const double pound = 2.2046226218;

  static double convert(
    double weight,
    WeightUnit from, {
    WeightUnit to = WeightUnit.kilogram,
  }) {
    if (from == to) {
      return weight;
    }

    return weight * pow(pound, from == WeightUnit.pound ? -1 : 1);
  }
}
