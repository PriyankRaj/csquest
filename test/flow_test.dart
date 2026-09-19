// End-to-end widget flow checks: exercise the real navigation + puzzle +
// block-editor interactions a user would actually perform, not just "does it
// build". Uses a fresh SharedPreferences mock per test via setUp.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cs_quest/main.dart';
import 'package:cs_quest/nav/quest_nav.dart';
import 'package:cs_quest/progress/progress_store.dart';

Future<void> _boot(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  progressStore = await ProgressStore.load();
  QuestNav.tabIndex.value = 0; // tests share the same static notifier
  await tester.pumpWidget(const QuestApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Process Quest: open OS, solve an MCQ chapter', (tester) async {
    await _boot(tester);

    // App boots to Home — tap its Process Quest card to enter that tab
    // (there's no bottom nav bar anymore; navigation is via Home + the
    // top-bar quest switcher).
    await tester.tap(find.text('Process Quest'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Operating Systems'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Operating Systems'), findsWidgets);

    // First path node should be tappable (unlocked by default).
    await tester.tap(find.text('The Birth of a Process'));
    await tester.pumpAndSettle();

    expect(find.textContaining('PCB'), findsWidgets);

    // Select the correct MCQ option (index 2) and check it — scroll each
    // into view first since the chapter body pushes them below the fold.
    final option = find.text(
        'The actual compiled machine code of every other process on the system');
    await tester.scrollUntilVisible(option, 200);
    await tester.pumpAndSettle();
    await tester.tap(option);
    await tester.pumpAndSettle();

    final checkBtn = find.text('Check');
    await tester.scrollUntilVisible(checkBtn, 200);
    await tester.pumpAndSettle();
    await tester.tap(checkBtn);
    await tester.pumpAndSettle();

    expect(find.textContaining('a PCB describes this process only'), findsOneWidget);
    expect(find.text('Back to path'), findsOneWidget);
  });

  testWidgets('Code Quest: open movement lesson 1, add a move block, run and check', (tester) async {
    await _boot(tester);

    await tester.tap(find.text('Code Quest'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Bring a Character to Life'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('First Steps!'));
    await tester.pumpAndSettle();

    // Empty script placeholder should be visible before adding anything.
    expect(find.textContaining('Tap "+ Block" to start'), findsOneWidget);

    await tester.tap(find.text('Block'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('move 10 steps'));
    await tester.pumpAndSettle();

    expect(find.textContaining('move'), findsWidgets);
    // Regression guard: the value chip must actually render in the placed
    // block (previously silently dropped entirely — see _blockLabelRow),
    // pre-filled with the block's default.
    final valueChip = find.text('10');
    expect(valueChip, findsOneWidget);

    // Changing it is tap-a-chip, never a keyboard: tap the value to open the
    // option picker, then tap a different preset.
    await tester.tap(valueChip);
    await tester.pumpAndSettle();
    await tester.tap(find.text('30').last);
    await tester.pumpAndSettle();
    expect(find.text('30'), findsOneWidget);

    // Check now lives in the CTA row below the canvas (always on-screen).
    await tester.tap(find.widgetWithText(FilledButton, 'Check'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Nailed it'), findsOneWidget);
  });

  testWidgets('Quest switcher: no bottom nav bar, top-bar icon switches tabs', (tester) async {
    await _boot(tester);

    // No persistent bottom nav bar anymore.
    expect(find.byType(NavigationBar), findsNothing);

    await tester.tap(find.text('Process Quest'));
    await tester.pumpAndSettle();
    expect(find.text('Operating Systems'), findsOneWidget);

    // Tap the top-bar switcher and jump straight to Code Quest.
    await tester.tap(find.byTooltip('Switch quest'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Code Quest'));
    await tester.pumpAndSettle();

    expect(find.text('Bring a Character to Life'), findsOneWidget);
  });
}
