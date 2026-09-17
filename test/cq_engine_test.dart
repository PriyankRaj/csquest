// Verifies the expanded Code Quest block engine (Control/Looks/Sound/
// Variables categories added on top of the original Motion-only set) before
// any lesson content is authored against it.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cs_quest/main.dart';
import 'package:cs_quest/nav/quest_nav.dart';
import 'package:cs_quest/progress/progress_store.dart';

Future<void> _openFirstStepsLesson(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  progressStore = await ProgressStore.load();
  QuestNav.tabIndex.value = 0;
  await tester.pumpWidget(const QuestApp());
  await tester.pumpAndSettle();

  await tester.tap(find.text('Code Quest'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Bring a Character to Life'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('First Steps!'));
  await tester.pumpAndSettle();
}

// dragUntilVisible's own "found it" check is coarser than the exact pixel
// bounds tester.tap() hit-tests against, so a target can register as "found"
// a few pixels past the edge. ensureVisible() afterwards nails the exact
// scroll offset needed before we ever try to tap.
Future<void> _scrollTo(WidgetTester tester, Finder target) async {
  final scrollable = find.descendant(of: find.byType(ListView), matching: find.byType(Scrollable));
  await tester.scrollUntilVisible(target, 150, scrollable: scrollable);
  await tester.pumpAndSettle();
  await tester.ensureVisible(target);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Palette groups blocks by category, including the new ones', (tester) async {
    await _openFirstStepsLesson(tester);

    await tester.tap(find.text('Block'));
    await tester.pumpAndSettle();

    // Walk top-to-bottom in visual order — the drag-based scroller only
    // reliably moves one direction, so checking out of order would require
    // scrolling back up.
    const expected = [
      'MOTION',
      'CONTROL', 'repeat 4 times', 'wait 1 seconds',
      'LOOKS', 'say Hello!', 'show', 'hide',
      'SOUND', 'play sound',
      'VARIABLES', 'set Score to 0', 'change Score by 1',
    ];
    for (final label in expected) {
      final finder = find.textContaining(label);
      await _scrollTo(tester, finder);
      expect(finder, findsOneWidget, reason: 'missing "$label" in palette');
    }
  });

  testWidgets('Variables: set Score, run, watcher updates on stage', (tester) async {
    await _openFirstStepsLesson(tester);

    expect(find.text('Score: 0'), findsOneWidget);

    await tester.tap(find.text('Block'));
    await tester.pumpAndSettle();
    final setScore = find.textContaining('set Score to 0');
    await _scrollTo(tester, setScore);
    await tester.tap(setScore);
    await tester.pumpAndSettle();

    final valueField = find.widgetWithText(TextFormField, '0');
    await tester.enterText(valueField, '7');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Run'));
    await tester.pumpAndSettle();

    expect(find.text('Score: 7'), findsOneWidget);
  });

  testWidgets('Looks: say block accepts free text, not just numbers', (tester) async {
    await _openFirstStepsLesson(tester);

    await tester.tap(find.text('Block'));
    await tester.pumpAndSettle();
    final sayBlock = find.textContaining('say Hello!');
    await _scrollTo(tester, sayBlock);
    await tester.tap(sayBlock);
    await tester.pumpAndSettle();

    final textField = find.widgetWithText(TextFormField, 'Hello!');
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'Wheee!');
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextFormField, 'Wheee!'), findsOneWidget);
  });

  testWidgets('Control: repeat is a container that accepts nested blocks', (tester) async {
    await _openFirstStepsLesson(tester);

    await tester.tap(find.text('Block'));
    await tester.pumpAndSettle();
    final repeatBlock = find.textContaining('repeat 4 times');
    await _scrollTo(tester, repeatBlock);
    await tester.tap(repeatBlock);
    await tester.pumpAndSettle();

    expect(find.text('Add inside'), findsOneWidget);
    await tester.tap(find.text('Add inside'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('move 10 steps'));
    await tester.pumpAndSettle();

    // The nested move block should now render inside the repeat container.
    expect(find.textContaining('move'), findsWidgets);
    expect(find.widgetWithText(TextFormField, '10'), findsOneWidget);
  });
}
