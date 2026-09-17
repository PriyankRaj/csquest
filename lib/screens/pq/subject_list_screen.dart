import 'package:flutter/material.dart';
import '../../data/pq_subjects_meta.dart';
import '../../theme.dart';
import '../../widgets/home_action.dart';
import '../../widgets/quest_switcher_action.dart';
import 'chapter_path_screen.dart';

/// Subject picker — a plain scrollable list of cards (no walking map, no
/// dwell timers). Best-practice mobile pattern: tap a card, go straight to
/// its lesson path. Locked/unavailable subjects are visibly listed (so the
/// full curriculum reads as real) but clearly marked "Coming soon".
class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🗺️ Process Quest'),
        actions: const [HomeAction(), QuestSwitcherAction(current: 1)],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: pqSubjects.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final s = pqSubjects[i];
          // A custom Row instead of ListTile(trailing: Chip(...)) — the chip
          // was stealing enough width to wrap subject names mid-word (e.g.
          // "Data Str-uctures"). Title now gets the full row minus the icon.
          return Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: s.available
                  ? () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChapterPathScreen(subject: s)),
                      )
                  : null,
              child: Opacity(
                opacity: s.available ? 1 : 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: QuestColors.of(context).panel2,
                        child: Text(s.icon, style: const TextStyle(fontSize: 22)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    s.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.w800),
                                  ),
                                ),
                                if (!s.available)
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: QuestColors.of(context).panel2,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text('Coming soon', style: TextStyle(fontSize: 10.5, color: QuestColors.of(context).textDim)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${s.place} · ${s.tagline}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12.5, color: QuestColors.of(context).textDim),
                            ),
                          ],
                        ),
                      ),
                      if (s.available) Icon(Icons.chevron_right, color: QuestColors.of(context).textDim),
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
