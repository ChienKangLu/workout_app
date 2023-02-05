import 'package:flutter/material.dart';

import '../../model/unit.dart';
import '../../util/localization_util.dart';

class WeightUnitDisplayHelper {
  static String toDisplayString(BuildContext context, WeightUnit unit) {
    switch (unit) {
      case WeightUnit.kilogram:
        return LocalizationUtil.localize(context).unitKilogram;
      case WeightUnit.pound:
        return LocalizationUtil.localize(context).unitPound;
    }
  }
}