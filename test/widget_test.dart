// Smoke test: the app boots to the Process Quest tab without throwing.

import 'package:flutter_test/flutter_test.dart';

import 'package:cs_quest/main.dart';

void main() {
  testWidgets('App boots to the Home screen showing both quests', (WidgetTester tester) async {
    await tester.pumpWidget(const QuestApp());
    await tester.pumpAndSettle();

    expect(find.text('🐢 Quest Hub'), findsOneWidget);
    expect(find.text('Process Quest'), findsOneWidget);
    expect(find.text('Code Quest'), findsOneWidget);
  });
}
