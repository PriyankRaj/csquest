import '../models/cq_models.dart';
import 'cq_blocks.dart';

/// "Build a Teleporter" — Coordinate Cove. 60 lessons (601-660) built entirely
/// around motion_goto_xy, growing from a single exact-coordinate jump up to
/// deeply nested forever/repeat teleporter circuits that touch every block
/// in the engine. Turtu narrates throughout as the wheeled turtle.

num _numOf(BlockInstance b, String key) => (b.inputs[key] as num?) ?? 0;
String _textOf(BlockInstance b, String key) => (b.inputs[key] as String?) ?? '';
String _xy(BlockInstance b) => '${_numOf(b, 'x')},${_numOf(b, 'y')}';

const _motionIds = {
  'motion_move_steps',
  'motion_turn_right',
  'motion_turn_left',
  'motion_point_direction',
  'motion_change_x',
  'motion_change_y',
  'motion_goto_xy',
  'motion_if_on_edge_bounce',
};
const _controlIds = {'control_forever', 'control_repeat', 'control_wait', 'control_if_on_edge'};
const _looksIds = {'looks_say', 'looks_show', 'looks_hide'};
const _soundIds = {'sound_play_click'};
const _variablesIds = {'variables_set', 'variables_change'};

bool _isTurn(BlockInstance b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left';

final cqGotoXyLessons = <Lesson>[
  Lesson(
    id: 601,
    topicId: 'goto-xy',
    title: 'Blink to Point A',
    glyph: '📍',
    complexity: 1,
    target: 'Teleport Turtu to an exact spot with go to x y.',
    narrator: "Forget rolling all that way — just tell me where to appear!",
    steps: const ["Open the Motion tray.", "Tap 'go to x: y:' and add it.", "Set x to 50, then tap Run."],
    starter: () => [],
    check: (script) {
      final gotos = cqFlatten(script).where((b) => b.defId == 'motion_goto_xy').toList();
      if (gotos.isEmpty) return const LessonResult(false, "Add a 'go to x y' block from Motion.");
      final g = gotos.first;
      if (_numOf(g, 'x') == 0 && _numOf(g, 'y') == 0) {
        return const LessonResult(false, "Set x or y to something other than 0 so I actually teleport.");
      }
      return const LessonResult(true, "Blink! I'm there. 📍");
    },
  ),
  Lesson(
    id: 602,
    topicId: 'goto-xy',
    title: 'Underground',
    glyph: '🕳️',
    complexity: 1,
    target: 'Teleport to negative x AND negative y.',
    narrator: "Negative numbers work too — let's go the other direction!",
    steps: const ["Add a 'go to x y' block.", "Make BOTH x and y negative numbers.", "Run and watch where I land."],
    starter: () => [],
    check: (script) {
      final g = cqFlatten(script).where((b) => b.defId == 'motion_goto_xy').toList();
      if (g.isEmpty) return const LessonResult(false, "Add a 'go to x y' block.");
      if (!g.any((b) => _numOf(b, 'x') < 0 && _numOf(b, 'y') < 0)) {
        return const LessonResult(false, "Make both x AND y negative numbers.");
      }
      return const LessonResult(true, "Straight into the deep corner. 🕳️");
    },
  ),
  Lesson(
    id: 603,
    topicId: 'goto-xy',
    title: 'Announce Arrival',
    glyph: '📣',
    complexity: 1,
    target: 'Teleport, then say something right after.',
    narrator: "A good teleporter always announces itself!",
    steps: const ["Add 'go to x y' (Motion).", "Add a 'say' block (Looks) right after it.", "Type any message."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final iG = flat.indexWhere((b) => b.defId == 'motion_goto_xy');
      final iS = flat.indexWhere((b) => b.defId == 'looks_say');
      if (iG == -1) return const LessonResult(false, "Add a 'go to x y' block.");
      if (iS == -1) return const LessonResult(false, "Add a 'say' block after it.");
      if (iS < iG) return const LessonResult(false, "Put the 'say' block AFTER the teleport.");
      return const LessonResult(true, "Ta-da! Announced. 📣");
    },
  ),
  Lesson(
    id: 604,
    topicId: 'goto-xy',
    title: 'Back to Home Base',
    glyph: '🏠',
    complexity: 1,
    target: 'Teleport exactly to x:0, y:0 — dead center.',
    narrator: "Every teleporter needs a home button — that's x:0, y:0.",
    steps: const ["Add a 'go to x y' block.", "Set BOTH x and y to 0.", "Run — that's home base."],
    starter: () => [],
    check: (script) {
      final g = cqFlatten(script).where((b) => b.defId == 'motion_goto_xy').toList();
      if (!g.any((b) => _numOf(b, 'x') == 0 && _numOf(b, 'y') == 0)) {
        return const LessonResult(false, "Set a 'go to x y' block to exactly x:0, y:0.");
      }
      return const LessonResult(true, "Home sweet home. 🏠");
    },
  ),
  Lesson(
    id: 605,
    topicId: 'goto-xy',
    title: 'Two Stops',
    glyph: '🚏',
    complexity: 1,
    target: 'Visit two different points in a row.',
    narrator: "One teleport is fun. Two in a row is a trip!",
    steps: const ["Add a first 'go to x y' block.", "Add a second 'go to x y' with DIFFERENT numbers."],
    starter: () => [],
    check: (script) {
      final g = cqFlatten(script).where((b) => b.defId == 'motion_goto_xy').toList();
      if (g.length < 2) return const LessonResult(false, "Add two 'go to x y' blocks.");
      if (_xy(g[0]) == _xy(g[1])) {
        return const LessonResult(false, "Give the two teleports different coordinates.");
      }
      return const LessonResult(true, "Hop, hop! Two stops down. 🚏");
    },
  ),
  Lesson(
    id: 606,
    topicId: 'goto-xy',
    title: 'Patience Pays',
    glyph: '⏳',
    complexity: 2,
    target: 'Wait between two teleports so the jump is visible.',
    narrator: "Hopping too fast is dizzying — let's pause between jumps.",
    steps: const ["Keep the two 'go to x y' blocks.", "Add a 'wait' block (Control) between them."],
    starter: () => [
      BlockInstance('motion_goto_xy', inputs: {'x': -60, 'y': 40}),
      BlockInstance('motion_goto_xy', inputs: {'x': 60, 'y': -40}),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final gotoIdx = <int>[];
      for (var i = 0; i < flat.length; i++) {
        if (flat[i].defId == 'motion_goto_xy') gotoIdx.add(i);
      }
      if (gotoIdx.length < 2) return const LessonResult(false, "Keep both 'go to x y' blocks.");
      final waitIdx = flat.indexWhere((b) => b.defId == 'control_wait');
      if (waitIdx == -1) return const LessonResult(false, "Add a 'wait' block between the two teleports.");
      if (!(waitIdx > gotoIdx[0] && waitIdx < gotoIdx[1])) {
        return const LessonResult(false, "The 'wait' must sit BETWEEN the two teleports.");
      }
      return const LessonResult(true, "A calm, steady trip. ⏳");
    },
  ),
  Lesson(
    id: 607,
    topicId: 'goto-xy',
    title: 'Vanish and Reappear',
    glyph: '👻',
    complexity: 2,
    target: 'Hide, teleport, then show again — a real teleport effect.',
    narrator: "Real teleporters vanish before they reappear!",
    steps: const ["Add 'hide' (Looks).", "Add 'go to x y' next.", "Add 'show' (Looks) last."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final iH = flat.indexWhere((b) => b.defId == 'looks_hide');
      final iG = flat.indexWhere((b) => b.defId == 'motion_goto_xy');
      final iS = flat.indexWhere((b) => b.defId == 'looks_show');
      if (iH == -1) return const LessonResult(false, "Add a 'hide' block first.");
      if (iG == -1) return const LessonResult(false, "Add a 'go to x y' block after hiding.");
      if (iS == -1) return const LessonResult(false, "Add a 'show' block at the end.");
      if (!(iH < iG && iG < iS)) return const LessonResult(false, "Order matters: hide, then teleport, then show.");
      return const LessonResult(true, "Poof! Gone and back. 👻");
    },
  ),
  Lesson(
    id: 608,
    topicId: 'goto-xy',
    title: 'Sound of a Jump',
    glyph: '🔊',
    complexity: 2,
    target: 'Play a click sound right after teleporting.',
    narrator: "Every good jump needs a sound effect.",
    steps: const ["Add 'go to x y'.", "Add 'play sound' (Sound) right after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final iG = flat.indexWhere((b) => b.defId == 'motion_goto_xy');
      final iSnd = flat.indexWhere((b) => b.defId == 'sound_play_click');
      if (iG == -1) return const LessonResult(false, "Add a 'go to x y' block.");
      if (iSnd == -1) return const LessonResult(false, "Add a 'play sound' block after the teleport.");
      if (iSnd < iG) return const LessonResult(false, "The sound should play AFTER the teleport.");
      return const LessonResult(true, "Click! Nailed the landing. 🔊");
    },
  ),
  Lesson(
    id: 609,
    topicId: 'goto-xy',
    title: 'Slide Then Snap',
    glyph: '🛞',
    complexity: 2,
    target: 'Slide with change x/y, then snap instantly with go to x y.',
    narrator: "Sliding with change x/y is smooth. Snapping with go to x y is instant. Feel the difference!",
    steps: const ["Add 'change x by 10' then 'change y by 10'.", "Add a 'go to x y' block after both (instant snap)."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final iX = flat.indexWhere((b) => b.defId == 'motion_change_x');
      final iY = flat.indexWhere((b) => b.defId == 'motion_change_y');
      final iG = flat.indexWhere((b) => b.defId == 'motion_goto_xy');
      if (iX == -1 || iY == -1) return const LessonResult(false, "Add BOTH 'change x by' and 'change y by' blocks.");
      if (iG == -1) return const LessonResult(false, "Add a 'go to x y' block after the slide.");
      if (iG < iX || iG < iY) return const LessonResult(false, "The snap ('go to x y') should come LAST.");
      return const LessonResult(true, "Slide, then snap. Smooth and instant. 🛞");
    },
  ),
  Lesson(
    id: 610,
    topicId: 'goto-xy',
    title: 'Face Then Jump',
    glyph: '🧭',
    complexity: 2,
    target: 'Point in a direction, then teleport.',
    narrator: "Point where you're facing, THEN teleport — style matters.",
    steps: const ["Add 'point in direction' (Motion).", "Add 'go to x y' after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final iP = flat.indexWhere((b) => b.defId == 'motion_point_direction');
      final iG = flat.indexWhere((b) => b.defId == 'motion_goto_xy');
      if (iP == -1) return const LessonResult(false, "Add a 'point in direction' block.");
      if (iG == -1) return const LessonResult(false, "Add a 'go to x y' block after it.");
      if (iG < iP) return const LessonResult(false, "Face first, THEN teleport — check the order.");
      return const LessonResult(true, "Facing sharp, landing sharper. 🧭");
    },
  ),
  Lesson(
    id: 611,
    topicId: 'goto-xy',
    title: 'Triangle Trip',
    glyph: '🔺',
    complexity: 2,
    target: 'Visit three distinct points in a row.',
    narrator: "Three stops trace a shape — let's draw a triangle in jumps.",
    steps: const ["Add three 'go to x y' blocks.", "Give each one different x/y numbers."],
    starter: () => [],
    check: (script) {
      final g = cqFlatten(script).where((b) => b.defId == 'motion_goto_xy').toList();
      if (g.length < 3) return const LessonResult(false, "Add three 'go to x y' blocks.");
      final pts = g.map(_xy).toSet();
      if (pts.length < 3) return const LessonResult(false, "Make all three points different from each other.");
      return const LessonResult(true, "A perfect triangle trip. 🔺");
    },
  ),
  Lesson(
    id: 612,
    topicId: 'goto-xy',
    title: 'Score Reset',
    glyph: '🔄',
    complexity: 2,
    target: 'Set the Score to 0 before teleporting.',
    narrator: "Before the big teleport tour, reset the scoreboard to zero.",
    steps: const ["Add 'set Score to 0' (Variables).", "Add a 'go to x y' block after."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final set0 = flat.where((b) => b.defId == 'variables_set' && _numOf(b, 'value') == 0).toList();
      if (set0.isEmpty) return const LessonResult(false, "Add 'set Score to 0' from Variables.");
      final iSet = flat.indexOf(set0.first);
      final iG = flat.indexWhere((b) => b.defId == 'motion_goto_xy');
      if (iG == -1) return const LessonResult(false, "Add a 'go to x y' block after the reset.");
      if (iG < iSet) return const LessonResult(false, "Reset the Score FIRST, then teleport.");
      return const LessonResult(true, "Clean slate, ready to roll. 🔄");
    },
  ),
  Lesson(
    id: 613,
    topicId: 'goto-xy',
    title: 'Coordinates Out Loud',
    glyph: '🗣️',
    complexity: 2,
    target: 'Say something, then teleport.',
    narrator: "Tell everyone where you're headed before you go!",
    steps: const ["Add 'say' with any text (Looks).", "Add 'go to x y' after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final says = flat.where((b) => b.defId == 'looks_say' && _textOf(b, 'text').isNotEmpty).toList();
      if (says.isEmpty) return const LessonResult(false, "Add a 'say' block with some text.");
      final iSay = flat.indexOf(says.first);
      final iG = flat.indexWhere((b) => b.defId == 'motion_goto_xy');
      if (iG == -1) return const LessonResult(false, "Add a 'go to x y' block after the say.");
      if (iG < iSay) return const LessonResult(false, "Announce first, THEN teleport.");
      return const LessonResult(true, "Heard loud and clear. 🗣️");
    },
  ),
  Lesson(
    id: 614,
    topicId: 'goto-xy',
    title: 'Double Take',
    glyph: '🔁',
    complexity: 2,
    target: 'Repeat a teleport-and-wait twice so everyone sees it.',
    narrator: "Let's blink at the same spot twice to make sure everyone sees it.",
    steps: const ["Add a 'repeat' block, set times to 2.", "Inside: add 'go to x y' then 'wait'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final rep = reps.first;
      if (_numOf(rep, 'times') < 2) return const LessonResult(false, "Set the repeat's times to at least 2.");
      final inside = cqFlatten(rep.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Put a 'go to x y' block inside the repeat.");
      }
      if (!inside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Add a 'wait' block inside the repeat too.");
      }
      return const LessonResult(true, "Double take achieved. 🔁");
    },
  ),
  Lesson(
    id: 615,
    topicId: 'goto-xy',
    title: 'Edge Check',
    glyph: '🧱',
    complexity: 2,
    target: 'Teleport close to the edge, then bounce off it.',
    narrator: "Teleport near the wall and let the bounce block catch you.",
    steps: const ["Add 'go to x y' with a big number like 220.", "Add 'if on edge, bounce' (Motion) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final gotos = flat.where((b) => b.defId == 'motion_goto_xy').toList();
      final big = gotos.where((b) => _numOf(b, 'x').abs() >= 150 || _numOf(b, 'y').abs() >= 150).toList();
      if (big.isEmpty) {
        return const LessonResult(false, "Teleport with a big x or y (150 or more) to get near an edge.");
      }
      final iG = flat.indexOf(big.first);
      final iB = flat.indexWhere((b) => b.defId == 'motion_if_on_edge_bounce');
      if (iB == -1 || iB < iG) {
        return const LessonResult(false, "Add 'if on edge, bounce' AFTER the teleport.");
      }
      return const LessonResult(true, "Caught right at the wall. 🧱");
    },
  ),
  Lesson(
    id: 616,
    topicId: 'goto-xy',
    title: 'Four Corners Setup',
    glyph: '4️⃣',
    complexity: 2,
    target: 'Visit four distinct points, one teleport at a time.',
    narrator: "A square has four corners — let's visit all of them.",
    steps: const ["Add four 'go to x y' blocks.", "Make the four points form a square."],
    starter: () => [],
    check: (script) {
      final g = cqFlatten(script).where((b) => b.defId == 'motion_goto_xy').toList();
      if (g.length < 4) return const LessonResult(false, "Add four 'go to x y' blocks.");
      final pts = g.map(_xy).toSet();
      if (pts.length < 4) return const LessonResult(false, "Make all four points different.");
      return const LessonResult(true, "All four corners visited. 4️⃣");
    },
  ),
  Lesson(
    id: 617,
    topicId: 'goto-xy',
    title: 'Count Every Jump',
    glyph: '🔢',
    complexity: 3,
    target: 'Score a point for every teleport, at least twice.',
    narrator: "Let's keep score — one point for every teleport!",
    steps: const ["Add 'go to x y'.", "Add 'change Score by 1' right after it.", "Repeat that pair at least twice."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      var pairs = 0;
      for (var i = 0; i < flat.length - 1; i++) {
        if (flat[i].defId == 'motion_goto_xy' && flat[i + 1].defId == 'variables_change' && _numOf(flat[i + 1], 'value') > 0) {
          pairs++;
        }
      }
      if (pairs < 2) {
        return const LessonResult(false, "Follow at least two 'go to x y' blocks with 'change Score by 1' each.");
      }
      return const LessonResult(true, "Score's climbing with every jump! 🔢");
    },
  ),
  Lesson(
    id: 618,
    topicId: 'goto-xy',
    title: 'Loop the Tour',
    glyph: '🔁',
    complexity: 3,
    target: 'Loop a teleport-and-announce instead of repeating it by hand.',
    narrator: "Instead of writing the same jump over and over, let's loop it.",
    steps: const ["Add 'repeat 3 times'.", "Inside: 'go to x y' then 'say'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Put a 'go to x y' block inside the repeat.");
      }
      if (!inside.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block inside the repeat too.");
      }
      return const LessonResult(true, "Touring on a loop now. 🔁");
    },
  ),
  Lesson(
    id: 619,
    topicId: 'goto-xy',
    title: 'Timed Teleports',
    glyph: '⏱️',
    complexity: 3,
    target: 'Teleport and pause on a steady rhythm, several times.',
    narrator: "A steady rhythm: teleport, then pause, then teleport again.",
    steps: const ["Add 'repeat', set to 4.", "Inside: 'go to x y' then 'wait 1 seconds'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final rep = reps.first;
      if (_numOf(rep, 'times') < 3) return const LessonResult(false, "Set the repeat to at least 3 times.");
      final inside = cqFlatten(rep.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy') || !inside.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Inside the repeat, add both 'go to x y' AND 'wait'.");
      }
      return const LessonResult(true, "A steady teleport rhythm. ⏱️");
    },
  ),
  Lesson(
    id: 620,
    topicId: 'goto-xy',
    title: 'Square Dance',
    glyph: '🕺',
    complexity: 3,
    target: 'Teleport and roll a little at every stop in a loop.',
    narrator: "Let's dance around a square, teleporting to each corner.",
    steps: const ["Add 'repeat 4 times'.", "Inside: 'go to x y', then 'move 5 steps'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final rep = reps.first;
      if (_numOf(rep, 'times') < 4) return const LessonResult(false, "Set the repeat to at least 4 times.");
      final inside = cqFlatten(rep.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy') || !inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Inside the repeat, add 'go to x y' AND 'move steps'.");
      }
      return const LessonResult(true, "Dancing around the square. 🕺");
    },
  ),
  Lesson(
    id: 621,
    topicId: 'goto-xy',
    title: 'Spin and Snap',
    glyph: '🌀',
    complexity: 3,
    target: 'Spin, then snap to a new spot, on a loop.',
    narrator: "Spin a little, then snap to a new spot — repeat it a few times!",
    steps: const ["Add 'repeat 3 times'.", "Inside: a 'turn' block then 'go to x y'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      if (!inside.any(_isTurn)) return const LessonResult(false, "Add a 'turn' block inside the repeat.");
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Add a 'go to x y' block inside the repeat too.");
      }
      return const LessonResult(true, "Spinning and snapping in style. 🌀");
    },
  ),
  Lesson(
    id: 622,
    topicId: 'goto-xy',
    title: 'Blink Show',
    glyph: '✨',
    complexity: 3,
    target: 'Vanish, jump, and reappear — more than once.',
    narrator: "Vanish, jump, reappear — and do it more than once!",
    steps: const ["Add 'repeat 3 times'.", "Inside: 'hide', 'go to x y', 'show'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      final iH = inside.indexWhere((b) => b.defId == 'looks_hide');
      final iG = inside.indexWhere((b) => b.defId == 'motion_goto_xy');
      final iS = inside.indexWhere((b) => b.defId == 'looks_show');
      if (iH == -1 || iG == -1 || iS == -1) {
        return const LessonResult(false, "Inside the repeat, add 'hide', 'go to x y', AND 'show'.");
      }
      if (!(iH < iG && iG < iS)) return const LessonResult(false, "Order inside the repeat: hide, teleport, show.");
      return const LessonResult(true, "A dazzling blink show. ✨");
    },
  ),
  Lesson(
    id: 623,
    topicId: 'goto-xy',
    title: 'Click Circuit',
    glyph: '🔘',
    complexity: 3,
    target: 'Play a click on every jump of a loop.',
    narrator: "Every jump on this circuit gets its own click.",
    steps: const ["Add 'repeat 4 times'.", "Inside: 'go to x y' then 'play sound'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy') || !inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Inside the repeat, add 'go to x y' AND 'play sound'.");
      }
      return const LessonResult(true, "Click, click, click — the circuit hums. 🔘");
    },
  ),
  Lesson(
    id: 624,
    topicId: 'goto-xy',
    title: 'Scoreboard Tour',
    glyph: '🏆',
    complexity: 3,
    target: 'Reset the score, then rack up points on every stop.',
    narrator: "Reset the score, then rack up points on every stop of the tour.",
    steps: const ["Add 'set Score to 0' before everything.", "Add 'repeat 4 times' after.", "Inside: 'go to x y' then 'change Score by 1'."],
    starter: () => [],
    check: (script) {
      final iSet = script.indexWhere((b) => b.defId == 'variables_set' && _numOf(b, 'value') == 0);
      if (iSet == -1) return const LessonResult(false, "Add 'set Score to 0' before the loop.");
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block after the reset.");
      if (script.indexOf(reps.first) < iSet) return const LessonResult(false, "Reset the Score BEFORE the repeat loop.");
      final inside = cqFlatten(reps.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy') || !inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Inside the repeat, add 'go to x y' AND 'change Score by 1'.");
      }
      return const LessonResult(true, "Score's climbing on tour. 🏆");
    },
  ),
  Lesson(
    id: 625,
    topicId: 'goto-xy',
    title: 'Wait and See',
    glyph: '👀',
    complexity: 3,
    target: 'Slow the tour down and comment on the view.',
    narrator: "Slow the tour down and comment on the view.",
    steps: const ["Add 'repeat 3 times'.", "Inside: 'go to x y', 'wait 0.5 seconds', 'say'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) return const LessonResult(false, "Add 'go to x y' inside the repeat.");
      if (!inside.any((b) => b.defId == 'control_wait')) return const LessonResult(false, "Add a 'wait' block inside the repeat.");
      if (!inside.any((b) => b.defId == 'looks_say')) return const LessonResult(false, "Add a 'say' block inside the repeat.");
      return const LessonResult(true, "Slow enough to enjoy the view. 👀");
    },
  ),
  Lesson(
    id: 626,
    topicId: 'goto-xy',
    title: 'Edge Patrol',
    glyph: '🧱',
    complexity: 3,
    target: 'Teleport near an edge, then react to it.',
    narrator: "Patrol the edge — and if I touch it, take action.",
    steps: const ["Add 'go to x y' near the edge.", "Add 'if on edge' (Control) block after.", "Inside: add 'if on edge, bounce' (Motion)."],
    starter: () => [],
    check: (script) {
      final iG = script.indexWhere((b) => b.defId == 'motion_goto_xy');
      if (iG == -1) return const LessonResult(false, "Add a 'go to x y' block.");
      final ifs = script.where((b) => b.defId == 'control_if_on_edge').toList();
      if (ifs.isEmpty) return const LessonResult(false, "Add an 'if on edge' block after the teleport.");
      if (script.indexOf(ifs.first) < iG) return const LessonResult(false, "The 'if on edge' block must come AFTER the teleport.");
      if (!cqFlatten(ifs.first.body).any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Inside 'if on edge', add 'if on edge, bounce'.");
      }
      return const LessonResult(true, "Edge patrolled and secured. 🧱");
    },
  ),
  Lesson(
    id: 627,
    topicId: 'goto-xy',
    title: 'Bounce Loop',
    glyph: '🏀',
    complexity: 3,
    target: 'Bounce around a loop, then reset home with a teleport.',
    narrator: "Bounce around for a few laps, then reset to home.",
    steps: const ["Add 'repeat 4 times'.", "Inside: 'move 10 steps' then 'if on edge, bounce'.", "After the repeat, add 'go to x y' set to 0,0."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps') || !inside.any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Inside the repeat, add 'move steps' AND 'if on edge, bounce'.");
      }
      final afterRep = script.skip(script.indexOf(reps.first) + 1);
      if (!afterRep.any((b) => b.defId == 'motion_goto_xy' && _numOf(b, 'x') == 0 && _numOf(b, 'y') == 0)) {
        return const LessonResult(false, "After the repeat, add 'go to x y' set to 0,0 to reset home.");
      }
      return const LessonResult(true, "Bounced, then reset. 🏀");
    },
  ),
  Lesson(
    id: 628,
    topicId: 'goto-xy',
    title: 'Five Stop Relay',
    glyph: '🎯',
    complexity: 3,
    target: 'Run a five-lap teleport relay with checkpoints and score.',
    narrator: "This relay has five checkpoints — announce each one and keep score.",
    steps: const ["Add 'repeat 5 times'.", "Inside: 'go to x y', 'say', 'change Score by 1'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 5})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final rep = reps.first;
      if (_numOf(rep, 'times') < 5) return const LessonResult(false, "Set the repeat to at least 5 times.");
      final inside = cqFlatten(rep.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy') ||
          !inside.any((b) => b.defId == 'looks_say') ||
          !inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Inside the repeat, add 'go to x y', 'say', AND 'change Score by 1'.");
      }
      return const LessonResult(true, "Five checkpoints, five cheers. 🎯");
    },
  ),
  Lesson(
    id: 629,
    topicId: 'goto-xy',
    title: 'Nested Patrol',
    glyph: '🪆',
    complexity: 3,
    target: 'Build a patrol inside a patrol — a loop within a loop.',
    narrator: "A patrol inside a patrol — teleport within a loop within a loop.",
    steps: const ["Add 'repeat 2 times'.", "Inside, add ANOTHER 'repeat 3 times'.", "Inside the inner repeat: 'go to x y'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final outers = script.where((b) => b.defId == 'control_repeat').toList();
      if (outers.isEmpty) return const LessonResult(false, "Add an outer 'repeat' block.");
      final inners = outers.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (inners.isEmpty) return const LessonResult(false, "Add a second 'repeat' block INSIDE the first one.");
      if (!cqFlatten(inners.first.body).any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Put a 'go to x y' block inside the inner repeat.");
      }
      return const LessonResult(true, "A patrol within a patrol. 🪆");
    },
  ),
  Lesson(
    id: 630,
    topicId: 'goto-xy',
    title: 'Point, Move, Jump',
    glyph: '🎬',
    complexity: 3,
    target: 'Aim, roll, then teleport the rest of the way, on a loop.',
    narrator: "Aim, roll a little, then teleport the rest of the way.",
    steps: const ["Add 'repeat 3 times'.", "Inside: 'point in direction', 'move 10 steps', 'go to x y'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      final iP = inside.indexWhere((b) => b.defId == 'motion_point_direction');
      final iM = inside.indexWhere((b) => b.defId == 'motion_move_steps');
      final iG = inside.indexWhere((b) => b.defId == 'motion_goto_xy');
      if (iP == -1 || iM == -1 || iG == -1) {
        return const LessonResult(false, "Inside the repeat, add 'point in direction', 'move steps', AND 'go to x y'.");
      }
      if (!(iP < iM && iM < iG)) return const LessonResult(false, "Order: point, then move, then teleport.");
      return const LessonResult(true, "Aim, roll, jump — flawless. 🎬");
    },
  ),
  Lesson(
    id: 631,
    topicId: 'goto-xy',
    title: 'Countdown Teleporter',
    glyph: '⏬',
    complexity: 4,
    target: "Count down the Score while teleporting on a loop.",
    narrator: "Let's count down as we teleport — five jumps until landing.",
    steps: const ["Add 'set Score to 5'.", "Add 'repeat 5 times' after.", "Inside: 'go to x y' then 'change Score by -1'."],
    starter: () => [],
    check: (script) {
      final iSet = script.indexWhere((b) => b.defId == 'variables_set' && _numOf(b, 'value') > 0);
      if (iSet == -1) return const LessonResult(false, "Add 'set Score to 5' (a positive number) before the loop.");
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block after the set.");
      final inside = cqFlatten(reps.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) return const LessonResult(false, "Add 'go to x y' inside the repeat.");
      if (!inside.any((b) => b.defId == 'variables_change' && _numOf(b, 'value') < 0)) {
        return const LessonResult(false, "Inside the repeat, add 'change Score by -1' (a negative number).");
      }
      return const LessonResult(true, "Counting down to landing. ⏬");
    },
  ),
  Lesson(
    id: 632,
    topicId: 'goto-xy',
    title: 'Full Announcement',
    glyph: '📢',
    complexity: 4,
    target: 'Announce, teleport, and celebrate with a point — on a loop.',
    narrator: "Announce, teleport, then celebrate with a point.",
    steps: const ["Add 'repeat 4 times'.", "Inside: 'say', 'go to x y', 'change Score by 1'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      final iSay = inside.indexWhere((b) => b.defId == 'looks_say');
      final iG = inside.indexWhere((b) => b.defId == 'motion_goto_xy');
      final iC = inside.indexWhere((b) => b.defId == 'variables_change' && _numOf(b, 'value') > 0);
      if (iSay == -1 || iG == -1 || iC == -1) {
        return const LessonResult(false, "Inside the repeat, add 'say', 'go to x y', AND 'change Score by 1'.");
      }
      if (!(iSay < iG && iG < iC)) return const LessonResult(false, "Order: announce, teleport, then score.");
      return const LessonResult(true, "Announced, jumped, and celebrated. 📢");
    },
  ),
  Lesson(
    id: 633,
    topicId: 'goto-xy',
    title: 'Grid Patrol',
    glyph: '🗺️',
    complexity: 4,
    target: 'Patrol the coordinate grid, pausing and scoring at every point.',
    narrator: "Patrol the whole coordinate grid, pausing and scoring at every point.",
    steps: const ["Add 'repeat 4 times'.", "Inside: 'go to x y', 'wait', 'change Score by 1'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy') ||
          !inside.any((b) => b.defId == 'control_wait') ||
          !inside.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Inside the repeat, add 'go to x y', 'wait', AND 'change Score by 1'.");
      }
      return const LessonResult(true, "The whole grid, patrolled. 🗺️");
    },
  ),
  Lesson(
    id: 634,
    topicId: 'goto-xy',
    title: 'Six Point Tour',
    glyph: '6️⃣',
    complexity: 4,
    target: 'Run a six-stop tour, announcing every stop.',
    narrator: "Six stops, six announcements — the grand tour begins.",
    steps: const ["Add 'repeat 6 times'.", "Inside: 'go to x y' then 'say'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 6})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final rep = reps.first;
      if (_numOf(rep, 'times') < 6) return const LessonResult(false, "Set the repeat to at least 6 times.");
      final inside = cqFlatten(rep.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy') || !inside.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Inside the repeat, add 'go to x y' AND 'say'.");
      }
      return const LessonResult(true, "Six stops, six cheers. 6️⃣");
    },
  ),
  Lesson(
    id: 635,
    topicId: 'goto-xy',
    title: 'Face Your Destination',
    glyph: '🧭',
    complexity: 4,
    target: 'Point, teleport, then turn — a directional relay on a loop.',
    narrator: "Before every jump, make sure you're facing the right way.",
    steps: const ["Add 'repeat 3 times'.", "Inside: 'point in direction', 'go to x y', a 'turn' block."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      if (!inside.any((b) => b.defId == 'motion_point_direction')) {
        return const LessonResult(false, "Add a 'point in direction' block inside the repeat.");
      }
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Add a 'go to x y' block inside the repeat.");
      }
      if (!inside.any(_isTurn)) return const LessonResult(false, "Add a 'turn' block inside the repeat too.");
      return const LessonResult(true, "Always facing the right way. 🧭");
    },
  ),
  Lesson(
    id: 636,
    topicId: 'goto-xy',
    title: 'The Big Relay',
    glyph: '🏁',
    complexity: 4,
    target: 'Combine move, turn, teleport, wait, and say — all five, on a loop.',
    narrator: "This is the full relay — roll, spin, teleport, pause, and announce.",
    steps: const ["Add 'repeat 3 times'.", "Inside, add: 'move steps', 'turn', 'go to x y', 'wait', 'say' — all five."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      final need = <String, bool>{
        'move': inside.any((b) => b.defId == 'motion_move_steps'),
        'turn': inside.any(_isTurn),
        'goto': inside.any((b) => b.defId == 'motion_goto_xy'),
        'wait': inside.any((b) => b.defId == 'control_wait'),
        'say': inside.any((b) => b.defId == 'looks_say'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Inside the repeat, use ALL five: move, turn, go to x y, wait, and say.");
      }
      return const LessonResult(true, "The full relay, executed perfectly. 🏁");
    },
  ),
  Lesson(
    id: 637,
    topicId: 'goto-xy',
    title: 'Half-Second Hops',
    glyph: '⏱️',
    complexity: 4,
    target: 'Hop fast — teleport with a wait under a second, on a loop.',
    narrator: "Fast little hops — half a second between each.",
    steps: const ["Add 'repeat 4 times'.", "Inside: 'go to x y' then 'wait 0.5 seconds'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) return const LessonResult(false, "Add 'go to x y' inside the repeat.");
      if (!inside.any((b) => b.defId == 'control_wait' && _numOf(b, 'seconds') < 1)) {
        return const LessonResult(false, "Add a 'wait' block with LESS than 1 second inside the repeat.");
      }
      return const LessonResult(true, "Fast little hops. ⏱️");
    },
  ),
  Lesson(
    id: 638,
    topicId: 'goto-xy',
    title: 'Welcome to Coordinate Cove',
    glyph: '🌊',
    complexity: 4,
    target: 'Announce the Cove by name, then tour it on a loop.',
    narrator: "Every visitor deserves a proper welcome to Coordinate Cove.",
    steps: const ["Add 'say' with text containing 'Coordinate Cove'.", "Add 'repeat 3 times' after with 'go to x y' inside."],
    starter: () => [],
    check: (script) {
      final says = script.where((b) => b.defId == 'looks_say' && _textOf(b, 'text').toLowerCase().contains('coordinate cove')).toList();
      if (says.isEmpty) return const LessonResult(false, "Add a 'say' block whose text mentions 'Coordinate Cove'.");
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block after the welcome message.");
      if (script.indexOf(reps.first) < script.indexOf(says.first)) {
        return const LessonResult(false, "Welcome visitors BEFORE starting the tour loop.");
      }
      if (!cqFlatten(reps.first.body).any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Add a 'go to x y' block inside the repeat.");
      }
      return const LessonResult(true, "Welcome to Coordinate Cove! 🌊");
    },
  ),
  Lesson(
    id: 639,
    topicId: 'goto-xy',
    title: 'Show, Jump, Hide, Jump',
    glyph: '🎭',
    complexity: 4,
    target: 'Blink through two teleports with show/hide toggling, on a loop.',
    narrator: "Blink for a proper light show while teleporting.",
    steps: const ["Add 'repeat 2 times'.", "Inside: 'show', 'go to x y', 'hide', 'go to x y'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      final gCount = inside.where((b) => b.defId == 'motion_goto_xy').length;
      if (gCount < 2) return const LessonResult(false, "Add TWO 'go to x y' blocks inside the repeat.");
      if (!inside.any((b) => b.defId == 'looks_show')) return const LessonResult(false, "Add a 'show' block inside the repeat.");
      if (!inside.any((b) => b.defId == 'looks_hide')) return const LessonResult(false, "Add a 'hide' block inside the repeat.");
      final iShow = inside.indexWhere((b) => b.defId == 'looks_show');
      final iFirstGoto = inside.indexWhere((b) => b.defId == 'motion_goto_xy');
      if (iShow > iFirstGoto) return const LessonResult(false, "'show' should come before the first teleport.");
      return const LessonResult(true, "What a light show! 🎭");
    },
  ),
  Lesson(
    id: 640,
    topicId: 'goto-xy',
    title: 'Full Circuit',
    glyph: '🔄',
    complexity: 4,
    target: 'Combine sound, score, and a breather in one loop.',
    narrator: "Every circuit needs sound, score, and a breather.",
    steps: const ["Add 'repeat 4 times'.", "Inside: 'go to x y', 'play sound', 'change Score by 1', 'wait'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      final need = <String, bool>{
        'goto': inside.any((b) => b.defId == 'motion_goto_xy'),
        'sound': inside.any((b) => b.defId == 'sound_play_click'),
        'score': inside.any((b) => b.defId == 'variables_change'),
        'wait': inside.any((b) => b.defId == 'control_wait'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Inside the repeat, use all four: go to x y, play sound, change Score, and wait.");
      }
      return const LessonResult(true, "A full, satisfying circuit. 🔄");
    },
  ),
  Lesson(
    id: 641,
    topicId: 'goto-xy',
    title: 'Bounce and Score',
    glyph: '🎾',
    complexity: 4,
    target: 'Bounce off walls, teleport, and score — all in one loop.',
    narrator: "Bounce off the walls, but every so often, teleport somewhere new and score.",
    steps: const ["Add 'repeat 5 times'.", "Inside: 'move steps', 'if on edge, bounce', 'go to x y', 'change Score by 1'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 5})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      final need = <String, bool>{
        'move': inside.any((b) => b.defId == 'motion_move_steps'),
        'bounce': inside.any((b) => b.defId == 'motion_if_on_edge_bounce'),
        'goto': inside.any((b) => b.defId == 'motion_goto_xy'),
        'score': inside.any((b) => b.defId == 'variables_change'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Inside the repeat, use all four: move, bounce, teleport, and score.");
      }
      return const LessonResult(true, "Bounced, jumped, and scored. 🎾");
    },
  ),
  Lesson(
    id: 642,
    topicId: 'goto-xy',
    title: 'Deep Patrol',
    glyph: '🪆',
    complexity: 4,
    target: 'Nest a patrol inside a patrol, scoring after every inner round.',
    narrator: "A patrol within a patrol, and points for finishing each round.",
    steps: const [
      "Add 'repeat 2 times' (outer).",
      "Inside outer: add 'repeat 3 times' (inner) containing 'go to x y' and 'wait'.",
      "After the inner repeat (still inside outer), add 'change Score by 1'.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final outers = script.where((b) => b.defId == 'control_repeat').toList();
      if (outers.isEmpty) return const LessonResult(false, "Add an outer 'repeat' block.");
      final outer = outers.first;
      final inners = outer.body.where((b) => b.defId == 'control_repeat').toList();
      if (inners.isEmpty) return const LessonResult(false, "Add an inner 'repeat' block inside the outer one.");
      final innerBody = cqFlatten(inners.first.body);
      if (!innerBody.any((b) => b.defId == 'motion_goto_xy') || !innerBody.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Inside the INNER repeat, add 'go to x y' AND 'wait'.");
      }
      if (!cqFlatten(outer.body).any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Inside the outer repeat, add 'change Score by 1' after the inner loop.");
      }
      return const LessonResult(true, "Deep patrol complete, round after round. 🪆");
    },
  ),
  Lesson(
    id: 643,
    topicId: 'goto-xy',
    title: 'Edge to Edge',
    glyph: '↔️',
    complexity: 4,
    target: 'Bounce from one edge clear to the other, on a loop.',
    narrator: "Bounce from one edge clear to the other, again and again.",
    steps: const [
      "Add 'repeat 3 times'.",
      "Inside: 'go to x y' (big positive x), 'if on edge, bounce', 'go to x y' (big negative x), 'if on edge, bounce'.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(reps.first.body);
      final gotos = inside.where((b) => b.defId == 'motion_goto_xy').toList();
      if (gotos.length < 2) return const LessonResult(false, "Add TWO 'go to x y' blocks inside the repeat.");
      final hasPos = gotos.any((b) => _numOf(b, 'x') > 100);
      final hasNeg = gotos.any((b) => _numOf(b, 'x') < -100);
      if (!hasPos || !hasNeg) {
        return const LessonResult(false, "Make one teleport's x a big positive number and the other a big negative number.");
      }
      final bounces = inside.where((b) => b.defId == 'motion_if_on_edge_bounce').length;
      if (bounces < 2) return const LessonResult(false, "Add TWO 'if on edge, bounce' blocks, one after each teleport.");
      return const LessonResult(true, "Edge to edge, cleanly. ↔️");
    },
  ),
  Lesson(
    id: 644,
    topicId: 'goto-xy',
    title: 'Five-Block Compound',
    glyph: '🧩',
    complexity: 4,
    target: 'Use a block from every single category, with a teleport in the mix.',
    narrator: "The best teleporter scripts pull from every tray — motion, control, looks, sound, variables, all at once.",
    steps: const [
      "Build a script using at least one block from Motion, Control, Looks, Sound, AND Variables.",
      "Make sure a 'go to x y' block is somewhere in there.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final ids = flat.map((b) => b.defId).toSet();
      if (!ids.any(_motionIds.contains)) return const LessonResult(false, "Include a Motion block.");
      if (!ids.any(_controlIds.contains)) return const LessonResult(false, "Include a Control block.");
      if (!ids.any(_looksIds.contains)) return const LessonResult(false, "Include a Looks block.");
      if (!ids.any(_soundIds.contains)) return const LessonResult(false, "Include a Sound block.");
      if (!ids.any(_variablesIds.contains)) return const LessonResult(false, "Include a Variables block.");
      if (!ids.contains('motion_goto_xy')) return const LessonResult(false, "Make sure a 'go to x y' block is in there too.");
      return const LessonResult(true, "Every tray, one script. 🧩");
    },
  ),
  Lesson(
    id: 645,
    topicId: 'goto-xy',
    title: 'The Grand Tour',
    glyph: '🌟',
    complexity: 4,
    target: 'Run the biggest tour yet — eight stops, full fanfare.',
    narrator: "Eight stops, full fanfare — this is the grand tour of Coordinate Cove.",
    steps: const ["Add 'repeat 8 times'.", "Inside: 'go to x y', 'say', 'change Score by 1', 'wait', 'play sound'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 8})],
    check: (script) {
      final reps = script.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final rep = reps.first;
      if (_numOf(rep, 'times') < 8) return const LessonResult(false, "Set the repeat to at least 8 times.");
      final inside = cqFlatten(rep.body);
      final need = <String, bool>{
        'goto': inside.any((b) => b.defId == 'motion_goto_xy'),
        'say': inside.any((b) => b.defId == 'looks_say'),
        'score': inside.any((b) => b.defId == 'variables_change'),
        'wait': inside.any((b) => b.defId == 'control_wait'),
        'sound': inside.any((b) => b.defId == 'sound_play_click'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Inside the repeat, use all five: teleport, say, score, wait, and sound.");
      }
      return const LessonResult(true, "The grand tour, complete! 🌟");
    },
  ),
  Lesson(
    id: 646,
    topicId: 'goto-xy',
    title: 'Forever Patrol Begins',
    glyph: '♾️',
    complexity: 4,
    target: 'Teleport and pause, forever.',
    narrator: "Time to go forever — an endless teleport patrol.",
    steps: const ["Add a 'forever' block (Control).", "Inside: 'go to x y' then 'wait'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) return const LessonResult(false, "Put 'go to x y' inside the forever loop.");
      if (!inside.any((b) => b.defId == 'control_wait')) return const LessonResult(false, "Add a 'wait' block inside the forever loop too.");
      return const LessonResult(true, "An endless patrol begins. ♾️");
    },
  ),
  Lesson(
    id: 647,
    topicId: 'goto-xy',
    title: 'Forever Scoring',
    glyph: '♾️',
    complexity: 4,
    target: 'Score forever, every single teleport.',
    narrator: "Forever means the score never stops climbing either.",
    steps: const ["Keep the 'forever' block.", "Inside: 'go to x y' then 'change Score by 1'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) return const LessonResult(false, "Put 'go to x y' inside the forever loop.");
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by 1' inside the forever loop too.");
      return const LessonResult(true, "The score will never stop! ♾️");
    },
  ),
  Lesson(
    id: 648,
    topicId: 'goto-xy',
    title: 'Forever with a Loop Inside',
    glyph: '♾️',
    complexity: 4,
    target: 'Run a repeat loop of teleports inside a forever loop.',
    narrator: "Inside my endless patrol, let's run a mini loop of teleports.",
    steps: const ["Add 'forever'.", "Inside forever: add 'repeat 3 times'.", "Inside that repeat: 'go to x y'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final reps = forever.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the forever loop.");
      if (!cqFlatten(reps.first.body).any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Put a 'go to x y' block inside that repeat.");
      }
      return const LessonResult(true, "A mini loop, forever running. ♾️");
    },
  ),
  Lesson(
    id: 649,
    topicId: 'goto-xy',
    title: 'Endless Announcer',
    glyph: '📣',
    complexity: 5,
    target: 'Teleport, announce, and pause — forever.',
    narrator: "I'll never stop announcing where I've teleported to.",
    steps: const ["Add 'forever'.", "Inside: 'go to x y', 'say', 'wait'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body);
      final iG = inside.indexWhere((b) => b.defId == 'motion_goto_xy');
      final iS = inside.indexWhere((b) => b.defId == 'looks_say');
      final iW = inside.indexWhere((b) => b.defId == 'control_wait');
      if (iG == -1 || iS == -1 || iW == -1) {
        return const LessonResult(false, "Inside forever, add 'go to x y', 'say', AND 'wait'.");
      }
      if (!(iG < iS)) return const LessonResult(false, "Teleport, THEN announce.");
      return const LessonResult(true, "Announcing forever, one jump at a time. 📣");
    },
  ),
  Lesson(
    id: 650,
    topicId: 'goto-xy',
    title: 'Bounce Forever',
    glyph: '🏀',
    complexity: 5,
    target: 'Bounce forever, sneaking in a teleport every lap.',
    narrator: "Forever bouncing, but every lap I sneak in a teleport too.",
    steps: const ["Add 'forever'.", "Inside: 'move steps', 'if on edge, bounce', 'go to x y'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body);
      final need = <String, bool>{
        'move': inside.any((b) => b.defId == 'motion_move_steps'),
        'bounce': inside.any((b) => b.defId == 'motion_if_on_edge_bounce'),
        'goto': inside.any((b) => b.defId == 'motion_goto_xy'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Inside forever, use all three: move, bounce, and teleport.");
      }
      return const LessonResult(true, "Bouncing and teleporting, forever. 🏀");
    },
  ),
  Lesson(
    id: 651,
    topicId: 'goto-xy',
    title: 'Forever Edge Watch',
    glyph: '🧱',
    complexity: 5,
    target: 'Watch the edges forever, ready to bounce back to safety.',
    narrator: "Forever watching the edges, ready to teleport back to safety.",
    steps: const ["Add 'forever'.", "Inside: 'go to x y', then 'if on edge' containing 'if on edge, bounce'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forever.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Add a 'go to x y' block inside forever.");
      }
      final ifs = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (ifs.isEmpty) return const LessonResult(false, "Add an 'if on edge' block inside forever.");
      if (!cqFlatten(ifs.first.body).any((b) => b.defId == 'motion_if_on_edge_bounce')) {
        return const LessonResult(false, "Inside 'if on edge', add 'if on edge, bounce'.");
      }
      return const LessonResult(true, "Forever on watch, forever safe. 🧱");
    },
  ),
  Lesson(
    id: 652,
    topicId: 'goto-xy',
    title: 'Full Forever Circuit',
    glyph: '🧩',
    complexity: 5,
    target: 'Combine all five block categories inside one forever loop.',
    narrator: "The ultimate endless circuit — every single block type working together.",
    steps: const ["Add 'forever'.", "Inside, add: 'go to x y', 'wait', 'say', 'change Score by 1', 'play sound' — all five."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body);
      final need = <String, bool>{
        'goto': inside.any((b) => b.defId == 'motion_goto_xy'),
        'wait': inside.any((b) => b.defId == 'control_wait'),
        'say': inside.any((b) => b.defId == 'looks_say'),
        'score': inside.any((b) => b.defId == 'variables_change'),
        'sound': inside.any((b) => b.defId == 'sound_play_click'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Inside forever, use all five: teleport, wait, say, score, and sound.");
      }
      return const LessonResult(true, "The ultimate endless circuit. 🧩");
    },
  ),
  Lesson(
    id: 653,
    topicId: 'goto-xy',
    title: 'Deep Forever Nest',
    glyph: '🪆',
    complexity: 5,
    target: 'Nest a scoring, waiting teleport loop three levels deep.',
    narrator: "Forever, running a loop, running a teleport — deep nesting, deep fun.",
    steps: const ["Add 'forever'.", "Inside: 'repeat 4 times'.", "Inside that repeat: 'go to x y', 'wait', 'change Score by 1'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final reps = forever.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside forever.");
      final inner = cqFlatten(reps.first.body);
      final need = <String, bool>{
        'goto': inner.any((b) => b.defId == 'motion_goto_xy'),
        'wait': inner.any((b) => b.defId == 'control_wait'),
        'score': inner.any((b) => b.defId == 'variables_change'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Inside the repeat, use all three: teleport, wait, and change Score.");
      }
      return const LessonResult(true, "Three levels deep, and still ticking. 🪆");
    },
  ),
  Lesson(
    id: 654,
    topicId: 'goto-xy',
    title: 'Reset and Repeat Forever',
    glyph: '🔄',
    complexity: 5,
    target: 'Wipe the score clean every lap, then rack up new points.',
    narrator: "Every lap, wipe the score clean and rack up new points.",
    steps: const ["Add 'forever'.", "Inside: 'set Score to 0', then 'repeat 3 times' containing 'go to x y' and 'change Score by 1'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forever.first.body;
      final iSet = body.indexWhere((b) => b.defId == 'variables_set' && _numOf(b, 'value') == 0);
      if (iSet == -1) return const LessonResult(false, "Inside forever, add 'set Score to 0'.");
      final reps = body.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside forever, after the reset.");
      if (body.indexOf(reps.first) < iSet) return const LessonResult(false, "Reset the Score BEFORE the repeat loop.");
      final inner = cqFlatten(reps.first.body);
      if (!inner.any((b) => b.defId == 'motion_goto_xy') || !inner.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Inside the repeat, add 'go to x y' AND 'change Score by 1'.");
      }
      return const LessonResult(true, "Fresh score, every single lap. 🔄");
    },
  ),
  Lesson(
    id: 655,
    topicId: 'goto-xy',
    title: 'Show Off Forever',
    glyph: '✨',
    complexity: 5,
    target: 'Blink in and out of existence forever, with sound.',
    narrator: "Forever blinking in and out of existence — the ultimate light show.",
    steps: const ["Add 'forever'.", "Inside: 'hide', 'go to x y', 'show', 'play sound'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body);
      final iH = inside.indexWhere((b) => b.defId == 'looks_hide');
      final iG = inside.indexWhere((b) => b.defId == 'motion_goto_xy');
      final iS = inside.indexWhere((b) => b.defId == 'looks_show');
      final iSnd = inside.indexWhere((b) => b.defId == 'sound_play_click');
      if (iH == -1 || iG == -1 || iS == -1 || iSnd == -1) {
        return const LessonResult(false, "Inside forever, add 'hide', 'go to x y', 'show', AND 'play sound'.");
      }
      if (!(iH < iG && iG < iS)) return const LessonResult(false, "Order: hide, then teleport, then show.");
      return const LessonResult(true, "The ultimate forever light show. ✨");
    },
  ),
  Lesson(
    id: 656,
    topicId: 'goto-xy',
    title: 'Compass Forever',
    glyph: '🧭',
    complexity: 5,
    target: 'Combine every motion trick — point, roll, spin, teleport — forever.',
    narrator: "Forever combining every motion trick I know — point, roll, spin, teleport.",
    steps: const ["Add 'forever'.", "Inside: 'point in direction', 'move steps', a 'turn' block, then 'go to x y'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body);
      final need = <String, bool>{
        'point': inside.any((b) => b.defId == 'motion_point_direction'),
        'move': inside.any((b) => b.defId == 'motion_move_steps'),
        'turn': inside.any(_isTurn),
        'goto': inside.any((b) => b.defId == 'motion_goto_xy'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Inside forever, use all four: point, move, turn, and teleport.");
      }
      return const LessonResult(true, "Every motion trick, forever. 🧭");
    },
  ),
  Lesson(
    id: 657,
    topicId: 'goto-xy',
    title: 'Countdown Forever',
    glyph: '⏬',
    complexity: 5,
    target: 'Teleport, count down, and pause — forever, with no end in sight.',
    narrator: "Forever counting down as I teleport — where does it end? Nowhere, it's forever!",
    steps: const ["Add 'forever'.", "Inside: 'go to x y', 'change Score by -1', 'wait'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forever.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) return const LessonResult(false, "Add 'go to x y' inside forever.");
      if (!inside.any((b) => b.defId == 'variables_change' && _numOf(b, 'value') < 0)) {
        return const LessonResult(false, "Add 'change Score by -1' (a negative number) inside forever.");
      }
      if (!inside.any((b) => b.defId == 'control_wait')) return const LessonResult(false, "Add a 'wait' block inside forever too.");
      return const LessonResult(true, "Counting down, forever. ⏬");
    },
  ),
  Lesson(
    id: 658,
    topicId: 'goto-xy',
    title: 'The Nine-Block Odyssey',
    glyph: '🌌',
    complexity: 5,
    target: 'Build the biggest circuit yet — forever, a repeat, and five block types.',
    narrator: "This is it — the biggest teleporter script yet. Every block, working as one.",
    steps: const ["Add 'forever'.", "Inside: 'repeat 5 times'.", "Inside repeat: 'go to x y', 'wait', 'say', 'change Score by 1', 'play sound'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final reps = forever.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside forever.");
      final rep = reps.first;
      if (_numOf(rep, 'times') < 5) return const LessonResult(false, "Set the repeat to at least 5 times.");
      final inner = cqFlatten(rep.body);
      final need = <String, bool>{
        'goto': inner.any((b) => b.defId == 'motion_goto_xy'),
        'wait': inner.any((b) => b.defId == 'control_wait'),
        'say': inner.any((b) => b.defId == 'looks_say'),
        'score': inner.any((b) => b.defId == 'variables_change'),
        'sound': inner.any((b) => b.defId == 'sound_play_click'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Inside the repeat, use all five: teleport, wait, say, score, and sound.");
      }
      return const LessonResult(true, "The nine-block odyssey, complete. 🌌");
    },
  ),
  Lesson(
    id: 659,
    topicId: 'goto-xy',
    title: 'Master of Coordinate Cove',
    glyph: '👑',
    complexity: 5,
    target: 'Combine forever, a nested repeat, edge-watching, and every category.',
    narrator: "You've learned every trick — now prove you're the true Master of Coordinate Cove.",
    steps: const [
      "Build inside a 'forever' block.",
      "Include a nested 'repeat' loop with 'go to x y' and 'wait'.",
      "Also include an 'if on edge' block, a 'say', a 'change Score by', and a 'play sound' block somewhere inside forever.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forever.first.body;
      final reps = body.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a nested 'repeat' loop inside forever.");
      final inner = cqFlatten(reps.first.body);
      if (!inner.any((b) => b.defId == 'motion_goto_xy') || !inner.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Inside the repeat, add 'go to x y' AND 'wait'.");
      }
      final flatBody = cqFlatten(body);
      final need = <String, bool>{
        'if_on_edge': flatBody.any((b) => b.defId == 'control_if_on_edge'),
        'say': flatBody.any((b) => b.defId == 'looks_say'),
        'score': flatBody.any((b) => b.defId == 'variables_change'),
        'sound': flatBody.any((b) => b.defId == 'sound_play_click'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Inside forever, also add: an 'if on edge' block, a 'say', a score change, AND a sound.");
      }
      return const LessonResult(true, "You are the Master of Coordinate Cove! 👑");
    },
  ),
  Lesson(
    id: 660,
    topicId: 'goto-xy',
    title: 'Graduation Teleport',
    glyph: '🎓',
    complexity: 5,
    target: 'Build the ultimate teleporter: forever, a nested repeat, 3+ teleports, and every category.',
    narrator: "One last jump before graduation — make it count, make it big, make it yours.",
    steps: const [
      "Use a 'forever' block containing a 'repeat' loop.",
      "Inside, use at least 3 'go to x y' teleports combined with wait, say, change Score, and play sound.",
      "Finish strong — Run it and watch the whole show.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = script.where((b) => b.defId == 'control_forever').toList();
      if (forever.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final reps = forever.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (reps.isEmpty) return const LessonResult(false, "Add a nested 'repeat' loop inside forever.");
      final flat = cqFlatten(script);
      final gotoCount = flat.where((b) => b.defId == 'motion_goto_xy').length;
      if (gotoCount < 3) return const LessonResult(false, "Use at least 3 'go to x y' teleports across the whole script.");
      final need = <String, bool>{
        'wait': flat.any((b) => b.defId == 'control_wait'),
        'say': flat.any((b) => b.defId == 'looks_say'),
        'score': flat.any((b) => b.defId == 'variables_change'),
        'sound': flat.any((b) => b.defId == 'sound_play_click'),
      };
      if (need.values.any((v) => !v)) {
        return const LessonResult(false, "Also include: wait, say, change Score, AND play sound somewhere in the script.");
      }
      if (flat.length < 10) {
        return const LessonResult(false, "Make it a full show — use at least 10 blocks in total.");
      }
      return const LessonResult(true, "Congratulations — you've mastered Coordinate Cove! 🎓");
    },
  ),
];
