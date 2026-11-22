import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example_app_supabase/main.dart';

void main() {
  testWidgets('Shows setup message when Supabase is not configured', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.textContaining('Supabase is not configured'), findsOneWidget);
  });

  testWidgets('Component gallery renders every section', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 6000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('View components'));
    // The gallery has an always-spinning loader, so pumpAndSettle never settles.
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    for (final section in [
      'Text fields',
      'Dropdown',
      'Buttons',
      'Checkbox and card',
      'Empty state',
    ]) {
      expect(find.text(section), findsOneWidget);
    }
    expect(tester.takeException(), isNull);

    // Password toggle reveals text.
    await tester.tap(find.byTooltip('Show password'));
    await tester.pump();
    expect(find.byTooltip('Hide password'), findsOneWidget);
  });
}
