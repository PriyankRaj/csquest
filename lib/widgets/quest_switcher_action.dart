import 'package:flutter/material.dart';
import '../nav/quest_nav.dart';
import '../theme.dart';

/// Duolingo puts its course switcher in the top bar (tap the flag, pick a
/// course) instead of spending a full bottom-nav row on it. This is that,
/// for our two quests: a small icon button, place it in an AppBar's
/// `actions`, tap opens a compact picker for Home / Process Quest / Code
/// Quest.
class QuestSwitcherAction extends StatelessWidget {
  final int current; // 0 = Home, 1 = Process Quest, 2 = Code Quest
  const QuestSwitcherAction({super.key, required this.current});

  List<({String icon, String label, Color color})> _options(BuildContext context) {
    final qc = QuestColors.of(context);
    return [
      (icon: '🐢', label: 'Home', color: qc.textDim),
      (icon: '🗺️', label: 'Process Quest', color: qc.accent),
      (icon: '🧩', label: 'Code Quest', color: qc.accent2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Switch quest',
      // Always the turtle — a consistent, always-recognizable nav affordance
      // rather than one that changes per screen (which reads as decoration,
      // not navigation, until you've learned what each icon means).
      icon: const Text('🐢', style: TextStyle(fontSize: 20)),
      onPressed: () {
        final options = _options(context);
        final textPrimary = QuestColors.of(context).textPrimary;
        showModalBottomSheet(
          context: context,
          backgroundColor: QuestColors.of(context).panel,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Switch to', style: TextStyle(fontWeight: FontWeight.w800, color: textPrimary)),
                  ),
                ),
                for (var i = 0; i < options.length; i++)
                  ListTile(
                    leading: Text(options[i].icon, style: const TextStyle(fontSize: 22)),
                    title: Text(options[i].label, style: TextStyle(color: i == current ? options[i].color : textPrimary, fontWeight: FontWeight.w700)),
                    trailing: i == current ? Icon(Icons.check, color: options[i].color) : null,
                    onTap: () {
                      Navigator.of(context).pop();
                      QuestNav.go(i);
                    },
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
