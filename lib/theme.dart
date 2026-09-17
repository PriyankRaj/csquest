import 'package:flutter/material.dart';

/// App-wide look: kept independent of the "DesiLingo" branding that showed up
/// in the web version's source files — this is Quest's own identity, a dark
/// slate base with a teal/gold accent pair (same family as the original
/// process-quest web palette, minus the Duolingo-style blue/orange).
class QuestColors {
  static const accent = Color(0xFF3DDBB0); // teal
  static const accent2 = Color(0xFFFFC24B); // gold
  static const danger = Color(0xFFFF6B81);
  static const bg = Color(0xFF0F1420);
  static const panel = Color(0xFF161D2E);
  static const panel2 = Color(0xFF1B2436);
  static const textDim = Color(0xFF93A0BF);

  // Code Quest keeps a lighter, tool-like surface — it's an editor, not a story.
  static const cqBg = Color(0xFFF4F6FB);
  static const cqPanel = Color(0xFFFFFFFF);
  static const cqMotion = Color(0xFF4C97FF);
  static const cqControl = Color(0xFFFFAB19);
}

ThemeData buildQuestTheme() {
  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: QuestColors.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: QuestColors.accent,
      brightness: Brightness.dark,
      primary: QuestColors.accent,
      secondary: QuestColors.accent2,
      surface: QuestColors.panel,
      error: QuestColors.danger,
    ),
    fontFamily: 'Roboto',
  );
  return base.copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: QuestColors.bg,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: QuestColors.panel,
      indicatorColor: QuestColors.accent.withValues(alpha: 0.18),
    ),
    cardTheme: CardThemeData(
      color: QuestColors.panel,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: QuestColors.accent,
        foregroundColor: const Color(0xFF0B1220),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
      ),
    ),
  );
}
