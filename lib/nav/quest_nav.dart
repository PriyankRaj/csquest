import 'package:flutter/foundation.dart';

/// Global "which quest tab is active" signal — lets any screen jump between
/// Home / Process Quest / Code Quest (e.g. from a small switcher menu)
/// without a persistent bottom nav bar eating screen height on every page.
/// 0 = Home, 1 = Process Quest, 2 = Code Quest.
class QuestNav {
  QuestNav._();
  static final ValueNotifier<int> tabIndex = ValueNotifier(0);
  static void go(int i) => tabIndex.value = i;
}
