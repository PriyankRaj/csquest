import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/pq_models.dart';
import '../../theme.dart';
import '../../widgets/home_action.dart';
import '../../widgets/puzzle/circuit_puzzle.dart';
import '../../widgets/puzzle/match_puzzle.dart';
import '../../widgets/puzzle/mcq_puzzle.dart';
import '../../widgets/puzzle/order_puzzle.dart';
import '../../widgets/puzzle/sort2_puzzle.dart';
import '../../widgets/quest_switcher_action.dart';

/// One chapter — narrative up top, hint callouts collapsed behind a 💡
/// disclosure (matches the web version's fix for the same problem), then the
/// puzzle. "Next" only appears once the puzzle is solved.
class ChapterScreen extends StatefulWidget {
  final Subject subject;
  final Chapter chapter;
  const ChapterScreen({super.key, required this.subject, required this.chapter});

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  bool _solved = false;

  Future<void> _onSolved() async {
    if (_solved) return;
    setState(() => _solved = true);
    await progressStore.markDone('pq:${widget.subject.id}:${widget.chapter.id}');
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.chapter;
    return Scaffold(
      appBar: AppBar(
        title: Text(c.title),
        actions: const [HomeAction(), QuestSwitcherAction(current: 1)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 22, backgroundColor: QuestColors.of(context).panel2, child: Text(c.avatar, style: const TextStyle(fontSize: 20))),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Process', style: TextStyle(fontWeight: FontWeight.w700)),
                      Text(c.role, style: TextStyle(fontSize: 12, color: QuestColors.of(context).textDim)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(c.bodyIntro, style: TextStyle(fontSize: 15, height: 1.5, color: QuestColors.of(context).textPrimary)),
            for (final hint in c.calloutHints)
              Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  leading: const Text('💡', style: TextStyle(fontSize: 18)),
                  title: const Text('Hint', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(hint, style: TextStyle(fontSize: 13, color: QuestColors.of(context).textDim)),
                    ),
                  ],
                ),
              ),
            const Divider(height: 32),
            Text('🧩 Puzzle time', style: TextStyle(fontWeight: FontWeight.w800, color: QuestColors.of(context).accent)),
            const SizedBox(height: 12),
            switch (c.puzzleType) {
              PuzzleType.mcq => McqPuzzleWidget(puzzle: c.mcq!, onChecked: (ok) { if (ok) _onSolved(); }),
              PuzzleType.order => OrderPuzzleWidget(puzzle: c.order!, onChecked: (ok) { if (ok) _onSolved(); }),
              PuzzleType.sort2 => Sort2PuzzleWidget(puzzle: c.sort2!, onChecked: (ok) { if (ok) _onSolved(); }),
              PuzzleType.match => MatchPuzzleWidget(puzzle: c.match!, onChecked: (ok) { if (ok) _onSolved(); }),
              PuzzleType.circuit => CircuitPuzzleWidget(puzzle: c.circuit!, onChecked: (ok) { if (ok) _onSolved(); }),
            },
            const SizedBox(height: 20),
            if (_solved)
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Back to path'),
              ),
          ],
        ),
      ),
    );
  }
}
