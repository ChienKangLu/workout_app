import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationUtil {
  static AppLocalizations localize(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    if (appLocalizations == null) {
      throw Exception("No app localization");
    }

    return appLocalizations;
  }
}