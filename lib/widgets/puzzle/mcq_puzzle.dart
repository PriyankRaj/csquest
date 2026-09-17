import 'package:flutter/material.dart';
import '../../models/pq_models.dart';
import '../../theme.dart';
import 'feedback_banner.dart';

class McqPuzzleWidget extends StatefulWidget {
  final McqPuzzle puzzle;
  final ValueChanged<bool> onChecked; // true = correct
  const McqPuzzleWidget({super.key, required this.puzzle, required this.onChecked});

  @override
  State<McqPuzzleWidget> createState() => _McqPuzzleWidgetState();
}

class _McqPuzzleWidgetState extends State<McqPuzzleWidget> {
  int? _selected;
  bool? _correct;

  void _check() {
    if (_selected == null) return;
    final ok = _selected == widget.puzzle.answerIndex;
    setState(() => _correct = ok);
    widget.onChecked(ok);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.puzzle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(p.question, style: const TextStyle(fontSize: 15, height: 1.4)),
        const SizedBox(height: 14),
        ...List.generate(p.options.length, (i) {
          final selected = _selected == i;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: OutlinedButton(
              onPressed: _correct == true ? null : () => setState(() => _selected = i),
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                backgroundColor: selected ? QuestColors.accent.withValues(alpha: 0.12) : null,
                side: BorderSide(color: selected ? QuestColors.accent : QuestColors.textDim.withValues(alpha: 0.4)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(p.options[i], style: const TextStyle(color: Colors.white)),
            ),
          );
        }),
        const SizedBox(height: 8),
        if (_correct == null)
          ElevatedButton(onPressed: _selected == null ? null : _check, child: const Text('Check')),
        if (_correct != null)
          FeedbackBanner(ok: _correct!, text: _correct! ? p.explainOk : p.explainBad),
        if (_correct == false)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextButton(onPressed: () => setState(() => _correct = null), child: const Text('Try again')),
          ),
      ],
    );
  }
}
