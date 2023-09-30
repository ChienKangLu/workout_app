import 'package:flutter/material.dart';

import '../../model/exercise.dart';
import '../../model/unit.dart';
import '../../util/localization_util.dart';
import '../../util/string_util.dart';

extension WeightUnitExtension on WeightUnit {
  String unitString(BuildContext context) {
    switch (this) {
      case WeightUnit.kilogram:
        return LocalizationUtil.localize(context).unitKilogram;
      case WeightUnit.pound:
        return LocalizationUtil.localize(context).unitPound;
    }
  }
}

extension ExerciseSetExtension on ExerciseSet {
  String totalWeightString({
    int digits = 2,
  }) {
    final text = totalWeight().toStringAsFixed(digits);
    return text.trimTrailingZero(digits);
  }
}
