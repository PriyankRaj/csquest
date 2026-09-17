import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around SharedPreferences for the two kinds of progress this
/// slice tracks: completed Process Quest chapters ("pq:<subject>:<id>") and
/// completed Code Quest lessons ("cq:<lessonId>"). A real multi-subject app
/// would want a richer store, but a flat string set is honest for this scope.
class ProgressStore {
  ProgressStore._(this._prefs);
  final SharedPreferences _prefs;
  static const _key = 'quest_completed_v1';

  static Future<ProgressStore> load() async {
    final prefs = await SharedPreferences.getInstance();
    return ProgressStore._(prefs);
  }

  Set<String> _all() => (_prefs.getStringList(_key) ?? const []).toSet();

  bool isDone(String id) => _all().contains(id);

  Future<void> markDone(String id) async {
    final s = _all()..add(id);
    await _prefs.setStringList(_key, s.toList());
  }

  Future<void> reset() async {
    await _prefs.setStringList(_key, const []);
  }
}
