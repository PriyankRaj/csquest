// Smoke test: the app boots to the Process Quest tab without throwing.

import 'package:flutter_test/flutter_test.dart';

import 'package:cs_quest/main.dart';

void main() {
  testWidgets('App boots to the Home screen showing both quests', (WidgetTester tester) async {
    await tester.pumpWidget(const QuestApp());
    await tester.pumpAndSettle();

    // At least one 🐢 (title) — the top-bar quest switcher icon is also a
    // turtle (see QuestSwitcherAction), so this can't assert exactly one.
    expect(find.text('🐢'), findsWidgets);
    expect(find.text('Quest Hub'), findsOneWidget);
    expect(find.text('Process Quest'), findsOneWidget);
    expect(find.text('Code Quest'), findsOneWidget);
  });
}
