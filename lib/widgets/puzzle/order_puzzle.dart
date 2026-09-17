import 'package:flutter/material.dart';
import '../../models/pq_models.dart';
import '../../theme.dart';
import 'feedback_banner.dart';

/// Reordering on mobile: ReorderableListView with a drag handle — long-press
/// or grab the handle and drag. This is the native mobile equivalent of the
/// web version's HTML5 drag-and-drop (which never worked on touch at all).
class OrderPuzzleWidget extends StatefulWidget {
  final OrderPuzzle puzzle;
  final ValueChanged<bool> onChecked;
  const OrderPuzzleWidget({super.key, required this.puzzle, required this.onChecked});

  @override
  State<OrderPuzzleWidget> createState() => _OrderPuzzleWidgetState();
}

class _OrderPuzzleWidgetState extends State<OrderPuzzleWidget> {
  late List<OrderItem> _items;
  bool? _correct;

  @override
  void initState() {
    super.initState();
    _items = [...widget.puzzle.items]..shuffle();
  }

  void _check() {
    final ok = _items.map((e) => e.id).toList().toString() ==
        widget.puzzle.items.map((e) => e.id).toList().toString();
    setState(() => _correct = ok);
    widget.onChecked(ok);
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.puzzle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(p.instructions, style: TextStyle(fontSize: 14, color: QuestColors.of(context).textDim)),
        const SizedBox(height: 12),
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex -= 1;
              final item = _items.removeAt(oldIndex);
              _items.insert(newIndex, item);
            });
          },
          itemBuilder: (context, i) {
            final item = _items[i];
            return Container(
              key: ValueKey(item.id),
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: QuestColors.of(context).panel2,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: QuestColors.of(context).textDim.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Text('${i + 1}.', style: TextStyle(color: QuestColors.of(context).textDim, fontWeight: FontWeight.w700)),
                  const SizedBox(width: 10),
                  Expanded(child: Text(item.label, style: TextStyle(color: QuestColors.of(context).textPrimary))),
                  Icon(Icons.drag_handle, color: QuestColors.of(context).textDim),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        if (_correct == null) ElevatedButton(onPressed: _check, child: const Text('Check order')),
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
