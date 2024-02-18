import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:workout_app/util/localization_util.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget testApp(
      Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
      void Function(BuildContext) callback) {
    return MaterialApp(
      localizationsDelegates: localizationsDelegates,
      home: Builder(
        builder: (context) {
          callback(context);
          return Container();
        },
      ),
    );
  }

  testWidgets("get localize failed", (tester) async {
    await tester.pumpWidget(
      testApp(null, (context) {
        expect(() => LocalizationUtil.localize(context), throwsA(isA<Exception>()));
      }),
    );
  });

  testWidgets("get localize successfully", (tester) async {
    await tester.pumpWidget(
      testApp(AppLocalizations.localizationsDelegates, (context) {
        expect(LocalizationUtil.localize(context), isNotNull);
      }),
    );
  });
}
