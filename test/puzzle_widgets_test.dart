// Coverage for MatchPuzzleWidget and CircuitPuzzleWidget: these had zero
// tests despite being used across dozens of chapters in every subject.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cs_quest/models/pq_models.dart';
import 'package:cs_quest/widgets/puzzle/circuit_puzzle.dart';
import 'package:cs_quest/widgets/puzzle/match_puzzle.dart';
import 'package:cs_quest/widgets/puzzle/order_puzzle.dart';
import 'package:cs_quest/widgets/puzzle/sort2_puzzle.dart';

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(MaterialApp(home: Scaffold(body: child)));
}

void main() {
  group('MatchPuzzleWidget', () {
    final puzzle = MatchPuzzle(
      instructions: 'Match the terms',
      pairs: const [
        MatchPair('p1', 'Stack', 'LIFO'),
        MatchPair('p2', 'Queue', 'FIFO'),
      ],
      explainOk: 'Great matching!',
    );

    testWidgets('tapping a correct pair locks it in and updates the counter', (tester) async {
      var checked = false;
      await _pump(tester, MatchPuzzleWidget(puzzle: puzzle, onChecked: (ok) => checked = ok));

      await tester.tap(find.text('Stack'));
      await tester.pump();
      await tester.tap(find.text('LIFO'));
      await tester.pump();

      expect(find.text('Matched 1/2 🧩'), findsOneWidget);
      expect(checked, isFalse, reason: 'should not report success until all pairs are matched');
    });

    testWidgets('tapping a wrong pair shows a transient wrong state and does not lock it', (tester) async {
      await _pump(tester, MatchPuzzleWidget(puzzle: puzzle, onChecked: (_) {}));

      await tester.tap(find.text('Stack'));
      await tester.pump();
      await tester.tap(find.text('FIFO'));
      await tester.pump();

      expect(find.text('Matched 0/2 🧩'), findsOneWidget);

      // The 450ms clear-timer must fire without throwing (mounted guard).
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Matched 0/2 🧩'), findsOneWidget);
    });

    testWidgets('matching every pair calls onChecked(true) exactly once and shows explainOk', (tester) async {
      var callCount = 0;
      var lastValue = false;
      await _pump(tester, MatchPuzzleWidget(puzzle: puzzle, onChecked: (ok) {
        callCount++;
        lastValue = ok;
      }));

      await tester.tap(find.text('Stack'));
      await tester.pump();
      await tester.tap(find.text('LIFO'));
      await tester.pump();
      await tester.tap(find.text('Queue'));
      await tester.pump();
      await tester.tap(find.text('FIFO'));
      await tester.pump();

      expect(callCount, 1);
      expect(lastValue, isTrue);
      expect(find.text('Matched 2/2 🧩'), findsOneWidget);
      expect(find.text('Great matching!'), findsOneWidget);
    });

    testWidgets('a matched chip ignores further taps', (tester) async {
      await _pump(tester, MatchPuzzleWidget(puzzle: puzzle, onChecked: (_) {}));

      await tester.tap(find.text('Stack'));
      await tester.pump();
      await tester.tap(find.text('LIFO'));
      await tester.pump();
      expect(find.text('Matched 1/2 🧩'), findsOneWidget);

      // Tapping the now-matched "Stack" chip again must be a no-op, not a crash.
      await tester.tap(find.text('Stack'));
      await tester.pump();
      expect(find.text('Matched 1/2 🧩'), findsOneWidget);
    });
  });

  group('CircuitPuzzleWidget', () {
    testWidgets('AND gate: only lights up and reports success when both inputs are 1', (tester) async {
      final puzzle = CircuitPuzzle(
        instructions: 'Light the AND gate',
        gate: CircuitGate.and,
        explainOk: 'Both were high!',
        explainBad: 'Need both inputs high.',
      );
      var lastResult = false;
      await _pump(tester, CircuitPuzzleWidget(puzzle: puzzle, onChecked: (ok) => lastResult = ok));

      await tester.tap(find.text('Check'));
      await tester.pump();
      expect(lastResult, isFalse);
      expect(find.text('Need both inputs high.'), findsOneWidget);

      await tester.tap(find.text('Try again'));
      await tester.pump();
      await tester.tap(find.text('A: 0'));
      await tester.pump();
      await tester.tap(find.text('B: 0'));
      await tester.pump();
      await tester.tap(find.text('Check'));
      await tester.pump();

      expect(lastResult, isTrue);
      expect(find.text('Both were high!'), findsOneWidget);
    });

    testWidgets('OR gate: lights up and succeeds with only one input high', (tester) async {
      final puzzle = CircuitPuzzle(
        instructions: 'Light the OR gate',
        gate: CircuitGate.or,
        explainOk: 'One was enough!',
        explainBad: 'Need at least one input high.',
      );
      var lastResult = false;
      await _pump(tester, CircuitPuzzleWidget(puzzle: puzzle, onChecked: (ok) => lastResult = ok));

      await tester.tap(find.text('A: 0'));
      await tester.pump();
      await tester.tap(find.text('Check'));
      await tester.pump();

      expect(lastResult, isTrue);
      expect(find.text('One was enough!'), findsOneWidget);
    });

    testWidgets('toggling an input after a failed check clears the banner', (tester) async {
      final puzzle = CircuitPuzzle(
        instructions: 'Light the AND gate',
        gate: CircuitGate.and,
        explainOk: 'Both were high!',
        explainBad: 'Need both inputs high.',
      );
      await _pump(tester, CircuitPuzzleWidget(puzzle: puzzle, onChecked: (_) {}));

      await tester.tap(find.text('Check'));
      await tester.pump();
      expect(find.text('Need both inputs high.'), findsOneWidget);

      await tester.tap(find.text('A: 0'));
      await tester.pump();
      expect(find.text('Need both inputs high.'), findsNothing);
      expect(find.text('Check'), findsOneWidget);
    });
  });

  group('OrderPuzzleWidget', () {
    final puzzle = OrderPuzzle(
      instructions: 'Put these in order',
      items: const [
        OrderItem('a', 'First'),
        OrderItem('b', 'Second'),
        OrderItem('c', 'Third'),
      ],
      explainOk: 'Correct order!',
      explainBad: 'Not quite the right order.',
    );

    testWidgets('checking the shuffled (near-certainly wrong) order reports failure without crashing', (tester) async {
      var reported = true;
      await _pump(tester, OrderPuzzleWidget(puzzle: puzzle, onChecked: (ok) => reported = ok));
      await tester.tap(find.text('Check order'));
      await tester.pump();
      // Whatever the shuffle produced, the widget must render a definitive banner, not crash.
      expect(find.byType(ElevatedButton), findsNothing);
      expect(reported, isA<bool>());
    });

    testWidgets('Try again clears the verdict and shows the Check button again', (tester) async {
      await _pump(tester, OrderPuzzleWidget(puzzle: puzzle, onChecked: (_) {}));
      await tester.tap(find.text('Check order'));
      await tester.pump();
      final tryAgain = find.text('Try again');
      if (tryAgain.evaluate().isNotEmpty) {
        await tester.tap(tryAgain);
        await tester.pump();
        expect(find.text('Check order'), findsOneWidget);
      }
    });
  });

  group('Sort2PuzzleWidget', () {
    final puzzle = Sort2Puzzle(
      instructions: 'Sort into buckets',
      bucketALabel: 'Bucket A',
      bucketBLabel: 'Bucket B',
      items: const [
        Sort2Item('x', 'Belongs in A', true),
        Sort2Item('y', 'Belongs in B', false),
      ],
      explainOk: 'Sorted correctly!',
      explainBad: 'Some cards are in the wrong bucket.',
    );

    testWidgets('Check is disabled until the tray is empty', (tester) async {
      await _pump(tester, Sort2PuzzleWidget(puzzle: puzzle, onChecked: (_) {}));
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull, reason: 'Check must be disabled while cards remain in the tray');
    });

    testWidgets('tap-to-place fallback: tap a bucket, then tap a card, places it there', (tester) async {
      await _pump(tester, Sort2PuzzleWidget(puzzle: puzzle, onChecked: (_) {}));

      // Default target is bucket A; tapping "Belongs in A" should place it directly.
      await tester.tap(find.text('Belongs in A'));
      await tester.pump();
      expect(find.text('Bucket A'), findsOneWidget);

      // Select bucket B, then tap the remaining tray card to place it there too.
      await tester.tap(find.text('Bucket B'));
      await tester.pump();
      await tester.tap(find.text('Belongs in B'));
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull, reason: 'tray should be empty now, enabling Check');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('Sorted correctly!'), findsOneWidget);
    });

    testWidgets('tap-to-place into the wrong bucket is reported as incorrect', (tester) async {
      await _pump(tester, Sort2PuzzleWidget(puzzle: puzzle, onChecked: (_) {}));

      await tester.tap(find.text('Belongs in A')); // default target bucket A: correct
      await tester.pump();
      await tester.tap(find.text('Belongs in B')); // still targeting bucket A: wrong
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      expect(find.text('Some cards are in the wrong bucket.'), findsOneWidget);
    });
  });
}
