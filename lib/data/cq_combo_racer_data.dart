import '../models/cq_models.dart';
import 'cq_blocks.dart';

/// "Build a Racing Game" — Racetrack Ridge. This is the CAPSTONE topic: it
/// combines everything from Motion, Control, Looks, Sound and Variables into
/// a single continuously-rolling "race" — Process the turtle laps a track,
/// bounces off the walls, tracks laps/speed with the one project variable,
/// and calls out the action with say/sound. There's no multi-sprite or
/// checkpoint system in this engine, so "racing" here means: one turtle,
/// forever motion, edge-bouncing, and a variable-driven scoreboard.
///
/// Lessons 961-975 (complexity 2-3): re-establish the core moves needed for
/// a race — rolling forward, turning, bouncing, pausing, announcing, and the
/// first touches of the Score variable.
/// Lessons 976-1000 (complexity 3-4): combine forever/repeat containers with
/// bounce + variable counting + say/sound, and build acceleration patterns.
/// Lessons 1001-1020 (complexity 4-5): full multi-feature race scripts,
/// nested containers for laps, and the final capstone "Ultimate Race".

/// Finds the first direct child in [list] with defId [defId] (does not
/// recurse into bodies) — use this to grab a specific nested container.
BlockInstance? _child(List<BlockInstance> list, String defId) {
  for (final b in list) {
    if (b.defId == defId) return b;
  }
  return null;
}

/// All direct children in [list] with defId [defId] (no recursion).
List<BlockInstance> _children(List<BlockInstance> list, String defId) =>
    list.where((b) => b.defId == defId).toList();

/// True if a block with defId [a] appears before a block with defId [b] in
/// the flattened script (by first occurrence of each).
bool _before(List<BlockInstance> flat, String a, String b) {
  final ia = flat.indexWhere((x) => x.defId == a);
  final ib = flat.indexWhere((x) => x.defId == b);
  return ia != -1 && ib != -1 && ia < ib;
}

num _numInput(BlockInstance b, String key) => (b.inputs[key] as num?) ?? 0;

int _countOf(List<BlockInstance> flat, String defId) =>
    flat.where((b) => b.defId == defId).length;

final cqComboRacerLessons = <Lesson>[
  // ---------------------------------------------------------------------
  // 961-975: complexity 2-3 — core race moves
  // ---------------------------------------------------------------------
  Lesson(
    id: 961,
    topicId: 'combo-racer',
    title: 'Rev the Engine',
    glyph: '🏎️',
    complexity: 2,
    target: 'Get Process rolling forward onto Racetrack Ridge.',
    narrator: "Welcome to Racetrack Ridge! Before anything fancy, let's just get me rolling.",
    steps: const ["Add a 'move steps' block (Motion).", 'Set the number above 0.', 'Tap Run and watch me roll onto the track.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final move = flat.where((b) => b.defId == 'motion_move_steps').toList();
      if (move.isEmpty) return const LessonResult(false, "Add a 'move steps' block from Motion.");
      if (_numInput(move.first, 'steps') <= 0) {
        return const LessonResult(false, 'Set the move block to a positive number of steps.');
      }
      return const LessonResult(true, "Engines on — I'm rolling onto the track! 🏎️");
    },
  ),
  Lesson(
    id: 962,
    topicId: 'combo-racer',
    title: 'Steer the Wheel',
    glyph: '↻',
    complexity: 2,
    target: 'Move, then turn — the first corner of the track.',
    narrator: "A racetrack isn't a straight line. Let's take our first corner.",
    steps: const ["Add 'move 10 steps'.", "Add a 'turn' block (Motion) after it."],
    starter: () => [BlockInstance('motion_move_steps', inputs: {'steps': 10})],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Keep a 'move steps' block in your script.");
      }
      if (!_before(flat, 'motion_move_steps', 'motion_turn_right') &&
          !_before(flat, 'motion_move_steps', 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block (Motion) right after the move block.");
      }
      return const LessonResult(true, 'First corner cleared! ↻');
    },
  ),
  Lesson(
    id: 963,
    topicId: 'combo-racer',
    title: 'Point at the Starting Line',
    glyph: '🧭',
    complexity: 2,
    target: 'Aim Process exactly down the track before the race starts.',
    narrator: "Racers line up facing the exact same way. Let's aim me precisely.",
    steps: const ["Add 'point in direction' (Motion).", 'Set an exact heading, then Run.'],
    starter: () => [],
    check: (script) {
      if (!cqHas(script, 'motion_point_direction')) {
        return const LessonResult(false, "Add a 'point in direction' block.");
      }
      return const LessonResult(true, 'Lined up dead straight down the track. 🧭');
    },
  ),
  Lesson(
    id: 964,
    topicId: 'combo-racer',
    title: 'Diagonal Shortcut',
    glyph: '↔️',
    complexity: 2,
    target: 'Cut across the track diagonally with x and y changes.',
    narrator: "Sometimes the fastest line across the track is diagonal.",
    steps: const ["Add 'change x by 10' (Motion).", "Add 'change y by 10' (Motion)."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_change_x')) {
        return const LessonResult(false, "Add a 'change x by' block.");
      }
      if (!flat.any((b) => b.defId == 'motion_change_y')) {
        return const LessonResult(false, "Add a 'change y by' block too.");
      }
      return const LessonResult(true, 'Nice diagonal shortcut across the track! ↔️');
    },
  ),
  Lesson(
    id: 965,
    topicId: 'combo-racer',
    title: 'Straight to the Grid',
    glyph: '📍',
    complexity: 2,
    target: 'Teleport Process to an exact spot on the starting grid.',
    narrator: "Every race starts from a fixed grid position. Let's snap me there instantly.",
    steps: const ["Add 'go to x y' (Motion).", 'Set both numbers, then Run.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Add a 'go to x: y:' block.");
      }
      return const LessonResult(true, "Parked right on the starting grid! 📍");
    },
  ),
  Lesson(
    id: 966,
    topicId: 'combo-racer',
    title: 'Keep on Rolling',
    glyph: '🔁',
    complexity: 3,
    target: 'Make Process roll forward forever, lap after lap.',
    narrator: "A real race never stops after one move — let's keep me rolling forever.",
    steps: const ["Add a 'forever' block (Control).", "Put 'move steps' inside it."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      return const LessonResult(true, "Rolling forever — that's a race! 🔁");
    },
  ),
  Lesson(
    id: 967,
    topicId: 'combo-racer',
    title: 'Track Wall Bounce',
    glyph: '🏓',
    complexity: 3,
    target: 'Bounce cleanly off the track walls instead of driving off the edge.',
    narrator: "The track has walls — let's bounce off them instead of flying into the crowd.",
    steps: const ["Inside the forever loop, keep 'move steps'.", "Add 'if on edge, bounce' (Motion) right after it."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Keep a 'move steps' block inside the forever loop.");
      }
      if (!_before(inside, 'motion_move_steps', 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Add 'if on edge, bounce' right after the move block, inside forever.");
      }
      return const LessonResult(true, 'Bouncing clean off the track walls! 🏓');
    },
  ),
  Lesson(
    id: 968,
    topicId: 'combo-racer',
    title: 'Pit Stop Pause',
    glyph: '🛑',
    complexity: 3,
    target: 'Add a short pit-stop pause inside the racing loop.',
    narrator: "Even racers need a quick pit stop. Let's add a wait inside the loop.",
    steps: const ["Inside forever, keep move + bounce.", "Add 'wait seconds' (Control) somewhere inside forever too."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Keep 'move steps' inside the forever loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Keep 'if on edge, bounce' inside the forever loop.");
      }
      final wait = inside.where((b) => b.defId == 'control_wait').toList();
      if (wait.isEmpty) return const LessonResult(false, "Add a 'wait seconds' block inside the forever loop.");
      if (_numInput(wait.first, 'seconds') <= 0) {
        return const LessonResult(false, 'Set the wait to more than 0 seconds.');
      }
      return const LessonResult(true, 'A quick pit stop, then back on the track! 🛑');
    },
  ),
  Lesson(
    id: 969,
    topicId: 'combo-racer',
    title: 'Announce the Start',
    glyph: '💬',
    complexity: 3,
    target: 'Have Process say something before the race begins.',
    narrator: "Every good race needs an announcer. Let's have me shout something first.",
    steps: const ["Add a 'say' block (Looks) before your forever loop.", 'Give it racing words!'],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final say = flat.where((b) => b.defId == 'looks_say').toList();
      if (say.isEmpty) return const LessonResult(false, "Add a 'say' block (Looks).");
      final text = (say.first.inputs['text'] as String?) ?? '';
      if (text.trim().isEmpty) return const LessonResult(false, 'Give the say block some words!');
      if (!_before(flat, 'looks_say', 'control_forever')) {
        return const LessonResult(false, "Put the 'say' block before the forever loop.");
      }
      return const LessonResult(true, 'And they\'re off! 💬');
    },
  ),
  Lesson(
    id: 970,
    topicId: 'combo-racer',
    title: 'Engine Sound',
    glyph: '🔊',
    complexity: 3,
    target: 'Play an engine sound before the race starts.',
    narrator: "What's a race without engine noise? Let's play a sound at the start.",
    steps: const ["Add 'play sound' (Sound) before your forever loop."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block (Sound).");
      }
      if (!_before(flat, 'sound_play_click', 'control_forever')) {
        return const LessonResult(false, "Put the 'play sound' block before the forever loop.");
      }
      return const LessonResult(true, 'Vroom! Engines are running. 🔊');
    },
  ),
  Lesson(
    id: 971,
    topicId: 'combo-racer',
    title: 'Show Your Ride',
    glyph: '👀',
    complexity: 2,
    target: 'Make sure Process is visible before the race begins.',
    narrator: "Can't race if nobody can see the car! Let's make sure I'm showing.",
    steps: const ["Add a 'show' block (Looks) at the very start of your script."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (flat.isEmpty || flat.first.defId != 'looks_show') {
        return const LessonResult(false, "Add a 'show' block as the very first block.");
      }
      return const LessonResult(true, 'There I am, ready to race! 👀');
    },
  ),
  Lesson(
    id: 972,
    topicId: 'combo-racer',
    title: 'Ghost Car Reset',
    glyph: '🙈',
    complexity: 3,
    target: 'Hide, teleport to the grid, then reappear — a clean race reset.',
    narrator: "Before a re-race, let's disappear, sneak back to the start line, then reappear.",
    steps: const ["Add 'hide' (Looks).", "Add 'go to x y' (Motion) after it.", "Add 'show' (Looks) last."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'looks_hide')) {
        return const LessonResult(false, "Add a 'hide' block first.");
      }
      if (!flat.any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Add a 'go to x: y:' block after hide.");
      }
      if (!flat.any((b) => b.defId == 'looks_show')) {
        return const LessonResult(false, "Add a 'show' block at the end.");
      }
      if (!_before(flat, 'looks_hide', 'motion_goto_xy') || !_before(flat, 'motion_goto_xy', 'looks_show')) {
        return const LessonResult(false, 'Order matters: hide, then go to x y, then show.');
      }
      return const LessonResult(true, 'Clean reset, back on the grid! 🙈');
    },
  ),
  Lesson(
    id: 973,
    topicId: 'combo-racer',
    title: 'First Speed Reading',
    glyph: '🎛️',
    complexity: 3,
    target: 'Set the Score variable to act as the car\'s starting Speed.',
    narrator: "Let's give this car a Speed reading, using our Score variable.",
    steps: const ["Add 'set Score to' (Variables) before your forever loop.", 'Set it to a small starting number.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final set = flat.where((b) => b.defId == 'variables_set').toList();
      if (set.isEmpty) return const LessonResult(false, "Add a 'set Score to' block (Variables).");
      if (!_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, "Put 'set Score to' before the forever loop.");
      }
      return const LessonResult(true, 'Speed reading locked in! 🎛️');
    },
  ),
  Lesson(
    id: 974,
    topicId: 'combo-racer',
    title: 'Boost the Engine',
    glyph: '⚡',
    complexity: 3,
    target: 'Increase Speed with a change block before hitting the track.',
    narrator: "Let's give the engine a boost before we roll — change that Speed upward.",
    steps: const ["Keep 'set Score to' before forever.", "Add 'change Score by' (Variables) after it, still before forever."],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 1}),
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'variables_set')) {
        return const LessonResult(false, "Keep a 'set Score to' block in your script.");
      }
      final change = flat.where((b) => b.defId == 'variables_change').toList();
      if (change.isEmpty) return const LessonResult(false, "Add a 'change Score by' block (Variables).");
      if (!_before(flat, 'variables_set', 'variables_change')) {
        return const LessonResult(false, "Put 'change Score by' after 'set Score to'.");
      }
      if (!_before(flat, 'variables_change', 'control_forever')) {
        return const LessonResult(false, 'Boost the engine before the forever loop starts.');
      }
      return const LessonResult(true, 'Boosted! Feel that extra speed. ⚡');
    },
  ),
  Lesson(
    id: 975,
    topicId: 'combo-racer',
    title: 'Grid, Set, Go',
    glyph: '🚦',
    complexity: 3,
    target: 'Combine show, point direction, and a move into a start sequence.',
    narrator: "Grid... set... GO! Let's chain a real start sequence together.",
    steps: const ["Add 'show' (Looks).", "Add 'point in direction' (Motion).", "Add 'move steps' (Motion) last."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'looks_show')) {
        return const LessonResult(false, "Add a 'show' block first.");
      }
      if (!flat.any((b) => b.defId == 'motion_point_direction')) {
        return const LessonResult(false, "Add a 'point in direction' block.");
      }
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block.");
      }
      if (!_before(flat, 'looks_show', 'motion_point_direction') ||
          !_before(flat, 'motion_point_direction', 'motion_move_steps')) {
        return const LessonResult(false, 'Order matters: show, then point, then move.');
      }
      return const LessonResult(true, 'Grid, set, GO! 🚦');
    },
  ),

  // ---------------------------------------------------------------------
  // 976-1000: complexity 3-4 — laps, sound, acceleration
  // ---------------------------------------------------------------------
  Lesson(
    id: 976,
    topicId: 'combo-racer',
    title: 'Lap Counter Setup',
    glyph: '🏁',
    complexity: 3,
    target: "Zero out a lap counter before the race, using Score.",
    narrator: "Before every race we zero the lap counter. Let's set Score to 0.",
    steps: const ["Add 'set Score to 0' (Variables) before your forever loop."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final set = flat.where((b) => b.defId == 'variables_set').toList();
      if (set.isEmpty) return const LessonResult(false, "Add a 'set Score to' block.");
      if (_numInput(set.first, 'value') != 0) {
        return const LessonResult(false, 'Set Score to exactly 0 to start the lap counter.');
      }
      if (!_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, 'Zero the counter before the forever loop.');
      }
      return const LessonResult(true, 'Lap counter zeroed. Ready to race! 🏁');
    },
  ),
  Lesson(
    id: 977,
    topicId: 'combo-racer',
    title: 'Counting Every Roll',
    glyph: '➕',
    complexity: 3,
    target: 'Change Score inside the forever loop so it keeps climbing.',
    narrator: "Let's track progress every time around the loop — change Score inside forever.",
    steps: const ["Keep move + bounce inside forever.", "Add 'change Score by 1' (Variables) inside forever too."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Keep 'move steps' inside forever.");
      }
      if (!inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Keep 'if on edge, bounce' inside forever.");
      }
      final change = inside.where((b) => b.defId == 'variables_change').toList();
      if (change.isEmpty) return const LessonResult(false, "Add a 'change Score by' block inside forever.");
      return const LessonResult(true, "Score's climbing every trip around! ➕");
    },
  ),
  Lesson(
    id: 978,
    topicId: 'combo-racer',
    title: 'Bounce & Count',
    glyph: '🧱',
    complexity: 3,
    target: 'Count Score right after every wall bounce, in order.',
    narrator: "Let's make the counter go up right after I bounce off a wall — order matters!",
    steps: const ["Inside forever: move, then bounce, then change Score by 1, in that order."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
        BlockInstance('variables_change', inputs: {'value': 1}),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!_before(inside, 'motion_move_steps', 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, 'Move before bounce, inside forever.');
      }
      if (!_before(inside, 'motion_if_on_edge_bounce', 'variables_change')) {
        return const LessonResult(false, "Change Score right after bouncing off the wall.");
      }
      return const LessonResult(true, 'Every bounce counted, in perfect order! 🧱');
    },
  ),
  Lesson(
    id: 979,
    topicId: 'combo-racer',
    title: 'Call Out Each Lap',
    glyph: '📣',
    complexity: 4,
    target: 'Say something right after the lap counter changes.',
    narrator: "The crowd wants updates! Let's shout out every time the counter changes.",
    steps: const ["Keep move, bounce, and change Score, in order, inside forever.", "Add 'say' (Looks) right after 'change Score by'."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
        BlockInstance('variables_change', inputs: {'value': 1}),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!_before(inside, 'motion_if_on_edge_bounce', 'variables_change')) {
        return const LessonResult(false, 'Keep bounce before change Score, inside forever.');
      }
      final say = inside.where((b) => b.defId == 'looks_say').toList();
      if (say.isEmpty) return const LessonResult(false, "Add a 'say' block inside forever.");
      if (!_before(inside, 'variables_change', 'looks_say')) {
        return const LessonResult(false, "Put 'say' right after 'change Score by'.");
      }
      return const LessonResult(true, 'The crowd hears every update! 📣');
    },
  ),
  Lesson(
    id: 980,
    topicId: 'combo-racer',
    title: 'Horn on the Wall',
    glyph: '📢',
    complexity: 4,
    target: 'Honk a sound every time Process bounces off a wall.',
    narrator: "Let's honk the horn every time I clip a wall — safety first!",
    steps: const ["Keep move + bounce inside forever.", "Add 'play sound' (Sound) right after the bounce block."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Keep 'if on edge, bounce' inside forever.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside forever.");
      }
      if (!_before(inside, 'motion_if_on_edge_bounce', 'sound_play_click')) {
        return const LessonResult(false, "Play the sound right after the bounce.");
      }
      return const LessonResult(true, 'Honk! Every wall gets a horn now. 📢');
    },
  ),
  Lesson(
    id: 981,
    topicId: 'combo-racer',
    title: 'Racing Repeat',
    glyph: '🔂',
    complexity: 3,
    target: 'Use repeat to power through a straightaway a fixed number of times.',
    narrator: "Not every stretch needs forever — sometimes a fixed straightaway is enough.",
    steps: const ["Add a 'repeat' block (Control).", "Put 'move steps' inside it.", 'Set repeat to more than 1.'],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block (Control).");
      if (_numInput(repeat, 'times') <= 1) {
        return const LessonResult(false, 'Set repeat to more than 1 time.');
      }
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the repeat block.");
      }
      return const LessonResult(true, 'Straightaway cleared with a clean repeat! 🔂');
    },
  ),
  Lesson(
    id: 982,
    topicId: 'combo-racer',
    title: 'Straightaway Sprint',
    glyph: '💨',
    complexity: 4,
    target: 'Simulate speeding up with two increasing move blocks inside a repeat.',
    narrator: "Real racers accelerate — let's put two move blocks in the repeat, second one faster.",
    steps: const ["Inside a repeat block, add 'move steps' twice.", 'Make the second move block\'s steps bigger than the first.'],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 5}),
      ]),
    ],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      final moves = _children(repeat.body, 'motion_move_steps');
      if (moves.length < 2) {
        return const LessonResult(false, "Add two 'move steps' blocks inside the repeat.");
      }
      if (!(_numInput(moves[1], 'steps') > _numInput(moves[0], 'steps'))) {
        return const LessonResult(false, "Make the second move block's steps bigger than the first — that's acceleration!");
      }
      return const LessonResult(true, "Feel that acceleration through the straightaway! 💨");
    },
  ),
  Lesson(
    id: 983,
    topicId: 'combo-racer',
    title: 'Acceleration Sequence',
    glyph: '🚀',
    complexity: 4,
    target: 'Chain three move blocks with climbing step counts.',
    narrator: "Let's really feel the acceleration: three moves, each faster than the last.",
    steps: const ["Add three 'move steps' blocks in a row.", 'Make each one bigger than the last.'],
    starter: () => [
      BlockInstance('motion_move_steps', inputs: {'steps': 5}),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final moves = flat.where((b) => b.defId == 'motion_move_steps').toList();
      if (moves.length < 3) return const LessonResult(false, "Add three 'move steps' blocks in a row.");
      final a = _numInput(moves[0], 'steps');
      final b = _numInput(moves[1], 'steps');
      final c = _numInput(moves[2], 'steps');
      if (!(a < b && b < c)) {
        return const LessonResult(false, 'Each move should have more steps than the one before it.');
      }
      return const LessonResult(true, 'Zero to full throttle in three moves! 🚀');
    },
  ),
  Lesson(
    id: 984,
    topicId: 'combo-racer',
    title: 'Chicane Challenge',
    glyph: '🌀',
    complexity: 4,
    target: 'Weave through an S-curve chicane using turns and moves.',
    narrator: "This next bit of track zig-zags. Let's alternate turning left and right.",
    steps: const ["Add 'move', 'turn left', 'move', 'turn right' in that order."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn left' block.");
      }
      if (!flat.any((b) => b.defId == 'motion_turn_right')) {
        return const LessonResult(false, "Add a 'turn right' block too.");
      }
      final moveCount = _countOf(flat, 'motion_move_steps');
      if (moveCount < 2) {
        return const LessonResult(false, 'Weave with at least two move blocks between the turns.');
      }
      if (!_before(flat, 'motion_turn_left', 'motion_turn_right') &&
          !_before(flat, 'motion_turn_right', 'motion_turn_left')) {
        return const LessonResult(false, 'Add both a left and a right turn to make the S-curve.');
      }
      return const LessonResult(true, 'Chicane cleared without clipping a wall! 🌀');
    },
  ),
  Lesson(
    id: 985,
    topicId: 'combo-racer',
    title: 'Track Wall Physics',
    glyph: '🧱',
    complexity: 4,
    target: "Use 'if on edge' to react to the wall your own way, without auto-bounce.",
    narrator: "Let's try the manual wall check — 'if on edge' — and decide what happens ourselves.",
    steps: const ["Add an 'if on edge' block (Control).", "Put a 'turn' block inside it."],
    starter: () => [],
    check: (script) {
      final ifEdge = _child(script, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Add an 'if on edge' block (Control).");
      final inside = cqFlatten(ifEdge.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, 'Handled that wall entirely on our own terms! 🧱');
    },
  ),
  Lesson(
    id: 986,
    topicId: 'combo-racer',
    title: 'Bounce with Style',
    glyph: '✨',
    complexity: 4,
    target: 'Combine move, bounce, and a honk into one loop.',
    narrator: "Let's bounce off walls in style — with a honk every time.",
    steps: const ["Inside forever: move, then bounce, then play sound, in that order."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!_before(inside, 'motion_move_steps', 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, 'Move, then bounce, inside forever.');
      }
      if (!_before(inside, 'motion_if_on_edge_bounce', 'sound_play_click')) {
        return const LessonResult(false, 'Play the sound right after bouncing.');
      }
      return const LessonResult(true, 'Bouncing off the walls in style! ✨');
    },
  ),
  Lesson(
    id: 987,
    topicId: 'combo-racer',
    title: 'Pit Row Cadence',
    glyph: '🔧',
    complexity: 4,
    target: 'Combine a repeat straightaway with a wait, inside forever.',
    narrator: "Let's build a lap rhythm: a burst of straight moves, then a short breather.",
    steps: const ["Inside forever, add a 'repeat' block with move inside it.", "Add 'wait seconds' after the repeat, still inside forever.", "Add 'if on edge, bounce' too."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 3}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block inside forever.");
      final repeatInside = cqFlatten(repeat.body);
      if (!repeatInside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the repeat block.");
      }
      final foreverInside = cqFlatten(forever.body);
      if (!foreverInside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Add a 'wait seconds' block inside forever, after the repeat.");
      }
      if (!foreverInside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Add 'if on edge, bounce' inside forever too.");
      }
      return const LessonResult(true, 'A lap rhythm any pit crew would be proud of! 🔧');
    },
  ),
  Lesson(
    id: 988,
    topicId: 'combo-racer',
    title: 'Nested Speed Boost',
    glyph: '🌪️',
    complexity: 4,
    target: 'Give the car a burst of speed with a repeat inside forever, plus bouncing.',
    narrator: "Let's give the engine a burst — a fast repeat of moves nested right inside forever.",
    steps: const ["Inside forever, add a 'repeat' with a big 'move steps' value inside it.", "Add 'if on edge, bounce' inside forever too."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 2}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 20}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block inside forever.");
      final move = _child(cqFlatten(repeat.body), 'motion_move_steps');
      if (move == null) return const LessonResult(false, "Put 'move steps' inside the repeat block.");
      if (_numInput(move, 'steps') < 15) {
        return const LessonResult(false, 'Make the move steps at least 15 for a real speed burst.');
      }
      final foreverInside = cqFlatten(forever.body);
      if (!foreverInside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Add 'if on edge, bounce' inside forever too.");
      }
      return const LessonResult(true, 'Turbo burst engaged — and still bouncing clean! 🌪️');
    },
  ),
  Lesson(
    id: 989,
    topicId: 'combo-racer',
    title: 'Lap Announcement Combo',
    glyph: '🎙️',
    complexity: 4,
    target: 'Combine move, bounce, counting, and an announcement in one loop.',
    narrator: "Let's put it all together: roll, bounce, count the lap, then shout about it.",
    steps: const ["Zero Score before forever.", "Inside forever: move, bounce, change Score by 1, then say — in that order."],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
        BlockInstance('variables_change', inputs: {'value': 1}),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final set = flat.where((b) => b.defId == 'variables_set').toList();
      if (set.isEmpty || !_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, "Zero Score with 'set Score to 0' before the forever loop.");
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!_before(inside, 'motion_move_steps', 'motion_if_on_edge_bounce') ||
          !_before(inside, 'motion_if_on_edge_bounce', 'variables_change') ||
          !_before(inside, 'variables_change', 'looks_say')) {
        return const LessonResult(false, 'Order inside forever: move, bounce, change Score, then say.');
      }
      return const LessonResult(true, 'Every lap rolled, bounced, counted, and announced! 🎙️');
    },
  ),
  Lesson(
    id: 990,
    topicId: 'combo-racer',
    title: 'Victory Lap Sound',
    glyph: '🎉',
    complexity: 4,
    target: 'Add a celebration sound right after each lap gets counted.',
    narrator: "Every counted lap deserves a little fanfare. Let's honk right after counting.",
    steps: const ["Keep move, bounce, change Score inside forever.", "Add 'play sound' right after 'change Score by'."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
        BlockInstance('variables_change', inputs: {'value': 1}),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Keep 'change Score by' inside forever.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside forever.");
      }
      if (!_before(inside, 'variables_change', 'sound_play_click')) {
        return const LessonResult(false, "Play the sound right after 'change Score by'.");
      }
      return const LessonResult(true, 'Fanfare for every lap! 🎉');
    },
  ),
  Lesson(
    id: 991,
    topicId: 'combo-racer',
    title: 'Speed Readout',
    glyph: '📈',
    complexity: 4,
    target: 'Keep Score climbing continuously as a live speed readout.',
    narrator: "Let's make Score behave like a live speedometer — climbing every trip around the loop.",
    steps: const ["Set Score to a small starting number before forever.", "Inside forever, add 'change Score by' after the move block."],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 1}),
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, 'Set a starting Score value before the forever loop.');
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!_before(inside, 'motion_move_steps', 'variables_change')) {
        return const LessonResult(false, "Add 'change Score by' after the move block, inside forever.");
      }
      return const LessonResult(true, 'Speedometer climbing lap after lap! 📈');
    },
  ),
  Lesson(
    id: 992,
    topicId: 'combo-racer',
    title: 'Turbo Trigger',
    glyph: '🔋',
    complexity: 4,
    target: 'Boost Score several times in a repeat before the race loop begins.',
    narrator: "Time for a pre-race turbo trigger — pump Score up several times before we roll.",
    steps: const ["Add a 'repeat' block set to 3 or more.", "Inside it, add 'change Score by' (Variables).", 'Keep your forever race loop after the repeat.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block before your forever loop.");
      if (_numInput(repeat, 'times') < 3) {
        return const LessonResult(false, 'Set repeat to at least 3 times for a real turbo trigger.');
      }
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Add a 'change Score by' block inside the repeat.");
      }
      final flat = cqFlatten(script);
      if (!_before(flat, 'control_repeat', 'control_forever')) {
        return const LessonResult(false, 'Put the turbo repeat before the forever race loop.');
      }
      return const LessonResult(true, 'Turbo triggered — Score is way up! 🔋');
    },
  ),
  Lesson(
    id: 993,
    topicId: 'combo-racer',
    title: 'Multi-Corner Track',
    glyph: '🛣️',
    complexity: 3,
    target: 'Chain three corners together with alternating turns.',
    narrator: "This part of the track has three corners in a row. Let's chain them all.",
    steps: const ["Add 'move', 'turn', 'move', 'turn', 'move', 'turn' — six blocks total."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final moveCount = _countOf(flat, 'motion_move_steps');
      final turnCount = _countOf(flat, 'motion_turn_right') + _countOf(flat, 'motion_turn_left');
      if (moveCount < 3) return const LessonResult(false, "Add at least three 'move steps' blocks.");
      if (turnCount < 3) return const LessonResult(false, "Add at least three turn blocks.");
      return const LessonResult(true, 'Three corners, cleanly chained! 🛣️');
    },
  ),
  Lesson(
    id: 994,
    topicId: 'combo-racer',
    title: 'The Whole Grid',
    glyph: '🏟️',
    complexity: 4,
    target: 'Set up the full starting grid, then start racing.',
    narrator: "Let's build the complete pre-race setup: position, direction, visibility, then go.",
    steps: const ["Add 'go to x y', 'point in direction', and 'show' before your forever loop.", 'Keep move + bounce inside forever.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Add a 'go to x: y:' block.");
      }
      if (!flat.any((b) => b.defId == 'motion_point_direction')) {
        return const LessonResult(false, "Add a 'point in direction' block.");
      }
      if (!flat.any((b) => b.defId == 'looks_show')) {
        return const LessonResult(false, "Add a 'show' block.");
      }
      if (!_before(flat, 'motion_goto_xy', 'control_forever') ||
          !_before(flat, 'motion_point_direction', 'control_forever') ||
          !_before(flat, 'looks_show', 'control_forever')) {
        return const LessonResult(false, 'All grid setup blocks must come before the forever loop.');
      }
      return const LessonResult(true, 'The whole grid is set — let the race begin! 🏟️');
    },
  ),
  Lesson(
    id: 995,
    topicId: 'combo-racer',
    title: 'Final Countdown',
    glyph: '⏱️',
    complexity: 4,
    target: 'Count down out loud before the race starts.',
    narrator: "Every great race needs a countdown. Let's say three things before we roll.",
    steps: const ["Add three 'say' blocks in a row before your forever loop."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final says = flat.where((b) => b.defId == 'looks_say').toList();
      if (says.length < 3) return const LessonResult(false, "Add three 'say' blocks in a row.");
      if (!_before(flat, 'looks_say', 'control_forever')) {
        return const LessonResult(false, 'The countdown must happen before the forever loop.');
      }
      return const LessonResult(true, "3... 2... 1... GO! ⏱️");
    },
  ),
  Lesson(
    id: 996,
    topicId: 'combo-racer',
    title: 'Photo Finish',
    glyph: '📸',
    complexity: 4,
    target: 'Race a fixed number of moves, then announce the finish and vanish.',
    narrator: "This race has a finish line — let's run a fixed sprint, then celebrate and vanish.",
    steps: const ["Add a 'repeat' block with 'move steps' inside.", "After the repeat, add 'say' with a finish message.", "Add 'hide' last."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block for the sprint.");
      if (!cqFlatten(repeat.body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the repeat block.");
      }
      final say = flat.where((b) => b.defId == 'looks_say').toList();
      if (say.isEmpty) return const LessonResult(false, "Add a 'say' block announcing the finish.");
      if (!flat.any((b) => b.defId == 'looks_hide')) {
        return const LessonResult(false, "Add a 'hide' block at the very end.");
      }
      if (!_before(flat, 'control_repeat', 'looks_say') || !_before(flat, 'looks_say', 'looks_hide')) {
        return const LessonResult(false, 'Order: sprint repeat, then say, then hide.');
      }
      return const LessonResult(true, 'Photo finish captured! 📸');
    },
  ),
  Lesson(
    id: 997,
    topicId: 'combo-racer',
    title: 'Two-Lap Simulation',
    glyph: '🔄',
    complexity: 4,
    target: "Loop a square-shaped lap twice using a repeat around move+turn.",
    narrator: "Let's simulate lapping a square track — twice around, using a repeat.",
    steps: const ["Add a 'repeat' set to 2.", "Inside it, add move and turn blocks that make one loop of the track."],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 2}, body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
      ]),
    ],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block.");
      if (_numInput(repeat, 'times') != 2) {
        return const LessonResult(false, 'Set repeat to exactly 2 for a two-lap simulation.');
      }
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add 'move steps' inside the repeat.");
      }
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, 'Add a turn block inside the repeat to complete the loop shape.');
      }
      return const LessonResult(true, 'Two laps down, simulated perfectly! 🔄');
    },
  ),
  Lesson(
    id: 998,
    topicId: 'combo-racer',
    title: 'Race Prep Checklist',
    glyph: '📋',
    complexity: 4,
    target: 'Run the complete pre-race checklist: show, position, direction, zero the counter.',
    narrator: "Real race teams run a checklist before every race. Let's run ours.",
    steps: const ["Before your forever loop, add: 'show', 'go to x y', 'point in direction', and 'set Score to 0' — all four."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Keep a 'forever' block for the race.");
      final needed = ['looks_show', 'motion_goto_xy', 'motion_point_direction', 'variables_set'];
      for (final id in needed) {
        if (!flat.any((b) => b.defId == id)) {
          return LessonResult(false, "Checklist missing: add a '$id' block before the race.");
        }
        if (!_before(flat, id, 'control_forever')) {
          return LessonResult(false, 'Every checklist item must come before the forever loop.');
        }
      }
      return const LessonResult(true, 'Checklist complete — this team is race-ready! 📋');
    },
  ),
  Lesson(
    id: 999,
    topicId: 'combo-racer',
    title: 'Speed-Powered Sprint',
    glyph: '🏆',
    complexity: 4,
    target: 'Set a Speed value, then immediately race with a strong move.',
    narrator: "Let's connect the Speed setting to the race itself — set it, then really move.",
    steps: const ["Add 'set Score to' with a number 5 or higher.", "Add 'move steps' with 15 or more steps right after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final set = flat.where((b) => b.defId == 'variables_set').toList();
      if (set.isEmpty) return const LessonResult(false, "Add a 'set Score to' block.");
      if (_numInput(set.first, 'value') < 5) {
        return const LessonResult(false, 'Set Score to 5 or higher for real speed.');
      }
      final move = flat.where((b) => b.defId == 'motion_move_steps').toList();
      if (move.isEmpty) return const LessonResult(false, "Add a 'move steps' block after setting Score.");
      if (_numInput(move.first, 'steps') < 15) {
        return const LessonResult(false, 'Move at least 15 steps to match that speed.');
      }
      if (!_before(flat, 'variables_set', 'motion_move_steps')) {
        return const LessonResult(false, 'Set the speed before moving.');
      }
      return const LessonResult(true, 'Speed set, and the car matches it! 🏆');
    },
  ),
  Lesson(
    id: 1000,
    topicId: 'combo-racer',
    title: 'Halfway Around the Track',
    glyph: '🎯',
    complexity: 4,
    target: 'Build a full mid-race loop: move, bounce, count, and announce, all inside forever.',
    narrator: "We're halfway through training. Let's prove we can build a complete racing loop.",
    steps: const ["Zero Score before forever.", "Inside forever: move, bounce, change Score by 1, then say, in that exact order."],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, 'Zero Score before the forever loop.');
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      const order = ['motion_move_steps', 'motion_if_on_edge_bounce', 'variables_change', 'looks_say'];
      for (var i = 0; i < order.length - 1; i++) {
        if (!_before(inside, order[i], order[i + 1])) {
          return const LessonResult(false, 'Inside forever, keep this order: move, bounce, change Score, say.');
        }
      }
      return const LessonResult(true, 'A complete racing loop, built from scratch! 🎯');
    },
  ),

  // ---------------------------------------------------------------------
  // 1001-1020: complexity 4-5 — full race scripts, capstone
  // ---------------------------------------------------------------------
  Lesson(
    id: 1001,
    topicId: 'combo-racer',
    title: 'The Real Track Bounce',
    glyph: '🏎️',
    complexity: 4,
    target: 'Race at full speed — a strong move value, bouncing forever.',
    narrator: "Training wheels off. Let's race at real speed, bouncing off every wall.",
    steps: const ["Inside forever: move with at least 15 steps, then bounce."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      final move = _child(inside, 'motion_move_steps');
      if (move == null) return const LessonResult(false, "Put 'move steps' inside forever.");
      if (_numInput(move, 'steps') < 15) {
        return const LessonResult(false, 'Set the move steps to at least 15 for full race speed.');
      }
      if (!inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Keep 'if on edge, bounce' inside forever.");
      }
      return const LessonResult(true, 'Full speed, bouncing clean off every wall! 🏎️');
    },
  ),
  Lesson(
    id: 1002,
    topicId: 'combo-racer',
    title: 'Double Wall Check',
    glyph: '🧱',
    complexity: 4,
    target: 'Check for walls twice per loop — after moving twice.',
    narrator: "Tight corners come fast — let's check for walls twice every trip around the loop.",
    steps: const ["Inside forever, add move+bounce, then another move+bounce — four blocks total."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (_countOf(inside, 'motion_move_steps') < 2) {
        return const LessonResult(false, "Add a second 'move steps' block inside forever.");
      }
      if (_countOf(inside, 'motion_if_on_edge_bounce') < 2) {
        return const LessonResult(false, "Add a second 'if on edge, bounce' block inside forever.");
      }
      return const LessonResult(true, 'Double-checked for walls — no surprises! 🧱');
    },
  ),
  Lesson(
    id: 1003,
    topicId: 'combo-racer',
    title: 'Lap Milestone',
    glyph: '🚩',
    complexity: 4,
    target: 'Zero the counter, then count laps consistently inside the loop.',
    narrator: "Let's lock in a proper lap milestone tracker from start to finish.",
    steps: const ["Set Score to 0 before forever.", "Inside forever: move, bounce, then change Score by 1."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final set = flat.where((b) => b.defId == 'variables_set').toList();
      if (set.isEmpty || _numInput(set.first, 'value') != 0 || !_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, 'Zero Score with a set block before the forever loop.');
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!_before(inside, 'motion_if_on_edge_bounce', 'variables_change')) {
        return const LessonResult(false, "Change Score by 1 after bouncing, inside forever.");
      }
      return const LessonResult(true, 'Lap milestones tracked from lap one! 🚩');
    },
  ),
  Lesson(
    id: 1004,
    topicId: 'combo-racer',
    title: 'Milestone Shoutout',
    glyph: '📯',
    complexity: 4,
    target: 'Announce every counted lap, with the counter properly zeroed first.',
    narrator: "Let's shout out every milestone, right from a properly zeroed counter.",
    steps: const ["Zero Score before forever.", "Inside forever: move, bounce, change Score, then say — full chain."],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final set = flat.where((b) => b.defId == 'variables_set').toList();
      if (set.isEmpty || _numInput(set.first, 'value') != 0) {
        return const LessonResult(false, 'Set Score to exactly 0 before the race.');
      }
      if (!_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, 'Zero the counter before the forever loop.');
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      const order = ['motion_move_steps', 'motion_if_on_edge_bounce', 'variables_change', 'looks_say'];
      for (var i = 0; i < order.length - 1; i++) {
        if (!_before(inside, order[i], order[i + 1])) {
          return const LessonResult(false, 'Inside forever: move, bounce, change Score, then say — in order.');
        }
      }
      return const LessonResult(true, 'Every milestone properly zeroed, counted, and announced! 📯');
    },
  ),
  Lesson(
    id: 1005,
    topicId: 'combo-racer',
    title: 'Turbo Boost Lap',
    glyph: '🔥',
    complexity: 5,
    target: 'Pump Score up at least three times, then race with move and bounce.',
    narrator: "Time for a serious turbo sequence before the lights go green.",
    steps: const ["Add a 'repeat' set to 3 or more, containing 'change Score by'.", "After the repeat, add your forever race loop with move + bounce."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block before the forever loop.");
      if (_numInput(repeat, 'times') < 3) {
        return const LessonResult(false, 'Set repeat to at least 3 for a serious turbo boost.');
      }
      final repeatInside = cqFlatten(repeat.body);
      if (_countOf(repeatInside, 'variables_change') < 1) {
        return const LessonResult(false, "Add 'change Score by' inside the repeat.");
      }
      final flat = cqFlatten(script);
      final forever = _child(script, 'control_forever');
      if (forever == null || !_before(flat, 'control_repeat', 'control_forever')) {
        return const LessonResult(false, 'Follow the turbo repeat with your forever race loop.');
      }
      final foreverInside = cqFlatten(forever.body);
      if (!foreverInside.any((b) => b.defId == 'motion_move_steps') ||
          !foreverInside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, 'Keep move and bounce inside the forever loop.');
      }
      return const LessonResult(true, 'Turbo boosted, then straight into the race! 🔥');
    },
  ),
  Lesson(
    id: 1006,
    topicId: 'combo-racer',
    title: 'Pit Stop Strategy',
    glyph: '🛠️',
    complexity: 4,
    target: 'Add a real pit-stop pause between moves, inside the racing loop.',
    narrator: "Let's plan a smart pit stop right in the middle of the racing loop.",
    steps: const ["Inside forever: move, then wait, then bounce — all three, in order."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      final wait = inside.where((b) => b.defId == 'control_wait').toList();
      if (wait.isEmpty) return const LessonResult(false, "Add a 'wait seconds' block inside forever.");
      if (_numInput(wait.first, 'seconds') <= 0) {
        return const LessonResult(false, 'Set the wait to more than 0 seconds.');
      }
      if (!_before(inside, 'motion_move_steps', 'control_wait')) {
        return const LessonResult(false, 'Move first, then wait, inside forever.');
      }
      if (!_before(inside, 'control_wait', 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, 'Bounce should come after the pit-stop wait.');
      }
      return const LessonResult(true, 'A perfectly timed pit stop strategy! 🛠️');
    },
  ),
  Lesson(
    id: 1007,
    topicId: 'combo-racer',
    title: 'Sound of Speed',
    glyph: '🔊',
    complexity: 4,
    target: 'Combine bounce, sound, and counting in the correct order.',
    narrator: "Let's chain the sound effect right into our lap-counting logic.",
    steps: const ["Inside forever: move, bounce, play sound, then change Score by 1 — in that order."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      const order = ['motion_move_steps', 'motion_if_on_edge_bounce', 'sound_play_click', 'variables_change'];
      for (var i = 0; i < order.length - 1; i++) {
        if (!_before(inside, order[i], order[i + 1])) {
          return const LessonResult(false, 'Order inside forever: move, bounce, play sound, then change Score.');
        }
      }
      return const LessonResult(true, 'Sound and score, perfectly synced! 🔊');
    },
  ),
  Lesson(
    id: 1008,
    topicId: 'combo-racer',
    title: 'The Announcer',
    glyph: '🎤',
    complexity: 5,
    target: 'Combine move, bounce, count, say, and sound — the full loop body.',
    narrator: "Let's give this loop everything an announcer could want: motion, sound, and words.",
    steps: const ["Inside forever, chain: move, bounce, change Score, say, then play sound — five blocks, in that order."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      const order = [
        'motion_move_steps',
        'motion_if_on_edge_bounce',
        'variables_change',
        'looks_say',
        'sound_play_click',
      ];
      for (var i = 0; i < order.length - 1; i++) {
        if (!_before(inside, order[i], order[i + 1])) {
          return const LessonResult(false, 'Chain all five inside forever, in order: move, bounce, change Score, say, play sound.');
        }
      }
      return const LessonResult(true, 'A full broadcast-ready racing loop! 🎤');
    },
  ),
  Lesson(
    id: 1009,
    topicId: 'combo-racer',
    title: 'Grid Start Sequence',
    glyph: '🏁',
    complexity: 5,
    target: 'Build a complete pre-race sequence, then start racing.',
    narrator: "Let's build the whole opening sequence: show, position, aim, countdown, then GO.",
    steps: const ["Before forever, chain: show, go to x y, point in direction, then say (countdown).", 'Keep move + bounce inside forever.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      const order = ['looks_show', 'motion_goto_xy', 'motion_point_direction', 'looks_say', 'control_forever'];
      for (var i = 0; i < order.length - 1; i++) {
        if (!_before(flat, order[i], order[i + 1])) {
          return const LessonResult(
              false, 'Chain in order: show, go to x y, point in direction, say, then the forever race loop.');
        }
      }
      final forever = _child(script, 'control_forever');
      final inside = forever == null ? <BlockInstance>[] : cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps') ||
          !inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, 'Keep move and bounce inside the forever loop.');
      }
      return const LessonResult(true, 'Full grid start sequence, then GO! 🏁');
    },
  ),
  Lesson(
    id: 1010,
    topicId: 'combo-racer',
    title: 'Chicane at Speed',
    glyph: '💫',
    complexity: 4,
    target: 'Race a chicane while accelerating — increasing move steps between turns.',
    narrator: "Let's take this S-curve while actually speeding up through it.",
    steps: const ["Add move, turn, move, turn — with the second move's steps bigger than the first."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final moves = flat.where((b) => b.defId == 'motion_move_steps').toList();
      final turns = flat.where((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left').toList();
      if (moves.length < 2) return const LessonResult(false, "Add at least two 'move steps' blocks.");
      if (turns.length < 2) return const LessonResult(false, 'Add at least two turn blocks.');
      if (!(_numInput(moves[1], 'steps') > _numInput(moves[0], 'steps'))) {
        return const LessonResult(false, 'Make the second move faster than the first — that\'s the acceleration.');
      }
      return const LessonResult(true, 'Accelerating clean through the chicane! 💫');
    },
  ),
  Lesson(
    id: 1011,
    topicId: 'combo-racer',
    title: 'The Two-Lap Track',
    glyph: '🔁',
    complexity: 5,
    target: 'Nest a repeat inside a repeat to simulate two laps of a square track.',
    narrator: "Let's really nest it — a square lap shape, repeated, then that whole thing repeated again for two laps.",
    steps: const ["Add an outer 'repeat' set to 2.", "Inside it, add an inner 'repeat' set to 4, containing move and turn."],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 2}, body: [
        BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 10}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ]),
      ]),
    ],
    check: (script) {
      final outer = _child(script, 'control_repeat');
      if (outer == null) return const LessonResult(false, "Add an outer 'repeat' block.");
      if (_numInput(outer, 'times') != 2) {
        return const LessonResult(false, 'Set the outer repeat to exactly 2 for two laps.');
      }
      final inner = _child(outer.body, 'control_repeat');
      if (inner == null) return const LessonResult(false, "Add an inner 'repeat' block inside the outer one.");
      if (_numInput(inner, 'times') < 3) {
        return const LessonResult(false, 'Set the inner repeat to at least 3 to shape one lap.');
      }
      final innerInside = cqFlatten(inner.body);
      if (!innerInside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add 'move steps' inside the inner repeat.");
      }
      if (!innerInside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, 'Add a turn block inside the inner repeat.');
      }
      return const LessonResult(true, 'Two full laps, nested perfectly! 🔁');
    },
  ),
  Lesson(
    id: 1012,
    topicId: 'combo-racer',
    title: 'Full Circuit',
    glyph: '🛞',
    complexity: 5,
    target: 'Run laps forever, counting each completed circuit.',
    narrator: "Now let's make the circuit never stop — one shaped lap after another, forever, each one counted.",
    steps: const ["Add a 'forever' block.", "Inside it, add a 'repeat' block shaping one lap (move + turn).", "After the inner repeat, still inside forever, add 'change Score by 1'."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 10}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block inside forever, to shape one lap.");
      final repeatInside = cqFlatten(repeat.body);
      if (!repeatInside.any((b) => b.defId == 'motion_move_steps') ||
          !repeatInside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, 'Shape one lap inside the repeat with move and turn blocks.');
      }
      final foreverInside = cqFlatten(forever.body);
      if (!_before(foreverInside, 'control_repeat', 'variables_change')) {
        return const LessonResult(false, "Add 'change Score by 1' inside forever, after the lap-shaping repeat.");
      }
      return const LessonResult(true, 'A full circuit, lap after lap, forever! 🛞');
    },
  ),
  Lesson(
    id: 1013,
    topicId: 'combo-racer',
    title: 'Circuit with Announcer',
    glyph: '📻',
    complexity: 5,
    target: 'Shape a lap, count it, and announce it — every time around forever.',
    narrator: "Let's give the circuit a voice — announce every completed lap.",
    steps: const ["Inside forever: shape one lap with a repeat, then change Score by 1, then say — in that order."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 10}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ]),
        BlockInstance('variables_change', inputs: {'value': 1}),
      ]),
    ],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a lap-shaping 'repeat' inside forever.");
      final foreverInside = cqFlatten(forever.body);
      if (!_before(foreverInside, 'control_repeat', 'variables_change')) {
        return const LessonResult(false, "Change Score after the lap-shaping repeat.");
      }
      if (!_before(foreverInside, 'variables_change', 'looks_say')) {
        return const LessonResult(false, "Say something right after changing Score.");
      }
      return const LessonResult(true, 'The circuit now has a voice — every lap announced! 📻');
    },
  ),
  Lesson(
    id: 1014,
    topicId: 'combo-racer',
    title: 'Bounce-Powered Speedway',
    glyph: '⚡',
    complexity: 5,
    target: 'Zero the counter, then race with the full bounce/count/say/sound chain.',
    narrator: "This speedway needs it all: a clean start, and a loop that does everything right.",
    steps: const ["Set Score to 0 before forever.", "Inside forever, chain: move, bounce, change Score, say, play sound — all five, in order."],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final set = flat.where((b) => b.defId == 'variables_set').toList();
      if (set.isEmpty || _numInput(set.first, 'value') != 0 || !_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, 'Zero Score with a set block before the forever loop.');
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      const order = [
        'motion_move_steps',
        'motion_if_on_edge_bounce',
        'variables_change',
        'looks_say',
        'sound_play_click',
      ];
      for (var i = 0; i < order.length - 1; i++) {
        if (!_before(inside, order[i], order[i + 1])) {
          return const LessonResult(false, 'Chain all five inside forever, in order.');
        }
      }
      return const LessonResult(true, 'A speedway that does everything right, from lap zero! ⚡');
    },
  ),
  Lesson(
    id: 1015,
    topicId: 'combo-racer',
    title: 'The Qualifying Lap',
    glyph: '⏳',
    complexity: 4,
    target: 'Run one accelerating qualifying lap, then report the result.',
    narrator: "One clean qualifying lap, gradually speeding up, then a report to the pit crew.",
    steps: const ["Inside a 'repeat' set to 1, add three move blocks with increasing steps.", "After the repeat, add a 'say' block with the result."],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 1}, body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 5}),
      ]),
    ],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block set to 1.");
      final moves = _children(repeat.body, 'motion_move_steps');
      if (moves.length < 3) return const LessonResult(false, 'Add three move blocks inside the repeat.');
      if (!(_numInput(moves[0], 'steps') < _numInput(moves[1], 'steps') &&
          _numInput(moves[1], 'steps') < _numInput(moves[2], 'steps'))) {
        return const LessonResult(false, 'Each move should be faster than the last.');
      }
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'looks_say') || !_before(flat, 'control_repeat', 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block reporting the result after the repeat.");
      }
      return const LessonResult(true, 'Qualifying lap complete — great report to the pit! ⏳');
    },
  ),
  Lesson(
    id: 1016,
    topicId: 'combo-racer',
    title: 'Photo Finish, For Real',
    glyph: '🏆',
    complexity: 5,
    target: 'Race a fixed sprint while counting, then announce the win and vanish.',
    narrator: "Final sprint to the checkered flag — count every step, then celebrate.",
    steps: const ["Add a 'repeat' with move AND change Score inside it.", "After the repeat: say a finish message, then hide."],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 5}, body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('variables_change', inputs: {'value': 1}),
      ]),
    ],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block for the final sprint.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the repeat.");
      }
      if (!inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put 'change Score by' inside the repeat too.");
      }
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'looks_say') || !_before(flat, 'control_repeat', 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block announcing the finish, after the repeat.");
      }
      if (!flat.any((b) => b.defId == 'looks_hide') || !_before(flat, 'looks_say', 'looks_hide')) {
        return const LessonResult(false, "Add a 'hide' block at the very end.");
      }
      return const LessonResult(true, 'Checkered flag! Photo finish captured! 🏆');
    },
  ),
  Lesson(
    id: 1017,
    topicId: 'combo-racer',
    title: 'The Full Race Script, Part 1',
    glyph: '🏁',
    complexity: 5,
    target: 'Combine the full pre-race checklist with a complete announced racing loop.',
    narrator: "Let's put the pre-race checklist and the race loop together for the first time.",
    steps: const ["Before forever: show, go to x y, point in direction, then set Score to 0.", "Inside forever: move, bounce, change Score, then say — in order."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      const pre = ['looks_show', 'motion_goto_xy', 'motion_point_direction', 'variables_set', 'control_forever'];
      for (var i = 0; i < pre.length - 1; i++) {
        if (!_before(flat, pre[i], pre[i + 1])) {
          return const LessonResult(false, 'Pre-race order: show, go to x y, point in direction, set Score to 0, then the race loop.');
        }
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      const raceOrder = ['motion_move_steps', 'motion_if_on_edge_bounce', 'variables_change', 'looks_say'];
      for (var i = 0; i < raceOrder.length - 1; i++) {
        if (!_before(inside, raceOrder[i], raceOrder[i + 1])) {
          return const LessonResult(false, 'Inside forever: move, bounce, change Score, then say — in order.');
        }
      }
      return const LessonResult(true, 'Pre-race checklist and race loop, working as one! 🏁');
    },
  ),
  Lesson(
    id: 1018,
    topicId: 'combo-racer',
    title: 'The Full Race Script, Part 2',
    glyph: '🎇',
    complexity: 5,
    target: 'Add sound to the full race script, honking on every wall bounce.',
    narrator: "Let's finish the script — every bounce also gets a honk, right in the middle of the chain.",
    steps: const ["Keep the full pre-race checklist.", "Inside forever: move, bounce, play sound, change Score, then say — in that exact order."],
    starter: () => [
      BlockInstance('looks_show'),
      BlockInstance('motion_goto_xy', inputs: {'x': 0, 'y': 0}),
      BlockInstance('motion_point_direction', inputs: {'degrees': 90}),
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      const pre = ['looks_show', 'motion_goto_xy', 'motion_point_direction', 'variables_set', 'control_forever'];
      for (var i = 0; i < pre.length - 1; i++) {
        if (!_before(flat, pre[i], pre[i + 1])) {
          return const LessonResult(false, 'Keep the full pre-race checklist before the forever loop.');
        }
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      const raceOrder = [
        'motion_move_steps',
        'motion_if_on_edge_bounce',
        'sound_play_click',
        'variables_change',
        'looks_say',
      ];
      for (var i = 0; i < raceOrder.length - 1; i++) {
        if (!_before(inside, raceOrder[i], raceOrder[i + 1])) {
          return const LessonResult(false, 'Inside forever: move, bounce, play sound, change Score, then say.');
        }
      }
      return const LessonResult(true, 'The full race script — sound and all! 🎇');
    },
  ),
  Lesson(
    id: 1019,
    topicId: 'combo-racer',
    title: 'Master Racer Setup',
    glyph: '👑',
    complexity: 5,
    target: 'Combine the pre-race checklist with a nested lap-shaping circuit, fully announced.',
    narrator: "Let's build the most complete circuit yet — real lap shapes, not just bouncing.",
    steps: const [
      "Before forever: show, go to x y, point in direction, set Score to 0.",
      "Inside forever: a repeat block shaping one lap (move + turn), then change Score by 1, then say.",
    ],
    starter: () => [
      BlockInstance('looks_show'),
      BlockInstance('motion_goto_xy', inputs: {'x': 0, 'y': 0}),
      BlockInstance('motion_point_direction', inputs: {'degrees': 90}),
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 10}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ]),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      const pre = ['looks_show', 'motion_goto_xy', 'motion_point_direction', 'variables_set', 'control_forever'];
      for (var i = 0; i < pre.length - 1; i++) {
        if (!_before(flat, pre[i], pre[i + 1])) {
          return const LessonResult(false, 'Keep the full pre-race checklist before the forever loop.');
        }
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a lap-shaping 'repeat' inside forever.");
      final repeatInside = cqFlatten(repeat.body);
      if (!repeatInside.any((b) => b.defId == 'motion_move_steps') ||
          !repeatInside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, 'Shape one lap with move and turn blocks inside the repeat.');
      }
      final foreverInside = cqFlatten(forever.body);
      if (!_before(foreverInside, 'control_repeat', 'variables_change')) {
        return const LessonResult(false, 'Change Score after the lap-shaping repeat, inside forever.');
      }
      if (!_before(foreverInside, 'variables_change', 'looks_say')) {
        return const LessonResult(false, 'Say something right after changing Score, inside forever.');
      }
      return const LessonResult(true, 'A master-level circuit, announced lap by lap! 👑');
    },
  ),
  Lesson(
    id: 1020,
    topicId: 'combo-racer',
    title: 'The Ultimate Race!',
    glyph: '🏆',
    complexity: 5,
    target: 'Build the complete capstone race: full pre-race checklist plus a race loop with every feature.',
    narrator: "This is it — Racetrack Ridge's ultimate race. Everything you've learned, in one script.",
    steps: const [
      "Before forever: show, go to x y, point in direction, then set Score to 0 — the full checklist.",
      "Inside forever: move, bounce, change Score, say, then play sound — the full race loop, in order.",
    ],
    starter: () => [
      BlockInstance('looks_show'),
      BlockInstance('motion_goto_xy', inputs: {'x': 0, 'y': 0}),
      BlockInstance('motion_point_direction', inputs: {'degrees': 90}),
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_forever', body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 10}),
        BlockInstance('motion_if_on_edge_bounce'),
      ]),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      const pre = ['looks_show', 'motion_goto_xy', 'motion_point_direction', 'variables_set', 'control_forever'];
      for (var i = 0; i < pre.length - 1; i++) {
        if (!_before(flat, pre[i], pre[i + 1])) {
          return const LessonResult(false, 'Pre-race checklist first: show, go to x y, point in direction, set Score to 0.');
        }
      }
      final set = flat.where((b) => b.defId == 'variables_set').toList();
      if (set.isEmpty || _numInput(set.first, 'value') != 0) {
        return const LessonResult(false, 'Set Score to exactly 0 to start the ultimate race clean.');
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block for the race.");
      final inside = cqFlatten(forever.body);
      const raceOrder = [
        'motion_move_steps',
        'motion_if_on_edge_bounce',
        'variables_change',
        'looks_say',
        'sound_play_click',
      ];
      for (var i = 0; i < raceOrder.length - 1; i++) {
        if (!_before(inside, raceOrder[i], raceOrder[i + 1])) {
          return const LessonResult(
              false, 'Inside forever, chain every feature in order: move, bounce, change Score, say, play sound.');
        }
      }
      return const LessonResult(
          true, "THE ULTIMATE RACE — checklist, motion, walls, laps, words, and sound, all working together! 🏆🏁");
    },
  ),
];
