import 'package:flutter/material.dart';
import '../../models/pq_models.dart';
import '../../theme.dart';

/// Tap-to-pair matching — pick one chip on the left, one on the right; a
/// correct pair locks in green, a wrong pair shakes and clears. Ported from
/// the web version's click-select mechanic (never used drag at all there),
/// so no touch-specific rework was needed — just a Flutter equivalent.
class MatchPuzzleWidget extends StatefulWidget {
  final MatchPuzzle puzzle;
  final ValueChanged<bool> onChecked;
  const MatchPuzzleWidget({super.key, required this.puzzle, required this.onChecked});

  @override
  State<MatchPuzzleWidget> createState() => _MatchPuzzleWidgetState();
}

class _MatchPuzzleWidgetState extends State<MatchPuzzleWidget> {
  late List<MatchPair> _left;
  late List<MatchPair> _right;
  final Set<String> _matched = {};
  String? _wrongLeft, _wrongRight;
  String? _selectedLeftId, _selectedRightId;

  @override
  void initState() {
    super.initState();
    _left = [...widget.puzzle.pairs]..shuffle();
    _right = [...widget.puzzle.pairs]..shuffle();
  }

  void _pick(String id, {required bool isLeft}) {
    if (_matched.contains(id)) return;
    setState(() {
      if (isLeft) {
        _selectedLeftId = id;
      } else {
        _selectedRightId = id;
      }
      if (_selectedLeftId != null && _selectedRightId != null) {
        if (_selectedLeftId == _selectedRightId) {
          _matched.add(_selectedLeftId!);
          if (_matched.length == widget.puzzle.pairs.length) widget.onChecked(true);
        } else {
          _wrongLeft = _selectedLeftId;
          _wrongRight = _selectedRightId;
          Future.delayed(const Duration(milliseconds: 450), () {
            if (!mounted) return;
            setState(() {
              _wrongLeft = null;
              _wrongRight = null;
            });
          });
        }
        _selectedLeftId = null;
        _selectedRightId = null;
      }
    });
  }

  Widget _chip(String id, String text, {required bool isLeft}) {
    final matched = _matched.contains(id);
    final wrong = isLeft ? _wrongLeft == id : _wrongRight == id;
    final selected = isLeft ? _selectedLeftId == id : _selectedRightId == id;
    Color border = QuestColors.of(context).textDim.withValues(alpha: 0.4);
    Color? fill;
    Color textColor = QuestColors.of(context).textPrimary;
    if (matched) {
      border = QuestColors.of(context).accent;
      fill = QuestColors.of(context).accent.withValues(alpha: 0.15);
      textColor = QuestColors.of(context).accent;
    } else if (wrong) {
      border = QuestColors.of(context).danger;
      fill = QuestColors.of(context).danger.withValues(alpha: 0.15);
    } else if (selected) {
      border = QuestColors.of(context).accent2;
      fill = QuestColors.of(context).accent2.withValues(alpha: 0.12);
    }
    return GestureDetector(
      onTap: matched ? null : () => _pick(id, isLeft: isLeft),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(color: fill, border: Border.all(color: border), borderRadius: BorderRadius.circular(10)),
        child: Text(text, style: TextStyle(color: textColor, fontSize: 13)),
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
        const SizedBox(height: 10),
        Text('Matched ${_matched.length}/${p.pairs.length} 🧩', style: TextStyle(fontSize: 12, color: QuestColors.of(context).textDim, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Column(children: [for (final pr in _left) _chip(pr.id, pr.left, isLeft: true)])),
            const SizedBox(width: 10),
            Expanded(child: Column(children: [for (final pr in _right) _chip(pr.id, pr.right, isLeft: false)])),
          ],
        ),
        if (_matched.length == p.pairs.length)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: QuestColors.of(context).accent.withValues(alpha: 0.12), border: Border.all(color: QuestColors.of(context).accent), borderRadius: BorderRadius.circular(12)),
              child: Text(p.explainOk, style: TextStyle(color: QuestColors.of(context).accent, fontWeight: FontWeight.w600)),
            ),
          ),
      ],
    );
  }
}
