import '../models/cq_models.dart';
import 'cq_blocks.dart';

/// "Draw With Loops" (Loop-the-Loop Valley) — topic id 'loops'.
/// Theme: drawing shapes/patterns with control_repeat + motion_move_steps +
/// motion_turn_right/left. Growing depth: single-repeat polygons → stars →
/// forever-driven animation → nested repeats (flowers/mandalas) → full
/// combined showcases using variables/looks/sound alongside the geometry.
///
/// Shared helpers below keep every check() a real structural/mathematical
/// check (interior turn angle = 360 / number of sides) rather than a
/// trivial always-pass check.

num? _n(Object? v) => v is num ? v : null;

BlockInstance? _firstTurn(List<BlockInstance> body) {
  for (final b in body) {
    if (b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left') return b;
  }
  return null;
}

bool _hasMoveForward(List<BlockInstance> body) =>
    body.any((b) => b.defId == 'motion_move_steps' && (_n(b.inputs['steps']) ?? 0) > 0);

/// A repeat block draws a regular polygon with [sides] sides only if its
/// 'times' equals [sides] AND its turn angle equals 360/sides (the true
/// exterior-angle math for a regular polygon walked by a turtle).
bool _isPolygonRepeat(BlockInstance? repeat, int sides) {
  if (repeat == null || repeat.defId != 'control_repeat') return false;
  final times = _n(repeat.inputs['times']);
  if (times == null || times.round() != sides) return false;
  final body = cqFlatten(repeat.body);
  if (!_hasMoveForward(body)) return false;
  final turn = _firstTurn(body);
  if (turn == null) return false;
  final angle = _n(turn.inputs['degrees']) ?? 0;
  final expected = 360 / sides;
  return (angle - expected).abs() < 0.6;
}

bool _isStarRepeat(BlockInstance? repeat, int points, num turnAngle) {
  if (repeat == null || repeat.defId != 'control_repeat') return false;
  if (_n(repeat.inputs['times'])?.round() != points) return false;
  final body = cqFlatten(repeat.body);
  if (!_hasMoveForward(body)) return false;
  final turn = _firstTurn(body);
  if (turn == null) return false;
  final angle = _n(turn.inputs['degrees']) ?? 0;
  return (angle - turnAngle).abs() < 0.6;
}

List<BlockInstance> _repeatsIn(List<BlockInstance> script) =>
    cqFlatten(script).where((b) => b.defId == 'control_repeat').toList();

/// Finds an outer repeat (times == [petals]) whose body directly contains
/// an inner repeat drawing a regular [innerSides]-gon, rotated between
/// petals by the mathematically correct 360/petals degrees — a "flower".
BlockInstance? _findOuterFlower(List<BlockInstance> script, int innerSides, int petals) {
  for (final r in _repeatsIn(script)) {
    if (_n(r.inputs['times'])?.round() != petals) continue;
    final inner = r.body.firstWhere((b) => b.defId == 'control_repeat', orElse: () => BlockInstance('none'));
    if (inner.defId == 'none' || !_isPolygonRepeat(inner, innerSides)) continue;
    final rest = r.body.where((b) => b.defId != 'control_repeat').toList();
    final turn = _firstTurn(rest);
    if (turn == null) continue;
    final angle = _n(turn.inputs['degrees']) ?? 0;
    final expected = 360 / petals;
    if ((angle - expected).abs() < 0.6) return r;
  }
  return null;
}

/// Same idea, but the inner repeat draws a star instead of a plain polygon.
BlockInstance? _findOuterStarFlower(List<BlockInstance> script, int starPoints, num starAngle, int petals) {
  for (final r in _repeatsIn(script)) {
    if (_n(r.inputs['times'])?.round() != petals) continue;
    final inner = r.body.firstWhere((b) => b.defId == 'control_repeat', orElse: () => BlockInstance('none'));
    if (inner.defId == 'none' || !_isStarRepeat(inner, starPoints, starAngle)) continue;
    final rest = r.body.where((b) => b.defId != 'control_repeat').toList();
    final turn = _firstTurn(rest);
    if (turn == null) continue;
    final angle = _n(turn.inputs['degrees']) ?? 0;
    final expected = 360 / petals;
    if ((angle - expected).abs() < 0.6) return r;
  }
  return null;
}

final cqLoopsLessons = <Lesson>[
  // ---------------------------------------------------------------------
  // 661-675 — complexity 1: meet repeat, build a square, decorate it.
  // ---------------------------------------------------------------------
  Lesson(
    id: 661,
    topicId: 'loops',
    title: 'Repeat Rookie',
    glyph: '🔁',
    complexity: 1,
    target: 'Use a repeat block so Process moves forward 4 times without four separate move blocks.',
    narrator: 'Process: My wheels get tired tapping the same block four times — teach me to repeat!',
    steps: const [
      "Open Control and add 'repeat 4 times'.",
      "Inside it, add 'move 10 steps' from Motion.",
      'Tap Run and count how many times I roll.',
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeats = _repeatsIn(script);
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block from Control.");
      final r = repeats.first;
      if ((_n(r.inputs['times']) ?? 0) != 4) return const LessonResult(false, "Set the repeat's number to 4.");
      if (!_hasMoveForward(cqFlatten(r.body))) {
        return const LessonResult(false, "Put a 'move steps' block inside the repeat.");
      }
      return const LessonResult(true, 'Four rolls in one block — my wheels thank you! 🔁');
    },
  ),
  Lesson(
    id: 662,
    topicId: 'loops',
    title: 'Turn It Up',
    glyph: '↻',
    complexity: 1,
    target: 'Add a turn block inside the repeat so Process turns after every move.',
    narrator: "Moving in a repeating straight line is fine, but a repeating SQUARE needs a turn too.",
    steps: const ["Keep 'repeat 4 times'.", "Inside it, after move, add 'turn right 90 degrees'."],
    starter: () => [
      BlockInstance(
        'control_repeat',
        inputs: {'times': 4},
        body: [BlockInstance('motion_move_steps', inputs: {'steps': 10})],
      ),
    ],
    check: (script) {
      final repeats = _repeatsIn(script);
      if (repeats.isEmpty) return const LessonResult(false, 'Keep the repeat block.');
      final body = cqFlatten(repeats.first.body);
      if (!_hasMoveForward(body)) return const LessonResult(false, 'Keep a move block inside the repeat.');
      final turn = _firstTurn(body);
      if (turn == null) return const LessonResult(false, 'Add a turn block inside the repeat, after move.');
      if ((_n(turn.inputs['degrees']) ?? 0) == 0) {
        return const LessonResult(false, "Set the turn's degrees to something other than 0.");
      }
      return const LessonResult(true, 'Now I move AND turn every lap! ↻');
    },
  ),
  Lesson(
    id: 663,
    topicId: 'loops',
    title: 'Right Angle',
    glyph: '📐',
    complexity: 1,
    target: 'Set the turn to exactly 90 degrees so each corner is a perfect right angle.',
    narrator: '360 degrees split 4 ways is 90 each — that is the actual math behind a square corner.',
    steps: const ["Keep repeat 4 times.", "Set the turn block to exactly 90 degrees."],
    starter: () => [
      BlockInstance(
        'control_repeat',
        inputs: {'times': 4},
        body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 50}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 45}),
        ],
      ),
    ],
    check: (script) {
      final ok = _repeatsIn(script).any((r) => _isPolygonRepeat(r, 4));
      if (!ok) return const LessonResult(false, 'Set repeat to 4 times, and the turn to 90 degrees (360÷4).');
      return const LessonResult(true, "Four perfect right angles — that's a square! 📐");
    },
  ),
  Lesson(
    id: 664,
    topicId: 'loops',
    title: 'Square One',
    glyph: '⬜',
    complexity: 1,
    target: 'Draw your very first complete square: repeat 4 [move, turn 90].',
    narrator: 'From scratch this time — no starter blocks, just you, me, and 360 degrees.',
    steps: const ["Add 'repeat 4 times'.", "Inside: move some steps, then turn right 90 degrees."],
    starter: () => [],
    check: (script) {
      final ok = _repeatsIn(script).any((r) => _isPolygonRepeat(r, 4));
      if (!ok) return const LessonResult(false, 'Build repeat 4 [move steps, turn 90] from scratch.');
      return const LessonResult(true, 'A square, built from nothing but wheels and math! ⬜');
    },
  ),
  Lesson(
    id: 665,
    topicId: 'loops',
    title: 'Rectangle Remix',
    glyph: '▭',
    complexity: 1,
    target: 'Draw a rectangle: repeat 2 times, alternating a long move and a short move, each with a 90-degree turn.',
    narrator: "A rectangle is just a square that's been to the gym on two of its sides.",
    steps: const ['Add repeat 2 times.', 'Inside: move 100, turn 90, move 50, turn 90.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final candidates = _repeatsIn(script).where((r) => (_n(r.inputs['times'])?.round() ?? 0) == 2).toList();
      if (candidates.isEmpty) return const LessonResult(false, 'Set the repeat block to 2 times.');
      final r = candidates.first;
      final moves = r.body.where((b) => b.defId == 'motion_move_steps').toList();
      final turns = r.body.where((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left').toList();
      if (moves.length < 2) {
        return const LessonResult(false, 'Add two move blocks inside the repeat (a long side and a short side).');
      }
      if (turns.length < 2) return const LessonResult(false, 'Add two turn blocks, one after each move.');
      final s1 = _n(moves[0].inputs['steps']) ?? 0;
      final s2 = _n(moves[1].inputs['steps']) ?? 0;
      if (s1 == s2) {
        return const LessonResult(false, "Make the two move blocks different lengths so it's a rectangle, not a square.");
      }
      for (final t in turns) {
        if (((_n(t.inputs['degrees']) ?? 0) - 90).abs() > 0.6) {
          return const LessonResult(false, 'Keep every turn at 90 degrees.');
        }
      }
      return const LessonResult(true, 'A crisp rectangle — nice remix! ▭');
    },
  ),
  Lesson(
    id: 666,
    topicId: 'loops',
    title: 'Triangle Trouble',
    glyph: '🔺',
    complexity: 1,
    target: 'Draw a triangle: repeat 3 times, turning 120 degrees each lap (360÷3).',
    narrator: 'Three sides, three turns, and they still have to add up to one full spin around.',
    steps: const ["Add repeat 3 times.", 'Inside: move steps, then turn 120 degrees.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final ok = _repeatsIn(script).any((r) => _isPolygonRepeat(r, 3));
      if (!ok) return const LessonResult(false, 'Set repeat to 3 times and the turn to 120 degrees (360÷3).');
      return const LessonResult(true, 'A tidy triangle — three sides, no trouble! 🔺');
    },
  ),
  Lesson(
    id: 667,
    topicId: 'loops',
    title: 'Say My Shape',
    glyph: '💬',
    complexity: 1,
    target: 'After drawing your square, make Process announce it with a say block.',
    narrator: "Drawing is great, but bragging about it is better.",
    steps: const ['Keep your square (repeat 4, turn 90).', "After the repeat, add 'say' from Looks with text 'Square!'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 60}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ])],
    check: (script) {
      if (!_repeatsIn(script).any((r) => _isPolygonRepeat(r, 4))) {
        return const LessonResult(false, 'Keep a square: repeat 4 times, turn 90.');
      }
      final say = cqFlatten(script).where((b) => b.defId == 'looks_say').toList();
      if (say.isEmpty) return const LessonResult(false, "Add a 'say' block from Looks after the square.");
      final text = say.first.inputs['text']?.toString() ?? '';
      if (text.trim().isEmpty) return const LessonResult(false, "Give the say block some text, like 'Square!'.");
      return const LessonResult(true, 'Announced loud and clear! 💬');
    },
  ),
  Lesson(
    id: 668,
    topicId: 'loops',
    title: 'Click Complete',
    glyph: '🔊',
    complexity: 1,
    target: 'Play a click sound right after finishing your square.',
    narrator: 'A little chime tells everyone the drawing is finished.',
    steps: const ['Keep your square.', "After the repeat, add 'play sound' from Sound."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 60}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ])],
    check: (script) {
      if (!_repeatsIn(script).any((r) => _isPolygonRepeat(r, 4))) {
        return const LessonResult(false, 'Keep a square: repeat 4 times, turn 90.');
      }
      if (!cqHas(script, 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block from Sound after the square.");
      }
      return const LessonResult(true, 'Click! Square complete. 🔊');
    },
  ),
  Lesson(
    id: 669,
    topicId: 'loops',
    title: 'Pace Yourself',
    glyph: '⏱️',
    complexity: 1,
    target: 'Add a short wait so the drawing has a beat instead of flashing instantly.',
    narrator: 'Even a rolling turtle needs a moment to breathe between shapes.',
    steps: const ["Add a 'wait' block from Control.", 'Set it to more than 0 seconds.', 'Keep a shape-drawing repeat too.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 60}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ])],
    check: (script) {
      final flat = cqFlatten(script);
      final wait = flat.where((b) => b.defId == 'control_wait').toList();
      if (wait.isEmpty) return const LessonResult(false, "Add a 'wait' block from Control.");
      if ((_n(wait.first.inputs['seconds']) ?? 0) <= 0) {
        return const LessonResult(false, 'Set the wait to more than 0 seconds.');
      }
      if (!flat.any((b) => b.defId == 'control_repeat')) {
        return const LessonResult(false, 'Keep a repeat block drawing a shape too.');
      }
      return const LessonResult(true, 'A little pause makes the drawing feel alive. ⏱️');
    },
  ),
  Lesson(
    id: 670,
    topicId: 'loops',
    title: 'Score Zero',
    glyph: '0️⃣',
    complexity: 1,
    target: 'Set Score to 0 before you start drawing shapes.',
    narrator: "Before I count anything, I need to start at zero — otherwise old scores confuse me.",
    steps: const ["Add 'set Score to 0' from Variables.", 'Put it before your repeat block.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 60}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ])],
    check: (script) {
      final idxSet = script.indexWhere((b) => b.defId == 'variables_set');
      if (idxSet == -1) return const LessonResult(false, "Add a 'set Score to' block from Variables.");
      if ((_n(script[idxSet].inputs['value']) ?? -1) != 0) {
        return const LessonResult(false, 'Set Score to 0, not another number.');
      }
      final idxRepeat = script.indexWhere((b) => b.defId == 'control_repeat');
      if (idxRepeat != -1 && idxRepeat < idxSet) {
        return const LessonResult(false, 'Set Score to 0 BEFORE you start drawing.');
      }
      return const LessonResult(true, 'Score reset — ready to count my shapes! 0️⃣');
    },
  ),
  Lesson(
    id: 671,
    topicId: 'loops',
    title: 'Shape Counter',
    glyph: '🧮',
    complexity: 1,
    target: 'Change Score by 1 every time you finish drawing a shape.',
    narrator: 'One shape, one point. Keep track of my art gallery!',
    steps: const ['Keep a shape-drawing repeat.', "After it, add 'change Score by 1' from Variables."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 60}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 120}),
        ])],
    check: (script) {
      final flat = cqFlatten(script);
      final change = flat.where((b) => b.defId == 'variables_change').toList();
      if (change.isEmpty) return const LessonResult(false, "Add a 'change Score by' block from Variables.");
      if ((_n(change.first.inputs['value']) ?? 0) <= 0) {
        return const LessonResult(false, 'Change Score by a positive number, like 1.');
      }
      if (!flat.any((b) => b.defId == 'control_repeat')) {
        return const LessonResult(false, 'Keep a repeat block drawing a shape.');
      }
      return const LessonResult(true, "That's one shape in the books! 🧮");
    },
  ),
  Lesson(
    id: 672,
    topicId: 'loops',
    title: 'Pentagon Power',
    glyph: '⬠',
    complexity: 1,
    target: 'Draw a pentagon: repeat 5 times, turning 72 degrees each lap (360÷5).',
    narrator: 'Five sides means five turns of exactly 72 degrees — do the division and see!',
    steps: const ['Add repeat 5 times.', 'Inside: move steps, then turn 72 degrees.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 5})],
    check: (script) {
      final ok = _repeatsIn(script).any((r) => _isPolygonRepeat(r, 5));
      if (!ok) return const LessonResult(false, 'Set repeat to 5 times and the turn to 72 degrees (360÷5).');
      return const LessonResult(true, 'Five clean sides — pentagon power! ⬠');
    },
  ),
  Lesson(
    id: 673,
    topicId: 'loops',
    title: 'Hex Appeal',
    glyph: '⬡',
    complexity: 1,
    target: 'Draw a hexagon: repeat 6 times, turning 60 degrees each lap (360÷6).',
    narrator: 'Six sides, six 60-degree turns — honeycombs love this shape.',
    steps: const ['Add repeat 6 times.', 'Inside: move steps, then turn 60 degrees.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 6})],
    check: (script) {
      final ok = _repeatsIn(script).any((r) => _isPolygonRepeat(r, 6));
      if (!ok) return const LessonResult(false, 'Set repeat to 6 times and the turn to 60 degrees (360÷6).');
      return const LessonResult(true, 'That hexagon has real hex appeal! ⬡');
    },
  ),
  Lesson(
    id: 674,
    topicId: 'loops',
    title: 'Octagon Outline',
    glyph: '🛑',
    complexity: 1,
    target: 'Draw an octagon: repeat 8 times, turning 45 degrees each lap (360÷8).',
    narrator: 'Eight sides — just like a stop sign. Let the math pick the angle for you.',
    steps: const ['Add repeat 8 times.', 'Inside: move steps, then turn 45 degrees.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 8})],
    check: (script) {
      final ok = _repeatsIn(script).any((r) => _isPolygonRepeat(r, 8));
      if (!ok) return const LessonResult(false, 'Set repeat to 8 times and the turn to 45 degrees (360÷8).');
      return const LessonResult(true, 'Stop! ...and admire that octagon. 🛑');
    },
  ),
  Lesson(
    id: 675,
    topicId: 'loops',
    title: 'Perfect Ten',
    glyph: '🔟',
    complexity: 1,
    target: 'Draw a decagon: repeat 10 times, turning 36 degrees each lap (360÷10).',
    narrator: 'Ten sides, ten tiny 36-degree turns — starting to look almost round!',
    steps: const ['Add repeat 10 times.', 'Inside: move steps, then turn 36 degrees.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 10})],
    check: (script) {
      final ok = _repeatsIn(script).any((r) => _isPolygonRepeat(r, 10));
      if (!ok) return const LessonResult(false, 'Set repeat to 10 times and the turn to 36 degrees (360÷10).');
      return const LessonResult(true, 'Ten sides down — that is a perfect ten! 🔟');
    },
  ),

  // ---------------------------------------------------------------------
  // 676-700 — complexity 2-3: more polygons, stars, forever, motion
  // extras, and the first nested repeats (flowers).
  // ---------------------------------------------------------------------
  Lesson(
    id: 676,
    topicId: 'loops',
    title: 'Nonagon Nine',
    glyph: '9️⃣',
    complexity: 2,
    target: 'Draw a nonagon: repeat 9 times, turning 40 degrees each lap (360÷9).',
    narrator: 'Nine sides, nine 40-degree turns. My wheels are getting good at this.',
    steps: const ['Add repeat 9 times.', 'Inside: move steps, then turn 40 degrees.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 9})],
    check: (script) {
      final ok = _repeatsIn(script).any((r) => _isPolygonRepeat(r, 9));
      if (!ok) return const LessonResult(false, 'Set repeat to 9 times and the turn to 40 degrees (360÷9).');
      return const LessonResult(true, 'Nine crisp sides! 9️⃣');
    },
  ),
  Lesson(
    id: 677,
    topicId: 'loops',
    title: 'Twelve-Gon Triumph',
    glyph: '🕛',
    complexity: 2,
    target: 'Draw a 12-sided polygon: repeat 12 times, turning 30 degrees each lap (360÷12).',
    narrator: 'Twelve sides, like a clock face — 30 degrees between each tick.',
    steps: const ['Add repeat 12 times.', 'Inside: move steps, then turn 30 degrees.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 12})],
    check: (script) {
      final ok = _repeatsIn(script).any((r) => _isPolygonRepeat(r, 12));
      if (!ok) return const LessonResult(false, 'Set repeat to 12 times and the turn to 30 degrees (360÷12).');
      return const LessonResult(true, "Twelve sides — practically a clock! 🕛");
    },
  ),
  Lesson(
    id: 678,
    topicId: 'loops',
    title: 'Star Point',
    glyph: '⭐',
    complexity: 2,
    target: 'Draw a 5-pointed star: repeat 5 times, turning 144 degrees each lap.',
    narrator: 'Turn past 90 and something magical happens — points instead of corners!',
    steps: const ['Add repeat 5 times.', 'Inside: move steps, then turn 144 degrees (not 72 this time!).'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 5})],
    check: (script) {
      final ok = _repeatsIn(script).any((r) => _isStarRepeat(r, 5, 144));
      if (!ok) return const LessonResult(false, 'Set repeat to 5 times and the turn to 144 degrees to make a star, not a pentagon.');
      return const LessonResult(true, 'You just drew a star! ⭐');
    },
  ),
  Lesson(
    id: 679,
    topicId: 'loops',
    title: 'Bigger, Bolder Star',
    glyph: '🌟',
    complexity: 2,
    target: 'Draw a bigger 5-pointed star by using a longer move (at least 50 steps).',
    narrator: 'Same star, longer legs — let it fill the whole valley.',
    steps: const ['Keep repeat 5, turn 144.', 'Make the move block 50 steps or more.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 5}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 20}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 144}),
        ])],
    check: (script) {
      final star = _repeatsIn(script).where((r) => _isStarRepeat(r, 5, 144)).toList();
      if (star.isEmpty) return const LessonResult(false, 'Keep repeat 5 times, turn 144 degrees, to make the star.');
      final move = star.first.body.firstWhere((b) => b.defId == 'motion_move_steps', orElse: () => BlockInstance('none'));
      if ((_n(move.inputs['steps']) ?? 0) < 50) {
        return const LessonResult(false, 'Make the move block at least 50 steps for a bigger star.');
      }
      return const LessonResult(true, 'Now THAT is a bold star. 🌟');
    },
  ),
  Lesson(
    id: 680,
    topicId: 'loops',
    title: 'Forever Square',
    glyph: '♾️',
    complexity: 2,
    target: "Put your square-drawing repeat inside a 'forever' block so it draws non-stop.",
    narrator: "Why draw one square when I can draw it forever?",
    steps: const ["Add a 'forever' block from Control.", 'Move your repeat 4 [move, turn 90] block inside it.'],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block to your script.");
      final ok = forever.first.body.any((b) => _isPolygonRepeat(b, 4));
      if (!ok) return const LessonResult(false, 'Put a square repeat (4 times, turn 90) inside the forever block.');
      return const LessonResult(true, 'An endless square parade! ♾️');
    },
  ),
  Lesson(
    id: 681,
    topicId: 'loops',
    title: 'Animated Square',
    glyph: '🎞️',
    complexity: 2,
    target: 'Add a wait inside the forever block so each square draws with a visible pause.',
    narrator: 'Forever is fast — a wait lets everyone actually watch me draw.',
    steps: const ['Keep the forever + square repeat.', "Add a 'wait' block inside forever, after the repeat."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 60}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Keep the 'forever' block.");
      final body = forever.first.body;
      if (!body.any((b) => _isPolygonRepeat(b, 4))) {
        return const LessonResult(false, 'Keep the square repeat inside forever.');
      }
      final wait = body.where((b) => b.defId == 'control_wait').toList();
      if (wait.isEmpty || (_n(wait.first.inputs['seconds']) ?? 0) <= 0) {
        return const LessonResult(false, 'Add a wait block inside forever, set above 0 seconds.');
      }
      return const LessonResult(true, 'Smooth, paced, endless squares. 🎞️');
    },
  ),
  Lesson(
    id: 682,
    topicId: 'loops',
    title: 'Two Shapes, One Script',
    glyph: '🔺⬜',
    complexity: 2,
    target: 'Draw a triangle, then a square, one after another in the same script.',
    narrator: 'Two shapes, back to back — my gallery is growing.',
    steps: const ['Add repeat 3 [move, turn 120] (triangle).', 'Then add repeat 4 [move, turn 90] (square) after it.'],
    starter: () => [],
    check: (script) {
      final tri = script.indexWhere((b) => _isPolygonRepeat(b, 3));
      final sq = script.indexWhere((b) => _isPolygonRepeat(b, 4));
      if (tri == -1) return const LessonResult(false, 'Add a triangle repeat (3 times, turn 120) first.');
      if (sq == -1) return const LessonResult(false, 'Add a square repeat (4 times, turn 90) after the triangle.');
      if (tri > sq) return const LessonResult(false, 'Draw the triangle BEFORE the square.');
      return const LessonResult(true, 'Two shapes, one confident script! 🔺⬜');
    },
  ),
  Lesson(
    id: 683,
    topicId: 'loops',
    title: 'Announce Each Shape',
    glyph: '🗣️',
    complexity: 2,
    target: 'Say the name of each shape right after you draw it.',
    narrator: 'A good tour guide names every stop along the way.',
    steps: const ['Keep your triangle then square.', "Add 'say' after each shape with its name."],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 3}, body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 60}),
        BlockInstance('motion_turn_right', inputs: {'degrees': 120}),
      ]),
      BlockInstance('control_repeat', inputs: {'times': 4}, body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 60}),
        BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
      ]),
    ],
    check: (script) {
      if (!script.any((b) => _isPolygonRepeat(b, 3)) || !script.any((b) => _isPolygonRepeat(b, 4))) {
        return const LessonResult(false, 'Keep both the triangle and square repeats.');
      }
      final says = script.where((b) => b.defId == 'looks_say').toList();
      if (says.length < 2) return const LessonResult(false, 'Add two say blocks — one for each shape.');
      final texts = says.map((s) => s.inputs['text']?.toString().trim() ?? '').toList();
      if (texts.any((t) => t.isEmpty)) return const LessonResult(false, 'Give every say block real text.');
      if (texts[0] == texts[1]) return const LessonResult(false, 'Use a different name for each shape.');
      return const LessonResult(true, 'A well-narrated shape tour! 🗣️');
    },
  ),
  Lesson(
    id: 684,
    topicId: 'loops',
    title: 'Count As You Go',
    glyph: '➕',
    complexity: 2,
    target: "Change Score by 1 for every SIDE drawn, right inside the repeat's body.",
    narrator: 'Instead of counting shapes, let\'s count every single side as I draw it.',
    steps: const ['Keep a shape repeat.', "Inside the repeat's body, add 'change Score by 1' after the turn."],
    starter: () => [
      BlockInstance('control_repeat', inputs: {'times': 5}, body: [
        BlockInstance('motion_move_steps', inputs: {'steps': 60}),
        BlockInstance('motion_turn_right', inputs: {'degrees': 72}),
      ]),
    ],
    check: (script) {
      final repeats = _repeatsIn(script);
      final r = repeats.firstWhere(
        (r) => r.body.any((b) => b.defId == 'variables_change' && (_n(b.inputs['value']) ?? 0) > 0),
        orElse: () => BlockInstance('none'),
      );
      if (r.defId == 'none') {
        return const LessonResult(false, "Put a 'change Score by 1' block INSIDE the repeat's body, not after it.");
      }
      if (!_hasMoveForward(r.body) || _firstTurn(r.body) == null) {
        return const LessonResult(false, 'Keep move and turn blocks inside the repeat too.');
      }
      return const LessonResult(true, 'Every side counted — nice bookkeeping! ➕');
    },
  ),
  Lesson(
    id: 685,
    topicId: 'loops',
    title: 'Reposition and Draw',
    glyph: '📍',
    complexity: 3,
    target: "Use 'go to x y' to reset Process's position, then draw a square from there.",
    narrator: "Before I draw, let's make sure I start from exactly the right spot.",
    steps: const ["Add 'go to x: 0 y: 0' from Motion.", 'Then add your square repeat after it.'],
    starter: () => [],
    check: (script) {
      final idxGoto = script.indexWhere((b) => b.defId == 'motion_goto_xy');
      if (idxGoto == -1) return const LessonResult(false, "Add a 'go to x y' block from Motion.");
      final idxSq = script.indexWhere((b) => _isPolygonRepeat(b, 4));
      if (idxSq == -1) return const LessonResult(false, 'Add a square repeat (4 times, turn 90).');
      if (idxGoto > idxSq) return const LessonResult(false, "Position with 'go to x y' BEFORE drawing the square.");
      return const LessonResult(true, 'Positioned perfectly, then drawn perfectly. 📍');
    },
  ),
  Lesson(
    id: 686,
    topicId: 'loops',
    title: 'Face First',
    glyph: '🧭',
    complexity: 3,
    target: 'Point Process in a chosen direction before drawing a pentagon.',
    narrator: 'Which way I start facing changes which way the whole pentagon leans.',
    steps: const ["Add 'point in direction' from Motion.", 'Then add your pentagon repeat (5 times, turn 72) after it.'],
    starter: () => [],
    check: (script) {
      final idxPoint = script.indexWhere((b) => b.defId == 'motion_point_direction');
      if (idxPoint == -1) return const LessonResult(false, "Add a 'point in direction' block from Motion.");
      final idxPent = script.indexWhere((b) => _isPolygonRepeat(b, 5));
      if (idxPent == -1) return const LessonResult(false, 'Add a pentagon repeat (5 times, turn 72).');
      if (idxPoint > idxPent) return const LessonResult(false, 'Point in a direction BEFORE drawing the pentagon.');
      return const LessonResult(true, 'Facing just right before the first side. 🧭');
    },
  ),
  Lesson(
    id: 687,
    topicId: 'loops',
    title: 'Slide Over',
    glyph: '↔️',
    complexity: 3,
    target: 'Draw a triangle, slide sideways with change x, then draw a square next to it.',
    narrator: "No overlapping art — let's slide over before starting the next shape.",
    steps: const ['Add a triangle repeat.', "Add 'change x by' with a nonzero amount.", 'Add a square repeat after that.'],
    starter: () => [],
    check: (script) {
      final idxTri = script.indexWhere((b) => _isPolygonRepeat(b, 3));
      final idxSlide = script.indexWhere((b) => b.defId == 'motion_change_x' && (_n(b.inputs['amount']) ?? 0) != 0);
      final idxSq = script.indexWhere((b) => _isPolygonRepeat(b, 4));
      if (idxTri == -1) return const LessonResult(false, 'Add a triangle repeat (3 times, turn 120) first.');
      if (idxSlide == -1) return const LessonResult(false, "Add a 'change x by' block with a nonzero amount.");
      if (idxSq == -1) return const LessonResult(false, 'Add a square repeat (4 times, turn 90) after that.');
      if (!(idxTri < idxSlide && idxSlide < idxSq)) {
        return const LessonResult(false, 'Order matters: triangle, then slide, then square.');
      }
      return const LessonResult(true, 'Slid right over — no overlapping shapes! ↔️');
    },
  ),
  Lesson(
    id: 688,
    topicId: 'loops',
    title: 'Hide, Draw, Show',
    glyph: '🫥',
    complexity: 3,
    target: 'Hide Process while repositioning, then show it again right before drawing.',
    narrator: "Sometimes I like to sneak into position before making my big reveal.",
    steps: const ["Add 'hide' from Looks.", 'Add your shape repeat.', "Add 'show' from Looks right before it draws."],
    starter: () => [],
    check: (script) {
      final idxHide = script.indexWhere((b) => b.defId == 'looks_hide');
      final idxShow = script.indexWhere((b) => b.defId == 'looks_show');
      final idxShape = script.indexWhere((b) => b.defId == 'control_repeat' && _hasMoveForward(cqFlatten(b.body)));
      if (idxHide == -1) return const LessonResult(false, "Add a 'hide' block from Looks.");
      if (idxShow == -1) return const LessonResult(false, "Add a 'show' block from Looks.");
      if (idxShape == -1) return const LessonResult(false, 'Keep a shape-drawing repeat block.');
      if (!(idxHide < idxShow && idxShow < idxShape)) {
        return const LessonResult(false, 'Order: hide, then show, then draw the shape.');
      }
      return const LessonResult(true, 'A sneaky entrance and a big reveal! 🫥');
    },
  ),
  Lesson(
    id: 689,
    topicId: 'loops',
    title: 'Edge Watch',
    glyph: '🚧',
    complexity: 3,
    target: "Add an 'if on edge' safety block inside your forever-square loop.",
    narrator: "Drawing forever is risky near the edges — let's keep a watchful eye.",
    steps: const ['Keep forever + square repeat.', "Add 'if on edge' from Control inside the forever, with a wait inside it."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 60}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Keep the 'forever' block.");
      final body = forever.first.body;
      if (!body.any((b) => _isPolygonRepeat(b, 4))) {
        return const LessonResult(false, 'Keep the square repeat inside forever.');
      }
      if (!body.any((b) => b.defId == 'control_if_on_edge')) {
        return const LessonResult(false, "Add an 'if on edge' block inside the forever loop too.");
      }
      return const LessonResult(true, 'A watchful loop — safe and steady. 🚧');
    },
  ),
  Lesson(
    id: 690,
    topicId: 'loops',
    title: 'Bounce Break',
    glyph: '🏓',
    complexity: 3,
    target: "Add 'if on edge, bounce' inside your forever-square loop so Process never rolls off the map.",
    narrator: "Instead of just watching for the edge, let's actually bounce off it!",
    steps: const ['Keep forever + square repeat.', "Add 'if on edge, bounce' from Motion inside the forever loop."],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 60}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Keep the 'forever' block.");
      final body = forever.first.body;
      if (!body.any((b) => _isPolygonRepeat(b, 4))) {
        return const LessonResult(false, 'Keep the square repeat inside forever.');
      }
      if (!body.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Add 'if on edge, bounce' inside the forever loop too.");
      }
      return const LessonResult(true, 'Bouncing and drawing — best of both! 🏓');
    },
  ),
  Lesson(
    id: 691,
    topicId: 'loops',
    title: 'Spiral Square Start',
    glyph: '🌀',
    complexity: 3,
    target: 'Draw a spiral by adding a small extra turn AFTER each square, inside forever.',
    narrator: "If I nudge my angle a little extra every lap, the square starts to spiral outward!",
    steps: const ['Keep forever + square repeat.', 'Add a small turn (like 10 degrees) inside forever, after the repeat.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 40}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Keep the 'forever' block.");
      final body = forever.first.body;
      if (!body.any((b) => _isPolygonRepeat(b, 4))) {
        return const LessonResult(false, 'Keep the square repeat inside forever.');
      }
      final extraTurn = body.where((b) => b.defId != 'control_repeat').toList();
      final turn = _firstTurn(extraTurn);
      if (turn == null || (_n(turn.inputs['degrees']) ?? 0) == 0) {
        return const LessonResult(false, 'Add a nonzero turn inside forever, OUTSIDE the repeat, to create the spiral drift.');
      }
      return const LessonResult(true, 'A spiraling square — mesmerizing! 🌀');
    },
  ),
  Lesson(
    id: 692,
    topicId: 'loops',
    title: 'Spiral Triangle',
    glyph: '🌪️',
    complexity: 3,
    target: 'Do the same spiral trick with a triangle instead of a square.',
    narrator: "Any shape can spiral — let's try it with three sides this time.",
    steps: const ['Add forever with repeat 3 [move, turn 120] inside.', 'Add a small turn after the repeat, inside forever.'],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 3}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 40}),
          BlockInstance('motion_turn_left', inputs: {'degrees': 120}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Keep the 'forever' block.");
      final body = forever.first.body;
      if (!body.any((b) => _isPolygonRepeat(b, 3))) {
        return const LessonResult(false, 'Keep a triangle repeat (3 times, turn 120) inside forever.');
      }
      final extraTurn = body.where((b) => b.defId != 'control_repeat').toList();
      final turn = _firstTurn(extraTurn);
      if (turn == null || (_n(turn.inputs['degrees']) ?? 0) == 0) {
        return const LessonResult(false, 'Add a nonzero turn inside forever, OUTSIDE the repeat.');
      }
      return const LessonResult(true, 'A spinning triangle spiral! 🌪️');
    },
  ),
  Lesson(
    id: 693,
    topicId: 'loops',
    title: 'Flower Seed: Squares x4',
    glyph: '🌼',
    complexity: 3,
    target: 'Nest a repeat inside a repeat: 4 squares arranged around a point like flower petals.',
    narrator: "Time for a repeat INSIDE a repeat — one square, drawn four times, rotating each time.",
    steps: const [
      'Add an outer repeat 4 times.',
      'Inside it, put an inner repeat 4 [move, turn 90] (a whole square).',
      'After the inner repeat (still inside the outer one), add a turn of 90 degrees.',
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final flower = _findOuterFlower(script, 4, 4);
      if (flower == null) {
        return const LessonResult(
          false,
          'Build repeat 4 [ repeat 4 [move, turn 90], turn 90 ] — a square inside, rotated between petals.',
        );
      }
      return const LessonResult(true, "You grew a flower out of squares! 🌼");
    },
  ),
  Lesson(
    id: 694,
    topicId: 'loops',
    title: 'Six-Petal Square Flower',
    glyph: '🌸',
    complexity: 3,
    target: 'Grow a bigger flower: 6 squares arranged around a point, 60 degrees apart.',
    narrator: 'More petals means a smaller angle between them — 360 divided by 6 this time.',
    steps: const ['Build repeat 6 [ repeat 4 [move, turn 90], turn 60 ].'],
    starter: () => [],
    check: (script) {
      final flower = _findOuterFlower(script, 4, 6);
      if (flower == null) {
        return const LessonResult(false, 'Build repeat 6 [ repeat 4 [move, turn 90], turn 60 ] for 6 petals.');
      }
      return const LessonResult(true, 'Six petals, perfectly spaced! 🌸');
    },
  ),
  Lesson(
    id: 695,
    topicId: 'loops',
    title: 'Flower Progress Report',
    glyph: '📣',
    complexity: 3,
    target: 'Add a say block announcing your progress while growing the six-petal flower.',
    narrator: "Let's keep everyone posted while the flower blooms.",
    steps: const ['Keep the six-petal square flower.', "Add a 'say' block with some text."],
    starter: () => [],
    check: (script) {
      final flower = _findOuterFlower(script, 4, 6);
      if (flower == null) return const LessonResult(false, 'Keep repeat 6 [ repeat 4 [move, turn 90], turn 60 ].');
      final say = cqFlatten(script).where((b) => b.defId == 'looks_say' && (b.inputs['text']?.toString().trim().isNotEmpty ?? false));
      if (say.isEmpty) return const LessonResult(false, "Add a 'say' block with real text.");
      return const LessonResult(true, 'Blooming AND narrating — impressive! 📣');
    },
  ),
  Lesson(
    id: 696,
    topicId: 'loops',
    title: 'Count The Petals',
    glyph: '🌺',
    complexity: 3,
    target: 'Set Score to 0, then change Score by 1 for every petal grown.',
    narrator: 'Six petals deserve six points — one for each square drawn.',
    steps: const ['Set Score to 0 before the flower.', "Inside the OUTER repeat's body (not the inner one), add 'change Score by 1'."],
    starter: () => [],
    check: (script) {
      final idxSet = script.indexWhere((b) => b.defId == 'variables_set' && (_n(b.inputs['value']) ?? -1) == 0);
      if (idxSet == -1) return const LessonResult(false, 'Set Score to 0 before drawing the flower.');
      final flower = _findOuterFlower(script, 4, 6);
      if (flower == null) return const LessonResult(false, 'Keep repeat 6 [ repeat 4 [move, turn 90], turn 60 ].');
      final outerExtras = flower.body.where((b) => b.defId != 'control_repeat').toList();
      final hasChange = outerExtras.any((b) => b.defId == 'variables_change' && (_n(b.inputs['value']) ?? 0) > 0);
      if (!hasChange) {
        return const LessonResult(false, "Add 'change Score by 1' inside the outer repeat, alongside the turn.");
      }
      return const LessonResult(true, 'Six petals, six points — perfectly counted! 🌺');
    },
  ),
  Lesson(
    id: 697,
    topicId: 'loops',
    title: 'Petal Pause',
    glyph: '⏸️',
    complexity: 3,
    target: 'Add a wait between petals so the flower visibly blooms one petal at a time.',
    narrator: "Let's slow it down so people can watch each petal appear.",
    steps: const ['Keep the six-petal flower.', "Inside the outer repeat, add a 'wait' block."],
    starter: () => [],
    check: (script) {
      final flower = _findOuterFlower(script, 4, 6);
      if (flower == null) return const LessonResult(false, 'Keep repeat 6 [ repeat 4 [move, turn 90], turn 60 ].');
      final outerExtras = flower.body.where((b) => b.defId != 'control_repeat').toList();
      final wait = outerExtras.where((b) => b.defId == 'control_wait').toList();
      if (wait.isEmpty || (_n(wait.first.inputs['seconds']) ?? 0) <= 0) {
        return const LessonResult(false, 'Add a wait block (above 0 seconds) inside the outer repeat.');
      }
      return const LessonResult(true, 'One petal at a time — beautiful pacing! ⏸️');
    },
  ),
  Lesson(
    id: 698,
    topicId: 'loops',
    title: 'Triple Star Trio',
    glyph: '✨',
    complexity: 3,
    target: 'Grow 3 stars around a point instead of squares: repeat 3 [ star, turn 120 ].',
    narrator: 'Petals do not have to be squares — let\'s make them stars this time.',
    steps: const ['Build repeat 3 [ repeat 5 [move, turn 144], turn 120 ] (360÷3 = 120).'],
    starter: () => [],
    check: (script) {
      final trio = _findOuterStarFlower(script, 5, 144, 3);
      if (trio == null) {
        return const LessonResult(false, 'Build repeat 3 [ repeat 5 [move, turn 144], turn 120 ] for three stars.');
      }
      return const LessonResult(true, 'Three stars, evenly spaced — dazzling! ✨');
    },
  ),
  Lesson(
    id: 699,
    topicId: 'loops',
    title: 'Finishing Click',
    glyph: '🔔',
    complexity: 3,
    target: 'Play a click sound once the six-petal flower is completely finished.',
    narrator: 'A little chime for the finished bloom.',
    steps: const ['Keep the six-petal flower.', "After the outer repeat, add 'play sound' from Sound."],
    starter: () => [],
    check: (script) {
      final flower = _findOuterFlower(script, 4, 6);
      if (flower == null) return const LessonResult(false, 'Keep repeat 6 [ repeat 4 [move, turn 90], turn 60 ].');
      final idxFlower = script.indexOf(flower);
      final idxClick = script.indexWhere((b) => b.defId == 'sound_play_click');
      if (idxClick == -1) return const LessonResult(false, "Add a 'play sound' block from Sound.");
      if (idxFlower != -1 && idxClick < idxFlower) {
        return const LessonResult(false, 'Play the click AFTER the flower finishes, not before.');
      }
      return const LessonResult(true, 'Ding! The flower is complete. 🔔');
    },
  ),
  Lesson(
    id: 700,
    topicId: 'loops',
    title: 'Mid-Valley Showcase',
    glyph: '🎪',
    complexity: 3,
    target: 'Grow the six-petal flower forever, with a wait, a say, and a growing Score all together.',
    narrator: "Let's combine everything we've learned so far into one endless bloom show.",
    steps: const [
      "Wrap repeat 6 [ repeat 4 [move, turn 90], turn 60 ] inside a 'forever' block.",
      'Inside the outer repeat, keep a wait AND a say AND a change Score by 1.',
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Wrap everything in a 'forever' block.");
      final flower = _findOuterFlower(forever.first.body, 4, 6);
      if (flower == null) {
        return const LessonResult(false, 'Inside forever, build repeat 6 [ repeat 4 [move, turn 90], turn 60 ].');
      }
      final extras = flower.body.where((b) => b.defId != 'control_repeat').toList();
      final hasWait = extras.any((b) => b.defId == 'control_wait' && (_n(b.inputs['seconds']) ?? 0) > 0);
      final hasSay = extras.any((b) => b.defId == 'looks_say' && (b.inputs['text']?.toString().trim().isNotEmpty ?? false));
      final hasChange = extras.any((b) => b.defId == 'variables_change' && (_n(b.inputs['value']) ?? 0) > 0);
      if (!hasWait) return const LessonResult(false, 'Keep a wait block inside the outer repeat.');
      if (!hasSay) return const LessonResult(false, 'Keep a say block with real text inside the outer repeat.');
      if (!hasChange) return const LessonResult(false, 'Keep a change Score by 1 block inside the outer repeat.');
      return const LessonResult(true, 'An endless, narrated, counted bloom show! 🎪');
    },
  ),

  // ---------------------------------------------------------------------
  // 701-720 — complexity 4-5: deep nesting, mandalas, and full showcases.
  // ---------------------------------------------------------------------
  Lesson(
    id: 701,
    topicId: 'loops',
    title: 'Grid of Squares',
    glyph: '🔳',
    complexity: 4,
    target: 'Draw a row of 3 squares: repeat 3 [ go to x y, repeat 4 [move, turn 90] ].',
    narrator: "Instead of rotating between shapes, let's SLIDE between them to build a row.",
    steps: const [
      'Add an outer repeat 3 times.',
      "Inside it, add 'go to x y' first, then a square repeat (4 times, turn 90).",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      for (final r in _repeatsIn(script)) {
        if (_n(r.inputs['times'])?.round() != 3) continue;
        final hasGoto = r.body.any((b) => b.defId == 'motion_goto_xy');
        final inner = r.body.firstWhere((b) => b.defId == 'control_repeat', orElse: () => BlockInstance('none'));
        if (hasGoto && inner.defId != 'none' && _isPolygonRepeat(inner, 4)) {
          return const LessonResult(true, 'A whole grid of squares, neatly placed! 🔳');
        }
      }
      return const LessonResult(
        false,
        "Outer repeat 3 times: add 'go to x y' first, then repeat 4 [move, turn 90] for each square.",
      );
    },
  ),
  Lesson(
    id: 702,
    topicId: 'loops',
    title: 'Spiral Galaxy',
    glyph: '🌌',
    complexity: 4,
    target: 'Combine the spiral-square trick with a wait so the galaxy grows visibly, one lap at a time.',
    narrator: 'A spiral looks even better in slow motion.',
    steps: const [
      "Inside 'forever', keep repeat 4 [move, turn 90].",
      'After the repeat (still inside forever), add a small extra turn AND a wait.',
    ],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 30}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Keep the 'forever' block.");
      final body = forever.first.body;
      if (!body.any((b) => _isPolygonRepeat(b, 4))) {
        return const LessonResult(false, 'Keep the square repeat inside forever.');
      }
      final extras = body.where((b) => b.defId != 'control_repeat').toList();
      final turn = _firstTurn(extras);
      final wait = extras.where((b) => b.defId == 'control_wait').toList();
      if (turn == null || (_n(turn.inputs['degrees']) ?? 0) == 0) {
        return const LessonResult(false, 'Add a nonzero turn inside forever, outside the repeat.');
      }
      if (wait.isEmpty || (_n(wait.first.inputs['seconds']) ?? 0) <= 0) {
        return const LessonResult(false, 'Add a wait block (above 0 seconds) inside forever too.');
      }
      return const LessonResult(true, 'A slow, sprawling spiral galaxy! 🌌');
    },
  ),
  Lesson(
    id: 703,
    topicId: 'loops',
    title: 'Double Star Offset',
    glyph: '💫',
    complexity: 4,
    target: 'Draw two 5-pointed stars, reorienting Process between them.',
    narrator: 'Two stars are more interesting when the second one leans a different way.',
    steps: const [
      'Add a star repeat (5 times, turn 144).',
      "Add a 'turn' or 'point in direction' block to reorient.",
      'Add another star repeat after that.',
    ],
    starter: () => [],
    check: (script) {
      final stars = script.where((b) => _isStarRepeat(b, 5, 144)).toList();
      if (stars.length < 2) return const LessonResult(false, 'Add two separate star repeats (5 times, turn 144 each).');
      final idx1 = script.indexOf(stars[0]);
      final idx2 = script.indexOf(stars[1]);
      final between = script.sublist(idx1 + 1, idx2);
      final reoriented = between.any(
        (b) =>
            b.defId == 'motion_point_direction' ||
            ((b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left') && (_n(b.inputs['degrees']) ?? 0) != 0),
      );
      if (!reoriented) {
        return const LessonResult(false, 'Add a turn or point-in-direction block BETWEEN the two stars.');
      }
      return const LessonResult(true, 'Two stars, offset just right! 💫');
    },
  ),
  Lesson(
    id: 704,
    topicId: 'loops',
    title: 'Hexagon Flower Full Bloom',
    glyph: '🌻',
    complexity: 4,
    target: 'Grow 6 full hexagons arranged around a point: repeat 6 [ hexagon, turn 60 ].',
    narrator: 'Bigger petals this time — whole hexagons instead of squares.',
    steps: const ['Build repeat 6 [ repeat 6 [move, turn 60], turn 60 ].'],
    starter: () => [],
    check: (script) {
      final flower = _findOuterFlower(script, 6, 6);
      if (flower == null) return const LessonResult(false, 'Build repeat 6 [ repeat 6 [move, turn 60], turn 60 ].');
      return const LessonResult(true, 'A hexagon flower in full bloom! 🌻');
    },
  ),
  Lesson(
    id: 705,
    topicId: 'loops',
    title: 'Triangle Spiral Showcase',
    glyph: '🎇',
    complexity: 4,
    target: 'Spiral a triangle forever while pacing it with a wait and tallying laps in Score.',
    narrator: "A spiral, a wait, and a running tally — let's see it all together.",
    steps: const [
      "Inside 'forever', keep repeat 3 [move, turn 120].",
      'After the repeat (inside forever), add a nonzero turn, a wait, and a change Score by 1.',
    ],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 3}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 30}),
          BlockInstance('motion_turn_left', inputs: {'degrees': 120}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Keep the 'forever' block.");
      final body = forever.first.body;
      if (!body.any((b) => _isPolygonRepeat(b, 3))) {
        return const LessonResult(false, 'Keep the triangle repeat inside forever.');
      }
      final extras = body.where((b) => b.defId != 'control_repeat').toList();
      final turn = _firstTurn(extras);
      final wait = extras.where((b) => b.defId == 'control_wait').toList();
      final change = extras.where((b) => b.defId == 'variables_change').toList();
      if (turn == null || (_n(turn.inputs['degrees']) ?? 0) == 0) {
        return const LessonResult(false, 'Add a nonzero turn inside forever, outside the repeat.');
      }
      if (wait.isEmpty || (_n(wait.first.inputs['seconds']) ?? 0) <= 0) {
        return const LessonResult(false, 'Add a wait block (above 0 seconds).');
      }
      if (change.isEmpty || (_n(change.first.inputs['value']) ?? 0) <= 0) {
        return const LessonResult(false, 'Add a change Score by 1 block too.');
      }
      return const LessonResult(true, 'A spiraling, ticking, tallying triangle show! 🎇');
    },
  ),
  Lesson(
    id: 706,
    topicId: 'loops',
    title: 'Bounce & Draw',
    glyph: '🛡️',
    complexity: 4,
    target: "Combine both edge safety features: 'if on edge, bounce' AND an 'if on edge' block, inside a forever square loop.",
    narrator: 'Double protection — bounce away, and keep an extra watchful eye too.',
    steps: const [
      'Keep forever + square repeat.',
      "Add 'if on edge, bounce' from Motion inside forever.",
      "Add 'if on edge' from Control inside forever too, with something inside it.",
    ],
    starter: () => [
      BlockInstance('control_forever', body: [
        BlockInstance('control_repeat', inputs: {'times': 4}, body: [
          BlockInstance('motion_move_steps', inputs: {'steps': 50}),
          BlockInstance('motion_turn_right', inputs: {'degrees': 90}),
        ]),
      ]),
    ],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Keep the 'forever' block.");
      final body = forever.first.body;
      if (!body.any((b) => _isPolygonRepeat(b, 4))) {
        return const LessonResult(false, 'Keep the square repeat inside forever.');
      }
      if (!body.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Add 'if on edge, bounce' inside forever.");
      }
      if (!body.any((b) => b.defId == 'control_if_on_edge')) {
        return const LessonResult(false, "Add an 'if on edge' block inside forever too.");
      }
      return const LessonResult(true, 'Doubly protected and drawing forever! 🛡️');
    },
  ),
  Lesson(
    id: 707,
    topicId: 'loops',
    title: 'Tally The Sides',
    glyph: '🧾',
    complexity: 4,
    target: 'Set Score to 0, tally every side of a decagon (change Score by 1 per side), then announce the result.',
    narrator: 'Ten sides means Score should climb to ten if I tally correctly!',
    steps: const [
      'Set Score to 0 before your decagon.',
      "Inside the decagon repeat (10 times, turn 36), add 'change Score by 1'.",
      "After the repeat, add a 'say' block.",
    ],
    starter: () => [],
    check: (script) {
      final idxSet = script.indexWhere((b) => b.defId == 'variables_set' && (_n(b.inputs['value']) ?? -1) == 0);
      if (idxSet == -1) return const LessonResult(false, 'Set Score to 0 before the decagon.');
      final deca = script.firstWhere((b) => _isPolygonRepeat(b, 10), orElse: () => BlockInstance('none'));
      if (deca.defId == 'none') return const LessonResult(false, 'Build a decagon: repeat 10 times, turn 36.');
      final hasChange = deca.body.any((b) => b.defId == 'variables_change' && (_n(b.inputs['value']) ?? 0) > 0);
      if (!hasChange) return const LessonResult(false, "Add 'change Score by 1' inside the decagon's body.");
      final idxDeca = script.indexOf(deca);
      final say = script.where((b) => b.defId == 'looks_say').toList();
      if (say.isEmpty || script.indexOf(say.first) < idxDeca) {
        return const LessonResult(false, "Add a 'say' block after the decagon finishes.");
      }
      return const LessonResult(true, 'Ten sides, tallied and announced! 🧾');
    },
  ),
  Lesson(
    id: 708,
    topicId: 'loops',
    title: 'Double Flower',
    glyph: '🌺',
    complexity: 5,
    target:
        'Go three levels deep: repeat 2 [ repeat 3 [ repeat 4 [move, turn 90], turn 120 ], turn 180 ] — two flowers of squares.',
    narrator: "Petals inside petals — let's nest THREE repeats deep.",
    steps: const [
      'Build the innermost square: repeat 4 [move, turn 90].',
      'Wrap it: repeat 3 [ square, turn 120 ] — a 3-petal square flower (360÷3=120).',
      'Wrap THAT: repeat 2 [ flower, turn 180 ] — two flowers, 180 degrees apart (360÷2=180).',
    ],
    starter: () => [],
    check: (script) {
      for (final r in _repeatsIn(script)) {
        if (_n(r.inputs['times'])?.round() != 2) continue;
        final mid = r.body.firstWhere((b) => b.defId == 'control_repeat', orElse: () => BlockInstance('none'));
        if (mid.defId == 'none' || _n(mid.inputs['times'])?.round() != 3) continue;
        final inner = mid.body.firstWhere((b) => b.defId == 'control_repeat', orElse: () => BlockInstance('none'));
        if (inner.defId == 'none' || !_isPolygonRepeat(inner, 4)) continue;
        final midTurn = _firstTurn(mid.body.where((b) => b.defId != 'control_repeat').toList());
        if (midTurn == null || ((_n(midTurn.inputs['degrees']) ?? 0) - 120).abs() > 0.6) continue;
        final outerTurn = _firstTurn(r.body.where((b) => b.defId != 'control_repeat').toList());
        if (outerTurn == null || ((_n(outerTurn.inputs['degrees']) ?? 0) - 180).abs() > 0.6) continue;
        return const LessonResult(true, 'Three layers of repeats, all rotating in harmony — a true double flower! 🌺');
      }
      return const LessonResult(
        false,
        'Build repeat 2 [ repeat 3 [ repeat 4 [move, turn 90], turn 120 ], turn 180 ] — three levels deep!',
      );
    },
  ),
  Lesson(
    id: 709,
    topicId: 'loops',
    title: 'Five Stars Around',
    glyph: '🌟',
    complexity: 5,
    target: 'Arrange 5 stars around a point: repeat 5 [ star (5 times, turn 144), turn 72 ].',
    narrator: 'Five stars, evenly spaced by 72 degrees — the sky has never looked busier.',
    steps: const ['Build repeat 5 [ repeat 5 [move, turn 144], turn 72 ].'],
    starter: () => [],
    check: (script) {
      final ring = _findOuterStarFlower(script, 5, 144, 5);
      if (ring == null) {
        return const LessonResult(false, 'Build repeat 5 [ repeat 5 [move, turn 144], turn 72 ] for five stars.');
      }
      return const LessonResult(true, 'Five stars, perfectly arranged! 🌟');
    },
  ),
  Lesson(
    id: 710,
    topicId: 'loops',
    title: 'Infinite Square Counter',
    glyph: '🔁',
    complexity: 5,
    target: 'Forever: count a square, draw it, wait, and announce the running Score.',
    narrator: 'An endless counting machine, disguised as a square-drawing turtle.',
    steps: const [
      "Inside 'forever', add: change Score by 1, then repeat 4 [move, turn 90], then a wait, then a say.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forever.first.body;
      final hasChange = body.any((b) => b.defId == 'variables_change' && (_n(b.inputs['value']) ?? 0) > 0);
      final hasSquare = body.any((b) => _isPolygonRepeat(b, 4));
      final hasWait = body.any((b) => b.defId == 'control_wait' && (_n(b.inputs['seconds']) ?? 0) > 0);
      final hasSay = body.any((b) => b.defId == 'looks_say' && (b.inputs['text']?.toString().trim().isNotEmpty ?? false));
      if (!hasChange) return const LessonResult(false, 'Add a change Score by 1 block inside forever.');
      if (!hasSquare) return const LessonResult(false, 'Keep a square repeat (4 times, turn 90) inside forever.');
      if (!hasWait) return const LessonResult(false, 'Add a wait block (above 0 seconds) inside forever.');
      if (!hasSay) return const LessonResult(false, 'Add a say block with real text inside forever.');
      return const LessonResult(true, 'A tireless, talking, counting square machine! 🔁');
    },
  ),
  Lesson(
    id: 711,
    topicId: 'loops',
    title: 'Reset and Redraw',
    glyph: '🔄',
    complexity: 5,
    target: 'Draw a square, reposition with go to x y, then draw a triangle in the new spot.',
    narrator: "Two shapes, cleanly separated by a teleport in between.",
    steps: const ['Add a square repeat.', "Add 'go to x y' after it.", 'Add a triangle repeat after that.'],
    starter: () => [],
    check: (script) {
      final idxSq = script.indexWhere((b) => _isPolygonRepeat(b, 4));
      final idxGoto = script.indexWhere((b) => b.defId == 'motion_goto_xy');
      final idxTri = script.indexWhere((b) => _isPolygonRepeat(b, 3));
      if (idxSq == -1) return const LessonResult(false, 'Add a square repeat (4 times, turn 90) first.');
      if (idxGoto == -1) return const LessonResult(false, "Add a 'go to x y' block after the square.");
      if (idxTri == -1) return const LessonResult(false, 'Add a triangle repeat (3 times, turn 120) after that.');
      if (!(idxSq < idxGoto && idxGoto < idxTri)) {
        return const LessonResult(false, 'Order matters: square, then reposition, then triangle.');
      }
      return const LessonResult(true, 'Reset and redrawn — two clean shapes! 🔄');
    },
  ),
  Lesson(
    id: 712,
    topicId: 'loops',
    title: 'Orient Then Bloom',
    glyph: '🧭',
    complexity: 5,
    target: 'Point Process in a direction before growing the six-petal square flower.',
    narrator: 'The direction I start facing decides which way the whole flower leans.',
    steps: const ["Add 'point in direction' from Motion.", 'Then build repeat 6 [ repeat 4 [move, turn 90], turn 60 ].'],
    starter: () => [],
    check: (script) {
      final idxPoint = script.indexWhere((b) => b.defId == 'motion_point_direction');
      if (idxPoint == -1) return const LessonResult(false, "Add a 'point in direction' block from Motion.");
      final flower = _findOuterFlower(script, 4, 6);
      if (flower == null) return const LessonResult(false, 'Build repeat 6 [ repeat 4 [move, turn 90], turn 60 ].');
      if (idxPoint > script.indexOf(flower)) {
        return const LessonResult(false, 'Point in a direction BEFORE growing the flower.');
      }
      return const LessonResult(true, 'Oriented perfectly, then bloomed beautifully! 🧭');
    },
  ),
  Lesson(
    id: 713,
    topicId: 'loops',
    title: 'Pentagon Petals with Click',
    glyph: '🌷',
    complexity: 5,
    target: 'Grow 5 pentagons around a point, then play a click when finished: repeat 5 [ pentagon, turn 72 ].',
    narrator: 'Pentagon petals this time, with a satisfying chime at the end.',
    steps: const ['Build repeat 5 [ repeat 5 [move, turn 72], turn 72 ].', "Add 'play sound' after it finishes."],
    starter: () => [],
    check: (script) {
      final flower = _findOuterFlower(script, 5, 5);
      if (flower == null) return const LessonResult(false, 'Build repeat 5 [ repeat 5 [move, turn 72], turn 72 ].');
      final idxFlower = script.indexOf(flower);
      final idxClick = script.indexWhere((b) => b.defId == 'sound_play_click');
      if (idxClick == -1) return const LessonResult(false, "Add a 'play sound' block from Sound.");
      if (idxClick < idxFlower) return const LessonResult(false, 'Play the click AFTER the flower finishes.');
      return const LessonResult(true, 'Pentagon petals, finished with a chime! 🌷');
    },
  ),
  Lesson(
    id: 714,
    topicId: 'loops',
    title: 'Circle-ish Decagon Loop',
    glyph: '⭕',
    complexity: 5,
    target: 'Draw a decagon forever, paced with a wait, saying a comment when each one finishes.',
    narrator: 'Ten sides start looking almost round — let\'s watch it loop, slowly.',
    steps: const [
      "Inside 'forever', keep repeat 10 [move, turn 36].",
      'After the repeat (inside forever), add a wait and a say.',
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forever.first.body;
      if (!body.any((b) => _isPolygonRepeat(b, 10))) {
        return const LessonResult(false, 'Keep a decagon repeat (10 times, turn 36) inside forever.');
      }
      final extras = body.where((b) => b.defId != 'control_repeat').toList();
      final hasWait = extras.any((b) => b.defId == 'control_wait' && (_n(b.inputs['seconds']) ?? 0) > 0);
      final hasSay = extras.any((b) => b.defId == 'looks_say' && (b.inputs['text']?.toString().trim().isNotEmpty ?? false));
      if (!hasWait) return const LessonResult(false, 'Add a wait block inside forever.');
      if (!hasSay) return const LessonResult(false, 'Add a say block inside forever.');
      return const LessonResult(true, 'Perfect circle-ish loops, forever! ⭕');
    },
  ),
  Lesson(
    id: 715,
    topicId: 'loops',
    title: 'Total Turns Tally',
    glyph: '📊',
    complexity: 5,
    target: 'Draw a 12-gon, tally every side into Score (starting from 0), then announce the total.',
    narrator: 'Twelve sides means Score should reach twelve — let\'s prove the math.',
    steps: const [
      'Set Score to 0 first.',
      "Build repeat 12 [move, turn 30] with 'change Score by 1' inside its body too.",
      "Add a 'say' block after it finishes.",
    ],
    starter: () => [],
    check: (script) {
      final idxSet = script.indexWhere((b) => b.defId == 'variables_set' && (_n(b.inputs['value']) ?? -1) == 0);
      if (idxSet == -1) return const LessonResult(false, 'Set Score to 0 before the 12-gon.');
      final poly = script.firstWhere((b) => _isPolygonRepeat(b, 12), orElse: () => BlockInstance('none'));
      if (poly.defId == 'none') return const LessonResult(false, 'Build a 12-gon: repeat 12 times, turn 30.');
      final hasChange = poly.body.any((b) => b.defId == 'variables_change' && (_n(b.inputs['value']) ?? 0) > 0);
      if (!hasChange) return const LessonResult(false, "Add 'change Score by 1' inside the 12-gon's body.");
      final idxPoly = script.indexOf(poly);
      final say = script.where((b) => b.defId == 'looks_say').toList();
      if (say.isEmpty || script.indexOf(say.first) < idxPoly) {
        return const LessonResult(false, "Add a 'say' block after the 12-gon finishes.");
      }
      return const LessonResult(true, 'Twelve sides, twelve points, fully tallied! 📊');
    },
  ),
  Lesson(
    id: 716,
    topicId: 'loops',
    title: 'Pentagon Flower Mastery',
    glyph: '🎉',
    complexity: 5,
    target: 'Grow the 5-pentagon flower forever, with a wait, a say, AND a growing Score.',
    narrator: "The pentagon flower deserves the full showcase treatment too.",
    steps: const [
      'Wrap repeat 5 [ repeat 5 [move, turn 72], turn 72 ] inside a forever block.',
      'Inside the outer repeat, keep a wait, a say, and a change Score by 1.',
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Wrap everything in a 'forever' block.");
      final flower = _findOuterFlower(forever.first.body, 5, 5);
      if (flower == null) {
        return const LessonResult(false, 'Inside forever, build repeat 5 [ repeat 5 [move, turn 72], turn 72 ].');
      }
      final extras = flower.body.where((b) => b.defId != 'control_repeat').toList();
      final hasWait = extras.any((b) => b.defId == 'control_wait' && (_n(b.inputs['seconds']) ?? 0) > 0);
      final hasSay = extras.any((b) => b.defId == 'looks_say' && (b.inputs['text']?.toString().trim().isNotEmpty ?? false));
      final hasChange = extras.any((b) => b.defId == 'variables_change' && (_n(b.inputs['value']) ?? 0) > 0);
      if (!hasWait) return const LessonResult(false, 'Keep a wait block inside the outer repeat.');
      if (!hasSay) return const LessonResult(false, 'Keep a say block inside the outer repeat.');
      if (!hasChange) return const LessonResult(false, 'Keep a change Score by 1 block inside the outer repeat.');
      return const LessonResult(true, 'Pentagon flower mastery, fully showcased! 🎉');
    },
  ),
  Lesson(
    id: 717,
    topicId: 'loops',
    title: 'Star Parade',
    glyph: '🎆',
    complexity: 5,
    target: 'Draw 3 stars in a row by sliding sideways between them: repeat 3 [ star, change x by an amount ].',
    narrator: "This time petals do not rotate around a point — they march in a parade!",
    steps: const ['Build an outer repeat 3 times.', 'Inside: a star repeat (5 times, turn 144), then change x by a nonzero amount.'],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      for (final r in _repeatsIn(script)) {
        if (_n(r.inputs['times'])?.round() != 3) continue;
        final inner = r.body.firstWhere((b) => b.defId == 'control_repeat', orElse: () => BlockInstance('none'));
        if (inner.defId == 'none' || !_isStarRepeat(inner, 5, 144)) continue;
        final slide = r.body.where((b) => b.defId == 'motion_change_x' && (_n(b.inputs['amount']) ?? 0) != 0);
        if (slide.isEmpty) continue;
        return const LessonResult(true, 'A dazzling parade of stars! 🎆');
      }
      return const LessonResult(
        false,
        'Build repeat 3 [ repeat 5 [move, turn 144], change x by a nonzero amount ] to march the stars sideways.',
      );
    },
  ),
  Lesson(
    id: 718,
    topicId: 'loops',
    title: 'Ultimate Flower Show',
    glyph: '🏆',
    complexity: 5,
    target: 'The six-petal square flower, forever, with wait, say, sound, AND score — the full showcase.',
    narrator: "Everything I know, all in one endless bloom: pacing, narration, sound, and score.",
    steps: const [
      'Wrap repeat 6 [ repeat 4 [move, turn 90], turn 60 ] inside forever.',
      'Inside the outer repeat, keep a wait, a say, and a change Score by 1.',
      "After the outer repeat (still inside forever), add a 'play sound' block.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Wrap everything in a 'forever' block.");
      final foreverBody = forever.first.body;
      final flower = _findOuterFlower(foreverBody, 4, 6);
      if (flower == null) {
        return const LessonResult(false, 'Inside forever, build repeat 6 [ repeat 4 [move, turn 90], turn 60 ].');
      }
      final extras = flower.body.where((b) => b.defId != 'control_repeat').toList();
      final hasWait = extras.any((b) => b.defId == 'control_wait' && (_n(b.inputs['seconds']) ?? 0) > 0);
      final hasSay = extras.any((b) => b.defId == 'looks_say' && (b.inputs['text']?.toString().trim().isNotEmpty ?? false));
      final hasChange = extras.any((b) => b.defId == 'variables_change' && (_n(b.inputs['value']) ?? 0) > 0);
      if (!hasWait) return const LessonResult(false, 'Keep a wait block inside the outer repeat.');
      if (!hasSay) return const LessonResult(false, 'Keep a say block inside the outer repeat.');
      if (!hasChange) return const LessonResult(false, 'Keep a change Score by 1 block inside the outer repeat.');
      if (!foreverBody.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside forever, after the flower.");
      }
      return const LessonResult(true, 'The ultimate flower show — paced, narrated, and celebrated! 🏆');
    },
  ),
  Lesson(
    id: 719,
    topicId: 'loops',
    title: 'Mandala Master',
    glyph: '🕸️',
    complexity: 5,
    target:
        'Three levels deep, different numbers: repeat 4 [ repeat 3 [ repeat 6 [move, turn 60], turn 120 ], turn 90 ] — a mandala.',
    narrator: "The deepest pattern yet — hexagons, grouped in threes, grouped in fours.",
    steps: const [
      'Build the innermost hexagon: repeat 6 [move, turn 60].',
      'Wrap it: repeat 3 [ hexagon, turn 120 ] (360÷3=120).',
      'Wrap that: repeat 4 [ that group, turn 90 ] (360÷4=90).',
    ],
    starter: () => [],
    check: (script) {
      for (final r in _repeatsIn(script)) {
        if (_n(r.inputs['times'])?.round() != 4) continue;
        final mid = r.body.firstWhere((b) => b.defId == 'control_repeat', orElse: () => BlockInstance('none'));
        if (mid.defId == 'none' || _n(mid.inputs['times'])?.round() != 3) continue;
        final inner = mid.body.firstWhere((b) => b.defId == 'control_repeat', orElse: () => BlockInstance('none'));
        if (inner.defId == 'none' || !_isPolygonRepeat(inner, 6)) continue;
        final midTurn = _firstTurn(mid.body.where((b) => b.defId != 'control_repeat').toList());
        if (midTurn == null || ((_n(midTurn.inputs['degrees']) ?? 0) - 120).abs() > 0.6) continue;
        final outerTurn = _firstTurn(r.body.where((b) => b.defId != 'control_repeat').toList());
        if (outerTurn == null || ((_n(outerTurn.inputs['degrees']) ?? 0) - 90).abs() > 0.6) continue;
        return const LessonResult(true, 'A true mandala — three layers of perfect rotation! 🕸️');
      }
      return const LessonResult(
        false,
        'Build repeat 4 [ repeat 3 [ repeat 6 [move, turn 60], turn 120 ], turn 90 ] — three levels deep!',
      );
    },
  ),
  Lesson(
    id: 720,
    topicId: 'loops',
    title: 'Grand Finale',
    glyph: '🏁',
    complexity: 5,
    target:
        'The capstone: Score starts at 0, forever grows a flower (any regular-polygon petal) with wait, say, sound, and a rising Score — everything you have learned.',
    narrator: "This is it — every trick I've learned, rolled into one endless masterpiece.",
    steps: const [
      'Set Score to 0 before the forever block.',
      "Inside 'forever', build an outer-repeat flower: repeat N [ repeat sides [move, turn (360÷sides)], turn (360÷N) ].",
      'Inside that outer repeat, keep a wait, a say, and a change Score by 1.',
      "Inside forever (after the flower), add a 'play sound' block.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      final idxSet = script.indexWhere((b) => b.defId == 'variables_set' && (_n(b.inputs['value']) ?? -1) == 0);
      if (idxSet == -1) return const LessonResult(false, 'Set Score to 0 before the forever block.');
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block after resetting Score.");
      if (script.indexOf(forever.first) < idxSet) {
        return const LessonResult(false, 'Set Score to 0 BEFORE the forever block, not after.');
      }
      final foreverBody = forever.first.body;
      BlockInstance? flower;
      for (final r in cqFlatten(foreverBody).where((b) => b.defId == 'control_repeat')) {
        for (final sides in [3, 4, 5, 6, 8, 9, 10, 12]) {
          final f = _findOuterFlower([r], sides, (_n(r.inputs['times']) ?? -1).round());
          if (f != null) {
            flower = f;
            break;
          }
        }
        if (flower != null) break;
      }
      if (flower == null) {
        return const LessonResult(
          false,
          'Inside forever, build a flower: repeat N [ repeat sides [move, turn (360÷sides)], turn (360÷N) ].',
        );
      }
      final extras = flower.body.where((b) => b.defId != 'control_repeat').toList();
      final hasWait = extras.any((b) => b.defId == 'control_wait' && (_n(b.inputs['seconds']) ?? 0) > 0);
      final hasSay = extras.any((b) => b.defId == 'looks_say' && (b.inputs['text']?.toString().trim().isNotEmpty ?? false));
      final hasChange = extras.any((b) => b.defId == 'variables_change' && (_n(b.inputs['value']) ?? 0) > 0);
      if (!hasWait) return const LessonResult(false, 'Keep a wait block inside the outer repeat of the flower.');
      if (!hasSay) return const LessonResult(false, 'Keep a say block inside the outer repeat of the flower.');
      if (!hasChange) return const LessonResult(false, 'Keep a change Score by 1 block inside the outer repeat.');
      if (!foreverBody.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside forever, after the flower.");
      }
      return const LessonResult(true, 'The Grand Finale — a true Loop-the-Loop Valley masterpiece! 🏁');
    },
  ),
];
