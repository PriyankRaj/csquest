import '../models/cq_models.dart';
import 'cq_blocks.dart';

/// Ported from code-quest/lessons.js, "movement" topic, lessons 1-5 — the
/// green-flag hat block is implicit (the script list IS what runs on Run),
/// so the checks below are simplified accordingly but assert the same things.
///
/// Lessons 6-60 extend the topic with growing depth: simple two-block combos
/// (6-15), containers with nested blocks (16-40), and larger multi-container
/// choreography (41-60). Small helpers below mirror cqFlatten/cqHas but let
/// checks inspect a specific nesting level (a direct child of a container)
/// rather than the whole flattened subtree.

/// Finds the first direct child in [list] with defId [defId] (does not
/// recurse into bodies) — use this to grab a specific nested container.
BlockInstance? _child(List<BlockInstance> list, String defId) {
  for (final b in list) {
    if (b.defId == defId) return b;
  }
  return null;
}

/// True if a block with defId [a] appears before a block with defId [b] in
/// the flattened script.
bool _before(List<BlockInstance> flat, String a, String b) {
  final ia = flat.indexWhere((x) => x.defId == a);
  final ib = flat.indexWhere((x) => x.defId == b);
  return ia != -1 && ib != -1 && ia < ib;
}

num _numInput(BlockInstance b, String key) => (b.inputs[key] as num?) ?? 0;

final cqMovementLessons = <Lesson>[
  Lesson(
    id: 1,
    topicId: 'movement',
    title: 'First Steps!',
    glyph: '🚶',
    complexity: 1,
    target: 'Make Turtu move when you tap Run.',
    narrator: "I've got wheels for a reason — let's actually move!",
    steps: const ['Open the Motion tray.', "Tap 'move 10 steps' to add it to your script.", 'Tap Run and watch me roll.'],
    starter: () => [],
    check: (script) {
      final move = cqFlatten(script).where((b) => b.defId == 'motion_move_steps').toList();
      if (move.isEmpty) return const LessonResult(false, "Add a 'move steps' block from Motion.");
      if ((move.first.inputs['steps'] ?? 0) == 0) {
        return const LessonResult(false, "Set the move block's number to something other than 0!");
      }
      return const LessonResult(true, "Nice — I'm rolling! 🐢💨");
    },
  ),
  Lesson(
    id: 2,
    topicId: 'movement',
    title: 'Spin Master',
    glyph: '↻',
    complexity: 1,
    target: 'Move forward, then turn — see Turtu change direction.',
    narrator: "Moving in a straight line gets boring. Let's spin!",
    steps: const ["Add a 'move 10 steps' block.", "Add a 'turn' block (Motion) after it."],
    starter: () => [BlockInstance('motion_move_steps', inputs: {'steps': 10})],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Keep a 'move steps' block in your script.");
      }
      if (!flat.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block (Motion) after the move block.");
      }
      return const LessonResult(true, 'Now you\'re spinning me around! ↻');
    },
  ),
  Lesson(
    id: 3,
    topicId: 'movement',
    title: 'True North',
    glyph: '🧭',
    complexity: 1,
    target: 'Make Turtu face an exact direction before it moves.',
    narrator: "Instead of turning bit by bit, you can just tell me exactly which way to face.",
    steps: const ["Add 'point in direction 90' (Motion).", 'Change the number and Run — watch which way I face.'],
    starter: () => [],
    check: (script) {
      if (!cqHas(script, 'motion_point_direction')) {
        return const LessonResult(false, "Add a 'point in direction' block.");
      }
      return const LessonResult(true, 'Facing exactly where you told me to. 🧭');
    },
  ),
  Lesson(
    id: 4,
    topicId: 'movement',
    title: 'Diagonal Dash',
    glyph: '↔️',
    complexity: 2,
    target: 'Move Turtu diagonally using change x and change y together.',
    narrator: "There's another way to move: nudge my x and y position directly.",
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
      return const LessonResult(true, 'You just moved me diagonally with math! ↔️');
    },
  ),
  Lesson(
    id: 5,
    topicId: 'movement',
    title: 'Wall Bouncer',
    glyph: '🏓',
    complexity: 2,
    target: 'Keep Turtu moving forever, bouncing cleanly off every edge.',
    narrator: "Let's keep me moving forever, and bounce off the edges instead of running away.",
    steps: const [
      "Add a 'forever' block (Control).",
      "Inside forever: add 'move 10 steps', then 'if on edge, bounce' (both Motion).",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block to your script.");
      final inside = cqFlatten(forever.first.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Add 'if on edge, bounce' inside the forever loop too.");
      }
      return const LessonResult(true, 'Bouncing like a pro! 🏓');
    },
  ),
  Lesson(
    id: 6,
    topicId: 'movement',
    title: 'Turn It Up',
    glyph: '🔄',
    complexity: 1,
    target: 'Make Turtu whip around with a big turn.',
    narrator: "A little turn is fine, but let's really whip around this time!",
    steps: const ["Add a 'turn ↻ degrees' block (Motion).", 'Set the degrees higher than 90.'],
    starter: () => [],
    check: (script) {
      final turns = cqFlatten(script).where((b) => b.defId == 'motion_turn_right').toList();
      if (turns.isEmpty) return const LessonResult(false, "Add a 'turn right' block.");
      if (_numInput(turns.first, 'degrees') <= 90) {
        return const LessonResult(false, 'Set the degrees higher than 90 for a real whip-around.');
      }
      return const LessonResult(true, "Whoosh! That's a proper spin. 🔄");
    },
  ),
  Lesson(
    id: 7,
    topicId: 'movement',
    title: 'Lefty Loosey',
    glyph: '↺',
    complexity: 1,
    target: 'Turn Turtu the other way, sharply.',
    narrator: "Turning right is easy — now let's swing hard the other way.",
    steps: const ["Add a 'turn ↺ degrees' block (Motion).", 'Set the degrees to at least 30.'],
    starter: () => [],
    check: (script) {
      final turns = cqFlatten(script).where((b) => b.defId == 'motion_turn_left').toList();
      if (turns.isEmpty) return const LessonResult(false, "Add a 'turn left' block.");
      if (_numInput(turns.first, 'degrees') < 30) {
        return const LessonResult(false, 'Set the degrees to at least 30.');
      }
      return const LessonResult(true, 'Nice sharp swing to the left! ↺');
    },
  ),
  Lesson(
    id: 8,
    topicId: 'movement',
    title: 'Say Hello',
    glyph: '💬',
    complexity: 1,
    target: 'Make Turtu say something out loud.',
    narrator: "I've got a voice too, you know. Give me something to say!",
    steps: const ["Add a 'say' block (Looks).", 'Type your own message into it.'],
    starter: () => [],
    check: (script) {
      final says = cqFlatten(script).where((b) => b.defId == 'looks_say').toList();
      if (says.isEmpty) return const LessonResult(false, "Add a 'say' block from Looks.");
      final text = (says.first.inputs['text'] as String?) ?? '';
      if (text.trim().isEmpty) return const LessonResult(false, 'Type something into the say block.');
      return const LessonResult(true, 'Loud and clear! 💬');
    },
  ),
  Lesson(
    id: 9,
    topicId: 'movement',
    title: 'Show Yourself',
    glyph: '👀',
    complexity: 1,
    target: 'Show Turtu, then hide it again.',
    narrator: "Now you see me, now you don't. Show me, then hide me.",
    steps: const ["Add 'show' (Looks).", "Add 'hide' (Looks) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'looks_show')) {
        return const LessonResult(false, "Add a 'show' block.");
      }
      if (!flat.any((b) => b.defId == 'looks_hide')) {
        return const LessonResult(false, "Add a 'hide' block after 'show'.");
      }
      if (!_before(flat, 'looks_show', 'looks_hide')) {
        return const LessonResult(false, "'show' needs to come before 'hide'.");
      }
      return const LessonResult(true, 'Peekaboo! 👀');
    },
  ),
  Lesson(
    id: 10,
    topicId: 'movement',
    title: 'Click and Roll',
    glyph: '🔊',
    complexity: 2,
    target: 'Play a click sound and move Turtu.',
    narrator: "Let's make some noise while we move around!",
    steps: const ["Add 'move steps' (Motion).", "Add 'play sound' (Sound) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block.");
      }
      if (!flat.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block from Sound.");
      }
      return const LessonResult(true, 'Rolling with sound effects! 🔊');
    },
  ),
  Lesson(
    id: 11,
    topicId: 'movement',
    title: 'Wait For It',
    glyph: '⏳',
    complexity: 2,
    target: 'Make Turtu pause, then move.',
    narrator: "Sometimes the best move is to wait for a moment first.",
    steps: const ["Add a 'wait seconds' block (Control).", "Add 'move steps' (Motion) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final wait = flat.where((b) => b.defId == 'control_wait').toList();
      if (wait.isEmpty) return const LessonResult(false, "Add a 'wait seconds' block.");
      if (_numInput(wait.first, 'seconds') <= 0) {
        return const LessonResult(false, 'Set the wait time higher than 0.');
      }
      if (!_before(flat, 'control_wait', 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' after the 'wait' block.");
      }
      return const LessonResult(true, 'Patience, then action! ⏳');
    },
  ),
  Lesson(
    id: 12,
    topicId: 'movement',
    title: 'Score Keeper',
    glyph: '🔢',
    complexity: 1,
    target: 'Set the Score variable to a number.',
    narrator: "I can keep track of a score too. Let's set it to something.",
    steps: const ["Add 'set Score to' (Variables).", 'Change the number to something other than 0.'],
    starter: () => [],
    check: (script) {
      final sets = cqFlatten(script).where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Add a 'set Score to' block.");
      if (_numInput(sets.first, 'value') == 0) {
        return const LessonResult(false, 'Set the Score to something other than 0.');
      }
      return const LessonResult(true, 'Score is officially on the board! 🔢');
    },
  ),
  Lesson(
    id: 13,
    topicId: 'movement',
    title: 'Bonus Points',
    glyph: '➕',
    complexity: 2,
    target: 'Increase the Score variable.',
    narrator: "Setting a score once is fine, but let's earn some bonus points!",
    steps: const ["Add 'change Score by' (Variables).", 'Make sure the amount is positive.'],
    starter: () => [],
    check: (script) {
      final changes = cqFlatten(script).where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) return const LessonResult(false, "Add a 'change Score by' block.");
      if (_numInput(changes.first, 'value') <= 0) {
        return const LessonResult(false, 'Use a positive number to earn points.');
      }
      return const LessonResult(true, 'Bonus points earned! ➕');
    },
  ),
  Lesson(
    id: 14,
    topicId: 'movement',
    title: 'Teleporter',
    glyph: '🌀',
    complexity: 2,
    target: 'Send Turtu to an exact spot on the stage.',
    narrator: "Forget rolling there step by step — let's just teleport!",
    steps: const ["Add 'go to x: y:' (Motion).", 'Set x or y to something other than 0.'],
    starter: () => [],
    check: (script) {
      final gotos = cqFlatten(script).where((b) => b.defId == 'motion_goto_xy').toList();
      if (gotos.isEmpty) return const LessonResult(false, "Add a 'go to x: y:' block.");
      if (_numInput(gotos.first, 'x') == 0 && _numInput(gotos.first, 'y') == 0) {
        return const LessonResult(false, 'Set x or y to something other than 0.');
      }
      return const LessonResult(true, 'Zap! Teleported. 🌀');
    },
  ),
  Lesson(
    id: 15,
    topicId: 'movement',
    title: 'Face and Go',
    glyph: '🧭',
    complexity: 2,
    target: 'Point Turtu in a direction, then move that way.',
    narrator: "First we aim, then we roll. That's the smart way to travel.",
    steps: const ["Add 'point in direction' (Motion).", "Add 'move steps' (Motion) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'motion_point_direction', 'motion_move_steps')) {
        return const LessonResult(false, "Point in a direction, THEN move.");
      }
      return const LessonResult(true, 'Aim, then roll. Smooth! 🧭');
    },
  ),
  Lesson(
    id: 16,
    topicId: 'movement',
    title: 'Loop de Loop',
    glyph: '🔁',
    complexity: 2,
    target: 'Move Turtu several times using a repeat loop.',
    narrator: "Instead of adding 'move' five times, let's use a loop!",
    steps: const ["Add 'repeat times' (Control).", "Put 'move steps' inside it.", 'Set repeat times to 2 or more.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      if (_numInput(repeat, 'times') < 2) return const LessonResult(false, 'Set the repeat times to 2 or more.');
      if (!cqFlatten(repeat.body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the repeat loop.");
      }
      return const LessonResult(true, 'Loops save so much tapping! 🔁');
    },
  ),
  Lesson(
    id: 17,
    topicId: 'movement',
    title: 'Spinning Repeat',
    glyph: '🌪️',
    complexity: 2,
    target: 'Turn Turtu several times using a repeat loop.',
    narrator: "Let's make a proper spin cycle with a loop.",
    steps: const ["Add 'repeat times' (Control).", "Put a 'turn' block inside it."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the repeat loop.");
      }
      return const LessonResult(true, "Now that's a spin cycle! 🌪️");
    },
  ),
  Lesson(
    id: 18,
    topicId: 'movement',
    title: 'Forever Runner',
    glyph: '♾️',
    complexity: 2,
    target: 'Keep Turtu moving forever, non-stop.',
    narrator: "Let's never stop moving — put it inside a forever loop.",
    steps: const ["Add a 'forever' block (Control).", "Put 'move steps' inside it."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      if (!cqFlatten(forever.body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      return const LessonResult(true, "I'll never stop rolling now! ♾️");
    },
  ),
  Lesson(
    id: 19,
    topicId: 'movement',
    title: 'Endless Spin',
    glyph: '🌀',
    complexity: 2,
    target: 'Keep Turtu turning forever.',
    narrator: "Now let's spin forever instead of moving forever.",
    steps: const ["Add a 'forever' block (Control).", "Put a 'turn' block inside it."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the forever loop.");
      }
      return const LessonResult(true, "Spinning forever — I'm getting dizzy! 🌀");
    },
  ),
  Lesson(
    id: 20,
    topicId: 'movement',
    title: 'Say and Roll',
    glyph: '🗣️',
    complexity: 2,
    target: "Make Turtu say something, then move, inside a loop.",
    narrator: "Let's talk about where we're going before we roll there.",
    steps: const ["Add 'repeat times' (Control).", "Inside it, add 'say' then 'move steps'."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final inside = cqFlatten(repeat.body);
      if (!_before(inside, 'looks_say', 'motion_move_steps')) {
        return const LessonResult(false, "Inside the loop, 'say' needs to come before 'move steps'.");
      }
      return const LessonResult(true, 'Talking the walk! 🗣️');
    },
  ),
  Lesson(
    id: 21,
    topicId: 'movement',
    title: 'Bounce Patrol',
    glyph: '🏓',
    complexity: 3,
    target: 'Move and bounce off edges, several times, using a repeat loop.',
    narrator: "Let's patrol back and forth a set number of times.",
    steps: const ["Add 'repeat times' set to 3 or more.", "Inside it, add 'move steps' and 'if on edge, bounce'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      if (_numInput(repeat, 'times') < 3) return const LessonResult(false, 'Set the repeat times to 3 or more.');
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Put 'if on edge, bounce' inside the loop.");
      }
      return const LessonResult(true, 'Patrolling like clockwork! 🏓');
    },
  ),
  Lesson(
    id: 22,
    topicId: 'movement',
    title: 'Edge Watch',
    glyph: '🚧',
    complexity: 3,
    target: 'Do something special only when Turtu reaches the edge.',
    narrator: "The 'if on edge' block only runs its blocks when I'm actually at the edge.",
    steps: const ["Add an 'if on edge' block (Control).", "Put a 'turn' block inside it."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final ifEdge = _child(script, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Add an 'if on edge' block.");
      final inside = cqFlatten(ifEdge.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Edge detected, turning! That's smart code. 🚧");
    },
  ),
  Lesson(
    id: 23,
    topicId: 'movement',
    title: 'Bounce and Turn',
    glyph: '🔀',
    complexity: 3,
    target: "Combine forever, 'if on edge', and turning.",
    narrator: "Now let's put an edge-check inside a forever loop, for real patrol duty.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'if on edge'.", "Inside THAT, add a 'turn' block."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final ifEdge = _child(forever.body, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(ifEdge.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, 'Now THAT is real patrol logic! 🔀');
    },
  ),
  Lesson(
    id: 24,
    topicId: 'movement',
    title: 'Wait and Click',
    glyph: '⏱️',
    complexity: 3,
    target: 'Pause and play a sound, on repeat.',
    narrator: "Let's make a little rhythm — wait, then click, over and over.",
    steps: const ["Add 'repeat times' (Control).", "Inside it, add 'wait seconds' then 'play sound'."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Put a 'wait seconds' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put a 'play sound' block inside the loop.");
      }
      return const LessonResult(true, "Tick, tock, click! 🕰️");
    },
  ),
  Lesson(
    id: 25,
    topicId: 'movement',
    title: 'Score Loop',
    glyph: '📈',
    complexity: 3,
    target: 'Increase the Score every time a loop runs.',
    narrator: "Every trip around the loop should earn us something!",
    steps: const ["Add 'repeat times' (Control).", "Put 'change Score by' inside it."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      if (!cqFlatten(repeat.body).any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      return const LessonResult(true, 'Score climbing every loop! 📈');
    },
  ),
  Lesson(
    id: 26,
    topicId: 'movement',
    title: 'Countdown',
    glyph: '⏰',
    complexity: 3,
    target: "Pause and announce something, on every loop.",
    narrator: "Let's build a little countdown routine.",
    steps: const ["Add 'repeat times' (Control).", "Inside it, add 'wait seconds' then 'say'."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Put a 'wait seconds' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the loop.");
      }
      return const LessonResult(true, "T-minus... something! ⏰");
    },
  ),
  Lesson(
    id: 27,
    topicId: 'movement',
    title: 'Diagonal Loop',
    glyph: '📐',
    complexity: 3,
    target: 'Move diagonally, repeatedly, using a loop.',
    narrator: "One diagonal step is nice — a whole staircase of them is nicer!",
    steps: const ["Add 'repeat times' (Control).", "Inside it, add 'change x by' and 'change y by'."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_change_x')) {
        return const LessonResult(false, "Put 'change x by' inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_change_y')) {
        return const LessonResult(false, "Put 'change y by' inside the loop.");
      }
      return const LessonResult(true, 'A whole staircase of diagonal steps! 📐');
    },
  ),
  Lesson(
    id: 28,
    topicId: 'movement',
    title: 'Direction Dance',
    glyph: '💃',
    complexity: 3,
    target: 'Turn both left and right, forever.',
    narrator: "Let's dance — a turn this way, a turn that way, forever.",
    steps: const ["Add a 'forever' block.", "Inside it, add both a right turn and a left turn."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right')) {
        return const LessonResult(false, 'Add a right turn inside the forever loop.');
      }
      if (!inside.any((b) => b.defId == 'motion_turn_left')) {
        return const LessonResult(false, 'Add a left turn inside the forever loop too.');
      }
      return const LessonResult(true, "That's a dance move! 💃");
    },
  ),
  Lesson(
    id: 29,
    topicId: 'movement',
    title: 'Show and Tell',
    glyph: '🎭',
    complexity: 3,
    target: 'Show, say, then hide Turtu, on a loop.',
    narrator: "Let's do a proper little performance — appear, speak, vanish.",
    steps: const ["Add 'repeat times' (Control).", "Inside it, add 'show', then 'say', then 'hide' in that order."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final inside = cqFlatten(repeat.body);
      if (!(_before(inside, 'looks_show', 'looks_say') && _before(inside, 'looks_say', 'looks_hide'))) {
        return const LessonResult(false, "Order matters: 'show', then 'say', then 'hide'.");
      }
      return const LessonResult(true, 'A perfect little performance! 🎭');
    },
  ),
  Lesson(
    id: 30,
    topicId: 'movement',
    title: 'Teleport Loop',
    glyph: '✨',
    complexity: 3,
    target: 'Teleport Turtu repeatedly using a loop.',
    narrator: "Let's teleport again and again — very efficient travel.",
    steps: const ["Add 'repeat times' (Control).", "Put 'go to x: y:' inside it."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      if (!cqFlatten(repeat.body).any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Put a 'go to x: y:' block inside the loop.");
      }
      return const LessonResult(true, 'Zap zap zap! ✨');
    },
  ),
  Lesson(
    id: 31,
    topicId: 'movement',
    title: 'Bounce Beeper',
    glyph: '🔔',
    complexity: 3,
    target: 'Move, bounce off edges, and beep, forever.',
    narrator: "Let's add sound to the patrol so we can hear every bounce.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'move steps', 'if on edge, bounce', and 'play sound'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the forever loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Put 'if on edge, bounce' inside the forever loop.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the forever loop.");
      }
      return const LessonResult(true, 'Beep! Bounce! Beep! 🔔');
    },
  ),
  Lesson(
    id: 32,
    topicId: 'movement',
    title: 'Nested Spinner',
    glyph: '🎡',
    complexity: 4,
    target: 'Put a repeat loop of turns inside a forever loop.',
    narrator: "Loops inside loops — that's how you build real machinery.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'repeat times'.", "Inside THAT, add a 'turn' block."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Put a 'repeat times' block inside the forever loop.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the repeat loop.");
      }
      return const LessonResult(true, 'Loops within loops — masterful! 🎡');
    },
  ),
  Lesson(
    id: 33,
    topicId: 'movement',
    title: 'Patrol Path',
    glyph: '🛤️',
    complexity: 4,
    target: 'Draw a repeating path: move, then turn, forever.',
    narrator: "Move, turn, move, turn... let's make a real travel pattern.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'repeat times'.", "Inside THAT, add 'move steps' and 'turn'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Put a 'repeat times' block inside the forever loop.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the repeat loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the repeat loop.");
      }
      return const LessonResult(true, 'A path worth following! 🛤️');
    },
  ),
  Lesson(
    id: 34,
    topicId: 'movement',
    title: 'Score Marathon',
    glyph: '🏃',
    complexity: 4,
    target: 'Earn points on a timer, forever.',
    narrator: "Let's earn points steadily, with a little pause between each one.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'wait seconds' and 'change Score by'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Put a 'wait seconds' block inside the forever loop.");
      }
      if (!inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put a 'change Score by' block inside the forever loop.");
      }
      return const LessonResult(true, 'Steady points, forever! 🏃');
    },
  ),
  Lesson(
    id: 35,
    topicId: 'movement',
    title: 'Edge Announcer',
    glyph: '📢',
    complexity: 3,
    target: 'Announce it out loud when Turtu hits the edge.',
    narrator: "Let's brag a little every time we hit the edge.",
    steps: const ["Add an 'if on edge' block.", "Put a 'say' block inside it."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final ifEdge = _child(script, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Add an 'if on edge' block.");
      if (!cqFlatten(ifEdge.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, 'Edge reached, and announced! 📢');
    },
  ),
  Lesson(
    id: 36,
    topicId: 'movement',
    title: 'Double Bounce',
    glyph: '🎾',
    complexity: 4,
    target: "Put a real bounce block inside an 'if on edge' check, on a loop.",
    narrator: "Belt and braces — let's check the edge AND bounce off it, on repeat.",
    steps: const ["Add 'repeat times' (Control).", "Inside it, add 'if on edge'.", "Inside THAT, add 'if on edge, bounce'."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final ifEdge = _child(repeat.body, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Put an 'if on edge' block inside the loop.");
      if (!cqFlatten(ifEdge.body).any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Put 'if on edge, bounce' inside the 'if on edge' block.");
      }
      return const LessonResult(true, 'Double-checked and bouncing! 🎾');
    },
  ),
  Lesson(
    id: 37,
    topicId: 'movement',
    title: 'Setup and Go',
    glyph: '🚀',
    complexity: 3,
    target: 'Set the Score first, then start an endless bounce patrol.',
    narrator: "Every good mission starts with setup, THEN the main loop.",
    steps: const ["Add 'set Score to' first.", "Then add a 'forever' block with 'move steps' and 'if on edge, bounce' inside."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'variables_set')) {
        return const LessonResult(false, "Add a 'set Score to' block first.");
      }
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after setting the Score.");
      if (!_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, "'set Score to' needs to come before the forever loop.");
      }
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps') ||
          !inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Put 'move steps' and 'if on edge, bounce' inside the forever loop.");
      }
      return const LessonResult(true, 'Setup complete, mission running! 🚀');
    },
  ),
  Lesson(
    id: 38,
    topicId: 'movement',
    title: 'Turn Timer',
    glyph: '⏲️',
    complexity: 3,
    target: 'Wait, then turn, several times.',
    narrator: "Let's turn on a timer — pause, turn, pause, turn.",
    steps: const ["Add 'repeat times' set to 4 or more.", "Inside it, add 'wait seconds' and 'turn'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      if (_numInput(repeat, 'times') < 4) return const LessonResult(false, 'Set the repeat times to 4 or more.');
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Put a 'wait seconds' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the loop.");
      }
      return const LessonResult(true, 'Right on time, every turn! ⏲️');
    },
  ),
  Lesson(
    id: 39,
    topicId: 'movement',
    title: 'Zigzag',
    glyph: '⚡',
    complexity: 3,
    target: 'Move, then turn right, then turn left, on a loop.',
    narrator: "Let's zigzag — move, veer right, veer left, repeat.",
    steps: const ["Add 'repeat times' (Control).", "Inside it, add 'move steps', a right turn, and a left turn."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'motion_turn_right')) {
        return const LessonResult(false, 'Add a right turn inside the loop.');
      }
      if (!inside.any((b) => b.defId == 'motion_turn_left')) {
        return const LessonResult(false, 'Add a left turn inside the loop too.');
      }
      return const LessonResult(true, 'Zigging and zagging! ⚡');
    },
  ),
  Lesson(
    id: 40,
    topicId: 'movement',
    title: 'Grand Loop',
    glyph: '⭐',
    complexity: 4,
    target: 'Draw a repeating shape forever, using a loop inside a loop.',
    narrator: "Now let's run our little shape-drawing routine forever.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'repeat times' (3 or more).",
      "Inside THAT, add 'move steps' and 'turn'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Put a 'repeat times' block inside the forever loop.");
      if (_numInput(repeat, 'times') < 3) return const LessonResult(false, 'Set the repeat times to 3 or more.');
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps') ||
          !inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put 'move steps' and 'turn' inside the repeat loop.");
      }
      return const LessonResult(true, "That's a shape drawn forever! ⭐");
    },
  ),
  Lesson(
    id: 41,
    topicId: 'movement',
    title: 'Score Setup',
    glyph: '🏁',
    complexity: 4,
    target: 'Set the Score, then bounce patrol while earning points.',
    narrator: "Let's start the score at zero, then earn it while patrolling.",
    steps: const [
      "Add 'set Score to' first.",
      "Then add a 'forever' block with 'move steps', 'if on edge, bounce', and 'change Score by' inside.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, "Add 'set Score to' before the forever loop.");
      }
      final forever = _child(script, 'control_forever')!;
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps') ||
          !inside.any((b) => b.defId == 'motion_if_on_edge_bounce') ||
          !inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put 'move steps', 'if on edge, bounce', and 'change Score by' inside the loop.");
      }
      return const LessonResult(true, 'Patrolling AND scoring! 🏁');
    },
  ),
  Lesson(
    id: 42,
    topicId: 'movement',
    title: 'Talking Turtle',
    glyph: '🐢',
    complexity: 4,
    target: "Move forever, and say something whenever Turtu hits the edge.",
    narrator: "Let's talk every time we reach the edge, while still rolling forever.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'move steps'.",
      "Also inside it, add 'if on edge' with 'say' inside THAT.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      if (!cqFlatten(forever.body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the forever loop.");
      }
      final ifEdge = _child(forever.body, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!cqFlatten(ifEdge.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, 'A chatty little turtle! 🐢');
    },
  ),
  Lesson(
    id: 43,
    topicId: 'movement',
    title: 'Square Draw',
    glyph: '🟥',
    complexity: 4,
    target: 'Draw a square: repeat 4 times, moving and turning 90 degrees.',
    narrator: "Four sides, four turns — a classic square, coming right up.",
    steps: const [
      "Add 'repeat times' set to exactly 4.",
      "Inside it, add 'move steps' and a right turn set to 90 degrees.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      if (_numInput(repeat, 'times') < 4) return const LessonResult(false, 'Set the repeat times to 4.');
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the loop.");
      }
      final turn = _child(inside, 'motion_turn_right');
      if (turn == null) return const LessonResult(false, "Add a right turn inside the loop.");
      if (_numInput(turn, 'degrees') < 80 || _numInput(turn, 'degrees') > 100) {
        return const LessonResult(false, 'Set the turn to about 90 degrees for a square.');
      }
      return const LessonResult(true, 'A perfect square! 🟥');
    },
  ),
  Lesson(
    id: 44,
    topicId: 'movement',
    title: 'Triangle Draw',
    glyph: '🔺',
    complexity: 4,
    target: 'Draw a triangle: repeat 3 times, moving and turning 120 degrees.',
    narrator: "Three sides this time — sharper turns for a triangle.",
    steps: const [
      "Add 'repeat times' set to exactly 3.",
      "Inside it, add 'move steps' and a right turn set to 120 degrees.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      if (_numInput(repeat, 'times') < 3) return const LessonResult(false, 'Set the repeat times to 3.');
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put 'move steps' inside the loop.");
      }
      final turn = _child(inside, 'motion_turn_right');
      if (turn == null) return const LessonResult(false, "Add a right turn inside the loop.");
      if (_numInput(turn, 'degrees') < 110 || _numInput(turn, 'degrees') > 130) {
        return const LessonResult(false, 'Set the turn to about 120 degrees for a triangle.');
      }
      return const LessonResult(true, 'A perfect triangle! 🔺');
    },
  ),
  Lesson(
    id: 45,
    topicId: 'movement',
    title: 'Patrol and Report',
    glyph: '📋',
    complexity: 4,
    target: 'Patrol a shape forever, with a pause between laps.',
    narrator: "Let's patrol a shape, then take a breather before doing it again.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'repeat times' with 'move steps' and 'turn' inside THAT.",
      "Also inside the forever loop, add a 'wait seconds' block.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Put a 'repeat times' block inside the forever loop.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps') ||
          !inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put 'move steps' and 'turn' inside the repeat loop.");
      }
      if (!cqFlatten(forever.body).any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Also add a 'wait seconds' block inside the forever loop.");
      }
      return const LessonResult(true, 'Patrol complete, breather taken! 📋');
    },
  ),
  Lesson(
    id: 46,
    topicId: 'movement',
    title: 'Click Counter',
    glyph: '🖱️',
    complexity: 4,
    target: 'Click and earn a point, on a loop.',
    narrator: "Every click should count for something — literally!",
    steps: const ["Add 'repeat times' (Control).", "Inside it, add 'play sound' and 'change Score by'."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put 'change Score by' inside the loop.");
      }
      return const LessonResult(true, 'Every click counts! 🖱️');
    },
  ),
  Lesson(
    id: 47,
    topicId: 'movement',
    title: 'Bounce Tally',
    glyph: '🧮',
    complexity: 4,
    target: 'Move, bounce, score, and beep — all forever.',
    narrator: "Let's combine everything: movement, bouncing, scoring, and sound.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'move steps', 'if on edge, bounce', 'change Score by', and 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      final needed = ['motion_move_steps', 'motion_if_on_edge_bounce', 'variables_change', 'sound_play_click'];
      for (final id in needed) {
        if (!inside.any((b) => b.defId == id)) {
          return const LessonResult(false, 'Add move, bounce, score, and sound blocks inside the forever loop.');
        }
      }
      return const LessonResult(true, 'The full patrol package! 🧮');
    },
  ),
  Lesson(
    id: 48,
    topicId: 'movement',
    title: 'Vanish Loop',
    glyph: '👻',
    complexity: 4,
    target: 'Blink Turtu — show, wait, hide, wait — on a loop.',
    narrator: "Let's make a proper blink: appear, pause, disappear, pause.",
    steps: const ["Add 'repeat times' (Control).", "Inside it, add 'show', 'wait', 'hide', 'wait'."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'looks_show') || !inside.any((b) => b.defId == 'looks_hide')) {
        return const LessonResult(false, "Add both 'show' and 'hide' inside the loop.");
      }
      final waits = inside.where((b) => b.defId == 'control_wait').length;
      if (waits < 2) return const LessonResult(false, "Add two 'wait seconds' blocks — one after show, one after hide.");
      return const LessonResult(true, 'A perfect blink! 👻');
    },
  ),
  Lesson(
    id: 49,
    topicId: 'movement',
    title: 'Diagonal Weave',
    glyph: '🕸️',
    complexity: 4,
    target: 'Weave diagonally forever, turning whenever you hit an edge.',
    narrator: "Let's weave a diagonal path, and adjust course at every edge.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'change x by' and 'change y by'.",
      "Also inside it, add 'if on edge' with a 'turn' block inside THAT.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_change_x') || !inside.any((b) => b.defId == 'motion_change_y')) {
        return const LessonResult(false, "Add 'change x by' and 'change y by' inside the forever loop.");
      }
      final ifEdge = _child(forever.body, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Add an 'if on edge' block inside the forever loop.");
      if (!cqFlatten(ifEdge.body).any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, 'A beautiful diagonal weave! 🕸️');
    },
  ),
  Lesson(
    id: 50,
    topicId: 'movement',
    title: 'Full Patrol',
    glyph: '🛡️',
    complexity: 5,
    target: 'Set up the Score, then run a shape patrol that also bounces off edges.',
    narrator: "This is the real deal — setup, shape-walking, AND edge bouncing.",
    steps: const [
      "Add 'set Score to' first.",
      "Add a 'forever' block containing 'repeat times' (with 'move steps' and 'turn' inside).",
      "Also inside the forever loop, add 'if on edge, bounce'.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_set', 'control_forever')) {
        return const LessonResult(false, "Add 'set Score to' before the forever loop.");
      }
      final forever = _child(script, 'control_forever')!;
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Put a 'repeat times' block inside the forever loop.");
      final repeatInside = cqFlatten(repeat.body);
      if (!repeatInside.any((b) => b.defId == 'motion_move_steps') ||
          !repeatInside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put 'move steps' and 'turn' inside the repeat loop.");
      }
      if (!cqFlatten(forever.body).any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Also add 'if on edge, bounce' directly inside the forever loop.");
      }
      return const LessonResult(true, 'Full patrol, fully operational! 🛡️');
    },
  ),
  Lesson(
    id: 51,
    topicId: 'movement',
    title: 'Score Bouncer Pro',
    glyph: '🏆',
    complexity: 5,
    target: 'Bounce, score, and announce edge hits — forever.',
    narrator: "Let's build the pro version — bouncing, scoring, and bragging about it.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'move steps', 'if on edge, bounce', and 'change Score by'.",
      "Also add 'if on edge' with 'say' inside THAT.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps') ||
          !inside.any((b) => b.defId == 'motion_if_on_edge_bounce') ||
          !inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Add 'move steps', 'if on edge, bounce', and 'change Score by' inside the forever loop.");
      }
      final ifEdge = _child(forever.body, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Also add an 'if on edge' block inside the forever loop.");
      if (!cqFlatten(ifEdge.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, 'That is a professional patrol! 🏆');
    },
  ),
  Lesson(
    id: 52,
    topicId: 'movement',
    title: 'The Long Dance',
    glyph: '🕺',
    complexity: 4,
    target: 'A long choreography: move, turn right, turn left, wait — repeated 8+ times.',
    narrator: "Let's build a real routine and run it a good long while.",
    steps: const [
      "Add 'repeat times' set to 8 or more.",
      "Inside it, add 'move steps', a right turn, a left turn, and 'wait seconds'.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 8})],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      if (_numInput(repeat, 'times') < 8) return const LessonResult(false, 'Set the repeat times to 8 or more.');
      final inside = cqFlatten(repeat.body);
      final needed = ['motion_move_steps', 'motion_turn_right', 'motion_turn_left', 'control_wait'];
      for (final id in needed) {
        if (!inside.any((b) => b.defId == id)) {
          return const LessonResult(false, 'Add move, right turn, left turn, and wait blocks inside the loop.');
        }
      }
      return const LessonResult(true, 'What a routine! 🕺');
    },
  ),
  Lesson(
    id: 53,
    topicId: 'movement',
    title: 'Guard Duty',
    glyph: '🛡️',
    complexity: 5,
    target: "When Turtu hits the edge, turn AND announce it, forever.",
    narrator: "Standing guard means reacting properly at every edge, every time.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'if on edge'.",
      "Inside THAT, add both a 'turn' block and a 'say' block.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final ifEdge = _child(forever.body, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(ifEdge.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside the 'if on edge' block.");
      }
      if (!inside.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block inside the 'if on edge' block too.");
      }
      return const LessonResult(true, 'Standing guard, reacting properly! 🛡️');
    },
  ),
  Lesson(
    id: 54,
    topicId: 'movement',
    title: 'Treasure Hunt',
    glyph: '🗺️',
    complexity: 5,
    target: 'Teleport to a starting spot, then run a full scoring patrol.',
    narrator: "Every hunt starts at a landmark, THEN the searching begins.",
    steps: const [
      "Add 'go to x: y:' first, to set a starting spot.",
      "Then add a 'forever' block with 'move steps', 'if on edge, bounce', 'change Score by', and 'play sound' inside.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'motion_goto_xy', 'control_forever')) {
        return const LessonResult(false, "Add 'go to x: y:' before the forever loop.");
      }
      final forever = _child(script, 'control_forever')!;
      final inside = cqFlatten(forever.body);
      final needed = ['motion_move_steps', 'motion_if_on_edge_bounce', 'variables_change', 'sound_play_click'];
      for (final id in needed) {
        if (!inside.any((b) => b.defId == id)) {
          return const LessonResult(false, 'Add move, bounce, score, and sound blocks inside the forever loop.');
        }
      }
      return const LessonResult(true, 'The hunt is fully underway! 🗺️');
    },
  ),
  Lesson(
    id: 55,
    topicId: 'movement',
    title: 'Master Choreographer',
    glyph: '🎬',
    complexity: 5,
    target: 'Combine a shape-drawing loop with sound and scoring, forever.',
    narrator: "Let's direct the whole show — shapes, sound, and score together.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'repeat times' with 'move steps', a right turn, and a left turn inside THAT.",
      "Also directly inside the forever loop, add 'play sound' and 'change Score by'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Put a 'repeat times' block inside the forever loop.");
      final repeatInside = cqFlatten(repeat.body);
      if (!repeatInside.any((b) => b.defId == 'motion_move_steps') ||
          !repeatInside.any((b) => b.defId == 'motion_turn_right') ||
          !repeatInside.any((b) => b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put move, right turn, and left turn inside the repeat loop.");
      }
      final foreverDirect = cqFlatten(forever.body);
      if (!foreverDirect.any((b) => b.defId == 'sound_play_click') ||
          !foreverDirect.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Also add 'play sound' and 'change Score by' inside the forever loop.");
      }
      return const LessonResult(true, 'Lights, camera, choreography! 🎬');
    },
  ),
  Lesson(
    id: 56,
    topicId: 'movement',
    title: 'Double Trouble',
    glyph: '🎪',
    complexity: 5,
    target: "Bounce AND announce it, every time on repeat, inside an edge check.",
    narrator: "Belt, braces, AND a microphone — let's really cover the edge case.",
    steps: const [
      "Add 'repeat times' (Control).",
      "Inside it, add 'if on edge'.",
      "Inside THAT, add 'if on edge, bounce' and 'say'.",
    ],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final ifEdge = _child(repeat.body, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Put an 'if on edge' block inside the loop.");
      final inside = cqFlatten(ifEdge.body);
      if (!inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Put 'if on edge, bounce' inside the 'if on edge' block.");
      }
      if (!inside.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the 'if on edge' block too.");
      }
      return const LessonResult(true, 'Double trouble, fully handled! 🎪');
    },
  ),
  Lesson(
    id: 57,
    topicId: 'movement',
    title: 'Final Countdown',
    glyph: '🚨',
    complexity: 4,
    target: 'Wait, deduct a point, and announce it — on a loop.',
    narrator: "Let's build some tension — pause, lose a point, announce it.",
    steps: const ["Add 'repeat times' (Control).", "Inside it, add 'wait seconds', 'change Score by', and 'say'."],
    starter: () => [],
    check: (script) {
      final repeat = _child(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat times' block.");
      final inside = cqFlatten(repeat.body);
      if (!inside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Put a 'wait seconds' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put a 'change Score by' block inside the loop.");
      }
      if (!inside.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the loop too.");
      }
      return const LessonResult(true, 'Tension built, countdown complete! 🚨');
    },
  ),
  Lesson(
    id: 58,
    topicId: 'movement',
    title: 'Ultimate Patrol',
    glyph: '👑',
    complexity: 5,
    target: 'Run a shape-walking patrol AND a sound-and-score edge reaction, forever.',
    narrator: "This is the ultimate patrol — two whole routines running side by side.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'repeat times' with 'move steps' and 'turn' inside THAT.",
      "Also inside the forever loop, add 'if on edge' with 'play sound' and 'change Score by' inside THAT.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _child(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block.");
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Put a 'repeat times' block inside the forever loop.");
      final repeatInside = cqFlatten(repeat.body);
      if (!repeatInside.any((b) => b.defId == 'motion_move_steps') ||
          !repeatInside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put 'move steps' and 'turn' inside the repeat loop.");
      }
      final ifEdge = _child(forever.body, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Also put an 'if on edge' block inside the forever loop.");
      final ifEdgeInside = cqFlatten(ifEdge.body);
      if (!ifEdgeInside.any((b) => b.defId == 'sound_play_click') ||
          !ifEdgeInside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put 'play sound' and 'change Score by' inside the 'if on edge' block.");
      }
      return const LessonResult(true, 'The ultimate patrol, running perfectly! 👑');
    },
  ),
  Lesson(
    id: 59,
    topicId: 'movement',
    title: 'Show Stopper',
    glyph: '🌟',
    complexity: 5,
    target: 'Set up, appear, then run a full scoring patrol that also talks and beeps at the edge.',
    narrator: "This is the big finale rehearsal — setup, entrance, then the whole show.",
    steps: const [
      "Add 'set Score to' and 'show' first, in that order.",
      "Then add a 'forever' block with 'move steps', 'if on edge, bounce', and 'change Score by' inside.",
      "Also inside the forever loop, add 'if on edge' with 'say' and 'play sound' inside THAT.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_set', 'looks_show') || !_before(flat, 'looks_show', 'control_forever')) {
        return const LessonResult(false, "Order matters: 'set Score to', then 'show', then the forever loop.");
      }
      final forever = _child(script, 'control_forever')!;
      final inside = cqFlatten(forever.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps') ||
          !inside.any((b) => b.defId == 'motion_if_on_edge_bounce') ||
          !inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Add 'move steps', 'if on edge, bounce', and 'change Score by' inside the forever loop.");
      }
      final ifEdge = _child(forever.body, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Also add an 'if on edge' block inside the forever loop.");
      final ifEdgeInside = cqFlatten(ifEdge.body);
      if (!ifEdgeInside.any((b) => b.defId == 'looks_say') || !ifEdgeInside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'say' and 'play sound' inside the 'if on edge' block.");
      }
      return const LessonResult(true, 'What a show! Take a bow. 🌟');
    },
  ),
  Lesson(
    id: 60,
    topicId: 'movement',
    title: "Turtu's Masterpiece",
    glyph: '🎨',
    complexity: 5,
    target: 'The full masterpiece: teleport to start, then patrol a shape while scoring, announcing, and beeping at every edge.',
    narrator: "This is everything you've learned, all in one grand finale. Let's roll, Turtu!",
    steps: const [
      "Add 'set Score to' and 'go to x: y:' first, in that order.",
      "Then add a 'forever' block containing 'repeat times' (with 'move steps' and a right turn inside THAT).",
      "Also inside the forever loop, add 'if on edge' (with 'say' and 'change Score by' inside THAT) and 'play sound'.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_before(flat, 'variables_set', 'motion_goto_xy') || !_before(flat, 'motion_goto_xy', 'control_forever')) {
        return const LessonResult(false, "Order matters: 'set Score to', then 'go to x: y:', then the forever loop.");
      }
      final forever = _child(script, 'control_forever')!;
      final repeat = _child(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Put a 'repeat times' block inside the forever loop.");
      final repeatInside = cqFlatten(repeat.body);
      if (!repeatInside.any((b) => b.defId == 'motion_move_steps') || !repeatInside.any((b) => b.defId == 'motion_turn_right')) {
        return const LessonResult(false, "Put 'move steps' and a right turn inside the repeat loop.");
      }
      final ifEdge = _child(forever.body, 'control_if_on_edge');
      if (ifEdge == null) return const LessonResult(false, "Also put an 'if on edge' block inside the forever loop.");
      final ifEdgeInside = cqFlatten(ifEdge.body);
      if (!ifEdgeInside.any((b) => b.defId == 'looks_say') || !ifEdgeInside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put 'say' and 'change Score by' inside the 'if on edge' block.");
      }
      if (!cqFlatten(forever.body).any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Also add 'play sound' directly inside the forever loop.");
      }
      return const LessonResult(true, "A masterpiece! You've truly brought me to life. 🎨");
    },
  ),
];
