import 'package:flutter/material.dart';
import '../../data/cq_all_lessons.dart';
import '../../main.dart';
import '../../models/cq_models.dart';
import '../../theme.dart';
import '../../widgets/home_action.dart';
import '../../widgets/path_node.dart';
import '../../widgets/quest_switcher_action.dart';
import 'lesson_editor_screen.dart';

class LessonListScreen extends StatefulWidget {
  final Topic topic;
  const LessonListScreen({super.key, required this.topic});

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {
  List<Lesson> get _lessons => cqAllLessons.where((l) => l.topicId == widget.topic.id).toList();

  bool _isDone(Lesson l) => progressStore.isDone('cq:${l.id}');

  NodeState _stateFor(int i) {
    final lessons = _lessons;
    if (_isDone(lessons[i])) return NodeState.done;
    final prevDone = i == 0 || _isDone(lessons[i - 1]);
    return prevDone ? NodeState.current : NodeState.locked;
  }

  Future<void> _open(Lesson l, int i) async {
    if (_stateFor(i) == NodeState.locked) return;
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => LessonEditorScreen(lesson: l)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final lessons = _lessons;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.topic.icon} ${widget.topic.name}'),
        actions: const [HomeAction(), QuestSwitcherAction(current: 2)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.topic.tagline, style: const TextStyle(color: QuestColors.textDim)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: lessons.length,
              itemBuilder: (context, i) {
                final l = lessons[i];
                return Column(
                  children: [
                    PathNode(
                      glyph: l.glyph,
                      label: l.title,
                      state: _stateFor(i),
                      showLineAbove: i != 0,
                      onTap: () => _open(l, i),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Text('🎯 ${l.target}', style: const TextStyle(fontSize: 11, color: QuestColors.textDim), textAlign: TextAlign.center),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
