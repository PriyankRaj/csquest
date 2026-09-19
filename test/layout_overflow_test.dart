// Regression guard: the topic grid's childAspectRatio was tuned from 0.78 to
// 0.92 for a design reason ("icon fills more of the tile") without noticing
// it made every card overflow by 20px on a small phone. flutter analyze and
// the functional tests never caught it — only rendering the real widget at a
// real screen size does. Covers every top-level screen, in both light and
// dark, so a similar layout regression anywhere else fails here too.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cs_quest/main.dart';
import 'package:cs_quest/progress/progress_store.dart';
import 'package:cs_quest/screens/home_screen.dart';
import 'package:cs_quest/screens/pq/subject_list_screen.dart';
import 'package:cs_quest/screens/cq/topic_list_screen.dart';
import 'package:cs_quest/data/pq_subjects_meta.dart';
import 'package:cs_quest/data/cq_all_lessons.dart';
import 'package:cs_quest/screens/pq/chapter_path_screen.dart';
import 'package:cs_quest/screens/pq/chapter_screen.dart';
import 'package:cs_quest/screens/cq/lesson_list_screen.dart';
import 'package:cs_quest/screens/cq/lesson_editor_screen.dart';
import 'package:cs_quest/data/cq_topics_meta.dart';

Future<void> _probe(WidgetTester tester, Widget child, String label, {bool dark = false}) async {
  // A small phone (e.g. Android's 320dp-wide "small" reference), since
  // that's where a too-tight aspect ratio or fixed height overflows first.
  tester.view.physicalSize = const Size(320 * 3, 640 * 3);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(MaterialApp(
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    darkTheme: ThemeData.dark(),
    home: child,
  ));
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull, reason: '$label overflowed (dark=$dark)');
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    progressStore = await ProgressStore.load();
  });

  testWidgets('HomeScreen', (tester) async => _probe(tester, const HomeScreen(), 'HomeScreen'));
  testWidgets('SubjectListScreen', (tester) async => _probe(tester, const SubjectListScreen(), 'SubjectListScreen'));
  testWidgets('TopicListScreen', (tester) async => _probe(tester, const TopicListScreen(), 'TopicListScreen'));
  testWidgets('ChapterPathScreen', (tester) async => _probe(tester, ChapterPathScreen(subject: pqSubjects.first), 'ChapterPathScreen'));
  testWidgets('ChapterScreen', (tester) async => _probe(tester, ChapterScreen(subject: pqSubjects.first, chapter: pqSubjects.first.chapters.first), 'ChapterScreen'));
  testWidgets('LessonListScreen', (tester) async => _probe(tester, LessonListScreen(topic: cqTopics.first), 'LessonListScreen'));
  testWidgets('LessonEditorScreen light', (tester) async => _probe(tester, LessonEditorScreen(lesson: cqAllLessons.first), 'LessonEditorScreen'));
  testWidgets('LessonEditorScreen dark', (tester) async => _probe(tester, LessonEditorScreen(lesson: cqAllLessons.first), 'LessonEditorScreen', dark: true));
}
