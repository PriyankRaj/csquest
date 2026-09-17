import 'package:flutter/material.dart';
import '../nav/quest_nav.dart';

/// One-tap way back to the Quest Hub. [QuestSwitcherAction] can also get you
/// there, but that's a sheet-open-then-tap-Home detour — this sits right
/// next to it in the app bar for the common "just take me home" case.
class HomeAction extends StatelessWidget {
  const HomeAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Home',
      icon: const Icon(Icons.home_rounded),
      onPressed: () => QuestNav.go(0),
    );
  }
}
