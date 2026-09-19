import 'package:flutter/material.dart';
import '../../data/cq_topics_meta.dart';
import '../../theme.dart';
import '../../widgets/home_action.dart';
import '../../widgets/quest_switcher_action.dart';
import 'lesson_list_screen.dart';

class TopicListScreen extends StatelessWidget {
  const TopicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧩 Code Quest'),
        actions: const [HomeAction(), QuestSwitcherAction(current: 2)],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          // 0.92 looked right in isolation but overflowed by 20px on every
          // card once a 2-line title + subtitle + "Coming soon" badge
          // actually laid out — verified against a real overflow probe test,
          // not just eyeballing a mock.
          childAspectRatio: 0.72,
        ),
        itemCount: cqTopics.length,
        itemBuilder: (context, i) {
          final t = cqTopics[i];
          return Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: t.available
                  ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LessonListScreen(topic: t)))
                  : null,
              child: Opacity(
                opacity: t.available ? 1 : 0.45,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 32, backgroundColor: t.color.withValues(alpha: 0.2), child: Text(t.icon, style: const TextStyle(fontSize: 30))),
                      const SizedBox(height: 12),
                      Text(t.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5), maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(t.place, style: TextStyle(fontSize: 11, color: QuestColors.of(context).textDim), maxLines: 1, overflow: TextOverflow.ellipsis),
                      if (!t.available)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(color: QuestColors.of(context).panel2, borderRadius: BorderRadius.circular(8)),
                            child: Text('Coming soon', style: TextStyle(fontSize: 9.5, color: QuestColors.of(context).textDim)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
