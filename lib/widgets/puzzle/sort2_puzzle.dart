import 'package:flutter/material.dart';
import '../../models/pq_models.dart';
import '../../theme.dart';
import 'feedback_banner.dart';

/// Sort into two buckets — Flutter's Draggable/DragTarget handle touch
/// natively (unlike the web version's HTML5 drag-and-drop, which silently
/// didn't work on any phone). Chips also respond to a plain tap-to-place via
/// the last-tapped bucket, for anyone who finds drag fiddly.
class Sort2PuzzleWidget extends StatefulWidget {
  final Sort2Puzzle puzzle;
  final ValueChanged<bool> onChecked;
  const Sort2PuzzleWidget({super.key, required this.puzzle, required this.onChecked});

  @override
  State<Sort2PuzzleWidget> createState() => _Sort2PuzzleWidgetState();
}

class _Sort2PuzzleWidgetState extends State<Sort2PuzzleWidget> {
  late List<Sort2Item> _tray;
  final Map<String, bool> _placed = {}; // itemId -> placed in bucket A?
  bool? _correct;
  bool _lastTappedBucketA = true; // tap-to-place fallback target, defaults to bucket A

  @override
  void initState() {
    super.initState();
    _tray = [...widget.puzzle.items]..shuffle();
  }

  void _drop(Sort2Item item, bool toBucketA) {
    setState(() {
      _tray.removeWhere((e) => e.id == item.id);
      _placed[item.id] = toBucketA;
    });
  }

  void _check() {
    final ok = _tray.isEmpty && widget.puzzle.items.every((it) => _placed[it.id] == it.bucketA);
    setState(() => _correct = ok);
    widget.onChecked(ok);
  }

  Widget _chip(Sort2Item item) {
    return Draggable<Sort2Item>(
      data: item,
      feedback: Material(color: Colors.transparent, child: _chipVisual(item, dragging: true)),
      childWhenDragging: Opacity(opacity: 0.3, child: _chipVisual(item)),
      child: GestureDetector(
        onTap: () => _drop(item, _lastTappedBucketA),
        child: _chipVisual(item),
      ),
    );
  }

  Widget _chipVisual(Sort2Item item, {bool dragging = false}) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: dragging ? QuestColors.of(context).accent.withValues(alpha: 0.25) : QuestColors.of(context).panel2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: QuestColors.of(context).textDim.withValues(alpha: 0.4)),
      ),
      child: Text(item.label, style: TextStyle(color: QuestColors.of(context).textPrimary, fontSize: 13)),
    );
  }

  Widget _bucket(String label, bool isA) {
    final items = widget.puzzle.items.where((it) => _placed[it.id] == isA).toList();
    final isTapTarget = _tray.isNotEmpty && _lastTappedBucketA == isA;
    return Expanded(
      child: DragTarget<Sort2Item>(
        onAcceptWithDetails: (details) => _drop(details.data, isA),
        builder: (context, candidateData, rejectedData) {
          final hovering = candidateData.isNotEmpty;
          final highlight = hovering || isTapTarget;
          return GestureDetector(
            onTap: () => setState(() => _lastTappedBucketA = isA),
            child: Container(
              constraints: const BoxConstraints(minHeight: 110),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: hovering ? QuestColors.of(context).accent.withValues(alpha: 0.1) : QuestColors.of(context).panel,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: highlight ? QuestColors.of(context).accent : QuestColors.of(context).textDim.withValues(alpha: 0.3), width: highlight ? 2 : 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: QuestColors.of(context).accent)),
                  const SizedBox(height: 6),
                  Wrap(children: items.map((it) => GestureDetector(onTap: () {}, child: _chipVisual(it))).toList()),
                ],
              ),
            ),
          );
        },
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
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bucket(p.bucketALabel, true),
            const SizedBox(width: 10),
            _bucket(p.bucketBLabel, false),
          ],
        ),
        const SizedBox(height: 12),
        if (_tray.isNotEmpty) ...[
          Text('Drag each card into a bucket, or tap a bucket then tap a card:', style: TextStyle(fontSize: 12, color: QuestColors.of(context).textDim)),
          const SizedBox(height: 6),
          Wrap(children: _tray.map(_chip).toList()),
          const SizedBox(height: 12),
        ],
        if (_correct == null)
          ElevatedButton(onPressed: _tray.isEmpty ? _check : null, child: const Text('Check')),
        if (_correct != null) FeedbackBanner(ok: _correct!, text: _correct! ? p.explainOk : p.explainBad),
        if (_correct == false)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextButton(
              onPressed: () => setState(() {
                _correct = null;
                _tray = [...p.items]..shuffle();
                _placed.clear();
              }),
              child: const Text('Try again'),
            ),
          ),
      ],
    );
  }
}
