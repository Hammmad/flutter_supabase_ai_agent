import 'package:flutter_test/flutter_test.dart';

import 'package:example_app_supabase/main.dart';

void main() {
  testWidgets('Shows setup message when Supabase is not configured', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.textContaining('Supabase is not configured'), findsOneWidget);
  });
}
