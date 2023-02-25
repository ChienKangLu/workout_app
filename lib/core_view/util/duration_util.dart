import 'package:flutter/material.dart';

import '../../util/localization_util.dart';

class DurationUtil {
  static String displayText(BuildContext context, Duration duration) {
    final hours = duration.inHours.remainder(24).toString().padLeft(2, "0");
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$hours:$minutes:$seconds";
  }
}
