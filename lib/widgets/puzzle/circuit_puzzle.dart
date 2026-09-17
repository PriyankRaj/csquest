import 'package:flutter/material.dart';
import '../../models/pq_models.dart';
import '../../theme.dart';
import 'feedback_banner.dart';

/// Toggle-the-circuit — flip A/B, watch the LED, hit Check once it's lit.
/// Same mechanic as the web version (button taps, never drag), so it needed
/// no touch rework at all — just a faithful Flutter port.
class CircuitPuzzleWidget extends StatefulWidget {
  final CircuitPuzzle puzzle;
  final ValueChanged<bool> onChecked;
  const CircuitPuzzleWidget({super.key, required this.puzzle, required this.onChecked});

  @override
  State<CircuitPuzzleWidget> createState() => _CircuitPuzzleWidgetState();
}

class _CircuitPuzzleWidgetState extends State<CircuitPuzzleWidget> {
  int _a = 0, _b = 0;
  bool? _correct;

  bool get _lit => widget.puzzle.gate == CircuitGate.and ? (_a == 1 && _b == 1) : (_a == 1 || _b == 1);

  void _check() {
    setState(() => _correct = _lit);
    widget.onChecked(_lit);
  }

  Widget _toggle(String label, int value, VoidCallback onTap) {
    final on = value == 1;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 74,
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          color: on ? QuestColors.of(context).accent : QuestColors.of(context).panel2,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: on ? QuestColors.of(context).accent : QuestColors.of(context).textDim.withValues(alpha: 0.4)),
        ),
        child: Text('$label: $value', style: TextStyle(color: on ? const Color(0xFF0B1220) : QuestColors.of(context).textPrimary, fontWeight: FontWeight.w700)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.puzzle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(p.instructions, style: TextStyle(fontSize: 14, color: QuestColors.of(context).textDim)),
        const SizedBox(height: 14),
        Row(
          children: [
            _toggle('A', _a, () => setState(() { _a = 1 - _a; _correct = null; })),
            _toggle('B', _b, () => setState(() { _b = 1 - _b; _correct = null; })),
            Container(
              width: 60, height: 60, alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _lit ? QuestColors.of(context).accent2 : QuestColors.of(context).panel2,
                boxShadow: _lit ? [BoxShadow(color: QuestColors.of(context).accent2.withValues(alpha: 0.6), blurRadius: 16, spreadRadius: 2)] : null,
              ),
              child: Text(p.gate == CircuitGate.and ? 'AND' : 'OR', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: _lit ? const Color(0xFF0B1220) : QuestColors.of(context).textPrimary)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_correct == null) ElevatedButton(onPressed: _check, child: const Text('Check')),
        if (_correct != null) FeedbackBanner(ok: _correct!, text: _correct! ? p.explainOk : p.explainBad),
        if (_correct == false)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextButton(onPressed: () => setState(() => _correct = null), child: const Text('Try again')),
          ),
      ],
    );
  }
}
