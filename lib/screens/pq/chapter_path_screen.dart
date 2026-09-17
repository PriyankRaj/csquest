import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/pq_models.dart';
import '../../widgets/home_action.dart';
import '../../widgets/path_node.dart';
import '../../widgets/quest_switcher_action.dart';
import 'chapter_screen.dart';

/// The Duolingo-style vertical lesson path for one subject — zig-zagging
/// nodes, top to bottom, each locked until the previous one is done. This
/// replaces the web version's free-roam walking-map island entirely.
class ChapterPathScreen extends StatefulWidget {
  final Subject subject;
  const ChapterPathScreen({super.key, required this.subject});

  @override
  State<ChapterPathScreen> createState() => _ChapterPathScreenState();
}

class _ChapterPathScreenState extends State<ChapterPathScreen> {
  String _key(Chapter c) => 'pq:${widget.subject.id}:${c.id}';

  bool _isDone(Chapter c) => progressStore.isDone(_key(c));

  NodeState _stateFor(int index) {
    final chapters = widget.subject.chapters;
    if (_isDone(chapters[index])) return NodeState.done;
    final prevDone = index == 0 || _isDone(chapters[index - 1]);
    return prevDone ? NodeState.current : NodeState.locked;
  }

  Future<void> _openChapter(Chapter c, int index) async {
    if (_stateFor(index) == NodeState.locked) return;
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ChapterScreen(subject: widget.subject, chapter: c)),
    );
    setState(() {}); // refresh lock states after returning
  }

  @override
  Widget build(BuildContext context) {
    final chapters = widget.subject.chapters;
    final done = chapters.where(_isDone).length;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject.icon} ${widget.subject.name}'),
        actions: const [HomeAction(), QuestSwitcherAction(current: 1)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.subject.tagline, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: chapters.isEmpty ? 0 : done / chapters.length,
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 4),
                Text('$done/${chapters.length} chapters', style: const TextStyle(fontSize: 12, color: Colors.white54)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 24),
              itemCount: chapters.length,
              itemBuilder: (context, i) {
                final c = chapters[i];
                final align = i.isEven ? Alignment.center : (i % 4 == 1 ? Alignment(-0.4, 0) : Alignment(0.4, 0));
                return Align(
                  alignment: align,
                  child: PathNode(
                    glyph: c.avatar,
                    label: c.title,
                    state: _stateFor(i),
                    showLineAbove: i != 0,
                    onTap: () => _openChapter(c, i),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
