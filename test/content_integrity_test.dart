// Whole-project content integrity checks that no single agent's per-file
// self-verification could catch: global id uniqueness across files authored
// independently and in parallel, and expected chapter/lesson counts.

import 'package:flutter_test/flutter_test.dart';
import 'package:cs_quest/data/cq_all_lessons.dart';
import 'package:cs_quest/data/pq_subjects_meta.dart';

void main() {
  test('Every Code Quest lesson id is globally unique across all 10 topics', () {
    final ids = cqAllLessons.map((l) => l.id).toList();
    final dupes = ids.toSet().where((id) => ids.where((x) => x == id).length > 1).toSet();
    expect(dupes, isEmpty, reason: 'duplicate lesson ids found: $dupes');
  });

  test('Every topic has 60 lessons', () {
    final byTopic = <String, int>{};
    for (final l in cqAllLessons) {
      byTopic[l.topicId] = (byTopic[l.topicId] ?? 0) + 1;
    }
    for (final entry in byTopic.entries) {
      expect(entry.value, 60, reason: 'topic ${entry.key} has ${entry.value} lessons, expected 60');
    }
    expect(byTopic.keys.length, 10);
  });

  test('Every subject has real chapters and no duplicate chapter ids', () {
    for (final s in pqSubjects) {
      expect(s.available, isTrue, reason: '${s.id} should be available');
      expect(s.chapters, isNotEmpty, reason: '${s.id} has no chapters');
      final ids = s.chapters.map((c) => c.id).toList();
      expect(ids.toSet().length, ids.length, reason: '${s.id} has duplicate chapter ids');
      // Every subject should have ~60 chapters (networks has 61 in the source).
      expect(s.chapters.length, greaterThanOrEqualTo(59), reason: '${s.id} only has ${s.chapters.length} chapters');
    }
    expect(pqSubjects.length, 12);
  });

  test('Every chapter puzzleType matches exactly one non-null puzzle field', () {
    for (final s in pqSubjects) {
      for (final c in s.chapters) {
        final nonNullCount = [c.mcq, c.order, c.sort2, c.match, c.circuit].where((p) => p != null).length;
        expect(nonNullCount, 1, reason: '${s.id} chapter ${c.id} (puzzleType=${c.puzzleType}) has $nonNullCount non-null puzzle fields');
      }
    }
  });
}
