import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/core_view/util/display_string_util.dart';
import 'package:workout_app/model/exercise.dart';
import 'package:workout_app/model/unit.dart';

void main() {
  testWidgets('String of weight unit for kilogram', (tester) async {
    // GIVEN
    final builder = Builder(builder: (context) {
      return Text(WeightUnit.kilogram.unitString(context));
    });

    // WHEN
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: builder,
      ),
    );

    // THEN
    expect(find.text("kg"), findsOneWidget);
  });

  testWidgets('String of weight unit for pound', (tester) async {
    // GIVEN
    final builder = Builder(builder: (context) {
      return Text(WeightUnit.pound.unitString(context));
    });

    // WHEN
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: builder,
      ),
    );

    // THEN
    expect(find.text("lb"), findsOneWidget);
  });

  test('String of total weight without decimal place', () {
    // GIVEN
    final exerciseSet = ExerciseSet(
      baseWeight: 20,
      sideWeight: 15,
      unit: WeightUnit.kilogram,
      repetition: 5,
    );

    // WHEN
    final result = exerciseSet.totalWeightString();

    // THEN
    expect(result, "50");
  });

  test('String of total weight round to one decimal place', () {
    // GIVEN
    final exerciseSet = ExerciseSet(
      baseWeight: 20.5,
      sideWeight: 15,
      unit: WeightUnit.kilogram,
      repetition: 5,
    );

    // WHEN
    final result = exerciseSet.totalWeightString();

    // THEN
    expect(result, "50.5");
  });

  test('String of total weight round to two decimal places', () {
    // GIVEN
    final exerciseSet = ExerciseSet(
      baseWeight: 20.25,
      sideWeight: 15,
      unit: WeightUnit.kilogram,
      repetition: 5,
    );

    // WHEN
    final result = exerciseSet.totalWeightString();

    // THEN
    expect(result, "50.25");
  });
}
