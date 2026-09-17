import 'package:flutter/material.dart';

/// App-wide look: a teal/gold accent pair, with hand-tuned surface/text
/// colors for both light and dark (not purely seed-derived) so the "vibe"
/// stays consistent and legible either way. Access the resolved set for the
/// current brightness via [QuestColors.of] — most usages are inside a
/// `build(BuildContext context)` method, so `context` is normally in scope.
class QuestColors {
  final Color accent;
  final Color accent2;
  final Color danger;
  final Color bg;
  final Color panel;
  final Color panel2;
  final Color textPrimary;
  final Color textDim;
  const QuestColors._({
    required this.accent,
    required this.accent2,
    required this.danger,
    required this.bg,
    required this.panel,
    required this.panel2,
    required this.textPrimary,
    required this.textDim,
  });

  static const dark = QuestColors._(
    accent: Color(0xFF3DDBB0), // teal
    accent2: Color(0xFFFFC24B), // gold
    danger: Color(0xFFFF6B81),
    bg: Color(0xFF0F1420),
    panel: Color(0xFF161D2E),
    panel2: Color(0xFF1B2436),
    textPrimary: Colors.white,
    textDim: Color(0xFF93A0BF),
  );

  static const light = QuestColors._(
    accent: Color(0xFF1C9A78), // darker teal — enough contrast on a light bg
    accent2: Color(0xFFB8790A), // darker gold — same reason
    danger: Color(0xFFD6304B),
    bg: Color(0xFFF4F6FB),
    panel: Colors.white,
    panel2: Color(0xFFE9EDF6),
    textPrimary: Color(0xFF15181F),
    textDim: Color(0xFF5B6478),
  );

  static QuestColors of(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? dark : light;

  // Code Quest block-category colors — fixed content identity (like
  // Scratch's block categories: "this is a motion block"), not theme
  // chrome, so unlike the rest of this class they never flip with
  // brightness. Also referenced from const block data (cq_blocks.dart),
  // which is why these stay plain static consts rather than instance
  // fields resolved via [of].
  static const cqMotion = Color(0xFF4C97FF);
  static const cqControl = Color(0xFFFFAB19);
}

/// The user's Light/Dark/System preference — defaults to light (see
/// [HomeScreen]'s theme picker). [main] seeds [mode] from persisted
/// storage before the first frame; screens that change it are also
/// responsible for persisting the new value themselves (see
/// ProgressStore.setThemeModeName), keeping this controller free of any
/// storage dependency.
class ThemeController {
  ThemeController._();
  static final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.light);

  static ThemeMode parse(String? name) => switch (name) {
        'dark' => ThemeMode.dark,
        'system' => ThemeMode.system,
        _ => ThemeMode.light,
      };
}

ThemeData buildQuestTheme(Brightness brightness) {
  final palette = brightness == Brightness.dark ? QuestColors.dark : QuestColors.light;
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: palette.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: palette.accent,
      brightness: brightness,
      primary: palette.accent,
      secondary: palette.accent2,
      surface: palette.panel,
      error: palette.danger,
    ),
    fontFamily: 'Roboto',
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(bodyColor: palette.textPrimary, displayColor: palette.textPrimary),
    appBarTheme: AppBarTheme(
      backgroundColor: palette.bg,
      foregroundColor: palette.textPrimary,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: palette.panel,
      indicatorColor: palette.accent.withValues(alpha: 0.18),
    ),
    cardTheme: CardThemeData(
      color: palette.panel,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: palette.accent,
        foregroundColor: const Color(0xFF0B1220),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
      ),
    ),
  );
}
