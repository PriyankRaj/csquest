import 'package:flutter/material.dart';
import 'progress/progress_store.dart';
import 'screens/root_shell.dart';
import 'theme.dart';

late ProgressStore progressStore;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  progressStore = await ProgressStore.load();
  runApp(const QuestApp());
}

class QuestApp extends StatelessWidget {
  const QuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Computer Science Quest',
      debugShowCheckedModeBanner: false,
      theme: buildQuestTheme(),
      home: const RootShell(),
    );
  }
}
