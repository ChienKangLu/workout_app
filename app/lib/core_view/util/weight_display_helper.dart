import 'package:flutter/material.dart';

import '../../model/exercise.dart';
import '../../model/unit.dart';
import '../../util/localization_util.dart';
import '../../util/string_util.dart';

extension WeightUnitExtension on WeightUnit {
  String displayString(BuildContext context) {
    switch (this) {
      case WeightUnit.kilogram:
        return LocalizationUtil.localize(context).unitKilogram;
      case WeightUnit.pound:
        return LocalizationUtil.localize(context).unitPound;
    }
  }
}

extension WeightTrainingSetExtension on WeightTrainingExerciseSet {
  String displayTotalWeight({
    int digits = 2,
  }) {
    final text = totalWeight().toStringAsFixed(digits);
    return text.trimTrailingZero(digits);
  }

  double totalWeight() => baseWeight + sideWeight * 2;
}
