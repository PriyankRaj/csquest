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
        title: const Row(
          children: [
            Text('🐢', style: TextStyle(fontSize: 30)),
            SizedBox(width: 8),
            Text('Quest Hub'),
          ],
        ),
        actions: const [QuestSwitcherAction(current: 0)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Two gamified ways to learn, both narrated by Process the turtle. Pick one to start.',
                style: TextStyle(color: QuestColors.textDim, fontSize: 13),
              ),
              const SizedBox(height: 20),
              // Code Quest gets the big, eye-catching hero slot — the room a
              // compact two-row layout used to leave empty is exactly what
              // makes a bigger icon and a real CTA button read as "the fun
              // one to tap first" instead of just another list row.
              _FeaturedQuestCard(
                emoji: '🧩',
                badge: '✨ Build & play',
                title: 'Code Quest',
                subtitle: 'Snap blocks together to move sprites, animate a character, and build little games — the drag-and-drop way.',
                color: QuestColors.accent2,
                buttonLabel: 'Start Coding ➜',
                onTap: () => QuestNav.go(2),
              ),
              const SizedBox(height: 16),
              _FeaturedQuestCard(
                emoji: '🗺️',
                badge: '🎓 Learn & explore',
                title: 'Process Quest',
                subtitle: 'Learn computer science subjects — Operating Systems, Data Structures, Networks, and more.',
                color: QuestColors.accent,
                buttonLabel: 'Start Learning ➜',
                onTap: () => QuestNav.go(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A bigger, kid-friendlier hero tile: a soft glow behind a large icon
// bubble and a real CTA pill, instead of just another compact row.
class _FeaturedQuestCard extends StatelessWidget {
  final String emoji;
  final String badge;
  final String title;
  final String subtitle;
  final Color color;
  final String buttonLabel;
  final VoidCallback onTap;
  const _FeaturedQuestCard({
    required this.emoji,
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.buttonLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0.08)],
            ),
            border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: color.withValues(alpha: 0.18), shape: BoxShape.circle),
                    child: Text(emoji, style: const TextStyle(fontSize: 44)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                          child: Text(badge, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 11)),
                        ),
                        const SizedBox(height: 6),
                        Text(title, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22, color: color)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(subtitle, style: const TextStyle(fontSize: 13, color: QuestColors.textDim, height: 1.35)),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton(
                  onPressed: onTap,
                  style: FilledButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: const Color(0xFF0B1220),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                  ),
                  child: Text(buttonLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
