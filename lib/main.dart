import 'package:flutter/material.dart';
import 'progress/progress_store.dart';
import 'screens/root_shell.dart';
import 'theme.dart';

late ProgressStore progressStore;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  progressStore = await ProgressStore.load();
  ThemeController.mode.value = ThemeController.parse(progressStore.themeModeName);
  runApp(const QuestApp());
}

class QuestApp extends StatelessWidget {
  const QuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.mode,
      builder: (context, mode, _) => MaterialApp(
        title: 'Computer Science Quest',
        debugShowCheckedModeBanner: false,
        themeMode: mode,
        theme: buildQuestTheme(Brightness.light),
        darkTheme: buildQuestTheme(Brightness.dark),
        home: const RootShell(),
      ),
    );
  }
}
