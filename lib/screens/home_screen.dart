import 'package:flutter/material.dart';
import '../nav/quest_nav.dart';
import '../theme.dart';
import '../widgets/quest_switcher_action.dart';

/// The app's actual home — always shows both quests as equal, explicit
/// choices (never auto-picks one for you). Reachable any time via the quest
/// switcher icon in the top bar (see [QuestSwitcherAction]), so "what are my
/// two options" is never more than one tap away, without a bottom nav bar.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🐢 Quest Hub'),
        actions: const [QuestSwitcherAction(current: 0)],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Two gamified ways to learn, both narrated by Process the turtle. Pick one to start.',
                style: TextStyle(color: QuestColors.textDim, fontSize: 13),
              ),
              const SizedBox(height: 20),
              _QuestCard(
                emoji: '🗺️',
                title: 'Process Quest',
                subtitle: 'Learn computer science subjects — Operating Systems, Data Structures, Networks, and more.',
                accent: QuestColors.accent,
                onTap: () => QuestNav.go(1),
              ),
              const SizedBox(height: 14),
              _QuestCard(
                emoji: '🧩',
                title: 'Code Quest',
                subtitle: 'Learn to code the drag-and-drop way — snap blocks together to move sprites and build games.',
                accent: QuestColors.accent2,
                onTap: () => QuestNav.go(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;
  const _QuestCard({required this.emoji, required this.title, required this.subtitle, required this.accent, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accent.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              CircleAvatar(radius: 26, backgroundColor: accent.withValues(alpha: 0.15), child: Text(emoji, style: const TextStyle(fontSize: 24))),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: accent)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(fontSize: 12.5, color: QuestColors.textDim)),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.chevron_right, color: accent),
            ],
          ),
        ),
      ),
    );
  }
}
