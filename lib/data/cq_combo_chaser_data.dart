import '../models/cq_models.dart';
import 'cq_blocks.dart';

/// Capstone topic "combo-chaser" — "Build a Catching Game" (Chase Canyon).
///
/// There's no multi-sprite engine in this app, so "catching a target" is
/// simulated honestly with the single turtle: a `goto_xy` teleport represents
/// the target appearing at a new spot, and Process "catching" it is really
/// Process arriving at that spot (goto_xy) and banking the point
/// (`variables_change` on the shared "Score" variable) with `looks_say` /
/// `sound_play_click` feedback. Repeated goto_xy blocks at DIFFERENT
/// coordinates simulate the target moving between rounds. `motion_if_on_edge_
/// bounce` / `control_if_on_edge` double as the game's "miss" obstacle late
/// in the topic. Ids 1021-1080 are reserved for this topic only.

num _numInput(BlockInstance b, String key) => (b.inputs[key] as num?) ?? 0;

bool _before(List<BlockInstance> flat, String a, String b) {
  final ia = flat.indexWhere((x) => x.defId == a);
  final ib = flat.indexWhere((x) => x.defId == b);
  return ia != -1 && ib != -1 && ia < ib;
}

List<BlockInstance> _byId(List<BlockInstance> flat, String id) =>
    flat.where((b) => b.defId == id).toList();

/// Distinct "x,y" keys among all goto_xy blocks in [flat] — used to make sure
/// a lesson's targets actually move between rounds, not just repeat the same
/// spot.
Set<String> _gotoKeys(List<BlockInstance> flat) => _byId(flat, 'motion_goto_xy')
    .map((b) => '${_numInput(b, 'x')},${_numInput(b, 'y')}')
    .toSet();

/// True if there is a `variables_change` with a positive value anywhere
/// after the given goto_xy-index position in [flat] (a "catch" bump).
bool _hasPositiveChangeAfter(List<BlockInstance> flat, int fromIndex) {
  for (var i = fromIndex; i < flat.length; i++) {
    if (flat[i].defId == 'variables_change' && _numInput(flat[i], 'value') > 0) return true;
  }
  return false;
}

int _countPositiveChanges(List<BlockInstance> flat) =>
    _byId(flat, 'variables_change').where((b) => _numInput(b, 'value') > 0).length;

int _countNegativeChanges(List<BlockInstance> flat) =>
    _byId(flat, 'variables_change').where((b) => _numInput(b, 'value') < 0).length;

/// Builds one "catch" sequence: teleport to the target, bank the point,
/// and celebrate. Used by starters (real gameplay checks below still
/// re-derive everything from the submitted script, never trust the starter).
List<BlockInstance> _catchSeq(num x, num y, {String say = 'Caught it!', bool sound = false}) => [
      BlockInstance('motion_goto_xy', inputs: {'x': x, 'y': y}),
      BlockInstance('variables_change', inputs: {'value': 1}),
      if (sound) BlockInstance('sound_play_click'),
      BlockInstance('looks_say', inputs: {'text': say}),
    ];

List<BlockInstance> _missSeq({String say = 'Missed it!'}) => [
      BlockInstance('variables_change', inputs: {'value': -1}),
      BlockInstance('looks_say', inputs: {'text': say}),
    ];

/// Shared check: at least [minCatches] "catch" moments (goto_xy immediately
/// or eventually followed by a positive Score change) with at least 2
/// distinct target coordinates among them.
LessonResult _checkMultiCatch(List<BlockInstance> script, {required int minCatches}) {
  final flat = cqFlatten(script);
  final gotos = _byId(flat, 'motion_goto_xy');
  if (gotos.length < minCatches) {
    return LessonResult(false, 'Add at least $minCatches goto x/y teleports — one per round of the chase.');
  }
  final changes = _countPositiveChanges(flat);
  if (changes < minCatches) {
    return LessonResult(false, "Each catch needs a 'change Score by' block (positive) right after it.");
  }
  if (_gotoKeys(flat).length < 2) {
    return const LessonResult(false, 'Give each teleport a DIFFERENT x/y — the target has to actually move!');
  }
  if (!flat.any((b) => b.defId == 'looks_say')) {
    return const LessonResult(false, "Add a 'say' block to celebrate the catch.");
  }
  return const LessonResult(true, "Nailed it — that target didn't stand a chance! 🎯");
}

/// Shared check: a `control_repeat` container whose body holds at least
/// [minCatches] distinct-coordinate catch moments, optionally requiring a
/// wait for pacing and/or a sound cue.
LessonResult _checkRepeatCatches(
  List<BlockInstance> script, {
  int minCatches = 2,
  bool requireWait = false,
  bool requireSound = false,
}) {
  final repeats = cqFlatten(script).where((b) => b.defId == 'control_repeat').toList();
  if (repeats.isEmpty) {
    return const LessonResult(false, "Add a 'repeat' block (Control) to run several rounds of the chase.");
  }
  final inside = cqFlatten(repeats.first.body);
  final gotos = _byId(inside, 'motion_goto_xy');
  if (gotos.length < minCatches) {
    return LessonResult(false, "Put at least $minCatches goto x/y teleports inside the repeat block.");
  }
  if (_gotoKeys(inside).length < 2) {
    return const LessonResult(false, 'Use DIFFERENT x/y coordinates for each teleport inside the loop.');
  }
  if (_countPositiveChanges(inside) < minCatches) {
    return const LessonResult(false, "Each teleport inside the loop needs its own 'change Score by' bump.");
  }
  if (requireWait && !inside.any((b) => b.defId == 'control_wait')) {
    return const LessonResult(false, "Add a 'wait' block inside the loop to pace the rounds.");
  }
  if (requireSound && !inside.any((b) => b.defId == 'sound_play_click')) {
    return const LessonResult(false, "Add a 'play sound' block inside the loop for catch feedback.");
  }
  return const LessonResult(true, 'Round after round, right on target! 🔁🎯');
}

/// Shared check: a `control_forever` container whose body holds catch
/// moments (endless chase), optionally requiring a miss-penalty (edge
/// bounce/if-on-edge paired with a negative Score change).
LessonResult _checkForeverCatches(
  List<BlockInstance> script, {
  int minCatches = 2,
  bool requireMissPenalty = false,
  bool requireSound = false,
}) {
  final forevers = script.where((b) => b.defId == 'control_forever').toList();
  if (forevers.isEmpty) {
    return const LessonResult(false, "Add a 'forever' block — an endless chase never stops!");
  }
  final inside = cqFlatten(forevers.first.body);
  final gotos = _byId(inside, 'motion_goto_xy');
  if (gotos.length < minCatches) {
    return LessonResult(false, "Put at least $minCatches goto x/y teleports inside the forever loop.");
  }
  if (_gotoKeys(inside).length < 2) {
    return const LessonResult(false, 'Give the endless chase DIFFERENT target coordinates, not the same spot every lap.');
  }
  if (_countPositiveChanges(inside) < minCatches) {
    return const LessonResult(false, "Each teleport needs a positive 'change Score by' bump to count as a catch.");
  }
  if (requireSound && !inside.any((b) => b.defId == 'sound_play_click')) {
    return const LessonResult(false, "Add a 'play sound' block inside the loop for catch feedback.");
  }
  if (requireMissPenalty) {
    final hasEdge = inside.any((b) => b.defId == 'motion_if_on_edge_bounce' || b.defId == 'control_if_on_edge');
    if (!hasEdge) {
      return const LessonResult(false, "Add 'if on edge, bounce' or 'if on edge' inside the loop as the miss obstacle.");
    }
    if (_countNegativeChanges(inside) < 1) {
      return const LessonResult(false, "Pair the edge obstacle with a NEGATIVE 'change Score by' — that's the miss penalty.");
    }
  }
  return const LessonResult(true, 'The chase never stops — and neither does your streak! ♾️🏆');
}

final cqComboChaserLessons = <Lesson>[
  // ---------------------------------------------------------------------
  // 1021-1027 — the anatomy of one "catch": teleport, bank the point, cheer.
  // ---------------------------------------------------------------------
  Lesson(
    id: 1021,
    topicId: 'combo-chaser',
    title: 'Spot the Target',
    glyph: '🎯',
    complexity: 2,
    target: 'Teleport Process to a target spot with goto x/y.',
    narrator: "Welcome to Chase Canyon! A target just appeared out there — let's teleport straight to it.",
    steps: const ["Open Motion and add 'go to x: 0 y: 0'.", 'Change the numbers so the target is away from the middle.'],
    starter: () => [],
    check: (script) {
      final gotos = _byId(cqFlatten(script), 'motion_goto_xy');
      if (gotos.isEmpty) return const LessonResult(false, "Add a 'go to x/y' block from Motion.");
      final g = gotos.first;
      if (_numInput(g, 'x') == 0 && _numInput(g, 'y') == 0) {
        return const LessonResult(false, 'Move the target off (0, 0) — set x or y to something else.');
      }
      return const LessonResult(true, "There it is — you found the target's spot! 🎯");
    },
  ),
  Lesson(
    id: 1022,
    topicId: 'combo-chaser',
    title: 'Zero the Scoreboard',
    glyph: '🔢',
    complexity: 2,
    target: 'Reset Score to 0 before the chase begins, then teleport to the target.',
    narrator: 'Every good chase starts at Score 0. Set that first, THEN go after the target.',
    steps: const ["Add 'set Score to 0' (Variables) first.", "Add 'go to x/y' after it, pointed at your target."],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0})],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = _byId(flat, 'variables_set');
      if (sets.isEmpty) return const LessonResult(false, "Add a 'set Score to' block.");
      if (_numInput(sets.first, 'value') != 0) {
        return const LessonResult(false, 'Set Score to exactly 0 — that\'s the start of the game.');
      }
      if (!flat.any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Add a 'go to x/y' block after setting Score.");
      }
      if (!_before(flat, 'variables_set', 'motion_goto_xy')) {
        return const LessonResult(false, 'Set Score to 0 BEFORE teleporting to the target.');
      }
      return const LessonResult(true, 'Scoreboard reset — the chase is officially on! 🔢');
    },
  ),
  Lesson(
    id: 1023,
    topicId: 'combo-chaser',
    title: 'Bank the Point',
    glyph: '➕',
    complexity: 2,
    target: 'After arriving at the target, change Score by 1 — that IS the catch.',
    narrator: "Arriving at the target isn't enough — you have to bank the point. Change Score right after you land.",
    steps: const ["Keep the 'go to x/y' block.", "Add 'change Score by 1' right after it."],
    starter: () => [BlockInstance('motion_goto_xy', inputs: {'x': 100, 'y': 60})],
    check: (script) {
      final flat = cqFlatten(script);
      final gotoIdx = flat.indexWhere((b) => b.defId == 'motion_goto_xy');
      if (gotoIdx == -1) return const LessonResult(false, "Keep a 'go to x/y' block in your script.");
      if (!_hasPositiveChangeAfter(flat, gotoIdx)) {
        return const LessonResult(false, "Add a 'change Score by' block (positive number) after the teleport.");
      }
      return const LessonResult(true, 'Point banked! That\'s one catch in the books. ➕');
    },
  ),
  Lesson(
    id: 1024,
    topicId: 'combo-chaser',
    title: 'Call It Out',
    glyph: '💬',
    complexity: 2,
    target: 'Say something the moment you catch the target.',
    narrator: "A silent catch is no fun — announce it! Add a say block right after you bank the point.",
    steps: const ['Keep the teleport + Score change.', "Add 'say Caught it!' (Looks) after the Score change."],
    starter: () => [
      BlockInstance('motion_goto_xy', inputs: {'x': 100, 'y': 60}),
      BlockInstance('variables_change', inputs: {'value': 1}),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_change', 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block AFTER the 'change Score by' block.");
      }
      final say = _byId(flat, 'looks_say').first;
      if ((say.inputs['text'] as String?)?.trim().isEmpty ?? true) {
        return const LessonResult(false, 'Give the say block some actual words!');
      }
      return const LessonResult(true, 'Loud and proud — the canyon heard that catch! 💬');
    },
  ),
  Lesson(
    id: 1025,
    topicId: 'combo-chaser',
    title: 'Catch Chime',
    glyph: '🔔',
    complexity: 2,
    target: 'Add a click sound as extra feedback for the catch.',
    narrator: "Let's give the catch a sound, too — click, point, cheer, all in one moment.",
    steps: const ['Keep teleport + Score change + say.', "Add 'play sound' (Sound) somewhere in that catch sequence."],
    starter: () => [
      BlockInstance('motion_goto_xy', inputs: {'x': 100, 'y': 60}),
      BlockInstance('variables_change', inputs: {'value': 1}),
      BlockInstance('looks_say', inputs: {'text': 'Caught it!'}),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block (Sound) to the catch sequence.");
      }
      if (_countPositiveChanges(flat) < 1 || !flat.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, 'Keep the Score change and say block too — this is the FULL catch.');
      }
      return const LessonResult(true, 'Click! Point! Cheer! That\'s a proper catch. 🔔');
    },
  ),
  Lesson(
    id: 1026,
    topicId: 'combo-chaser',
    title: 'Show Yourself',
    glyph: '👀',
    complexity: 2,
    target: 'Show Process before the chase starts, then run the catch sequence.',
    narrator: "Before any chase, make sure Process is actually visible on the canyon floor.",
    steps: const ["Add 'show' (Looks) first.", 'Keep the teleport + Score change after it.'],
    starter: () => [
      BlockInstance('looks_show'),
      BlockInstance('motion_goto_xy', inputs: {'x': -80, 'y': 40}),
      BlockInstance('variables_change', inputs: {'value': 1}),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'looks_show', 'motion_goto_xy')) {
        return const LessonResult(false, "Add 'show' BEFORE the teleport — Process needs to be visible first.");
      }
      if (_countPositiveChanges(flat) < 1) {
        return const LessonResult(false, "Keep a 'change Score by' block after the teleport.");
      }
      return const LessonResult(true, 'Visible, ready, and already chasing. 👀');
    },
  ),
  Lesson(
    id: 1027,
    topicId: 'combo-chaser',
    title: 'The Full Catch Combo',
    glyph: '✅',
    complexity: 3,
    target: 'Put goto x/y, change Score, play sound, and say together in order.',
    narrator: "Time to combine everything: teleport, bank the point, chime, and cheer — the complete catch combo.",
    steps: const [
      "Add 'go to x/y' with your target's spot.",
      "Add 'change Score by 1'.",
      "Add 'play sound', then 'say Caught it!'.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final order = ['motion_goto_xy', 'variables_change', 'sound_play_click', 'looks_say'];
      for (final id in order) {
        if (!flat.any((b) => b.defId == id)) {
          return LessonResult(false, 'Your catch combo is missing a block: $id.');
        }
      }
      if (!_before(flat, 'motion_goto_xy', 'variables_change') ||
          !_before(flat, 'variables_change', 'sound_play_click') ||
          !_before(flat, 'sound_play_click', 'looks_say')) {
        return const LessonResult(false, 'Order matters: teleport → change Score → play sound → say.');
      }
      if (_numInput(flat.firstWhere((b) => b.defId == 'variables_change'), 'value') <= 0) {
        return const LessonResult(false, "The Score change must be positive — it's a catch, not a miss.");
      }
      return const LessonResult(true, 'That\'s the complete combo — textbook catch! ✅');
    },
  ),

  // ---------------------------------------------------------------------
  // 1028-1035 — multiple catches, one after another, at different spots.
  // ---------------------------------------------------------------------
  Lesson(
    id: 1028,
    topicId: 'combo-chaser',
    title: 'Two Targets',
    glyph: '🎯🎯',
    complexity: 3,
    target: 'Catch a target, then catch a SECOND target at a different spot.',
    narrator: "One catch was great. Now the target reappears somewhere else — chase it down too!",
    steps: const [
      'Add a full catch combo for the first target.',
      'Add a second catch combo at a DIFFERENT x/y.',
    ],
    starter: () => [..._catchSeq(120, 80)],
    check: (script) => _checkMultiCatch(script, minCatches: 2),
  ),
  Lesson(
    id: 1029,
    topicId: 'combo-chaser',
    title: 'Chase Pause',
    glyph: '⏱️',
    complexity: 3,
    target: 'Add a wait between two catches so the chase has pacing.',
    narrator: "Give the canyon a beat to breathe — wait a moment between catching one target and chasing the next.",
    steps: const ['Keep two catch combos at different spots.', "Insert a 'wait 1 seconds' block between them."],
    starter: () => [..._catchSeq(120, 80), BlockInstance('control_wait', inputs: {'seconds': 1}), ..._catchSeq(-90, 60)],
    check: (script) {
      final flat = cqFlatten(script);
      final result = _checkMultiCatch(script, minCatches: 2);
      if (!result.ok) return result;
      final gotoIdxs = <int>[];
      for (var i = 0; i < flat.length; i++) {
        if (flat[i].defId == 'motion_goto_xy') gotoIdxs.add(i);
      }
      final waitIdx = flat.indexWhere((b) => b.defId == 'control_wait');
      if (waitIdx == -1 || waitIdx < gotoIdxs.first || waitIdx > gotoIdxs.last) {
        return const LessonResult(false, "Put a 'wait' block BETWEEN the two catches, not before or after both.");
      }
      return const LessonResult(true, 'Nice pacing — the chase breathes now. ⏱️');
    },
  ),
  Lesson(
    id: 1030,
    topicId: 'combo-chaser',
    title: 'Triple Catch',
    glyph: '🥇',
    complexity: 3,
    target: 'Chain THREE catch combos at three different spots.',
    narrator: "Three targets, three spots, three catches. Chain them all in one script.",
    steps: const ['Add three full catch combos.', 'Give each one a different x/y.'],
    starter: () => [..._catchSeq(120, 80), ..._catchSeq(-90, 60), ..._catchSeq(150, -70)],
    check: (script) => _checkMultiCatch(script, minCatches: 3),
  ),
  Lesson(
    id: 1031,
    topicId: 'combo-chaser',
    title: 'Loop the Chase',
    glyph: '🔁',
    complexity: 3,
    target: 'Put two catches at different spots INSIDE a repeat block.',
    narrator: "Instead of writing every catch by hand, let a repeat block run the rounds for you.",
    steps: const ["Add a 'repeat' block (Control).", 'Inside it, put two catch combos at different x/y spots.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2}, body: [..._catchSeq(120, 80), ..._catchSeq(-90, 60)])],
    check: (script) => _checkRepeatCatches(script, minCatches: 2),
  ),
  Lesson(
    id: 1032,
    topicId: 'combo-chaser',
    title: 'Repeat & Ring',
    glyph: '🔔',
    complexity: 3,
    target: 'Add a sound cue inside the repeating catches.',
    narrator: "Every catch inside the loop deserves its own chime — add the sound block in there too.",
    steps: const ['Keep the repeat block with two different-spot catches.', "Make sure 'play sound' is inside the loop."],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 2}, body: [
        ..._catchSeq(120, 80, sound: true),
        ..._catchSeq(-90, 60, sound: true),
      ]),
    ],
    check: (script) => _checkRepeatCatches(script, minCatches: 2, requireSound: true),
  ),
  Lesson(
    id: 1033,
    topicId: 'combo-chaser',
    title: 'Timed Targets',
    glyph: '⏳',
    complexity: 3,
    target: 'Add wait blocks inside the repeat, between each catch.',
    narrator: "Let's slow the loop down a touch — a short wait between each catch inside the repeat.",
    steps: const ['Keep the repeat block with two catches.', "Add a 'wait' block between the two catch combos."],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 2}, body: [
        ..._catchSeq(120, 80),
        BlockInstance('control_wait', inputs: {'seconds': 1}),
        ..._catchSeq(-90, 60),
      ]),
    ],
    check: (script) => _checkRepeatCatches(script, minCatches: 2, requireWait: true),
  ),
  Lesson(
    id: 1034,
    topicId: 'combo-chaser',
    title: 'Four-Round Chase',
    glyph: '🏁',
    complexity: 3,
    target: 'Set the repeat to run at least 4 times with two different-spot catches inside.',
    narrator: "More rounds, more chasing! Bump the repeat count up to at least 4 laps.",
    steps: const ['Set the repeat times to 4 or more.', 'Keep two different-spot catches inside it.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 4}, body: [..._catchSeq(120, 80), ..._catchSeq(-90, 60)]),
    ],
    check: (script) {
      final repeats = cqFlatten(script).where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      if (_numInput(repeats.first, 'times') < 4) {
        return const LessonResult(false, 'Set the repeat to run at least 4 times.');
      }
      return _checkRepeatCatches(script, minCatches: 2);
    },
  ),
  Lesson(
    id: 1035,
    topicId: 'combo-chaser',
    title: 'Hide and Reset',
    glyph: '🙈',
    complexity: 3,
    target: 'Hide, then reset Score to 0, THEN run the repeating chase.',
    narrator: "Before a fresh chase begins, hide for a beat and zero the scoreboard — then let the loop rip.",
    steps: const ["Add 'hide' first.", "Add 'set Score to 0' next.", 'Keep the repeat block with catches after that.'],
    starter: () => [
      BlockInstance('looks_hide'),
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [..._catchSeq(120, 80), ..._catchSeq(-90, 60)]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'looks_hide', 'variables_set') || !_before(flat, 'variables_set', 'control_repeat')) {
        return const LessonResult(false, 'Order: hide → set Score to 0 → repeat block.');
      }
      final sets = _byId(flat, 'variables_set');
      if (sets.isEmpty || _numInput(sets.first, 'value') != 0) {
        return const LessonResult(false, 'Set Score to exactly 0 before the loop.');
      }
      return _checkRepeatCatches(script, minCatches: 2);
    },
  ),

  // ---------------------------------------------------------------------
  // 1036-1050 — growing the repeating chase: more catches, more polish.
  // ---------------------------------------------------------------------
  Lesson(
    id: 1036,
    topicId: 'combo-chaser',
    title: 'Sound of Success',
    glyph: '🎶',
    complexity: 3,
    target: 'Repeat block with two catches, both with sound AND say feedback.',
    narrator: "Let's make every catch in the loop feel great — chime AND cheer, every single time.",
    steps: const ['Keep two different-spot catches inside a repeat.', 'Each catch needs both sound and say.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        ..._catchSeq(100, 90, sound: true),
        ..._catchSeq(-110, 30, sound: true),
      ]),
    ],
    check: (script) {
      final r = _checkRepeatCatches(script, minCatches: 2, requireSound: true);
      if (!r.ok) return r;
      final inside = cqFlatten(cqFlatten(script).where((b) => b.defId == 'control_repeat').first.body);
      if (!inside.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block to each catch, too.");
      }
      return const LessonResult(true, 'Chime and cheer, every catch — pure gold. 🎶');
    },
  ),
  Lesson(
    id: 1037,
    topicId: 'combo-chaser',
    title: 'Three in a Loop',
    glyph: '🥉',
    complexity: 3,
    target: 'Fit THREE different-spot catches inside one repeat block.',
    narrator: "Three targets can absolutely live inside a single repeat — chase them all in one lap.",
    steps: const ['Put three catch combos inside a repeat block.', 'Give each a different x/y.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        ..._catchSeq(120, 80),
        ..._catchSeq(-90, 60),
        ..._catchSeq(150, -70),
      ]),
    ],
    check: (script) => _checkRepeatCatches(script, minCatches: 3),
  ),
  Lesson(
    id: 1038,
    topicId: 'combo-chaser',
    title: 'Pace the Triple',
    glyph: '⏲️',
    complexity: 3,
    target: 'Three catches inside a repeat, with a wait somewhere in between them.',
    narrator: "Three catches is a lot of action — slot a wait in there so players can keep up.",
    steps: const ['Keep three different-spot catches in a repeat.', "Add a 'wait' block somewhere between them."],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        ..._catchSeq(120, 80),
        BlockInstance('control_wait', inputs: {'seconds': 1}),
        ..._catchSeq(-90, 60),
        ..._catchSeq(150, -70),
      ]),
    ],
    check: (script) => _checkRepeatCatches(script, minCatches: 3, requireWait: true),
  ),
  Lesson(
    id: 1039,
    topicId: 'combo-chaser',
    title: 'Bigger Board',
    glyph: '🗺️',
    complexity: 3,
    target: 'Spread three catches to the far corners — use big, clearly different coordinates.',
    narrator: "Let's use the whole canyon! Spread your three targets far apart, not clustered together.",
    steps: const ['Keep three catches inside the repeat.', 'Use large, clearly different x/y values for each.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        ..._catchSeq(180, 120),
        ..._catchSeq(-170, -110),
        ..._catchSeq(190, -130),
      ]),
    ],
    check: (script) {
      final r = _checkRepeatCatches(script, minCatches: 3);
      if (!r.ok) return r;
      final inside = cqFlatten(cqFlatten(script).where((b) => b.defId == 'control_repeat').first.body);
      final gotos = _byId(inside, 'motion_goto_xy');
      final spreadEnough = gotos.any((b) => (_numInput(b, 'x').abs() > 100) || (_numInput(b, 'y').abs() > 100));
      if (!spreadEnough) {
        return const LessonResult(false, 'Push at least one target out past 100 on x or y — use the whole canyon!');
      }
      return const LessonResult(true, 'Now THAT is covering ground. 🗺️');
    },
  ),
  Lesson(
    id: 1040,
    topicId: 'combo-chaser',
    title: 'Five Laps',
    glyph: '🏃‍♂️',
    complexity: 3,
    target: 'Run a repeat of at least 5 laps with two different-spot catches inside.',
    narrator: "Five laps of the same two-target loop — that's a real endurance chase.",
    steps: const ['Set the repeat to run 5 or more times.', 'Keep two different-spot catches inside it.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 5}, body: [..._catchSeq(110, 70), ..._catchSeq(-100, 50)]),
    ],
    check: (script) {
      final repeats = cqFlatten(script).where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty || _numInput(repeats.first, 'times') < 5) {
        return const LessonResult(false, 'Set the repeat to run at least 5 times.');
      }
      return _checkRepeatCatches(script, minCatches: 2);
    },
  ),
  Lesson(
    id: 1041,
    topicId: 'combo-chaser',
    title: 'Say the Count',
    glyph: '🗣️',
    complexity: 4,
    target: 'Two catches inside a repeat, each with a DIFFERENT say message.',
    narrator: "Make each catch feel distinct — give the two catches different cheers.",
    steps: const ['Keep two different-spot catches in a repeat.', 'Give each catch its own unique say text.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        ..._catchSeq(120, 80, say: 'Got one!'),
        ..._catchSeq(-90, 60, say: 'Two in a row!'),
      ]),
    ],
    check: (script) {
      final r = _checkRepeatCatches(script, minCatches: 2);
      if (!r.ok) return r;
      final inside = cqFlatten(cqFlatten(script).where((b) => b.defId == 'control_repeat').first.body);
      final texts = _byId(inside, 'looks_say').map((b) => b.inputs['text'] as String? ?? '').toSet();
      if (texts.length < 2) {
        return const LessonResult(false, 'Give each catch a DIFFERENT say message — no copy-pasting the cheer.');
      }
      return const LessonResult(true, 'Every catch gets its own moment. 🗣️');
    },
  ),
  Lesson(
    id: 1042,
    topicId: 'combo-chaser',
    title: 'Sound, Wait, Repeat',
    glyph: '🎚️',
    complexity: 4,
    target: 'Combine sound AND wait inside a repeat of two different-spot catches.',
    narrator: "Layer it up: chime feedback, a breather, and repeat — the full loop, polished.",
    steps: const ['Keep two different-spot catches with sound.', 'Add a wait somewhere in the loop body too.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        ..._catchSeq(130, 90, sound: true),
        BlockInstance('control_wait', inputs: {'seconds': 1}),
        ..._catchSeq(-120, 40, sound: true),
      ]),
    ],
    check: (script) => _checkRepeatCatches(script, minCatches: 2, requireWait: true, requireSound: true),
  ),
  Lesson(
    id: 1043,
    topicId: 'combo-chaser',
    title: 'Four Corners',
    glyph: '🧭',
    complexity: 4,
    target: 'Fit FOUR different-spot catches inside one repeat block.',
    narrator: "Four targets, four corners of the canyon. Chase them all in a single lap.",
    steps: const ['Add four catch combos inside a repeat block.', 'Give all four different x/y spots.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 2}, body: [
        ..._catchSeq(150, 100),
        ..._catchSeq(-150, 100),
        ..._catchSeq(-150, -100),
        ..._catchSeq(150, -100),
      ]),
    ],
    check: (script) => _checkRepeatCatches(script, minCatches: 4),
  ),
  Lesson(
    id: 1044,
    topicId: 'combo-chaser',
    title: 'Full Board Feedback',
    glyph: '🌟',
    complexity: 4,
    target: 'Four different-spot catches in a repeat, every one with sound.',
    narrator: "All four corners, all four chimes — no catch goes unnoticed.",
    steps: const ['Keep four different-spot catches in a repeat.', 'Every catch needs its own sound cue.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 2}, body: [
        ..._catchSeq(150, 100, sound: true),
        ..._catchSeq(-150, 100, sound: true),
        ..._catchSeq(-150, -100, sound: true),
        ..._catchSeq(150, -100, sound: true),
      ]),
    ],
    check: (script) => _checkRepeatCatches(script, minCatches: 4, requireSound: true),
  ),
  Lesson(
    id: 1045,
    topicId: 'combo-chaser',
    title: 'Reset Between Rounds',
    glyph: '♻️',
    complexity: 4,
    target: 'Set Score to 0 before the loop, then run 3+ different-spot catches inside a repeat.',
    narrator: "A clean run starts at zero. Reset the scoreboard, then chase down three fresh targets.",
    steps: const ["Add 'set Score to 0' before the repeat.", 'Keep three different-spot catches inside the repeat.'],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        ..._catchSeq(120, 80),
        ..._catchSeq(-90, 60),
        ..._catchSeq(150, -70),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = _byId(flat, 'variables_set');
      if (sets.isEmpty || _numInput(sets.first, 'value') != 0) {
        return const LessonResult(false, "Add 'set Score to 0' before the repeat block.");
      }
      if (!_before(flat, 'variables_set', 'control_repeat')) {
        return const LessonResult(false, 'The Score reset must come BEFORE the repeat block.');
      }
      return _checkRepeatCatches(script, minCatches: 3);
    },
  ),
  Lesson(
    id: 1046,
    topicId: 'combo-chaser',
    title: 'Chase Warm-Up',
    glyph: '🔥',
    complexity: 4,
    target: 'Show, reset Score, then run a repeat of 3+ different-spot catches with sound.',
    narrator: "Show yourself, zero the board, then let the loop cook — full warm-up before the big chase.",
    steps: const ["Add 'show', then 'set Score to 0'.", 'Follow with a repeat containing 3+ catches with sound.'],
    starter: () => [
      BlockInstance('looks_show'),
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        ..._catchSeq(120, 80, sound: true),
        ..._catchSeq(-90, 60, sound: true),
        ..._catchSeq(150, -70, sound: true),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'looks_show', 'variables_set') || !_before(flat, 'variables_set', 'control_repeat')) {
        return const LessonResult(false, 'Order: show → set Score to 0 → repeat block.');
      }
      return _checkRepeatCatches(script, minCatches: 3, requireSound: true);
    },
  ),
  Lesson(
    id: 1047,
    topicId: 'combo-chaser',
    title: 'Six Laps of Chaos',
    glyph: '🌀',
    complexity: 4,
    target: 'Repeat at least 6 times over three different-spot catches with wait pacing.',
    narrator: "Crank the laps up to 6 — a marathon chase across three targets, nicely paced.",
    steps: const ['Set the repeat to run 6+ times.', 'Keep three different-spot catches with a wait inside.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 6}, body: [
        ..._catchSeq(120, 80),
        BlockInstance('control_wait', inputs: {'seconds': 1}),
        ..._catchSeq(-90, 60),
        ..._catchSeq(150, -70),
      ]),
    ],
    check: (script) {
      final repeats = cqFlatten(script).where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty || _numInput(repeats.first, 'times') < 6) {
        return const LessonResult(false, 'Set the repeat to run at least 6 times.');
      }
      return _checkRepeatCatches(script, minCatches: 3, requireWait: true);
    },
  ),
  Lesson(
    id: 1048,
    topicId: 'combo-chaser',
    title: 'Big Bounce Warm-Up',
    glyph: '🏓',
    complexity: 4,
    target: 'Combine edge-bounce movement with a repeat of different-spot catches.',
    narrator: "Before the real obstacle appears, practice bouncing around AND still landing your catches.",
    steps: const ["Add 'if on edge, bounce' before the repeat.", 'Keep 2+ different-spot catches inside the repeat.'],
    starter: () => [
      BlockInstance('motion_if_on_edge_bounce'),
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [..._catchSeq(120, 80), ..._catchSeq(-90, 60)]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Add 'if on edge, bounce' (Motion) before the repeat block.");
      }
      return _checkRepeatCatches(script, minCatches: 2);
    },
  ),
  Lesson(
    id: 1049,
    topicId: 'combo-chaser',
    title: 'Announce the Streak',
    glyph: '📣',
    complexity: 4,
    target: 'Three different-spot catches in a repeat, ending with an extra streak say.',
    narrator: "After the loop's regular catches, add ONE more say block outside to announce the streak.",
    steps: const ['Keep three different-spot catches inside a repeat.', "Add a 'say' block AFTER the repeat block ends."],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        ..._catchSeq(120, 80),
        ..._catchSeq(-90, 60),
        ..._catchSeq(150, -70),
      ]),
      BlockInstance('looks_say', inputs: {'text': 'Streak complete!'}),
    ],
    check: (script) {
      final r = _checkRepeatCatches(script, minCatches: 3);
      if (!r.ok) return r;
      final top = script;
      final repeatIdx = top.indexWhere((b) => b.defId == 'control_repeat');
      final sayAfter = top.skip(repeatIdx + 1).any((b) => b.defId == 'looks_say');
      if (repeatIdx == -1 || !sayAfter) {
        return const LessonResult(false, "Add a 'say' block AFTER (outside) the repeat block to announce the streak.");
      }
      return const LessonResult(true, 'Streak announced — the whole canyon knows! 📣');
    },
  ),
  Lesson(
    id: 1050,
    topicId: 'combo-chaser',
    title: 'The Polished Loop',
    glyph: '💎',
    complexity: 4,
    target: 'Four different-spot catches in a repeat, each with sound AND a unique say.',
    narrator: "This is the loop we've been building toward — four catches, every one polished to a shine.",
    steps: const ['Fit four different-spot catches in a repeat.', 'Give each one sound and a unique say message.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 2}, body: [
        ..._catchSeq(150, 100, say: 'Corner one!', sound: true),
        ..._catchSeq(-150, 100, say: 'Corner two!', sound: true),
        ..._catchSeq(-150, -100, say: 'Corner three!', sound: true),
        ..._catchSeq(150, -100, say: 'Corner four!', sound: true),
      ]),
    ],
    check: (script) {
      final r = _checkRepeatCatches(script, minCatches: 4, requireSound: true);
      if (!r.ok) return r;
      final inside = cqFlatten(cqFlatten(script).where((b) => b.defId == 'control_repeat').first.body);
      final texts = _byId(inside, 'looks_say').map((b) => b.inputs['text'] as String? ?? '').toSet();
      if (texts.length < 4) {
        return const LessonResult(false, 'Give each of the four catches its OWN unique say message.');
      }
      return const LessonResult(true, 'Polished, loud, and unstoppable. 💎');
    },
  ),

  // ---------------------------------------------------------------------
  // 1051-1060 — the chase never stops: forever loops, endless catching.
  // ---------------------------------------------------------------------
  Lesson(
    id: 1051,
    topicId: 'combo-chaser',
    title: 'Endless Canyon',
    glyph: '♾️',
    complexity: 4,
    target: 'Put two different-spot catches inside a FOREVER loop instead of a repeat.',
    narrator: "Chase Canyon never really ends. Swap the repeat for a forever loop — the chase goes on and on.",
    steps: const ["Add a 'forever' block (Control).", 'Inside it, put two catch combos at different x/y spots.'],
    starter: () => [BlockInstance('control_forever', body: [..._catchSeq(120, 80), ..._catchSeq(-90, 60)])],
    check: (script) => _checkForeverCatches(script, minCatches: 2),
  ),
  Lesson(
    id: 1052,
    topicId: 'combo-chaser',
    title: 'Forever with Feedback',
    glyph: '🔊',
    complexity: 4,
    target: 'Two different-spot catches inside forever, both with sound.',
    narrator: "An endless chase deserves endless feedback — sound on every single catch.",
    steps: const ['Keep two different-spot catches inside forever.', 'Add sound to each catch.'],
    starter: () => [BlockInstance('control_forever', body: [..._catchSeq(120, 80, sound: true), ..._catchSeq(-90, 60, sound: true)])],
    check: (script) => _checkForeverCatches(script, minCatches: 2, requireSound: true),
  ),
  Lesson(
    id: 1053,
    topicId: 'combo-chaser',
    title: 'Three Forever',
    glyph: '3️⃣',
    complexity: 4,
    target: 'Three different-spot catches inside one forever loop.',
    narrator: "Three targets, looping forever — the chase truly never stops now.",
    steps: const ['Put three catch combos inside forever.', 'Give each a different x/y spot.'],
    starter: () => [
      BlockInstance('control_forever', body: [..._catchSeq(120, 80), ..._catchSeq(-90, 60), ..._catchSeq(150, -70)]),
    ],
    check: (script) => _checkForeverCatches(script, minCatches: 3),
  ),
  Lesson(
    id: 1054,
    topicId: 'combo-chaser',
    title: 'Paced Forever',
    glyph: '🕐',
    complexity: 4,
    target: 'Three different-spot catches inside forever, with a wait for pacing.',
    narrator: "Even an endless chase needs a breath now and then — slot a wait in there.",
    steps: const ['Keep three different-spot catches inside forever.', "Add a 'wait' block somewhere between them."],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80),
        BlockInstance('control_wait', inputs: {'seconds': 1}),
        ..._catchSeq(-90, 60),
        ..._catchSeq(150, -70),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 3);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      if (!inside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Add a 'wait' block inside the forever loop.");
      }
      return const LessonResult(true, 'Even forever needs a breath. 🕐');
    },
  ),
  Lesson(
    id: 1055,
    topicId: 'combo-chaser',
    title: 'Reset, Then Forever',
    glyph: '🆕',
    complexity: 4,
    target: 'Set Score to 0 before the forever loop, then chase 2+ different-spot targets endlessly.',
    narrator: "Zero the board once, up front — the forever loop after it will run the whole game.",
    steps: const ["Add 'set Score to 0' before the forever loop.", 'Keep 2+ different-spot catches inside it.'],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_forever', body: [..._catchSeq(120, 80), ..._catchSeq(-90, 60)]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = _byId(flat, 'variables_set');
      if (sets.isEmpty || _numInput(sets.first, 'value') != 0) {
        return const LessonResult(false, "Add 'set Score to 0' before the forever loop.");
      }
      if (!_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, 'The Score reset must come BEFORE the forever loop.');
      }
      return _checkForeverCatches(script, minCatches: 2);
    },
  ),
  Lesson(
    id: 1056,
    topicId: 'combo-chaser',
    title: 'Show, Then Chase Forever',
    glyph: '🎬',
    complexity: 4,
    target: 'Show Process, reset Score, then chase 3+ different-spot targets forever.',
    narrator: "Lights up, scoreboard at zero, and then... the chase never stops.",
    steps: const ["Add 'show' then 'set Score to 0'.", 'Follow with a forever loop of 3+ different-spot catches.'],
    starter: () => [
      BlockInstance('looks_show'),
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_forever', body: [..._catchSeq(120, 80), ..._catchSeq(-90, 60), ..._catchSeq(150, -70)]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'looks_show', 'variables_set') || !_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, 'Order: show → set Score to 0 → forever loop.');
      }
      return _checkForeverCatches(script, minCatches: 3);
    },
  ),
  Lesson(
    id: 1057,
    topicId: 'combo-chaser',
    title: 'Four Forever Corners',
    glyph: '🔲',
    complexity: 4,
    target: 'Fit FOUR different-spot catches inside a forever loop.',
    narrator: "All four corners of the canyon, chased forever, one loop.",
    steps: const ['Put four catch combos inside forever.', 'Give all four different x/y spots.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100),
        ..._catchSeq(-150, 100),
        ..._catchSeq(-150, -100),
        ..._catchSeq(150, -100),
      ]),
    ],
    check: (script) => _checkForeverCatches(script, minCatches: 4),
  ),
  Lesson(
    id: 1058,
    topicId: 'combo-chaser',
    title: 'Full Feedback Forever',
    glyph: '🌈',
    complexity: 4,
    target: 'Four different-spot catches inside forever, all with sound.',
    narrator: "Four corners, four chimes, forever. This is Chase Canyon at full volume.",
    steps: const ['Keep four different-spot catches inside forever.', 'Give every one of them a sound cue.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100, sound: true),
        ..._catchSeq(-150, 100, sound: true),
        ..._catchSeq(-150, -100, sound: true),
        ..._catchSeq(150, -100, sound: true),
      ]),
    ],
    check: (script) => _checkForeverCatches(script, minCatches: 4, requireSound: true),
  ),
  Lesson(
    id: 1059,
    topicId: 'combo-chaser',
    title: 'Unique Cheers Forever',
    glyph: '🎉',
    complexity: 4,
    target: 'Three different-spot catches inside forever, each with a unique say message.',
    narrator: "Every catch in this endless loop should feel like its own little victory — say something different each time.",
    steps: const ['Keep three different-spot catches inside forever.', 'Give each a unique say message.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80, say: 'One!'),
        ..._catchSeq(-90, 60, say: 'Two!'),
        ..._catchSeq(150, -70, say: 'Three!'),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 3);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      final texts = _byId(inside, 'looks_say').map((b) => b.inputs['text'] as String? ?? '').toSet();
      if (texts.length < 3) {
        return const LessonResult(false, 'Give each of the three catches its OWN unique say message.');
      }
      return const LessonResult(true, 'Three different victories, endlessly repeating. 🎉');
    },
  ),
  Lesson(
    id: 1060,
    topicId: 'combo-chaser',
    title: 'The Endless Chase',
    glyph: '🌌',
    complexity: 4,
    target: 'Reset Score, show Process, then chase 4+ different-spot targets forever with sound.',
    narrator: "This is the endless chase in full: reset, show, and an ever-running loop of catches.",
    steps: const ["Add 'set Score to 0' then 'show'.", 'Follow with a forever loop of 4+ different-spot catches, all with sound.'],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('looks_show'),
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100, sound: true),
        ..._catchSeq(-150, 100, sound: true),
        ..._catchSeq(-150, -100, sound: true),
        ..._catchSeq(150, -100, sound: true),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_set', 'looks_show') || !_before(flat, 'looks_show', 'control_forever')) {
        return const LessonResult(false, 'Order: set Score to 0 → show → forever loop.');
      }
      return _checkForeverCatches(script, minCatches: 4, requireSound: true);
    },
  ),

  // ---------------------------------------------------------------------
  // 1061-1070 — misses matter now: edge obstacles cost you points.
  // ---------------------------------------------------------------------
  Lesson(
    id: 1061,
    topicId: 'combo-chaser',
    title: 'First Miss',
    glyph: '💥',
    complexity: 4,
    target: 'Inside a forever loop, add an edge bounce paired with a NEGATIVE Score change.',
    narrator: "Not every chase ends in a catch — hit the edge, and it costs you a point. That's the miss penalty.",
    steps: const [
      'Inside forever, add 2+ different-spot catches.',
      "Add 'if on edge, bounce' and a 'change Score by -1' right after it.",
    ],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80),
        ..._catchSeq(-90, 60),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(),
      ]),
    ],
    check: (script) => _checkForeverCatches(script, minCatches: 2, requireMissPenalty: true),
  ),
  Lesson(
    id: 1062,
    topicId: 'combo-chaser',
    title: 'Miss Call-Out',
    glyph: '😬',
    complexity: 4,
    target: 'Announce the miss with a say block right after the penalty.',
    narrator: "A miss deserves a groan — say something the moment the edge costs you a point.",
    steps: const ['Keep the edge bounce + negative Score change inside forever.', "Add 'say Missed it!' right after the penalty."],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80),
        ..._catchSeq(-90, 60),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(say: 'Missed it!'),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 2, requireMissPenalty: true);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      final negIdx = inside.indexWhere((b) => b.defId == 'variables_change' && _numInput(b, 'value') < 0);
      if (negIdx == -1 || !inside.skip(negIdx).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block right after the negative Score change.");
      }
      return const LessonResult(true, 'The canyon groans — the miss was heard. 😬');
    },
  ),
  Lesson(
    id: 1063,
    topicId: 'combo-chaser',
    title: 'Control the Edge',
    glyph: '🚧',
    complexity: 4,
    target: "Use 'if on edge' (Control) instead of the auto-bounce, as the miss check.",
    narrator: "Try the Control version of the edge check this time — same idea, different block.",
    steps: const ["Add 'if on edge' (Control) inside forever.", 'Put a negative Score change inside it.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80),
        ..._catchSeq(-90, 60),
        BlockInstance('control_if_on_edge', body: [..._missSeq()]),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 2);
      if (!r.ok) return r;
      final inside = script.where((b) => b.defId == 'control_forever').first.body;
      final ifEdge = inside.where((b) => b.defId == 'control_if_on_edge').toList();
      if (ifEdge.isEmpty) {
        return const LessonResult(false, "Use the 'if on edge' block (Control) this time, not the auto-bounce.");
      }
      if (_countNegativeChanges(cqFlatten(ifEdge.first.body)) < 1) {
        return const LessonResult(false, "Put a NEGATIVE 'change Score by' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, 'The edge is under control — literally! 🚧');
    },
  ),
  Lesson(
    id: 1064,
    topicId: 'combo-chaser',
    title: 'Three Catches, One Miss Risk',
    glyph: '⚖️',
    complexity: 4,
    target: 'Three different-spot catches AND the miss penalty, all in one forever loop.',
    narrator: "Balance the risk: three targets to chase, but the edge is still lurking.",
    steps: const ['Keep three different-spot catches inside forever.', 'Add the edge obstacle with its Score penalty too.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80),
        ..._catchSeq(-90, 60),
        ..._catchSeq(150, -70),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(),
      ]),
    ],
    check: (script) => _checkForeverCatches(script, minCatches: 3, requireMissPenalty: true),
  ),
  Lesson(
    id: 1065,
    topicId: 'combo-chaser',
    title: 'Sound the Miss',
    glyph: '🔕',
    complexity: 4,
    target: 'Catches with sound feedback AND a miss penalty in the same forever loop.',
    narrator: "Good catches chime happily. A miss should feel different — but let's give catches their sound cues too.",
    steps: const ['Keep 2+ different-spot catches with sound.', 'Add the edge obstacle with its Score penalty.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80, sound: true),
        ..._catchSeq(-90, 60, sound: true),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(),
      ]),
    ],
    check: (script) => _checkForeverCatches(script, minCatches: 2, requireMissPenalty: true, requireSound: true),
  ),
  Lesson(
    id: 1066,
    topicId: 'combo-chaser',
    title: 'Bigger Penalty',
    glyph: '📉',
    complexity: 5,
    target: 'Make the miss penalty cost at least 2 points, not just 1.',
    narrator: "One point for a miss feels too gentle — raise the stakes to at least 2.",
    steps: const ['Keep the catches and edge obstacle inside forever.', "Change the miss penalty's Score value to -2 or lower."],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80),
        ..._catchSeq(-90, 60),
        BlockInstance('motion_if_on_edge_bounce'),
        BlockInstance('variables_change', inputs: {'value': -2}),
        BlockInstance('looks_say', inputs: {'text': 'Ouch, missed it!'}),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 2, requireMissPenalty: true);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      final worstPenalty = _byId(inside, 'variables_change')
          .map((b) => _numInput(b, 'value'))
          .where((v) => v < 0)
          .fold<num>(0, (a, b) => b < a ? b : a);
      if (worstPenalty > -2) {
        return const LessonResult(false, 'Make the miss penalty at least -2 Score.');
      }
      return const LessonResult(true, 'Now missing actually stings. 📉');
    },
  ),
  Lesson(
    id: 1067,
    topicId: 'combo-chaser',
    title: 'Four Targets, One Trap',
    glyph: '🕳️',
    complexity: 5,
    target: 'Four different-spot catches plus the miss penalty, all inside forever.',
    narrator: "Four targets scattered around, and the edge trap still waiting to catch YOU off guard.",
    steps: const ['Fit four different-spot catches inside forever.', 'Add the edge obstacle with its Score penalty.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100),
        ..._catchSeq(-150, 100),
        ..._catchSeq(-150, -100),
        ..._catchSeq(150, -100),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(),
      ]),
    ],
    check: (script) => _checkForeverCatches(script, minCatches: 4, requireMissPenalty: true),
  ),
  Lesson(
    id: 1068,
    topicId: 'combo-chaser',
    title: 'Reset and Risk',
    glyph: '🎲',
    complexity: 5,
    target: 'Reset Score to 0 before a forever loop of 3+ catches AND a miss penalty.',
    narrator: "Fresh scoreboard, real stakes — zero out, then dive into the risky endless chase.",
    steps: const ["Add 'set Score to 0' before the forever loop.", 'Keep 3+ different-spot catches AND the miss penalty inside it.'],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80),
        ..._catchSeq(-90, 60),
        ..._catchSeq(150, -70),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final sets = _byId(flat, 'variables_set');
      if (sets.isEmpty || _numInput(sets.first, 'value') != 0) {
        return const LessonResult(false, "Add 'set Score to 0' before the forever loop.");
      }
      if (!_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, 'The Score reset must come BEFORE the forever loop.');
      }
      return _checkForeverCatches(script, minCatches: 3, requireMissPenalty: true);
    },
  ),
  Lesson(
    id: 1069,
    topicId: 'combo-chaser',
    title: 'Cheer and Groan',
    glyph: '🎭',
    complexity: 5,
    target: 'Unique say text on every catch AND a distinct say for the miss, in one forever loop.',
    narrator: "Every catch gets its own cheer, and the miss gets its own groan — full emotional range.",
    steps: const ['Give 3+ different-spot catches unique say text.', 'Give the miss penalty its own distinct say text.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80, say: 'Got the first!'),
        ..._catchSeq(-90, 60, say: 'Second one down!'),
        ..._catchSeq(150, -70, say: 'Third catch!'),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(say: 'Ugh, the edge got me!'),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 3, requireMissPenalty: true);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      final texts = _byId(inside, 'looks_say').map((b) => b.inputs['text'] as String? ?? '').toSet();
      if (texts.length < 4) {
        return const LessonResult(false, 'Give every catch AND the miss its own unique say message (4+ total).');
      }
      return const LessonResult(true, 'Every emotion, fully voiced. 🎭');
    },
  ),
  Lesson(
    id: 1070,
    topicId: 'combo-chaser',
    title: 'Risk It All',
    glyph: '🃏',
    complexity: 5,
    target: 'Four different-spot catches with sound, a bigger miss penalty (-2 or worse), all inside forever.',
    narrator: "High risk, high reward: four juicy targets, chimes on every catch, and a miss that really hurts.",
    steps: const ['Fit four different-spot catches with sound inside forever.', 'Make the miss penalty at least -2.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100, sound: true),
        ..._catchSeq(-150, 100, sound: true),
        ..._catchSeq(-150, -100, sound: true),
        ..._catchSeq(150, -100, sound: true),
        BlockInstance('motion_if_on_edge_bounce'),
        BlockInstance('variables_change', inputs: {'value': -2}),
        BlockInstance('looks_say', inputs: {'text': 'That one hurt!'}),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 4, requireMissPenalty: true, requireSound: true);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      final worstPenalty = _byId(inside, 'variables_change')
          .map((b) => _numInput(b, 'value'))
          .where((v) => v < 0)
          .fold<num>(0, (a, b) => b < a ? b : a);
      if (worstPenalty > -2) {
        return const LessonResult(false, 'Make the miss penalty at least -2 Score for this high-stakes round.');
      }
      return const LessonResult(true, 'High risk, high reward — and you nailed it. 🃏');
    },
  ),

  // ---------------------------------------------------------------------
  // 1071-1080 — final capstones: the complete catching game.
  // ---------------------------------------------------------------------
  Lesson(
    id: 1071,
    topicId: 'combo-chaser',
    title: 'The Real Game Begins',
    glyph: '🚦',
    complexity: 5,
    target: 'Reset Score, show, then run a forever loop with 3+ catches AND a miss penalty.',
    narrator: "This is a real catching game now: reset, show yourself, then chase forever with real risk.",
    steps: const ["Add 'set Score to 0' then 'show'.", 'Follow with a forever loop of 3+ catches and the edge miss penalty.'],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('looks_show'),
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80, sound: true),
        ..._catchSeq(-90, 60, sound: true),
        ..._catchSeq(150, -70, sound: true),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_set', 'looks_show') || !_before(flat, 'looks_show', 'control_forever')) {
        return const LessonResult(false, 'Order: set Score to 0 → show → forever loop.');
      }
      return _checkForeverCatches(script, minCatches: 3, requireMissPenalty: true);
    },
  ),
  Lesson(
    id: 1072,
    topicId: 'combo-chaser',
    title: 'Five Targets, Real Stakes',
    glyph: '5️⃣',
    complexity: 5,
    target: 'Five different-spot catches AND a miss penalty, all inside one forever loop.',
    narrator: "Five targets scattered across the canyon, and the edge is still out there waiting.",
    steps: const ['Fit five different-spot catches inside forever.', 'Add the edge obstacle with its Score penalty.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100),
        ..._catchSeq(-150, 100),
        ..._catchSeq(-150, -100),
        ..._catchSeq(150, -100),
        ..._catchSeq(0, 130),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(),
      ]),
    ],
    check: (script) => _checkForeverCatches(script, minCatches: 5, requireMissPenalty: true),
  ),
  Lesson(
    id: 1073,
    topicId: 'combo-chaser',
    title: 'Paced Peril',
    glyph: '⏳',
    complexity: 5,
    target: 'Four catches, a wait for pacing, sound feedback, and a miss penalty — all in one forever loop.',
    narrator: "Every element together: pacing, chimes, catches, and the ever-present risk of the edge.",
    steps: const ['Keep four different-spot catches with sound.', 'Add a wait for pacing and the edge miss penalty.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100, sound: true),
        BlockInstance('control_wait', inputs: {'seconds': 1}),
        ..._catchSeq(-150, 100, sound: true),
        ..._catchSeq(-150, -100, sound: true),
        ..._catchSeq(150, -100, sound: true),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 4, requireMissPenalty: true, requireSound: true);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      if (!inside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Add a 'wait' block inside the loop for pacing.");
      }
      return const LessonResult(true, 'Paced, chiming, and full of peril — beautiful. ⏳');
    },
  ),
  Lesson(
    id: 1074,
    topicId: 'combo-chaser',
    title: 'The Announcer',
    glyph: '📢',
    complexity: 5,
    target: 'Unique say for each of 3+ catches, a distinct miss say, PLUS a say block after the loop ends.',
    narrator: "Add a final announcer line outside the loop — though the loop runs forever, plan for the wrap-up.",
    steps: const ['Keep 3+ catches with unique say text and the miss penalty.', "Add one more 'say' block AFTER the forever loop."],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(120, 80, say: 'One down!'),
        ..._catchSeq(-90, 60, say: 'Two down!'),
        ..._catchSeq(150, -70, say: 'Three down!'),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(say: 'Edge got me!'),
      ]),
      BlockInstance('looks_say', inputs: {'text': 'Game over, canyon!'}),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 3, requireMissPenalty: true);
      if (!r.ok) return r;
      final foreverIdx = script.indexWhere((b) => b.defId == 'control_forever');
      final sayAfter = script.skip(foreverIdx + 1).any((b) => b.defId == 'looks_say');
      if (foreverIdx == -1 || !sayAfter) {
        return const LessonResult(false, "Add a 'say' block AFTER the forever loop as a final announcement.");
      }
      return const LessonResult(true, 'The announcer has the final word. 📢');
    },
  ),
  Lesson(
    id: 1075,
    topicId: 'combo-chaser',
    title: 'Harsh Canyon',
    glyph: '⚡',
    complexity: 5,
    target: 'Four different-spot catches and a miss penalty of at least -3, all inside forever.',
    narrator: "Chase Canyon gets meaner: the edge now costs you three whole points.",
    steps: const ['Keep four different-spot catches inside forever.', 'Make the miss penalty -3 or worse.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100, sound: true),
        ..._catchSeq(-150, 100, sound: true),
        ..._catchSeq(-150, -100, sound: true),
        ..._catchSeq(150, -100, sound: true),
        BlockInstance('motion_if_on_edge_bounce'),
        BlockInstance('variables_change', inputs: {'value': -3}),
        BlockInstance('looks_say', inputs: {'text': 'Harsh!'}),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 4, requireMissPenalty: true);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      final worstPenalty = _byId(inside, 'variables_change')
          .map((b) => _numInput(b, 'value'))
          .where((v) => v < 0)
          .fold<num>(0, (a, b) => b < a ? b : a);
      if (worstPenalty > -3) {
        return const LessonResult(false, 'Make the miss penalty at least -3 Score.');
      }
      return const LessonResult(true, 'The canyon plays for keeps now. ⚡');
    },
  ),
  Lesson(
    id: 1076,
    topicId: 'combo-chaser',
    title: 'Reset, Risk, Repeat Forever',
    glyph: '🔄',
    complexity: 5,
    target: 'Set Score to 0, show, then run forever with 4+ catches, sound, AND the miss penalty.',
    narrator: "Every piece of the game, in the right order: reset, show, then the endless risky chase.",
    steps: const ["Order: 'set Score to 0' → 'show' → forever loop.", 'Inside forever: 4+ different-spot catches with sound and the miss penalty.'],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('looks_show'),
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100, sound: true),
        ..._catchSeq(-150, 100, sound: true),
        ..._catchSeq(-150, -100, sound: true),
        ..._catchSeq(150, -100, sound: true),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_set', 'looks_show') || !_before(flat, 'looks_show', 'control_forever')) {
        return const LessonResult(false, 'Order: set Score to 0 → show → forever loop.');
      }
      return _checkForeverCatches(script, minCatches: 4, requireMissPenalty: true, requireSound: true);
    },
  ),
  Lesson(
    id: 1077,
    topicId: 'combo-chaser',
    title: 'Six-Target Gauntlet',
    glyph: '🏔️',
    complexity: 5,
    target: 'Six different-spot catches with unique say text, sound, AND the miss penalty in one forever loop.',
    narrator: "The full gauntlet: six targets scattered wide, each one celebrated differently, with real risk baked in.",
    steps: const ['Fit six different-spot catches with sound and unique say text.', 'Add the edge obstacle with its Score penalty.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100, say: 'North!', sound: true),
        ..._catchSeq(-150, 100, say: 'West!', sound: true),
        ..._catchSeq(-150, -100, say: 'South!', sound: true),
        ..._catchSeq(150, -100, say: 'East!', sound: true),
        ..._catchSeq(0, 140, say: 'Center high!', sound: true),
        ..._catchSeq(0, -140, say: 'Center low!', sound: true),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 6, requireMissPenalty: true, requireSound: true);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      final texts = _byId(inside, 'looks_say').map((b) => b.inputs['text'] as String? ?? '').toSet();
      if (texts.length < 6) {
        return const LessonResult(false, 'Give each of the six catches its OWN unique say message.');
      }
      return const LessonResult(true, 'Six targets, six victories — a true gauntlet. 🏔️');
    },
  ),
  Lesson(
    id: 1078,
    topicId: 'combo-chaser',
    title: 'Control-Block Canyon',
    glyph: '🎛️',
    complexity: 5,
    target: "Rebuild the miss penalty using 'if on edge' (Control) instead of the auto-bounce, with 4+ catches.",
    narrator: "One more variation on the obstacle: swap in the Control 'if on edge' block for the whole penalty.",
    steps: const ['Keep 4+ different-spot catches with sound inside forever.', "Put the negative Score change + say inside an 'if on edge' block."],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100, sound: true),
        ..._catchSeq(-150, 100, sound: true),
        ..._catchSeq(-150, -100, sound: true),
        ..._catchSeq(150, -100, sound: true),
        BlockInstance('control_if_on_edge', body: [..._missSeq()]),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 4, requireSound: true);
      if (!r.ok) return r;
      final inside = script.where((b) => b.defId == 'control_forever').first.body;
      final ifEdge = inside.where((b) => b.defId == 'control_if_on_edge').toList();
      if (ifEdge.isEmpty) {
        return const LessonResult(false, "Use the 'if on edge' block (Control) for the miss penalty this time.");
      }
      final penaltyBody = cqFlatten(ifEdge.first.body);
      if (_countNegativeChanges(penaltyBody) < 1 || !penaltyBody.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Inside 'if on edge', add a NEGATIVE Score change AND a say block.");
      }
      return const LessonResult(true, 'The edge check, fully under your control. 🎛️');
    },
  ),
  Lesson(
    id: 1079,
    topicId: 'combo-chaser',
    title: 'Five-Point Escalation',
    glyph: '🌡️',
    complexity: 5,
    target: 'Five catches, sound, unique say text, AND a miss penalty of -3 or worse, all in one forever loop.',
    narrator: "Almost the final round — every mechanic escalated: five targets, full feedback, and a harsh miss.",
    steps: const ['Keep five different-spot catches with sound and unique say.', 'Make the miss penalty -3 or worse.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100, say: 'First!', sound: true),
        ..._catchSeq(-150, 100, say: 'Second!', sound: true),
        ..._catchSeq(-150, -100, say: 'Third!', sound: true),
        ..._catchSeq(150, -100, say: 'Fourth!', sound: true),
        ..._catchSeq(0, 140, say: 'Fifth!', sound: true),
        BlockInstance('motion_if_on_edge_bounce'),
        BlockInstance('variables_change', inputs: {'value': -3}),
        BlockInstance('looks_say', inputs: {'text': 'That really cost you!'}),
      ]),
    ],
    check: (script) {
      final r = _checkForeverCatches(script, minCatches: 5, requireMissPenalty: true, requireSound: true);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      final texts = _byId(inside, 'looks_say').map((b) => b.inputs['text'] as String? ?? '').toSet();
      if (texts.length < 6) {
        return const LessonResult(false, 'Give every catch AND the miss its own unique say message (6+ total).');
      }
      final worstPenalty = _byId(inside, 'variables_change')
          .map((b) => _numInput(b, 'value'))
          .where((v) => v < 0)
          .fold<num>(0, (a, b) => b < a ? b : a);
      if (worstPenalty > -3) {
        return const LessonResult(false, 'Make the miss penalty at least -3 Score.');
      }
      return const LessonResult(true, 'Everything escalated, everything earned. 🌡️');
    },
  ),
  Lesson(
    id: 1080,
    topicId: 'combo-chaser',
    title: 'Chase Canyon: Complete',
    glyph: '🏆',
    complexity: 5,
    target: 'The full catching game: reset, show, forever loop with 5+ catches, sound, unique cheers, AND the miss penalty.',
    narrator: "This is it — the whole game, start to finish. Reset the board, show yourself, and let the endless chase run with every mechanic you've built.",
    steps: const [
      "Order: 'set Score to 0' → 'show' → forever loop.",
      'Inside forever: 5+ different-spot catches, each with sound and a unique say.',
      "Add 'if on edge, bounce' (or 'if on edge') paired with a negative Score change and a say for the miss.",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('looks_show'),
      BlockInstance('control_forever', body: [
        ..._catchSeq(150, 100, say: 'North target!', sound: true),
        ..._catchSeq(-150, 100, say: 'West target!', sound: true),
        ..._catchSeq(-150, -100, say: 'South target!', sound: true),
        ..._catchSeq(150, -100, say: 'East target!', sound: true),
        ..._catchSeq(0, 140, say: 'Center target!', sound: true),
        BlockInstance('motion_if_on_edge_bounce'),
        ..._missSeq(say: 'Bounced off the edge — missed it!'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_set', 'looks_show') || !_before(flat, 'looks_show', 'control_forever')) {
        return const LessonResult(false, 'Order: set Score to 0 → show → forever loop.');
      }
      final sets = _byId(flat, 'variables_set');
      if (sets.isEmpty || _numInput(sets.first, 'value') != 0) {
        return const LessonResult(false, 'Set Score to exactly 0 at the start.');
      }
      final r = _checkForeverCatches(script, minCatches: 5, requireMissPenalty: true, requireSound: true);
      if (!r.ok) return r;
      final inside = cqFlatten(script.where((b) => b.defId == 'control_forever').first.body);
      final texts = _byId(inside, 'looks_say').map((b) => b.inputs['text'] as String? ?? '').toSet();
      if (texts.length < 6) {
        return const LessonResult(false, 'Give every catch AND the miss its own unique say message (6+ total).');
      }
      return const LessonResult(true, 'Chase Canyon complete — you built the whole catching game! 🏆🎯♾️');
    },
  ),
];
