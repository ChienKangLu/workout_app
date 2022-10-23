import 'package:flutter/material.dart';

import '../../util/localization_util.dart';

class DurationUtil {
  static String displayText(BuildContext context, Duration duration) {
    final displayTexts = <String>[];
    final hours = duration.inHours.remainder(24);
    if (hours > 0) {
      displayTexts
          .add("$hours ${LocalizationUtil.localize(context).hourUnitText}");
    }
    final minutes = duration.inMinutes.remainder(60);
    if (minutes > 0) {
      displayTexts
          .add("$minutes ${LocalizationUtil.localize(context).minuteUnitText}");
    }
    final seconds = duration.inSeconds.remainder(60);
    if (seconds > 0) {
      displayTexts
          .add("$seconds ${LocalizationUtil.localize(context).secondUnitText}");
    }
    final milliseconds = duration.inMilliseconds.remainder(1000);
    if (milliseconds > 0) {
      displayTexts.add(
          "$milliseconds ${LocalizationUtil.localize(context).millisecondUnitText}");
    }
    return displayTexts.join(" ");
  }
}
