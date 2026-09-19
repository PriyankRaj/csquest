import '../models/cq_models.dart';
import 'cq_blocks.dart';

/// "Build a Scoreboard" — Number Nook. This engine has exactly ONE
/// project-wide variable, called Score, so every lesson works with it via
/// variables_set / variables_change. No "make a variable" flow exists here.
num _num(BlockInstance b, String key) {
  final v = b.inputs[key];
  if (v is num) return v;
  return 0;
}

/// Finds the first top-level control_repeat block in [script], if any.
BlockInstance? _firstRepeat(List<BlockInstance> script) {
  for (final b in script) {
    if (b.defId == 'control_repeat') return b;
  }
  return null;
}

/// Finds all top-level control_repeat blocks in [script].
List<BlockInstance> _repeats(List<BlockInstance> script) =>
    script.where((b) => b.defId == 'control_repeat').toList();

final cqVariablesLessons = <Lesson>[
  // ---------------------------------------------------------------
  // 841-855 — complexity 1: a single variables_set to a specific value,
  // gradually paired with one other block (say/show/sound/motion).
  // ---------------------------------------------------------------
  Lesson(
    id: 841,
    topicId: 'variables',
    title: 'Score Zero',
    glyph: '🔢',
    complexity: 1,
    target: 'Set the Score to 0 to start a fresh scoreboard.',
    narrator: "Every scoreboard needs a starting point — let's set Score to 0.",
    steps: const ["Open the Variables tray.", "Tap 'set Score to 0' to add it to your script."],
    starter: () => [],
    check: (script) {
      final sets = cqFlatten(script).where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Add a 'set Score to' block.");
      if (_num(sets.first, 'value') != 0) {
        return const LessonResult(false, "Set the value to exactly 0.");
      }
      return const LessonResult(true, 'Scoreboard reset to zero! 🔢');
    },
  ),
  Lesson(
    id: 842,
    topicId: 'variables',
    title: 'Perfect Ten',
    glyph: '🔟',
    complexity: 1,
    target: 'Set the Score to exactly 10.',
    narrator: "Let's give the scoreboard a head start — set Score to 10.",
    steps: const ["Add 'set Score to' from Variables.", 'Change the number to 10.'],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0})],
    check: (script) {
      final sets = cqFlatten(script).where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Add a 'set Score to' block.");
      if (_num(sets.first, 'value') != 10) {
        return const LessonResult(false, "Set the value to exactly 10.");
      }
      return const LessonResult(true, 'Score is exactly 10! 🔟');
    },
  ),
  Lesson(
    id: 843,
    topicId: 'variables',
    title: 'Quarter Century',
    glyph: '🎯',
    complexity: 1,
    target: 'Set the Score to exactly 25.',
    narrator: "Someone's had a great round — set Score to 25.",
    steps: const ["Add 'set Score to' from Variables.", 'Change the number to 25.'],
    starter: () => [],
    check: (script) {
      final sets = cqFlatten(script).where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Add a 'set Score to' block.");
      if (_num(sets.first, 'value') != 25) {
        return const LessonResult(false, "Set the value to exactly 25.");
      }
      return const LessonResult(true, 'Score set to 25! 🎯');
    },
  ),
  Lesson(
    id: 844,
    topicId: 'variables',
    title: 'Century Club',
    glyph: '💯',
    complexity: 1,
    target: 'Set the Score to exactly 100.',
    narrator: "Big number time — set Score to 100.",
    steps: const ["Add 'set Score to' from Variables.", 'Change the number to 100.'],
    starter: () => [],
    check: (script) {
      final sets = cqFlatten(script).where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Add a 'set Score to' block.");
      if (_num(sets.first, 'value') != 100) {
        return const LessonResult(false, "Set the value to exactly 100.");
      }
      return const LessonResult(true, 'Triple digits! 💯');
    },
  ),
  Lesson(
    id: 845,
    topicId: 'variables',
    title: 'Thousand Club',
    glyph: '🏆',
    complexity: 1,
    target: 'Set the Score to exactly 1000.',
    narrator: "Let's aim high — set Score to 1000.",
    steps: const ["Add 'set Score to' from Variables.", 'Change the number to 1000.'],
    starter: () => [],
    check: (script) {
      final sets = cqFlatten(script).where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Add a 'set Score to' block.");
      if (_num(sets.first, 'value') != 1000) {
        return const LessonResult(false, "Set the value to exactly 1000.");
      }
      return const LessonResult(true, 'Four whole digits — 1000! 🏆');
    },
  ),
  Lesson(
    id: 846,
    topicId: 'variables',
    title: 'Ready, Set...',
    glyph: '📣',
    complexity: 1,
    target: 'Set Score to 0, then announce the game is starting.',
    narrator: "Before the match starts, I like to reset the board and say so out loud.",
    steps: const ["Add 'set Score to 0' (Variables).", "Add 'say' (Looks) after it with any text."],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0})],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 0) {
        return const LessonResult(false, "Set Score to exactly 0 first.");
      }
      if (!flat.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block to announce the game starting.");
      }
      return const LessonResult(true, 'Ready, set, Score! 📣');
    },
  ),
  Lesson(
    id: 847,
    topicId: 'variables',
    title: 'Head Start',
    glyph: '🗣️',
    complexity: 1,
    target: 'Set Score to 10, then say something about it.',
    narrator: "Ten free points feels good — set Score to 10 and tell everyone.",
    steps: const ["Add 'set Score to 10' (Variables).", "Add 'say' (Looks) with a message."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 10) {
        return const LessonResult(false, "Set Score to exactly 10 first.");
      }
      final says = flat.where((b) => b.defId == 'looks_say').toList();
      if (says.isEmpty || (says.first.inputs['text'] as String? ?? '').isEmpty) {
        return const LessonResult(false, "Add a 'say' block with some text.");
      }
      return const LessonResult(true, 'You announced the head start! 🗣️');
    },
  ),
  Lesson(
    id: 848,
    topicId: 'variables',
    title: 'Three Lives',
    glyph: '❤️',
    complexity: 1,
    target: 'Set Score to 3 to represent three lives, then show Turtu.',
    narrator: "Score can track lives too — set it to 3 and make sure I'm visible on screen.",
    steps: const ["Add 'set Score to 3' (Variables).", "Add 'show' (Looks) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 3) {
        return const LessonResult(false, "Set Score to exactly 3 (three lives).");
      }
      if (!flat.any((b) => b.defId == 'looks_show')) {
        return const LessonResult(false, "Add a 'show' block so I'm visible.");
      }
      return const LessonResult(true, 'Three lives locked in! ❤️');
    },
  ),
  Lesson(
    id: 849,
    topicId: 'variables',
    title: 'First Point',
    glyph: '🔊',
    complexity: 1,
    target: 'Set Score to 1 and play a click to celebrate the first point.',
    narrator: "Nothing beats the sound of your very first point — set Score to 1 and play a click.",
    steps: const ["Add 'set Score to 1' (Variables).", "Add 'play sound' (Sound) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 1) {
        return const LessonResult(false, "Set Score to exactly 1.");
      }
      if (!flat.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block to celebrate.");
      }
      return const LessonResult(true, 'Click! First point on the board. 🔊');
    },
  ),
  Lesson(
    id: 850,
    topicId: 'variables',
    title: 'Fifty and Rolling',
    glyph: '🎳',
    complexity: 1,
    target: 'Set Score to 50, then move Turtu forward.',
    narrator: "Fifty points and still moving — set Score to 50 and take a step.",
    steps: const ["Add 'set Score to 50' (Variables).", "Add 'move steps' (Motion) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 50) {
        return const LessonResult(false, "Set Score to exactly 50.");
      }
      final moves = flat.where((b) => b.defId == 'motion_move_steps').toList();
      if (moves.isEmpty || _num(moves.first, 'steps') == 0) {
        return const LessonResult(false, "Add a 'move steps' block with a non-zero number.");
      }
      return const LessonResult(true, 'Fifty points and rolling! 🎳');
    },
  ),
  Lesson(
    id: 851,
    topicId: 'variables',
    title: 'Back To Base',
    glyph: '🏁',
    complexity: 1,
    target: 'Set Score to 0 and send Turtu back to the center.',
    narrator: "New game, new position — set Score to 0 and go back to x:0 y:0.",
    steps: const ["Add 'set Score to 0' (Variables).", "Add 'go to x:0 y:0' (Motion) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 0) {
        return const LessonResult(false, "Set Score to exactly 0.");
      }
      final gotos = flat.where((b) => b.defId == 'motion_goto_xy').toList();
      if (gotos.isEmpty || _num(gotos.first, 'x') != 0 || _num(gotos.first, 'y') != 0) {
        return const LessonResult(false, "Add a 'go to x:0 y:0' block.");
      }
      return const LessonResult(true, 'Back at base, score reset! 🏁');
    },
  ),
  Lesson(
    id: 852,
    topicId: 'variables',
    title: 'Seven Up',
    glyph: '↻',
    complexity: 1,
    target: 'Set Score to 7, then turn Turtu to face a new way.',
    narrator: "Lucky seven — set Score to 7 and give me a turn.",
    steps: const ["Add 'set Score to 7' (Variables).", "Add a 'turn' block (Motion) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 7) {
        return const LessonResult(false, "Set Score to exactly 7.");
      }
      if (!flat.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block after setting the score.");
      }
      return const LessonResult(true, 'Lucky seven, and a spin too! ↻');
    },
  ),
  Lesson(
    id: 853,
    topicId: 'variables',
    title: 'Pause The Board',
    glyph: '⏱️',
    complexity: 1,
    target: 'Set Score to 20, then wait so players can see it.',
    narrator: "Give the crowd a second to read the score — set Score to 20 and wait.",
    steps: const ["Add 'set Score to 20' (Variables).", "Add 'wait seconds' (Control) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 20) {
        return const LessonResult(false, "Set Score to exactly 20.");
      }
      if (!flat.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Add a 'wait seconds' block after setting the score.");
      }
      return const LessonResult(true, 'Score shown, crowd is reading it! ⏱️');
    },
  ),
  Lesson(
    id: 854,
    topicId: 'variables',
    title: 'Nine Lives Vanish',
    glyph: '👻',
    complexity: 1,
    target: 'Set Score to 9, then hide and show Turtu again.',
    narrator: "Watch this trick — set Score to 9, then hide and reappear.",
    steps: const ["Add 'set Score to 9' (Variables).", "Add 'hide' then 'show' (Looks) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 9) {
        return const LessonResult(false, "Set Score to exactly 9.");
      }
      if (!flat.any((b) => b.defId == 'looks_hide')) {
        return const LessonResult(false, "Add a 'hide' block.");
      }
      if (!flat.any((b) => b.defId == 'looks_show')) {
        return const LessonResult(false, "Add a 'show' block after hide.");
      }
      return const LessonResult(true, 'Now you see me, now you don\'t! 👻');
    },
  ),
  Lesson(
    id: 855,
    topicId: 'variables',
    title: 'Triple Combo',
    glyph: '🎉',
    complexity: 1,
    target: 'Set Score to 100, say it, and play a click — a full celebration.',
    narrator: "For a perfect 100, let's do it properly: set the score, say it, and celebrate with sound.",
    steps: const [
      "Add 'set Score to 100' (Variables).",
      "Add 'say' (Looks) with a message.",
      "Add 'play sound' (Sound).",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 100) {
        return const LessonResult(false, "Set Score to exactly 100.");
      }
      if (!flat.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block.");
      }
      if (!flat.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block.");
      }
      return const LessonResult(true, 'Perfect 100, said and celebrated! 🎉');
    },
  ),

  // ---------------------------------------------------------------
  // 856-880 — complexity 2-3: variables_change (increment/decrement),
  // combined with looks/motion/sound, plus first repeat/forever loops.
  // ---------------------------------------------------------------
  Lesson(
    id: 856,
    topicId: 'variables',
    title: 'One More Point',
    glyph: '➕',
    complexity: 2,
    target: 'Add 1 point to the Score.',
    narrator: "Instead of setting a number, let's change it — add 1 to whatever Score already is.",
    steps: const ["Add 'change Score by' (Variables).", 'Set the value to 1.'],
    starter: () => [],
    check: (script) {
      final changes = cqFlatten(script).where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) return const LessonResult(false, "Add a 'change Score by' block.");
      if (_num(changes.first, 'value') != 1) {
        return const LessonResult(false, "Set the change amount to exactly 1.");
      }
      return const LessonResult(true, 'Score just went up by 1! ➕');
    },
  ),
  Lesson(
    id: 857,
    topicId: 'variables',
    title: 'Lost A Point',
    glyph: '➖',
    complexity: 2,
    target: 'Subtract 1 point from the Score using a negative change.',
    narrator: "Not every move is a win — change Score by -1 to lose a point.",
    steps: const ["Add 'change Score by' (Variables).", 'Set the value to -1.'],
    starter: () => [],
    check: (script) {
      final changes = cqFlatten(script).where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) return const LessonResult(false, "Add a 'change Score by' block.");
      if (_num(changes.first, 'value') != -1) {
        return const LessonResult(false, "Set the change amount to exactly -1.");
      }
      return const LessonResult(true, 'Ouch, minus one point. ➖');
    },
  ),
  Lesson(
    id: 858,
    topicId: 'variables',
    title: 'Five Point Bonus',
    glyph: '🌟',
    complexity: 2,
    target: 'Add 5 points to the Score in one go.',
    narrator: "Bonus round! Change Score by 5 for a big jump.",
    steps: const ["Add 'change Score by' (Variables).", 'Set the value to 5.'],
    starter: () => [],
    check: (script) {
      final changes = cqFlatten(script).where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) return const LessonResult(false, "Add a 'change Score by' block.");
      if (_num(changes.first, 'value') != 5) {
        return const LessonResult(false, "Set the change amount to exactly 5.");
      }
      return const LessonResult(true, 'Five point bonus banked! 🌟');
    },
  ),
  Lesson(
    id: 859,
    topicId: 'variables',
    title: 'Penalty Five',
    glyph: '🚫',
    complexity: 2,
    target: 'Subtract 5 points from the Score using a negative change.',
    narrator: "A penalty stings — change Score by -5.",
    steps: const ["Add 'change Score by' (Variables).", 'Set the value to -5.'],
    starter: () => [],
    check: (script) {
      final changes = cqFlatten(script).where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) return const LessonResult(false, "Add a 'change Score by' block.");
      if (_num(changes.first, 'value') != -5) {
        return const LessonResult(false, "Set the change amount to exactly -5.");
      }
      return const LessonResult(true, 'That penalty hurt, but it\'s logged. 🚫');
    },
  ),
  Lesson(
    id: 860,
    topicId: 'variables',
    title: 'Double Tap',
    glyph: '✌️',
    complexity: 2,
    target: 'Add 1 point twice, so the Score gains 2 total.',
    narrator: "Two separate points, back to back — two 'change by 1' blocks in a row.",
    steps: const ["Add 'change Score by 1' (Variables).", 'Add another identical block right after it.'],
    starter: () => [],
    check: (script) {
      final changes = cqFlatten(script).where((b) => b.defId == 'variables_change').toList();
      if (changes.length < 2) {
        return const LessonResult(false, "Add two 'change Score by' blocks.");
      }
      final total = changes.fold<num>(0, (sum, b) => sum + _num(b, 'value'));
      if (total != 2) {
        return const LessonResult(false, "Make the two changes add up to +2 total.");
      }
      return const LessonResult(true, 'Two quick points — net +2! ✌️');
    },
  ),
  Lesson(
    id: 861,
    topicId: 'variables',
    title: 'Gain Then Give Back',
    glyph: '🔁',
    complexity: 2,
    target: 'Add 10, then subtract 3, for a net gain of 7.',
    narrator: "Ten points in, three points penalty out — let's see the net gain.",
    steps: const ["Add 'change Score by 10' (Variables).", "Add 'change Score by -3' after it."],
    starter: () => [],
    check: (script) {
      final changes = cqFlatten(script).where((b) => b.defId == 'variables_change').toList();
      if (changes.length < 2) {
        return const LessonResult(false, "Add two 'change Score by' blocks.");
      }
      final total = changes.fold<num>(0, (sum, b) => sum + _num(b, 'value'));
      if (total != 7) {
        return const LessonResult(false, "The two changes should net out to +7 (10 - 3).");
      }
      return const LessonResult(true, 'Net gain of 7 points! 🔁');
    },
  ),
  Lesson(
    id: 862,
    topicId: 'variables',
    title: 'Fresh Start Plus Three',
    glyph: '🆕',
    complexity: 2,
    target: 'Set Score to 0, then add 3 so it ends at 3.',
    narrator: "Reset the board, then score right away — set to 0, change by 3.",
    steps: const ["Add 'set Score to 0' (Variables).", "Add 'change Score by 3' after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      final changes = flat.where((b) => b.defId == 'variables_change').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 0) {
        return const LessonResult(false, "Set Score to exactly 0 first.");
      }
      if (changes.isEmpty || _num(changes.first, 'value') != 3) {
        return const LessonResult(false, "Then change Score by exactly 3.");
      }
      return const LessonResult(true, 'Fresh start, ended at 3! 🆕');
    },
  ),
  Lesson(
    id: 863,
    topicId: 'variables',
    title: 'Five Minus Two',
    glyph: '🧮',
    complexity: 2,
    target: 'Set Score to 5, then subtract 2 so it ends at 3.',
    narrator: "Start with 5 points, lose 2 — let's do the subtraction together.",
    steps: const ["Add 'set Score to 5' (Variables).", "Add 'change Score by -2' after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      final changes = flat.where((b) => b.defId == 'variables_change').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 5) {
        return const LessonResult(false, "Set Score to exactly 5 first.");
      }
      if (changes.isEmpty || _num(changes.first, 'value') != -2) {
        return const LessonResult(false, "Then change Score by exactly -2.");
      }
      return const LessonResult(true, 'Five minus two — ends at 3! 🧮');
    },
  ),
  Lesson(
    id: 864,
    topicId: 'variables',
    title: 'Score And Move',
    glyph: '🏃',
    complexity: 2,
    target: 'Add 2 points, move forward, and announce the score.',
    narrator: "A point should feel like progress — score it, move, and say something.",
    steps: const [
      "Add 'change Score by 2' (Variables).",
      "Add 'move steps' (Motion) after it.",
      "Add 'say' (Looks) after that.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final changes = flat.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty || _num(changes.first, 'value') != 2) {
        return const LessonResult(false, "Add a 'change Score by 2' block.");
      }
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block.");
      }
      if (!flat.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block to announce it.");
      }
      return const LessonResult(true, 'Scored, moved, and announced it! 🏃');
    },
  ),
  Lesson(
    id: 865,
    topicId: 'variables',
    title: 'Click For Every Point',
    glyph: '🔔',
    complexity: 2,
    target: 'Add 1 point and play a click sound to celebrate it.',
    narrator: "A point should make a sound — change Score by 1, then play a click.",
    steps: const ["Add 'change Score by 1' (Variables).", "Add 'play sound' (Sound) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final changes = flat.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty || _num(changes.first, 'value') != 1) {
        return const LessonResult(false, "Add a 'change Score by 1' block.");
      }
      if (!flat.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block after it.");
      }
      return const LessonResult(true, 'Click! Point earned and celebrated. 🔔');
    },
  ),
  Lesson(
    id: 866,
    topicId: 'variables',
    title: 'Four Up, One Back',
    glyph: '🎢',
    complexity: 3,
    target: 'Add 4, then subtract 1, ending at a net of 3, and announce it.',
    narrator: "A little rollercoaster — gain 4, lose 1, then tell the crowd the final score.",
    steps: const [
      "Add 'change Score by 4' (Variables).",
      "Add 'change Score by -1' after it.",
      "Add 'say' (Looks) announcing the score.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final changes = flat.where((b) => b.defId == 'variables_change').toList();
      if (changes.length < 2) {
        return const LessonResult(false, "Add both 'change Score by' blocks.");
      }
      final total = changes.fold<num>(0, (sum, b) => sum + _num(b, 'value'));
      if (total != 3) {
        return const LessonResult(false, "The changes should net out to +3 (4 - 1).");
      }
      if (!flat.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block announcing the final score.");
      }
      return const LessonResult(true, 'Net +3, announced loud and clear! 🎢');
    },
  ),
  Lesson(
    id: 867,
    topicId: 'variables',
    title: 'Three Strikes',
    glyph: '⚡',
    complexity: 3,
    target: 'Lose a point three separate times, ending at -3.',
    narrator: "Three mistakes in a row — three separate 'change by -1' blocks.",
    steps: const ["Add 'change Score by -1' (Variables).", 'Add two more identical blocks after it.'],
    starter: () => [],
    check: (script) {
      final changes = cqFlatten(script).where((b) => b.defId == 'variables_change').toList();
      if (changes.length < 3) {
        return const LessonResult(false, "Add three 'change Score by -1' blocks.");
      }
      final total = changes.fold<num>(0, (sum, b) => sum + _num(b, 'value'));
      if (total != -3) {
        return const LessonResult(false, "Three strikes should total -3.");
      }
      return const LessonResult(true, 'Three strikes, total of -3. ⚡');
    },
  ),
  Lesson(
    id: 868,
    topicId: 'variables',
    title: 'One Life Left',
    glyph: '💔',
    complexity: 3,
    target: 'Start with 3 lives, lose 2, ending with exactly 1.',
    narrator: "Three lives, two losses — let's see what's left.",
    steps: const [
      "Add 'set Score to 3' (Variables).",
      "Add 'change Score by -1' (Variables) twice after it.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = flat.where((b) => b.defId == 'variables_set').toList();
      final changes = flat.where((b) => b.defId == 'variables_change').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 3) {
        return const LessonResult(false, "Set Score to exactly 3 first.");
      }
      final totalChange = changes.fold<num>(0, (sum, b) => sum + _num(b, 'value'));
      if (changes.length < 2 || totalChange != -2) {
        return const LessonResult(false, "Lose exactly 2 lives total (two -1 changes).");
      }
      return const LessonResult(true, 'Down to your last life — 1 left! 💔');
    },
  ),
  Lesson(
    id: 869,
    topicId: 'variables',
    title: 'Two Steps, Two Points',
    glyph: '🔄',
    complexity: 3,
    target: 'Add 2 points twice (net +4), then turn Turtu around.',
    narrator: "Score twice, then spin to face the next challenge.",
    steps: const [
      "Add 'change Score by 2' (Variables) twice.",
      "Add a 'turn' block (Motion) after them.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final changes = flat.where((b) => b.defId == 'variables_change').toList();
      final total = changes.fold<num>(0, (sum, b) => sum + _num(b, 'value'));
      if (changes.length < 2 || total != 4) {
        return const LessonResult(false, "Add two 'change Score by 2' blocks (net +4).");
      }
      if (!flat.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block after scoring.");
      }
      return const LessonResult(true, 'Four points banked, now facing a new way! 🔄');
    },
  ),
  Lesson(
    id: 870,
    topicId: 'variables',
    title: 'Loop Of Three',
    glyph: '🔂',
    complexity: 3,
    target: 'Use a repeat loop to add 1 point, three times, ending at 3.',
    narrator: "Instead of three separate blocks, let's use a repeat loop to add 1 point, three times.",
    steps: const [
      "Add a 'repeat' block (Control), set times to 3.",
      "Inside it, add 'change Score by 1' (Variables).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the repeat loop.");
      }
      final delta = _num(inside.first, 'value');
      if (times * delta != 3) {
        return const LessonResult(false, "The loop should end with Score at exactly 3 (times × change).");
      }
      return const LessonResult(true, 'A loop that scores for you — ends at 3! 🔂');
    },
  ),
  Lesson(
    id: 871,
    topicId: 'variables',
    title: 'Five In A Loop',
    glyph: '🌀',
    complexity: 3,
    target: 'Repeat 5 times, adding 1 point each time, then say the final score.',
    narrator: "Five quick points in a loop, then tell everyone the final tally.",
    steps: const [
      "Add a 'repeat 5' block (Control).",
      "Inside it, add 'change Score by 1' (Variables).",
      "After the loop, add 'say' (Looks).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 5})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the repeat loop.");
      }
      final delta = _num(inside.first, 'value');
      if (times * delta != 5) {
        return const LessonResult(false, "The loop should end with Score at exactly 5.");
      }
      if (!script.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block after the loop to announce the score.");
      }
      return const LessonResult(true, 'Five points looped, and announced! 🌀');
    },
  ),
  Lesson(
    id: 872,
    topicId: 'variables',
    title: 'Double Points Loop',
    glyph: '✨',
    complexity: 3,
    target: 'Repeat 4 times, adding 2 points each time, ending at 8.',
    narrator: "Let's make each loop count for more — 4 loops of 2 points each.",
    steps: const [
      "Add a 'repeat 4' block (Control).",
      "Inside it, add 'change Score by 2' (Variables).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the repeat loop.");
      }
      final delta = _num(inside.first, 'value');
      if (times * delta != 8) {
        return const LessonResult(false, "The loop should end with Score at exactly 8 (times × change).");
      }
      return const LessonResult(true, 'Four loops of double points — 8 total! ✨');
    },
  ),
  Lesson(
    id: 873,
    topicId: 'variables',
    title: 'Countdown From Ten',
    glyph: '⏳',
    complexity: 3,
    target: 'Set Score to 10, then repeat 10 times subtracting 1 each time, ending at 0.',
    narrator: "A rocket launch countdown — start at 10 and tick down to zero.",
    steps: const [
      "Add 'set Score to 10' (Variables).",
      "Add a 'repeat 10' block (Control).",
      "Inside it, add 'change Score by -1' (Variables).",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 10}),
      BlockInstance('control_repeat', inputs: {'times': 10}),
    ],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 10) {
        return const LessonResult(false, "Set Score to exactly 10 first.");
      }
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the repeat loop.");
      }
      final delta = _num(inside.first, 'value');
      if (10 + (times * delta) != 0) {
        return const LessonResult(false, "The countdown should land exactly on 0.");
      }
      return const LessonResult(true, 'Liftoff — countdown reached zero! ⏳');
    },
  ),
  Lesson(
    id: 874,
    topicId: 'variables',
    title: 'Click Every Lap',
    glyph: '🔊',
    complexity: 3,
    target: 'Repeat 3 times, adding 1 point and playing a click each loop, ending at 3.',
    narrator: "Every lap should score a point and make a sound — 3 laps, 3 clicks.",
    steps: const [
      "Add a 'repeat 3' block (Control).",
      "Inside it, add 'change Score by 1' (Variables) and 'play sound' (Sound).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (times * delta != 3) {
        return const LessonResult(false, "The loop should end with Score at exactly 3.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside the loop too.");
      }
      return const LessonResult(true, 'Three laps, three clicks, score of 3! 🔊');
    },
  ),
  Lesson(
    id: 875,
    topicId: 'variables',
    title: 'Move And Score',
    glyph: '🏎️',
    complexity: 3,
    target: 'Repeat 6 times, moving and scoring 1 point each loop, ending at 6.',
    narrator: "Every step forward should earn a point — 6 loops of moving and scoring.",
    steps: const [
      "Add a 'repeat 6' block (Control).",
      "Inside it, add 'move steps' (Motion) and 'change Score by 1' (Variables).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 6})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (times * delta != 6) {
        return const LessonResult(false, "The loop should end with Score at exactly 6.");
      }
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block inside the loop too.");
      }
      return const LessonResult(true, 'Moving and scoring, six loops, score of 6! 🏎️');
    },
  ),
  Lesson(
    id: 876,
    topicId: 'variables',
    title: 'Never Stop Scoring',
    glyph: '♾️',
    complexity: 3,
    target: 'Add 1 point inside a forever loop, so the Score keeps climbing forever.',
    narrator: "Some games never end — let's score 1 point on every single loop, forever.",
    steps: const ["Add a 'forever' block (Control).", "Inside it, add 'change Score by 1' (Variables)."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty || _num(inside.first, 'value') != 1) {
        return const LessonResult(false, "Add 'change Score by 1' inside the forever loop.");
      }
      return const LessonResult(true, 'Score will climb forever now! ♾️');
    },
  ),
  Lesson(
    id: 877,
    topicId: 'variables',
    title: 'Five Sprints',
    glyph: '🏃‍♂️',
    complexity: 3,
    target: 'Repeat 5 times moving and scoring 1 each time, then say the final Score of 5.',
    narrator: "Five sprints down the track, one point per sprint, then announce it.",
    steps: const [
      "Add a 'repeat 5' block (Control).",
      "Inside it, add 'move steps' (Motion) and 'change Score by 1' (Variables).",
      "After the loop, add 'say' (Looks).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 5})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (times * delta != 5) {
        return const LessonResult(false, "The loop should end with Score at exactly 5.");
      }
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block inside the loop.");
      }
      if (!script.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block after the loop.");
      }
      return const LessonResult(true, 'Five sprints, five points, announced! 🏃‍♂️');
    },
  ),
  Lesson(
    id: 878,
    topicId: 'variables',
    title: 'Zero To Seven',
    glyph: '📈',
    complexity: 3,
    target: 'Set Score to 0, then repeat 7 times adding 1, ending at exactly 7.',
    narrator: "Clean slate, then climb steadily up to 7 — one loop step at a time.",
    steps: const [
      "Add 'set Score to 0' (Variables).",
      "Add a 'repeat 7' block (Control).",
      "Inside it, add 'change Score by 1' (Variables).",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_repeat', inputs: {'times': 7}),
    ],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 0) {
        return const LessonResult(false, "Set Score to exactly 0 first.");
      }
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(inside.first, 'value');
      if (0 + (times * delta) != 7) {
        return const LessonResult(false, "The loop should end with Score at exactly 7.");
      }
      return const LessonResult(true, 'Climbed steadily from 0 to 7! 📈');
    },
  ),
  Lesson(
    id: 879,
    topicId: 'variables',
    title: 'Big Jumps Of Five',
    glyph: '🦘',
    complexity: 3,
    target: 'Repeat 4 times adding 5 points each time, ending at 20.',
    narrator: "Big jumps this time — 4 loops of 5 points lands on 20.",
    steps: const [
      "Add a 'repeat 4' block (Control).",
      "Inside it, add 'change Score by 5' (Variables).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(inside.first, 'value');
      if (times * delta != 20) {
        return const LessonResult(false, "The loop should end with Score at exactly 20.");
      }
      return const LessonResult(true, 'Four big jumps landed on 20! 🦘');
    },
  ),
  Lesson(
    id: 880,
    topicId: 'variables',
    title: 'Empty The Tank',
    glyph: '⛽',
    complexity: 3,
    target: 'Set Score to 8, then repeat 8 times subtracting 1, ending at exactly 0.',
    narrator: "Eight units of fuel, draining one at a time until the tank is empty.",
    steps: const [
      "Add 'set Score to 8' (Variables).",
      "Add a 'repeat 8' block (Control).",
      "Inside it, add 'change Score by -1' (Variables).",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 8}),
      BlockInstance('control_repeat', inputs: {'times': 8}),
    ],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 8) {
        return const LessonResult(false, "Set Score to exactly 8 first.");
      }
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(inside.first, 'value');
      if (8 + (times * delta) != 0) {
        return const LessonResult(false, "The tank should end up at exactly 0.");
      }
      return const LessonResult(true, 'Tank empty — landed right on 0! ⛽');
    },
  ),

  // ---------------------------------------------------------------
  // 881-900 — complexity 4-5: heavier loop math, multiple loops/changes,
  // combined with motion, sound, and looks for full scoreboard scenes.
  // ---------------------------------------------------------------
  Lesson(
    id: 881,
    topicId: 'variables',
    title: 'Ten Laps, Ten Points',
    glyph: '🏁',
    complexity: 4,
    target: 'Repeat 10 times, moving and scoring 1 point each lap, ending at 10, then say it.',
    narrator: "Ten laps around the track, one point per lap — then tell the crowd the final score.",
    steps: const [
      "Add a 'repeat 10' block (Control).",
      "Inside it, add 'move steps' (Motion) and 'change Score by 1' (Variables).",
      "After the loop, add 'say' (Looks) announcing the score.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 10})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (times * delta != 10) {
        return const LessonResult(false, "The loop should end with Score at exactly 10.");
      }
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block inside the loop.");
      }
      if (!script.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block after the loop.");
      }
      return const LessonResult(true, 'Ten laps, ten points, announced! 🏁');
    },
  ),
  Lesson(
    id: 882,
    topicId: 'variables',
    title: 'Five Combo Clicks',
    glyph: '🎊',
    complexity: 4,
    target: 'Repeat 5 times, adding 2 points and clicking each time, ending at 10.',
    narrator: "Every combo is worth 2 points and a click — 5 combos should land on 10.",
    steps: const [
      "Add a 'repeat 5' block (Control).",
      "Inside it, add 'change Score by 2' (Variables) and 'play sound' (Sound).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 5})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (times * delta != 10) {
        return const LessonResult(false, "The loop should end with Score at exactly 10.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside the loop too.");
      }
      return const LessonResult(true, 'Five combos, ten points, five clicks! 🎊');
    },
  ),
  Lesson(
    id: 883,
    topicId: 'variables',
    title: 'Two Rounds Of Scoring',
    glyph: '🥇',
    complexity: 5,
    target: 'Repeat 3 times adding 2, then repeat 2 times adding 3 — total of 12.',
    narrator: "Round one scores small and often, round two scores big — add both rounds together.",
    steps: const [
      "Add a 'repeat 3' block (Control) with 'change Score by 2' inside.",
      "Add a second 'repeat 2' block (Control) with 'change Score by 3' inside.",
    ],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}),
      BlockInstance('control_repeat', inputs: {'times': 2}),
    ],
    check: (script) {
      final repeats = _repeats(script);
      if (repeats.length < 2) {
        return const LessonResult(false, "Add two separate 'repeat' blocks.");
      }
      num total = 0;
      for (final r in repeats) {
        final times = _num(r, 'times');
        final changes = cqFlatten(r.body).where((b) => b.defId == 'variables_change').toList();
        if (changes.isEmpty) {
          return const LessonResult(false, "Each repeat loop needs a 'change Score by' block inside it.");
        }
        total += times * _num(changes.first, 'value');
      }
      if (total != 12) {
        return const LessonResult(false, "The two rounds together should total exactly 12.");
      }
      return const LessonResult(true, 'Two rounds, combined total of 12! 🥇');
    },
  ),
  Lesson(
    id: 884,
    topicId: 'variables',
    title: 'Score And Spin Four Times',
    glyph: '🌪️',
    complexity: 4,
    target: 'Repeat 4 times, scoring 1 and turning each time, ending at 4, then announce it.',
    narrator: "Score a point, then spin — four times in a row — and tell everyone the total.",
    steps: const [
      "Add a 'repeat 4' block (Control).",
      "Inside it, add 'change Score by 1' (Variables) and a 'turn' block (Motion).",
      "After the loop, add 'say' (Looks).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (times * delta != 4) {
        return const LessonResult(false, "The loop should end with Score at exactly 4.");
      }
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside the loop.");
      }
      if (!script.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block after the loop.");
      }
      return const LessonResult(true, 'Four spins, four points, announced! 🌪️');
    },
  ),
  Lesson(
    id: 885,
    topicId: 'variables',
    title: 'Countdown By Tens',
    glyph: '💣',
    complexity: 4,
    target: 'Set Score to 50, then repeat 5 times subtracting 10, ending at exactly 0.',
    narrator: "Big countdown — 50 draining down by 10 each loop, 5 loops total.",
    steps: const [
      "Add 'set Score to 50' (Variables).",
      "Add a 'repeat 5' block (Control).",
      "Inside it, add 'change Score by -10' (Variables).",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 50}),
      BlockInstance('control_repeat', inputs: {'times': 5}),
    ],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 50) {
        return const LessonResult(false, "Set Score to exactly 50 first.");
      }
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(inside.first, 'value');
      if (50 + (times * delta) != 0) {
        return const LessonResult(false, "The countdown should land exactly on 0.");
      }
      return const LessonResult(true, 'Boom — countdown hit zero exactly! 💣');
    },
  ),
  Lesson(
    id: 886,
    topicId: 'variables',
    title: 'Triple Combo Loop',
    glyph: '🎆',
    complexity: 4,
    target: 'Repeat 6 times: score 1, click, and move — ending at Score 6.',
    narrator: "Full combo every loop — score, sound, and movement together, six times.",
    steps: const [
      "Add a 'repeat 6' block (Control).",
      "Inside it, add 'change Score by 1' (Variables), 'play sound' (Sound), and 'move steps' (Motion).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 6})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (times * delta != 6) {
        return const LessonResult(false, "The loop should end with Score at exactly 6.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block inside the loop.");
      }
      return const LessonResult(true, 'Full combo, six loops, score of 6! 🎆');
    },
  ),
  Lesson(
    id: 887,
    topicId: 'variables',
    title: 'Endless Runner',
    glyph: '🛹',
    complexity: 4,
    target: 'Forever: move, score 1, and bounce off edges — scoring never stops.',
    narrator: "An endless runner — I keep moving, scoring, and bouncing off the walls forever.",
    steps: const [
      "Add a 'forever' block (Control).",
      "Inside it, add 'move steps' (Motion), 'change Score by 1' (Variables), and 'if on edge, bounce' (Motion).",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty || _num(changes.first, 'value') != 1) {
        return const LessonResult(false, "Add 'change Score by 1' inside the forever loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Add 'if on edge, bounce' inside the loop.");
      }
      return const LessonResult(true, 'Running, scoring, bouncing — forever! 🛹');
    },
  ),
  Lesson(
    id: 888,
    topicId: 'variables',
    title: 'Say The Final Ten',
    glyph: '💬',
    complexity: 4,
    target: 'Repeat 10 times adding 1, ending at 10, then say a message mentioning it.',
    narrator: "After ten points roll in, announce the final score in your own words.",
    steps: const [
      "Add a 'repeat 10' block (Control) with 'change Score by 1' inside.",
      "After the loop, add 'say' (Looks) with a message like 'Score is 10!'.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 10})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(inside.first, 'value');
      if (times * delta != 10) {
        return const LessonResult(false, "The loop should end with Score at exactly 10.");
      }
      final says = script.where((b) => b.defId == 'looks_say').toList();
      if (says.isEmpty || !(says.first.inputs['text'] as String? ?? '').contains('10')) {
        return const LessonResult(false, "Add a 'say' block whose text mentions 10.");
      }
      return const LessonResult(true, 'Score of 10, announced by name! 💬');
    },
  ),
  Lesson(
    id: 889,
    topicId: 'variables',
    title: 'Bonus Then Penalty',
    glyph: '⚖️',
    complexity: 5,
    target: 'Repeat 3 times adding 5 with a click, then repeat 2 times subtracting 1 — net 13.',
    narrator: "Bonus round scores big with sound, then a penalty round chips a little away.",
    steps: const [
      "Add a 'repeat 3' block (Control) with 'change Score by 5' and 'play sound' inside.",
      "Add a 'repeat 2' block (Control) with 'change Score by -1' inside.",
    ],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}),
      BlockInstance('control_repeat', inputs: {'times': 2}),
    ],
    check: (script) {
      final repeats = _repeats(script);
      if (repeats.length < 2) {
        return const LessonResult(false, "Add two separate 'repeat' blocks.");
      }
      num total = 0;
      var sawSound = false;
      for (final r in repeats) {
        final times = _num(r, 'times');
        final bodyFlat = cqFlatten(r.body);
        final changes = bodyFlat.where((b) => b.defId == 'variables_change').toList();
        if (changes.isEmpty) {
          return const LessonResult(false, "Each repeat loop needs a 'change Score by' block inside it.");
        }
        total += times * _num(changes.first, 'value');
        if (bodyFlat.any((b) => b.defId == 'sound_play_click')) sawSound = true;
      }
      if (!sawSound) {
        return const LessonResult(false, "One of the loops should also play a sound (the bonus round).");
      }
      if (total != 13) {
        return const LessonResult(false, "The bonus and penalty rounds together should net exactly 13.");
      }
      return const LessonResult(true, 'Bonus and penalty combined — net 13! ⚖️');
    },
  ),
  Lesson(
    id: 890,
    topicId: 'variables',
    title: 'Hundred To Zero',
    glyph: '📉',
    complexity: 4,
    target: 'Set Score to 100, then repeat 10 times subtracting 10, ending at exactly 0.',
    narrator: "The big countdown — from 100 all the way down to nothing.",
    steps: const [
      "Add 'set Score to 100' (Variables).",
      "Add a 'repeat 10' block (Control).",
      "Inside it, add 'change Score by -10' (Variables).",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 100}),
      BlockInstance('control_repeat', inputs: {'times': 10}),
    ],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 100) {
        return const LessonResult(false, "Set Score to exactly 100 first.");
      }
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(inside.first, 'value');
      if (100 + (times * delta) != 0) {
        return const LessonResult(false, "The big countdown should land exactly on 0.");
      }
      return const LessonResult(true, 'From 100 to 0 — nothing left! 📉');
    },
  ),
  Lesson(
    id: 891,
    topicId: 'variables',
    title: 'Twenty-One And Moving',
    glyph: '🚴',
    complexity: 5,
    target: 'Repeat 7 times adding 3 and moving, ending at 21, then announce it.',
    narrator: "Seven laps of 3 points each — let's see if you land exactly on 21.",
    steps: const [
      "Add a 'repeat 7' block (Control).",
      "Inside it, add 'change Score by 3' (Variables) and 'move steps' (Motion).",
      "After the loop, add 'say' (Looks) announcing the total.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 7})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (times * delta != 21) {
        return const LessonResult(false, "The loop should end with Score at exactly 21 (7 × 3).");
      }
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block inside the loop.");
      }
      if (!script.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block after the loop.");
      }
      return const LessonResult(true, 'Seven laps of three — exactly 21! 🚴');
    },
  ),
  Lesson(
    id: 892,
    topicId: 'variables',
    title: 'The Full Combo Loop',
    glyph: '🎮',
    complexity: 5,
    target: 'Repeat 5 times: move, score 4, and click — ending at exactly 20.',
    narrator: "The ultimate single loop — movement, sound, and a fat 4-point score, five times over.",
    steps: const [
      "Add a 'repeat 5' block (Control).",
      "Inside it, add 'move steps' (Motion), 'change Score by 4' (Variables), and 'play sound' (Sound).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 5})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (times * delta != 20) {
        return const LessonResult(false, "The loop should end with Score at exactly 20 (5 × 4).");
      }
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside the loop.");
      }
      return const LessonResult(true, 'Full combo, five loops, score of 20! 🎮');
    },
  ),
  Lesson(
    id: 893,
    topicId: 'variables',
    title: 'Two Identical Rounds',
    glyph: '🔁',
    complexity: 5,
    target: 'Two separate repeat-4 loops each adding 2, totalling exactly 16.',
    narrator: "Play the same round twice — two loops of 4 repeats, 2 points each, add them up.",
    steps: const [
      "Add a 'repeat 4' block (Control) with 'change Score by 2' inside.",
      "Add another 'repeat 4' block (Control) with 'change Score by 2' inside.",
    ],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 4}),
      BlockInstance('control_repeat', inputs: {'times': 4}),
    ],
    check: (script) {
      final repeats = _repeats(script);
      if (repeats.length < 2) {
        return const LessonResult(false, "Add two separate 'repeat' blocks.");
      }
      num total = 0;
      for (final r in repeats) {
        final times = _num(r, 'times');
        final changes = cqFlatten(r.body).where((b) => b.defId == 'variables_change').toList();
        if (changes.isEmpty) {
          return const LessonResult(false, "Each repeat loop needs a 'change Score by' block inside it.");
        }
        total += times * _num(changes.first, 'value');
      }
      if (total != 16) {
        return const LessonResult(false, "The two rounds together should total exactly 16.");
      }
      return const LessonResult(true, 'Two identical rounds, total of 16! 🔁');
    },
  ),
  Lesson(
    id: 894,
    topicId: 'variables',
    title: 'Slow And Steady Forever',
    glyph: '🐢',
    complexity: 4,
    target: 'Forever: wait, then add 2 points, so the Score climbs steadily and never stops.',
    narrator: "Slow and steady — pause, then score 2 points, over and over, forever.",
    steps: const [
      "Add a 'forever' block (Control).",
      "Inside it, add 'wait seconds' (Control) and 'change Score by 2' (Variables).",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty || _num(changes.first, 'value') != 2) {
        return const LessonResult(false, "Add 'change Score by 2' inside the forever loop.");
      }
      if (!inside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Add a 'wait seconds' block inside the loop too.");
      }
      return const LessonResult(true, 'Slow, steady, and unstoppable! 🐢');
    },
  ),
  Lesson(
    id: 895,
    topicId: 'variables',
    title: 'Game Over Countdown',
    glyph: '🕹️',
    complexity: 5,
    target: 'Set Score to 9, repeat 9 times subtracting 1 with a click each time, then say Game Over.',
    narrator: "Nine lives, ticking away one click at a time, until it's Game Over.",
    steps: const [
      "Add 'set Score to 9' (Variables).",
      "Add a 'repeat 9' block (Control) with 'change Score by -1' and 'play sound' inside.",
      "After the loop, add 'say' (Looks) with a message.",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 9}),
      BlockInstance('control_repeat', inputs: {'times': 9}),
    ],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 9) {
        return const LessonResult(false, "Set Score to exactly 9 first.");
      }
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (9 + (times * delta) != 0) {
        return const LessonResult(false, "The countdown should land exactly on 0.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside the loop.");
      }
      final says = script.where((b) => b.defId == 'looks_say').toList();
      if (says.isEmpty || (says.first.inputs['text'] as String? ?? '').isEmpty) {
        return const LessonResult(false, "Add a 'say' block with a Game Over message after the loop.");
      }
      return const LessonResult(true, 'Nine lives spent — Game Over! 🕹️');
    },
  ),
  Lesson(
    id: 896,
    topicId: 'variables',
    title: 'Thirty And Reset Position',
    glyph: '🎯',
    complexity: 5,
    target: 'Repeat 6 times adding 5, ending at 30, reset position, and announce the score.',
    narrator: "Six rounds of five points lands on 30 — then head back to base and celebrate.",
    steps: const [
      "Add a 'repeat 6' block (Control) with 'change Score by 5' inside.",
      "After the loop, add 'go to x:0 y:0' (Motion).",
      "Add 'say' (Looks) announcing the score.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 6})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (inside.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(inside.first, 'value');
      if (times * delta != 30) {
        return const LessonResult(false, "The loop should end with Score at exactly 30 (6 × 5).");
      }
      final gotos = script.where((b) => b.defId == 'motion_goto_xy').toList();
      if (gotos.isEmpty || _num(gotos.first, 'x') != 0 || _num(gotos.first, 'y') != 0) {
        return const LessonResult(false, "Add a 'go to x:0 y:0' block after the loop.");
      }
      if (!script.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block announcing the score.");
      }
      return const LessonResult(true, 'Thirty points, back at base, announced! 🎯');
    },
  ),
  Lesson(
    id: 897,
    topicId: 'variables',
    title: 'A Dozen And Turning',
    glyph: '🧭',
    complexity: 5,
    target: 'Set Score to 0, repeat 12 times adding 1 and turning each time, ending at 12.',
    narrator: "A full dozen — score a point and turn a little on every one of the twelve loops.",
    steps: const [
      "Add 'set Score to 0' (Variables).",
      "Add a 'repeat 12' block (Control).",
      "Inside it, add 'change Score by 1' (Variables) and a 'turn' block (Motion).",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_repeat', inputs: {'times': 12}),
    ],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 0) {
        return const LessonResult(false, "Set Score to exactly 0 first.");
      }
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (0 + (times * delta) != 12) {
        return const LessonResult(false, "The loop should end with Score at exactly 12.");
      }
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside the loop.");
      }
      return const LessonResult(true, 'A full dozen, turning all the way! 🧭');
    },
  ),
  Lesson(
    id: 898,
    topicId: 'variables',
    title: 'Loop Plus Penalty',
    glyph: '🧾',
    complexity: 5,
    target: 'Repeat 5 times adding 2 (10), then subtract 3 once more, ending at exactly 7.',
    narrator: "Score steadily in a loop, then take one final penalty at the end.",
    steps: const [
      "Add a 'repeat 5' block (Control) with 'change Score by 2' inside.",
      "After the loop, add 'change Score by -3' (Variables).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 5})],
    check: (script) {
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final loopChanges = cqFlatten(repeat.body).where((b) => b.defId == 'variables_change').toList();
      if (loopChanges.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final loopTotal = times * _num(loopChanges.first, 'value');
      final standaloneChanges =
          script.where((b) => b.defId == 'variables_change').toList(); // top-level, outside loop
      if (standaloneChanges.isEmpty) {
        return const LessonResult(false, "Add one more 'change Score by' block after the loop.");
      }
      final total = loopTotal + _num(standaloneChanges.first, 'value');
      if (total != 7) {
        return const LessonResult(false, "The loop plus the final penalty should total exactly 7.");
      }
      return const LessonResult(true, 'Loop scored, penalty applied, landed on 7! 🧾');
    },
  ),
  Lesson(
    id: 899,
    topicId: 'variables',
    title: 'The Perfect Ten Run',
    glyph: '🏆',
    complexity: 5,
    target: 'Set Score to 0, repeat 10 times: click, move, and score 1 — ending at exactly 10.',
    narrator: "The perfect run — clean start, ten loops of sound, movement, and scoring.",
    steps: const [
      "Add 'set Score to 0' (Variables).",
      "Add a 'repeat 10' block (Control).",
      "Inside it, add 'play sound' (Sound), 'move steps' (Motion), and 'change Score by 1' (Variables).",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_repeat', inputs: {'times': 10}),
    ],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 0) {
        return const LessonResult(false, "Set Score to exactly 0 first.");
      }
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final changes = inside.where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      final delta = _num(changes.first, 'value');
      if (0 + (times * delta) != 10) {
        return const LessonResult(false, "The loop should end with Score at exactly 10.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block inside the loop.");
      }
      return const LessonResult(true, 'The perfect ten run — flawless! 🏆');
    },
  ),
  Lesson(
    id: 900,
    topicId: 'variables',
    title: 'Grand Finale Scoreboard',
    glyph: '👑',
    complexity: 5,
    target: 'Set Score to 0, loop 5 times scoring 4 with movement and sound, then one final -5 penalty, ending at exactly 15, announced.',
    narrator: "The grand finale — everything you've learned in one scoreboard: reset, loop, score, move, sound, penalty, and announce the final number.",
    steps: const [
      "Add 'set Score to 0' (Variables).",
      "Add a 'repeat 5' block (Control) with 'change Score by 4', 'move steps' (Motion), and 'play sound' (Sound) inside.",
      "After the loop, add 'change Score by -5' (Variables).",
      "Finish with a 'say' (Looks) block announcing the final score.",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_repeat', inputs: {'times': 5}),
    ],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty || _num(sets.first, 'value') != 0) {
        return const LessonResult(false, "Set Score to exactly 0 first.");
      }
      final repeat = _firstRepeat(script);
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final times = _num(repeat, 'times');
      final inside = cqFlatten(repeat.body);
      final loopChanges = inside.where((b) => b.defId == 'variables_change').toList();
      if (loopChanges.isEmpty) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside the loop.");
      }
      final loopTotal = times * _num(loopChanges.first, 'value');
      final standaloneChanges = script.where((b) => b.defId == 'variables_change').toList();
      if (standaloneChanges.isEmpty) {
        return const LessonResult(false, "Add a final 'change Score by' block (the penalty) after the loop.");
      }
      final total = loopTotal + _num(standaloneChanges.first, 'value');
      if (total != 15) {
        return const LessonResult(false, "The full scoreboard sequence should end at exactly 15.");
      }
      if (!script.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Finish with a 'say' block announcing the final score.");
      }
      return const LessonResult(true, 'Grand finale complete — final score 15! 👑');
    },
  ),
];
