import 'package:flutter/material.dart';
import '../nav/quest_nav.dart';
import 'home_screen.dart';
import 'pq/subject_list_screen.dart';
import 'cq/topic_list_screen.dart';

/// Three tabs — Home, Process Quest, Code Quest — but no persistent bottom
/// nav bar; that ate a full row of screen height on every single page for a
/// switcher you only need occasionally. Duolingo doesn't burn bottom-nav
/// space on a course switcher either — it's a small icon in the top bar that
/// opens a picker. [QuestSwitcherAction] is that icon here; tapping it (or a
/// Home card) moves [QuestNav.tabIndex], which this widget listens to.
class RootShell extends StatefulWidget {
  const RootShell({super.key});
  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  final _navKeys = [GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>()];

  Future<bool> _onWillPop() async {
    final nav = _navKeys[QuestNav.tabIndex.value].currentState!;
    if (nav.canPop()) {
      nav.pop();
      return false;
    }
    return true;
  }

  Widget _tab(int i, Widget root) {
    return Navigator(
      key: _navKeys[i],
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (_) => root, settings: settings),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        if (await _onWillPop()) {
          if (context.mounted) Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        body: ValueListenableBuilder<int>(
          valueListenable: QuestNav.tabIndex,
          builder: (context, index, _) => IndexedStack(
            index: index,
            children: [
              _tab(0, const HomeScreen()),
              _tab(1, const SubjectListScreen()),
              _tab(2, const TopicListScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
