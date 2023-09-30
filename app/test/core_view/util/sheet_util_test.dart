import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_app/core_view/util/sheet_util.dart';

void main() {
  testWidgets('Show sheet', (tester) async {
    // GIVEN
    const sheet = "sheet";
    final builder = Builder(builder: (context) {
      return Center(
        child: ElevatedButton(
          child: const Text("Button"),
          onPressed: () {
            SheetUtil.showSheet(
                context: context,
                builder: (context) {
                  return const Text(sheet);
                });
          },
        ),
      );
    });

    // WHEN
    await tester.pumpWidget(
      MaterialApp(home: builder),
    );
    final elevatedButton = find.byType(ElevatedButton);
    await tester.tap(elevatedButton);
    await tester.pumpAndSettle();

    // THEN
    expect(find.text(sheet), findsOneWidget);
  });
}
