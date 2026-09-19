import '../models/cq_models.dart';
import 'cq_blocks.dart';

/// "Make Smart Decisions" (Decision Docks) — the sensing topic.
///
/// IMPORTANT ENGINE NOTE: this engine has no generic sensing reporters and
/// no generic if/else. The ONLY conditional block is `control_if_on_edge` —
/// a container whose body runs only when Turtu is at the stage edge the
/// moment that block executes. Every lesson below is a decision built on
/// "is Turtu at the edge right now, or not" — growing from a single
/// one-shot check, to a continuously-checking loop, to layered combinations
/// of loops, repeats, and variables around that one decision block.
final cqSensingLessons = <Lesson>[
  // ---------------------------------------------------------------------
  // Complexity 1 (901-915): one 'if on edge' block, one reaction inside.
  // ---------------------------------------------------------------------
  Lesson(
    id: 901,
    topicId: 'sensing',
    title: 'Edge Alert!',
    glyph: '🚨',
    complexity: 1,
    target: "Make Turtu travel to the edge, then say something when it senses it.",
    narrator: "I can feel when I reach the edge of the world. Let's practice noticing it out loud!",
    steps: const [
      "Add a 'move steps' block (Motion) so I travel toward the edge.",
      "Add an 'if on edge' block (Control) after it.",
      "Put a 'say' block (Looks) inside the 'if on edge' block.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block so I actually travel toward the edge.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) {
        return const LessonResult(false, "Add an 'if on edge' block (Control) — that's how I sense the edge.");
      }
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "I felt the edge and said something about it! 🛑");
    },
  ),
  Lesson(
    id: 902,
    topicId: 'sensing',
    title: 'Beep at the Boundary',
    glyph: '🔊',
    complexity: 1,
    target: "React to the edge with a sound instead of words.",
    narrator: "Talking is nice, but a beep is faster. Let's react to the edge with sound.",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Put 'play sound' (Sound) inside it.",
    ],
    starter: () => [BlockInstance('motion_move_steps', inputs: {'steps': 10})],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Keep a 'move steps' block in your script.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put a 'play sound' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Beep! I sensed the edge and made noise about it. 🔊");
    },
  ),
  Lesson(
    id: 903,
    topicId: 'sensing',
    title: 'Turn Away',
    glyph: '↻',
    complexity: 1,
    target: "Turn Turtu around only when it senses the edge.",
    narrator: "Instead of just talking about the edge, let's actually do something useful: turn away from it.",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Put a 'turn' block inside it.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Sensed the edge, turned away — smart decision! ↻");
    },
  ),
  Lesson(
    id: 904,
    topicId: 'sensing',
    title: 'Duck Out of Sight',
    glyph: '🙈',
    complexity: 1,
    target: "Hide Turtu the moment it senses the edge.",
    narrator: "Sometimes the smartest reaction to the edge is to disappear for a moment!",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Put a 'hide' block (Looks) inside it.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'looks_hide')) {
        return const LessonResult(false, "Put a 'hide' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Poof — I vanished the instant I sensed the edge! 🙈");
    },
  ),
  Lesson(
    id: 905,
    topicId: 'sensing',
    title: 'Say It AND Beep It',
    glyph: '🗣️',
    complexity: 1,
    target: "React to the edge with two reactions at once: say, then play a sound.",
    narrator: "One reaction is good. Two reactions in the same decision is even better!",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Put 'say' AND 'play sound' both inside it.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block inside 'if on edge'.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block inside 'if on edge' too.");
      }
      return const LessonResult(true, "Two reactions from one decision — nice combo! 🗣️🔊");
    },
  ),
  Lesson(
    id: 906,
    topicId: 'sensing',
    title: 'Nudge Back Inward',
    glyph: '⬅️',
    complexity: 1,
    target: "Nudge Turtu's x position back inward when it senses the edge.",
    narrator: "Turning is one option. Another is to just shove myself back with a change to my x position.",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Put a 'change x by' block inside it, with a negative-feeling nudge.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'motion_change_x')) {
        return const LessonResult(false, "Put a 'change x by' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Sensed the edge and nudged myself back in. ⬅️");
    },
  ),
  Lesson(
    id: 907,
    topicId: 'sensing',
    title: 'Left Turn Only',
    glyph: '↺',
    complexity: 1,
    target: "React to the edge by turning left this time.",
    narrator: "Let's practice the other turn direction as our edge reaction.",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Put a 'turn ↺ left' block inside it.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn ↺ left' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "A clean left turn the moment I sensed the edge. ↺");
    },
  ),
  Lesson(
    id: 908,
    topicId: 'sensing',
    title: 'Show, Then Hide',
    glyph: '👀',
    complexity: 1,
    target: "React to the edge by hiding, right after showing at the start.",
    narrator: "Let's set the scene: show myself first, then hide the moment I sense the edge.",
    steps: const [
      "Add a 'show' block (Looks) at the very top.",
      "Add a 'move steps' block.",
      "Add an 'if on edge' block with 'hide' inside it.",
    ],
    starter: () => [BlockInstance('looks_show')],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'looks_show')) {
        return const LessonResult(false, "Keep the 'show' block at the top of your script.");
      }
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block after showing.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'looks_hide')) {
        return const LessonResult(false, "Put a 'hide' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Shown, traveled, sensed the edge, then hidden. 👀");
    },
  ),
  Lesson(
    id: 909,
    topicId: 'sensing',
    title: 'Count the Sighting',
    glyph: '🔢',
    complexity: 1,
    target: "Use a variable to count that Turtu sensed the edge — just once for now.",
    narrator: "Let's start keeping score. Every time I sense the edge, bump my Score up by one.",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Put a 'change Score by' block (Variables) inside it.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put a 'change Score by' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Score went up the moment I sensed the edge! 🔢");
    },
  ),
  Lesson(
    id: 910,
    topicId: 'sensing',
    title: 'Say It, Then Turn',
    glyph: '💬',
    complexity: 1,
    target: "React to the edge by announcing it, then turning away.",
    narrator: "Let's narrate my decision before I act on it: say something, THEN turn.",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Inside it, put 'say' first, then a 'turn' block after.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      final body = edges.first.body;
      final sayIdx = body.indexWhere((b) => b.defId == 'looks_say');
      final turnIdx = body.indexWhere((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left');
      if (sayIdx == -1) return const LessonResult(false, "Put a 'say' block inside the 'if on edge' block.");
      if (turnIdx == -1) return const LessonResult(false, "Put a 'turn' block after the say block, inside 'if on edge'.");
      if (turnIdx < sayIdx) return const LessonResult(false, "Order matters — say first, THEN turn.");
      return const LessonResult(true, "Announced it, then turned. Great decision order! 💬↻");
    },
  ),
  Lesson(
    id: 911,
    topicId: 'sensing',
    title: 'Beep and Vanish',
    glyph: '🫥',
    complexity: 1,
    target: "React to the edge with a sound, then hide.",
    narrator: "One more combo: beep, THEN disappear. Order inside the decision matters.",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Inside it, put 'play sound' first, then 'hide'.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      final body = edges.first.body;
      final soundIdx = body.indexWhere((b) => b.defId == 'sound_play_click');
      final hideIdx = body.indexWhere((b) => b.defId == 'looks_hide');
      if (soundIdx == -1) return const LessonResult(false, "Put a 'play sound' block inside the 'if on edge' block.");
      if (hideIdx == -1) return const LessonResult(false, "Put a 'hide' block after the sound, inside 'if on edge'.");
      if (hideIdx < soundIdx) return const LessonResult(false, "Order matters — beep first, THEN hide.");
      return const LessonResult(true, "Beeped, then vanished. Perfect sequence! 🫥");
    },
  ),
  Lesson(
    id: 912,
    topicId: 'sensing',
    title: 'Teleport Back Home',
    glyph: '📍',
    complexity: 1,
    target: "React to the edge by teleporting back to the center.",
    narrator: "Here's a bold reaction: the instant I sense the edge, snap myself back to x:0, y:0.",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Put a 'go to x y' block inside it, set to 0, 0.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Put a 'go to x y' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Sensed the edge and snapped straight home. 📍");
    },
  ),
  Lesson(
    id: 913,
    topicId: 'sensing',
    title: 'Face It, Then Say It',
    glyph: '🧭',
    complexity: 1,
    target: "React to the edge by pointing in a fresh direction, then announcing the new plan.",
    narrator: "Let's re-aim myself the instant I sense the edge, and tell everyone about the new direction.",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Inside it, put 'point in direction' first, then 'say'.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      final body = edges.first.body;
      final pointIdx = body.indexWhere((b) => b.defId == 'motion_point_direction');
      final sayIdx = body.indexWhere((b) => b.defId == 'looks_say');
      if (pointIdx == -1) return const LessonResult(false, "Put a 'point in direction' block inside 'if on edge'.");
      if (sayIdx == -1) return const LessonResult(false, "Put a 'say' block after it, inside 'if on edge'.");
      if (sayIdx < pointIdx) return const LessonResult(false, "Order matters — point first, THEN say.");
      return const LessonResult(true, "New direction chosen, then announced. 🧭");
    },
  ),
  Lesson(
    id: 914,
    topicId: 'sensing',
    title: 'Drop Down, Too',
    glyph: '⬇️',
    complexity: 1,
    target: "React to the edge by nudging Turtu's y position.",
    narrator: "We nudged x before. Let's try the vertical nudge as our edge reaction now.",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Put a 'change y by' block inside it.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'motion_change_y')) {
        return const LessonResult(false, "Put a 'change y by' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Sensed the edge and dropped my y position. ⬇️");
    },
  ),
  Lesson(
    id: 915,
    topicId: 'sensing',
    title: 'Triple Reaction',
    glyph: '🎯',
    complexity: 1,
    target: "React to the edge with three reactions in one decision: say, turn, and play a sound.",
    narrator: "Time to graduate from level one: pack three whole reactions into a single decision!",
    steps: const [
      "Add a 'move steps' block.",
      "Add an 'if on edge' block.",
      "Inside it, add 'say', a 'turn' block, AND 'play sound'.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Add a 'move steps' block first.");
      }
      final edges = flat.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'looks_say')) return const LessonResult(false, "Add a 'say' block inside.");
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside too.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) return const LessonResult(false, "Add a 'play sound' block inside too.");
      return const LessonResult(true, "Three reactions, one decision. Level one mastered! 🎯");
    },
  ),

  // ---------------------------------------------------------------------
  // Complexity 2-3 (916-940): the decision inside a 'forever' loop —
  // continuously sensing — combined with move, variables, waits, repeats.
  // ---------------------------------------------------------------------
  Lesson(
    id: 916,
    topicId: 'sensing',
    title: 'Always Watching',
    glyph: '👁️',
    complexity: 2,
    target: "Keep sensing the edge forever — not just once.",
    narrator: "One check isn't enough. Let's put the decision inside a loop so I'm ALWAYS watching for the edge.",
    steps: const [
      "Add a 'forever' block (Control).",
      "Inside it, put 'move steps', then an 'if on edge' block.",
      "Inside the 'if on edge' block, put 'say'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block to your script.");
      final inside = cqFlatten(forevers.first.body);
      if (!inside.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = forevers.first.body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Now I'm always watching for the edge! 👁️");
    },
  ),
  Lesson(
    id: 917,
    topicId: 'sensing',
    title: 'Endless Beeping',
    glyph: '🔁',
    complexity: 2,
    target: "Continuously travel and beep every time the edge is sensed.",
    narrator: "Every lap around the stage, I want a beep whenever I touch the edge.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it: 'move steps', then 'if on edge' with 'play sound' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put a 'play sound' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Endless laps, endless beeps at the edge! 🔁🔊");
    },
  ),
  Lesson(
    id: 918,
    topicId: 'sensing',
    title: 'Bounce Like a Pinball',
    glyph: '🏓',
    complexity: 2,
    target: "Continuously travel, turning away every single time the edge is sensed.",
    narrator: "Let's make me bounce around like a pinball — travel, sense, turn, over and over.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it: 'move steps', then 'if on edge' with a 'turn' block inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Bouncing forever like a pinball! 🏓");
    },
  ),
  Lesson(
    id: 919,
    topicId: 'sensing',
    title: 'Counting Bounces',
    glyph: '🧮',
    complexity: 2,
    target: "Count every single time Turtu senses the edge, forever.",
    narrator: "Let's keep a running tally: every time I sense the edge, Score goes up by one — forever.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it: 'move steps', then 'if on edge' with 'change Score by' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put a 'change Score by' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Every bounce now bumps up the Score! 🧮");
    },
  ),
  Lesson(
    id: 920,
    topicId: 'sensing',
    title: 'Count It and Say It',
    glyph: '📣',
    complexity: 2,
    target: "Every time the edge is sensed, bump Score AND announce it — forever.",
    narrator: "Let's combine: count the bounce, then say something about it, every single time.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside 'if on edge': 'change Score by', then 'say'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside 'if on edge'.");
      if (!inside.any((b) => b.defId == 'looks_say')) return const LessonResult(false, "Add 'say' inside 'if on edge' too.");
      return const LessonResult(true, "Counted AND announced, every single bounce. 📣");
    },
  ),
  Lesson(
    id: 921,
    topicId: 'sensing',
    title: 'Turn and Beep, Forever',
    glyph: '🔔',
    complexity: 2,
    target: "Forever: travel, and when the edge is sensed, turn and beep together.",
    narrator: "Let's pack two reactions into the forever-loop decision: turn away AND beep.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside 'if on edge': a 'turn' block, then 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside 'if on edge'.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside 'if on edge' too.");
      return const LessonResult(true, "Turn and beep, every time, forever. 🔔");
    },
  ),
  Lesson(
    id: 922,
    topicId: 'sensing',
    title: 'Drift and Decide',
    glyph: '🛰️',
    complexity: 2,
    target: "Drift sideways with change x, and still sense the edge forever.",
    narrator: "Let's try drifting sideways instead of a normal move, and keep sensing the edge as I drift.",
    steps: const [
      "Add a 'forever' block with 'change x by' inside.",
      "Add 'if on edge' inside the loop with a reaction inside it.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_change_x')) {
        return const LessonResult(false, "Put a 'change x by' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (edges.first.body.isEmpty) return const LessonResult(false, "Put at least one reaction block inside the 'if on edge' block.");
      return const LessonResult(true, "Drifting sideways, still sensing the edge. 🛰️");
    },
  ),
  Lesson(
    id: 923,
    topicId: 'sensing',
    title: 'Blink at the Boundary',
    glyph: '✨',
    complexity: 2,
    target: "Forever: show at the start, then flicker hide/show whenever the edge is sensed.",
    narrator: "Let's make a little blink happen right when I sense the edge, every single loop.",
    steps: const [
      "Add 'show' at the top.",
      "Add a 'forever' block with 'move steps' inside.",
      "Inside it, add 'if on edge' with 'hide' then 'show' inside.",
    ],
    starter: () => [BlockInstance('looks_show'), BlockInstance('control_forever')],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'looks_show')) return const LessonResult(false, "Keep a 'show' block in your script.");
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = edges.first.body;
      final hideIdx = inside.indexWhere((b) => b.defId == 'looks_hide');
      final showIdx = inside.indexWhere((b) => b.defId == 'looks_show');
      if (hideIdx == -1 || showIdx == -1) {
        return const LessonResult(false, "Put 'hide' then 'show' inside the 'if on edge' block.");
      }
      if (showIdx < hideIdx) return const LessonResult(false, "Order matters — hide first, THEN show, inside 'if on edge'.");
      return const LessonResult(true, "A little blink every time I sense the edge. ✨");
    },
  ),
  Lesson(
    id: 924,
    topicId: 'sensing',
    title: 'Home Base Loop',
    glyph: '🏠',
    complexity: 2,
    target: "Forever: travel, and teleport home the instant the edge is sensed.",
    narrator: "No matter how far I wander, sensing the edge should always snap me back home.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop with 'go to x y' inside it.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'motion_goto_xy')) {
        return const LessonResult(false, "Put a 'go to x y' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "No matter where I wander, I always snap home. 🏠");
    },
  ),
  Lesson(
    id: 925,
    topicId: 'sensing',
    title: 'Count and Beep, Forever',
    glyph: '🎵',
    complexity: 2,
    target: "Forever: travel, and every edge sighting bumps Score and beeps.",
    narrator: "Let's combine counting with beeping — every single time, forever.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside 'if on edge': 'change Score by', then 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside 'if on edge'.");
      if (!inside.any((b) => b.defId == 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside 'if on edge' too.");
      return const LessonResult(true, "Counted AND beeped, every time, forever. 🎵");
    },
  ),
  Lesson(
    id: 926,
    topicId: 'sensing',
    title: 'Say It Twice',
    glyph: '🔂',
    complexity: 3,
    target: "When the edge is sensed, repeat the announcement twice instead of once.",
    narrator: "One 'say' wasn't loud enough. Let's repeat the reaction itself, right inside the decision.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside 'if on edge', add a 'repeat 2 times' block, and put 'say' inside THAT.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final repeats = edges.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat' block inside the 'if on edge' block.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the 'repeat' block.");
      }
      return const LessonResult(true, "The reaction itself repeats now — louder decisions! 🔂");
    },
  ),
  Lesson(
    id: 927,
    topicId: 'sensing',
    title: 'Reset the Score First',
    glyph: '0️⃣',
    complexity: 3,
    target: "Set Score to 0 at the start, then count every edge sighting inside the loop.",
    narrator: "Before I start my patrol, let's zero out the Score so the counting is fair from the start.",
    steps: const [
      "Add 'set Score to 0' (Variables) at the very top.",
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop with 'change Score by' and 'say' inside it.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Keep a 'set Score to' block at the top of your script.");
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      if (script.indexOf(sets.first) > script.indexOf(forevers.first)) {
        return const LessonResult(false, "Put the 'set Score to' block BEFORE the forever loop.");
      }
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside 'if on edge'.");
      if (!inside.any((b) => b.defId == 'looks_say')) return const LessonResult(false, "Add 'say' inside 'if on edge' too.");
      return const LessonResult(true, "Score starts fair, and climbs with every edge sighting. 0️⃣");
    },
  ),
  Lesson(
    id: 928,
    topicId: 'sensing',
    title: 'Turn and Nudge',
    glyph: '🌀',
    complexity: 2,
    target: "Forever: on sensing the edge, turn AND nudge x, both.",
    narrator: "A turn alone might not be enough — let's also give myself a nudge inward.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop with a 'turn' block and a 'change x by' block inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside 'if on edge'.");
      }
      if (!inside.any((b) => b.defId == 'motion_change_x')) return const LessonResult(false, "Add a 'change x by' block inside 'if on edge' too.");
      return const LessonResult(true, "Turned AND nudged — a stronger decision. 🌀");
    },
  ),
  Lesson(
    id: 929,
    topicId: 'sensing',
    title: 'Triple Step, Then Check',
    glyph: '3️⃣',
    complexity: 3,
    target: "Take three steps before each edge check, all inside the forever loop.",
    narrator: "Let's cover more ground between decisions: three steps, THEN sense the edge.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat 3 times' block with 'move steps' inside.",
      "After the repeat, add 'if on edge' with a reaction inside it.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      final repeats = body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat' block inside the forever loop.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the 'repeat' block.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop, after the repeat.");
      if (edges.first.body.isEmpty) return const LessonResult(false, "Put a reaction block inside the 'if on edge' block.");
      return const LessonResult(true, "Three steps, then a decision. Efficient patrol! 3️⃣");
    },
  ),
  Lesson(
    id: 930,
    topicId: 'sensing',
    title: 'Wait, Then Decide',
    glyph: '⏳',
    complexity: 3,
    target: "Forever: move, wait a moment, then sense the edge and react.",
    narrator: "Let's slow the patrol down with a short wait before every decision — more dramatic!",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add a 'wait seconds' block right after the move.",
      "Add 'if on edge' with a reaction inside, after the wait.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      final moveIdx = body.indexWhere((b) => b.defId == 'motion_move_steps');
      final waitIdx = body.indexWhere((b) => b.defId == 'control_wait');
      final edgeIdx = body.indexWhere((b) => b.defId == 'control_if_on_edge');
      if (moveIdx == -1) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      if (waitIdx == -1) return const LessonResult(false, "Put a 'wait seconds' block inside the forever loop.");
      if (edgeIdx == -1) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!(moveIdx < waitIdx && waitIdx < edgeIdx)) {
        return const LessonResult(false, "Order matters: move, THEN wait, THEN sense the edge.");
      }
      if (body[edgeIdx].body.isEmpty) return const LessonResult(false, "Put a reaction block inside the 'if on edge' block.");
      return const LessonResult(true, "A dramatic pause before every decision. ⏳");
    },
  ),
  Lesson(
    id: 931,
    topicId: 'sensing',
    title: 'Say and Beep, Forever',
    glyph: '📯',
    complexity: 3,
    target: "Forever: move, wait, then sense the edge with a say AND a beep inside.",
    narrator: "Let's combine the pause with our biggest reaction combo yet.",
    steps: const [
      "Add a 'forever' block with 'move steps' and 'wait seconds' inside.",
      "Add 'if on edge' with 'say' and 'play sound' both inside it.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      if (!cqFlatten(body).any((b) => b.defId == 'control_wait')) return const LessonResult(false, "Put a 'wait seconds' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'looks_say')) return const LessonResult(false, "Add 'say' inside 'if on edge'.");
      if (!inside.any((b) => b.defId == 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside 'if on edge' too.");
      return const LessonResult(true, "Paused, then said AND beeped. Great combo! 📯");
    },
  ),
  Lesson(
    id: 932,
    topicId: 'sensing',
    title: 'Double Beep',
    glyph: '🔔🔔',
    complexity: 3,
    target: "When the edge is sensed, beep twice using a repeat block inside the decision.",
    narrator: "Let's make the beep reaction itself loop twice — a repeat block nested inside the decision.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside 'if on edge', add a 'repeat 2 times' block with 'play sound' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final repeats = edges.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat' block inside the 'if on edge' block.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put a 'play sound' block inside the 'repeat' block.");
      }
      return const LessonResult(true, "Double beep, every time I sense the edge! 🔔🔔");
    },
  ),
  Lesson(
    id: 933,
    topicId: 'sensing',
    title: 'Fair Score, Forever',
    glyph: '⚖️',
    complexity: 3,
    target: "Zero the Score, then count every edge sighting forever, one point at a time.",
    narrator: "Let's make this an official patrol log: start Score at 0, then count every sighting.",
    steps: const [
      "Add 'set Score to 0' at the top.",
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop with 'change Score by 1' inside it.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Keep a 'set Score to' block at the top.");
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      if (script.indexOf(sets.first) > script.indexOf(forevers.first)) {
        return const LessonResult(false, "Put 'set Score to' BEFORE the forever loop.");
      }
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final change = cqFlatten(edges.first.body).where((b) => b.defId == 'variables_change').toList();
      if (change.isEmpty) return const LessonResult(false, "Add 'change Score by' inside 'if on edge'.");
      return const LessonResult(true, "A fair, running tally of every edge sighting. ⚖️");
    },
  ),
  Lesson(
    id: 934,
    topicId: 'sensing',
    title: 'Turn and Tally',
    glyph: '📊',
    complexity: 3,
    target: "Forever: on sensing the edge, turn away AND bump the Score.",
    narrator: "Let's mix action with bookkeeping: turn to avoid the edge, and log that it happened.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop with a 'turn' block and 'change Score by' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside 'if on edge'.");
      }
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside 'if on edge' too.");
      return const LessonResult(true, "Turned away AND logged it. Smart bookkeeping! 📊");
    },
  ),
  Lesson(
    id: 935,
    topicId: 'sensing',
    title: 'Say, Hide, Show',
    glyph: '🎭',
    complexity: 3,
    target: "React to the edge with a three-step sequence: say, hide, then show.",
    narrator: "Let's put on a little show every time I sense the edge: announce it, vanish, then reappear.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside it, in order: 'say', then 'hide', then 'show'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = edges.first.body;
      final sayIdx = inside.indexWhere((b) => b.defId == 'looks_say');
      final hideIdx = inside.indexWhere((b) => b.defId == 'looks_hide');
      final showIdx = inside.indexWhere((b) => b.defId == 'looks_show');
      if (sayIdx == -1 || hideIdx == -1 || showIdx == -1) {
        return const LessonResult(false, "Put 'say', 'hide', and 'show' all inside the 'if on edge' block.");
      }
      if (!(sayIdx < hideIdx && hideIdx < showIdx)) {
        return const LessonResult(false, "Order matters — say, THEN hide, THEN show.");
      }
      return const LessonResult(true, "A tiny performance every time I sense the edge! 🎭");
    },
  ),
  Lesson(
    id: 936,
    topicId: 'sensing',
    title: 'Snap Home and Beep',
    glyph: '🏡',
    complexity: 3,
    target: "Forever: on sensing the edge, teleport home AND beep about it.",
    narrator: "Let's make the teleport-home reaction a little louder with a beep to match.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop with 'go to x y' and 'play sound' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'motion_goto_xy')) return const LessonResult(false, "Add 'go to x y' inside 'if on edge'.");
      if (!inside.any((b) => b.defId == 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside 'if on edge' too.");
      return const LessonResult(true, "Snapped home with a beep to announce it. 🏡");
    },
  ),
  Lesson(
    id: 937,
    topicId: 'sensing',
    title: 'Cover More Ground',
    glyph: '🗺️',
    complexity: 3,
    target: "Take two steps per lap before checking the edge, then react.",
    narrator: "Let's cover more ground between each decision using a repeat before the check.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat 2 times' block with 'move steps' inside.",
      "After the repeat, add 'if on edge' with 'say' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      final repeats = body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat' block inside the forever loop.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the 'repeat' block.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block after the repeat, inside the forever loop.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "More ground covered per decision — efficient! 🗺️");
    },
  ),
  Lesson(
    id: 938,
    topicId: 'sensing',
    title: 'The Full Combo',
    glyph: '🌟',
    complexity: 3,
    target: "Forever: on sensing the edge, count it, turn away, AND beep — all three.",
    narrator: "Let's assemble our biggest single decision yet: count, turn, and beep together.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside it: 'change Score by', a 'turn' block, and 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside 'if on edge'.");
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside 'if on edge' too.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside 'if on edge' too.");
      return const LessonResult(true, "Counted, turned, AND beeped — the full combo! 🌟");
    },
  ),
  Lesson(
    id: 939,
    topicId: 'sensing',
    title: 'Patient Patrol',
    glyph: '🕰️',
    complexity: 3,
    target: "Forever: move, wait, then on sensing the edge, count it and say something.",
    narrator: "A patient patrol: pause between steps, then log and announce every sighting.",
    steps: const [
      "Add a 'forever' block with 'move steps' then 'wait seconds' inside.",
      "Add 'if on edge' with 'change Score by' and 'say' inside it.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      if (!cqFlatten(body).any((b) => b.defId == 'control_wait')) return const LessonResult(false, "Put a 'wait seconds' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside 'if on edge'.");
      if (!inside.any((b) => b.defId == 'looks_say')) return const LessonResult(false, "Add 'say' inside 'if on edge' too.");
      return const LessonResult(true, "Patient, logged, and vocal about every sighting. 🕰️");
    },
  ),
  Lesson(
    id: 940,
    topicId: 'sensing',
    title: 'Triple Turn',
    glyph: '🔺',
    complexity: 3,
    target: "When the edge is sensed, spin around three times using a repeat inside the decision.",
    narrator: "For our level-two-and-three capstone: a dramatic triple spin whenever I sense the edge.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside 'if on edge', add a 'repeat 3 times' block with a 'turn' block inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final repeats = edges.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat' block inside the 'if on edge' block.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the 'repeat' block.");
      }
      return const LessonResult(true, "A dramatic triple spin at the edge. Level mastered! 🔺");
    },
  ),

  // ---------------------------------------------------------------------
  // Complexity 4-5 (941-960): layered decisions — nested repeats, multiple
  // reactions, variable-driven escalation, all around the same one block.
  // ---------------------------------------------------------------------
  Lesson(
    id: 941,
    topicId: 'sensing',
    title: 'Long Strides, Big Log',
    glyph: '🦵',
    complexity: 4,
    target: "Forever: take two steps per lap, and on sensing the edge, log it and announce it.",
    narrator: "Let's stride further between checks, and make the eventual decision count for more.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat 2 times' block with 'move steps' inside.",
      "After the repeat, add 'if on edge' with 'change Score by' and 'say' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      final repeats = body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat' block inside the forever loop.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the 'repeat' block.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block after the repeat, inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside 'if on edge'.");
      if (!inside.any((b) => b.defId == 'looks_say')) return const LessonResult(false, "Add 'say' inside 'if on edge' too.");
      return const LessonResult(true, "Longer strides, and a decision that really counts. 🦵");
    },
  ),
  Lesson(
    id: 942,
    topicId: 'sensing',
    title: 'Fair Start, Double Beep',
    glyph: '🎺',
    complexity: 4,
    target: "Zero the Score, then on every edge sighting: log it AND beep twice.",
    narrator: "Let's start fair and make each sighting really noticeable — a count, plus a double beep.",
    steps: const [
      "Add 'set Score to 0' at the top.",
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop with 'change Score by', then a 'repeat 2 times' block containing 'play sound'.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Keep a 'set Score to' block at the top.");
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      if (script.indexOf(sets.first) > script.indexOf(forevers.first)) {
        return const LessonResult(false, "Put 'set Score to' BEFORE the forever loop.");
      }
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final edgeBody = edges.first.body;
      if (!edgeBody.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' directly inside 'if on edge'.");
      final repeats = edgeBody.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat 2 times' block inside 'if on edge' too.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the 'repeat' block.");
      }
      return const LessonResult(true, "Fair count, loud double beep. Layered decision! 🎺");
    },
  ),
  Lesson(
    id: 943,
    topicId: 'sensing',
    title: 'Say, Turn, and Tally',
    glyph: '🧩',
    complexity: 4,
    target: "Forever: on sensing the edge, say something, turn away, AND log the Score — in that order.",
    narrator: "Let's make the decision tell a little story, in order: speak, act, then record it.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside it, in order: 'say', a 'turn' block, then 'change Score by'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = edges.first.body;
      final sayIdx = inside.indexWhere((b) => b.defId == 'looks_say');
      final turnIdx = inside.indexWhere((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left');
      final changeIdx = inside.indexWhere((b) => b.defId == 'variables_change');
      if (sayIdx == -1 || turnIdx == -1 || changeIdx == -1) {
        return const LessonResult(false, "Put 'say', a 'turn' block, AND 'change Score by' all inside 'if on edge'.");
      }
      if (!(sayIdx < turnIdx && turnIdx < changeIdx)) {
        return const LessonResult(false, "Order matters — say, THEN turn, THEN log the Score.");
      }
      return const LessonResult(true, "A little story in every decision. Well ordered! 🧩");
    },
  ),
  Lesson(
    id: 944,
    topicId: 'sensing',
    title: 'Decide First, Then Move',
    glyph: '🔄',
    complexity: 4,
    target: "Forever: check the edge first, THEN move — flip the usual order.",
    narrator: "Let's flip the pattern: sense the edge FIRST, react, and only then take the next step.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'if on edge' first, with a 'repeat 3 times' block containing 'say' inside it.",
      "After the 'if on edge' block, add 'move steps'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      final edgeIdx = body.indexWhere((b) => b.defId == 'control_if_on_edge');
      final moveIdx = body.indexWhere((b) => b.defId == 'motion_move_steps');
      if (edgeIdx == -1) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (moveIdx == -1) return const LessonResult(false, "Put a 'move steps' block inside the forever loop too.");
      if (moveIdx < edgeIdx) return const LessonResult(false, "This time, put 'if on edge' BEFORE 'move steps'.");
      final repeats = body[edgeIdx].body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat 3 times' block inside the 'if on edge' block.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the 'repeat' block.");
      }
      return const LessonResult(true, "Sensed first, reacted, then moved on. Clever flip! 🔄");
    },
  ),
  Lesson(
    id: 945,
    topicId: 'sensing',
    title: 'Check Before, Check During',
    glyph: '🔍',
    complexity: 4,
    target: "Sense the edge once before the patrol starts, and keep sensing it during the patrol too.",
    narrator: "A careful process checks the edge once before setting off, and then keeps checking the whole time.",
    steps: const [
      "Add an 'if on edge' block at the very top with 'say' inside it.",
      "Add a 'forever' block after it with 'move steps' inside.",
      "Inside the forever loop, add another 'if on edge' block with a reaction inside.",
    ],
    starter: () => [BlockInstance('control_if_on_edge'), BlockInstance('control_forever')],
    check: (script) {
      final topEdges = script.where((b) => b.defId == 'control_if_on_edge').toList();
      if (topEdges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block at the top of your script, before the forever loop.");
      if (!cqFlatten(topEdges.first.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the top-level 'if on edge' block.");
      }
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block after the top-level 'if on edge' block.");
      if (script.indexOf(topEdges.first) > script.indexOf(forevers.first)) {
        return const LessonResult(false, "The first 'if on edge' block should come BEFORE the forever loop.");
      }
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final innerEdges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (innerEdges.isEmpty) return const LessonResult(false, "Put a SECOND 'if on edge' block inside the forever loop.");
      if (innerEdges.first.body.isEmpty) return const LessonResult(false, "Put a reaction block inside the second 'if on edge' block.");
      return const LessonResult(true, "Checked once at the start, and kept checking forever. 🔍");
    },
  ),
  Lesson(
    id: 946,
    topicId: 'sensing',
    title: 'Double Points, Double Spin',
    glyph: '💥',
    complexity: 4,
    target: "Forever: on sensing the edge, add two points to Score AND spin twice.",
    narrator: "Let's escalate the reward for spotting the edge: bigger points, bigger spin.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop with 'change Score by 2' and a 'repeat 2 times' block containing a 'turn' block.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final edgeBody = edges.first.body;
      final change = edgeBody.where((b) => b.defId == 'variables_change').toList();
      if (change.isEmpty) return const LessonResult(false, "Add 'change Score by' directly inside 'if on edge'.");
      final repeats = edgeBody.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat 2 times' block inside 'if on edge' too.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the 'repeat' block.");
      }
      return const LessonResult(true, "Bigger points, bigger spin — escalating reactions! 💥");
    },
  ),
  Lesson(
    id: 947,
    topicId: 'sensing',
    title: 'Cover Ground, Log, Announce',
    glyph: '🚩',
    complexity: 5,
    target: "Zero the Score, patrol two steps at a time, and on sensing the edge, log it and say something.",
    narrator: "This is a real patrol program now: fair start, ground covered per lap, and a full logged decision.",
    steps: const [
      "Add 'set Score to 0' at the top.",
      "Add a 'forever' block. Inside it, add a 'repeat 2 times' block with 'move steps' inside.",
      "After the repeat, add 'if on edge' with 'change Score by' and 'say' inside.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Keep a 'set Score to' block at the top.");
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      if (script.indexOf(sets.first) > script.indexOf(forevers.first)) {
        return const LessonResult(false, "Put 'set Score to' BEFORE the forever loop.");
      }
      final body = forevers.first.body;
      final repeats = body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat' block inside the forever loop.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the 'repeat' block.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block after the repeat, inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside 'if on edge'.");
      if (!inside.any((b) => b.defId == 'looks_say')) return const LessonResult(false, "Add 'say' inside 'if on edge' too.");
      return const LessonResult(true, "A real patrol program: fair, efficient, and logged. 🚩");
    },
  ),
  Lesson(
    id: 948,
    topicId: 'sensing',
    title: 'Pause, Then Triple Beep',
    glyph: '🎶',
    complexity: 4,
    target: "Forever: move, wait, then on sensing the edge, beep three times.",
    narrator: "Let's give the decision a dramatic musical flourish: pause, sense, then triple beep.",
    steps: const [
      "Add a 'forever' block with 'move steps' then 'wait seconds' inside.",
      "Add 'if on edge' inside the loop with a 'repeat 3 times' block containing 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      if (!cqFlatten(body).any((b) => b.defId == 'control_wait')) return const LessonResult(false, "Put a 'wait seconds' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final repeats = edges.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat 3 times' block inside the 'if on edge' block.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the 'repeat' block.");
      }
      return const LessonResult(true, "A dramatic pause, then a triple beep flourish. 🎶");
    },
  ),
  Lesson(
    id: 949,
    topicId: 'sensing',
    title: 'The Grand Reaction',
    glyph: '🎆',
    complexity: 5,
    target: "Forever: on sensing the edge, say something, turn, beep, AND log the Score — all four.",
    narrator: "Let's build the grandest single decision yet: four reactions, one edge sighting.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside it: 'say', a 'turn' block, 'play sound', AND 'change Score by'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'looks_say')) return const LessonResult(false, "Add 'say' inside 'if on edge'.");
      if (!inside.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside 'if on edge' too.");
      }
      if (!inside.any((b) => b.defId == 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside 'if on edge' too.");
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside 'if on edge' too.");
      return const LessonResult(true, "Four reactions from one decision. The grand combo! 🎆");
    },
  ),
  Lesson(
    id: 950,
    topicId: 'sensing',
    title: 'Announce, Then Escalate',
    glyph: '📢',
    complexity: 4,
    target: "Forever: on sensing the edge, say something, THEN repeat a beep twice as the escalation.",
    narrator: "Let's build a decision with two stages: the calm announcement, then the escalation.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside it: 'say' first, then a 'repeat 2 times' block containing 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = edges.first.body;
      final sayIdx = inside.indexWhere((b) => b.defId == 'looks_say');
      final repeatIdx = inside.indexWhere((b) => b.defId == 'control_repeat');
      if (sayIdx == -1) return const LessonResult(false, "Put a 'say' block inside 'if on edge'.");
      if (repeatIdx == -1) return const LessonResult(false, "Put a 'repeat 2 times' block inside 'if on edge' too.");
      if (repeatIdx < sayIdx) return const LessonResult(false, "Order matters — say first, THEN the repeat escalation.");
      if (!cqFlatten(inside[repeatIdx].body).any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the 'repeat' block.");
      }
      return const LessonResult(true, "Calm announcement, then a real escalation. 📢");
    },
  ),
  Lesson(
    id: 951,
    topicId: 'sensing',
    title: 'Quadruple Count',
    glyph: '➕',
    complexity: 4,
    target: "When the edge is sensed, bump the Score four separate times using a repeat inside the decision.",
    narrator: "Let's make each edge sighting worth a lot more — four separate bumps, all in one decision.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside it, add a 'repeat 4 times' block with 'change Score by' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final repeats = edges.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat 4 times' block inside the 'if on edge' block.");
      if ((repeats.first.inputs['times'] ?? 0) as num < 2) {
        return const LessonResult(false, "Set the repeat block's times to more than 1 for a real quadruple count.");
      }
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put 'change Score by' inside the 'repeat' block.");
      }
      return const LessonResult(true, "One sighting, four counted bumps. Big decision! ➕");
    },
  ),
  Lesson(
    id: 952,
    topicId: 'sensing',
    title: 'Veteran Announcement',
    glyph: '🎓',
    complexity: 5,
    target: "Log the Score at the start, then on every edge sighting, add points and give a longer, veteran-style announcement.",
    narrator: "A veteran process doesn't just say 'edge!' — it explains itself with a proper sentence.",
    steps: const [
      "Add 'set Score to 0' at the top.",
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop with 'change Score by' and a 'say' block with a full sentence typed in.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Keep a 'set Score to' block at the top.");
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      if (script.indexOf(sets.first) > script.indexOf(forevers.first)) {
        return const LessonResult(false, "Put 'set Score to' BEFORE the forever loop.");
      }
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = cqFlatten(edges.first.body);
      if (!inside.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside 'if on edge'.");
      final says = inside.where((b) => b.defId == 'looks_say').toList();
      if (says.isEmpty) return const LessonResult(false, "Add a 'say' block inside 'if on edge'.");
      final text = (says.first.inputs['text'] ?? '').toString();
      if (text.trim().length < 8) {
        return const LessonResult(false, "Give the say block a longer, more veteran-sounding sentence.");
      }
      return const LessonResult(true, "A proper veteran-style announcement, every time. 🎓");
    },
  ),
  Lesson(
    id: 953,
    topicId: 'sensing',
    title: 'Layered Escape Plan',
    glyph: '🗝️',
    complexity: 5,
    target: "Forever: patrol two steps at a time, and on sensing the edge, escalate with a turn, then a repeated beep, then a log.",
    narrator: "This is a full escape plan: cover ground, sense, react in stages, and keep score.",
    steps: const [
      "Add a 'forever' block. Inside it, add a 'repeat 2 times' block with 'move steps' inside.",
      "After the repeat, add 'if on edge'.",
      "Inside 'if on edge', in order: a 'turn' block, a 'repeat 2 times' block containing 'play sound', then 'change Score by'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      final outerRepeats = body.where((b) => b.defId == 'control_repeat').toList();
      if (outerRepeats.isEmpty) return const LessonResult(false, "Put a 'repeat' block inside the forever loop for the patrol steps.");
      if (!cqFlatten(outerRepeats.first.body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside that 'repeat' block.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block after the repeat, inside the forever loop.");
      final inside = edges.first.body;
      final turnIdx = inside.indexWhere((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left');
      final innerRepeatIdx = inside.indexWhere((b) => b.defId == 'control_repeat');
      final changeIdx = inside.indexWhere((b) => b.defId == 'variables_change');
      if (turnIdx == -1) return const LessonResult(false, "Put a 'turn' block inside 'if on edge'.");
      if (innerRepeatIdx == -1) return const LessonResult(false, "Put a 'repeat 2 times' block inside 'if on edge' too.");
      if (changeIdx == -1) return const LessonResult(false, "Put 'change Score by' inside 'if on edge' too.");
      if (!(turnIdx < innerRepeatIdx && innerRepeatIdx < changeIdx)) {
        return const LessonResult(false, "Order matters — turn, THEN the repeated beep, THEN log the Score.");
      }
      if (!cqFlatten(inside[innerRepeatIdx].body).any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the inner 'repeat' block.");
      }
      return const LessonResult(true, "A full staged escape plan, every single lap. 🗝️");
    },
  ),
  Lesson(
    id: 954,
    topicId: 'sensing',
    title: 'One Step, One Check',
    glyph: '🪜',
    complexity: 4,
    target: "Repeat a move-then-check pattern twice inside the forever loop, counting each sighting.",
    narrator: "Let's make the decision happen twice per lap by nesting the whole move-and-check pattern in a repeat.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat 2 times' block.",
      "Inside the repeat, put 'move steps' then 'if on edge' with 'change Score by' inside it.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final repeats = forevers.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Put a 'repeat' block inside the forever loop.");
      final rBody = repeats.first.body;
      if (!rBody.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the 'repeat' block.");
      }
      final edges = rBody.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the 'repeat' block too.");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, "Put 'change Score by' inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Move-and-check, twice per lap. Nicely nested! 🪜");
    },
  ),
  Lesson(
    id: 955,
    topicId: 'sensing',
    title: 'Speak Twice, Beep Once',
    glyph: '🎤',
    complexity: 4,
    target: "Forever: on sensing the edge, say something twice using a repeat, then beep once.",
    narrator: "Let's mix a repeated reaction with a single one, both inside the same decision.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside it: a 'repeat 2 times' block containing 'say', THEN 'play sound' after it.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = edges.first.body;
      final repeatIdx = inside.indexWhere((b) => b.defId == 'control_repeat');
      final soundIdx = inside.indexWhere((b) => b.defId == 'sound_play_click');
      if (repeatIdx == -1) return const LessonResult(false, "Put a 'repeat 2 times' block inside 'if on edge'.");
      if (!cqFlatten(inside[repeatIdx].body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put 'say' inside the 'repeat' block.");
      }
      if (soundIdx == -1) return const LessonResult(false, "Put 'play sound' inside 'if on edge', after the repeat.");
      if (soundIdx < repeatIdx) return const LessonResult(false, "Order matters — the repeated say first, THEN the beep.");
      return const LessonResult(true, "Repeated speech, then a single beep. Nice mix! 🎤");
    },
  ),
  Lesson(
    id: 956,
    topicId: 'sensing',
    title: 'Big Points, Big News',
    glyph: '💎',
    complexity: 5,
    target: "Zero the Score, then on sensing the edge, award five points and announce it's a big deal.",
    narrator: "Let's make edge sightings feel like a jackpot — five points and a big announcement.",
    steps: const [
      "Add 'set Score to 0' at the top.",
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop with 'change Score by 5' and 'say' inside it.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Keep a 'set Score to' block at the top.");
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      if (script.indexOf(sets.first) > script.indexOf(forevers.first)) {
        return const LessonResult(false, "Put 'set Score to' BEFORE the forever loop.");
      }
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final changes = cqFlatten(edges.first.body).where((b) => b.defId == 'variables_change').toList();
      if (changes.isEmpty) return const LessonResult(false, "Add 'change Score by' inside 'if on edge'.");
      final amount = (changes.first.inputs['value'] ?? 0) as num;
      if (amount < 2) return const LessonResult(false, "Make the 'change Score by' amount bigger — this is a jackpot decision!");
      if (!cqFlatten(edges.first.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block inside 'if on edge' too.");
      }
      return const LessonResult(true, "A jackpot decision — big points, big news! 💎");
    },
  ),
  Lesson(
    id: 957,
    topicId: 'sensing',
    title: 'Everything At Once',
    glyph: '🧨',
    complexity: 5,
    target: "Forever: on sensing the edge, turn, beep twice, AND log the Score — layered in one decision.",
    narrator: "Let's fire off a whole layered reaction the instant I sense the edge: turn, double beep, and log it.",
    steps: const [
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop.",
      "Inside it: a 'turn' block, then a 'repeat 2 times' block with 'play sound' inside, then 'change Score by'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = edges.first.body;
      final turnIdx = inside.indexWhere((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left');
      final repeatIdx = inside.indexWhere((b) => b.defId == 'control_repeat');
      final changeIdx = inside.indexWhere((b) => b.defId == 'variables_change');
      if (turnIdx == -1) return const LessonResult(false, "Put a 'turn' block inside 'if on edge'.");
      if (repeatIdx == -1) return const LessonResult(false, "Put a 'repeat 2 times' block inside 'if on edge' too.");
      if (changeIdx == -1) return const LessonResult(false, "Put 'change Score by' inside 'if on edge' too.");
      if (!(turnIdx < repeatIdx && repeatIdx < changeIdx)) {
        return const LessonResult(false, "Order matters — turn, THEN the double beep, THEN the log.");
      }
      if (!cqFlatten(inside[repeatIdx].body).any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the 'repeat' block.");
      }
      return const LessonResult(true, "A full layered burst from one edge sighting. 🧨");
    },
  ),
  Lesson(
    id: 958,
    topicId: 'sensing',
    title: 'Two Watchful Loops',
    glyph: '🔭',
    complexity: 5,
    target: "Sense the edge once before starting, then continuously in the forever loop with a layered reaction.",
    narrator: "A truly watchful process checks the edge before it even begins, and never stops checking after that.",
    steps: const [
      "Add 'set Score to 0', then an 'if on edge' block with 'say' inside — both at the top.",
      "Add a 'forever' block with 'move steps' inside.",
      "Inside the loop, add another 'if on edge' block with 'change Score by' and a 'repeat 2 times' block containing 'play sound'.",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_if_on_edge'),
      BlockInstance('control_forever'),
    ],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Keep a 'set Score to' block at the top.");
      final topEdges = script.where((b) => b.defId == 'control_if_on_edge').toList();
      if (topEdges.isEmpty) return const LessonResult(false, "Add an 'if on edge' block at the top, before the forever loop.");
      if (!cqFlatten(topEdges.first.body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the top-level 'if on edge' block.");
      }
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block after the top-level check.");
      if (script.indexOf(topEdges.first) > script.indexOf(forevers.first)) {
        return const LessonResult(false, "The first 'if on edge' block must come BEFORE the forever loop.");
      }
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final innerEdges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (innerEdges.isEmpty) return const LessonResult(false, "Put a SECOND 'if on edge' block inside the forever loop.");
      final innerBody = innerEdges.first.body;
      if (!innerBody.any((b) => b.defId == 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the second 'if on edge' block.");
      final repeats = innerBody.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat 2 times' block inside the second 'if on edge' block too.");
      if (!cqFlatten(repeats.first.body).any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside that 'repeat' block.");
      }
      return const LessonResult(true, "Watchful before AND during the whole patrol. 🔭");
    },
  ),
  Lesson(
    id: 959,
    topicId: 'sensing',
    title: 'The Full Patrol',
    glyph: '🏆',
    complexity: 5,
    target: "Patrol two steps at a time forever, and on sensing the edge: log it, say it twice, and beep.",
    narrator: "Let's build the whole patrol program, top to bottom, with a rich layered decision at its heart.",
    steps: const [
      "Add a 'forever' block. Inside it, add a 'repeat 2 times' block with 'move steps' inside.",
      "After the repeat, add 'if on edge'.",
      "Inside 'if on edge': 'change Score by', then a 'repeat 2 times' block containing 'say', then 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final body = forevers.first.body;
      final outerRepeats = body.where((b) => b.defId == 'control_repeat').toList();
      if (outerRepeats.isEmpty) return const LessonResult(false, "Put a 'repeat' block inside the forever loop for the patrol steps.");
      if (!cqFlatten(outerRepeats.first.body).any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside that 'repeat' block.");
      }
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block after the repeat, inside the forever loop.");
      final inside = edges.first.body;
      final changeIdx = inside.indexWhere((b) => b.defId == 'variables_change');
      final innerRepeatIdx = inside.indexWhere((b) => b.defId == 'control_repeat');
      final soundIdx = inside.indexWhere((b) => b.defId == 'sound_play_click');
      if (changeIdx == -1) return const LessonResult(false, "Put 'change Score by' inside 'if on edge'.");
      if (innerRepeatIdx == -1) return const LessonResult(false, "Put a 'repeat 2 times' block inside 'if on edge' too.");
      if (soundIdx == -1) return const LessonResult(false, "Put 'play sound' inside 'if on edge' too, after the repeat.");
      if (!(changeIdx < innerRepeatIdx && innerRepeatIdx < soundIdx)) {
        return const LessonResult(false, "Order matters — log the Score, THEN the repeated say, THEN beep.");
      }
      if (!cqFlatten(inside[innerRepeatIdx].body).any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put 'say' inside the inner 'repeat' block.");
      }
      return const LessonResult(true, "The full patrol program, layered and complete. 🏆");
    },
  ),
  Lesson(
    id: 960,
    topicId: 'sensing',
    title: 'Sensing Mastery',
    glyph: '👑',
    complexity: 5,
    target: "The grand finale: a fair score, an efficient patrol, and the richest layered decision yet on sensing the edge.",
    narrator: "This is everything I've learned about sensing the edge, combined into one final, confident patrol.",
    steps: const [
      "Add 'set Score to 0' at the top.",
      "Add a 'forever' block with 'move steps' inside.",
      "Add 'if on edge' inside the loop, with: 'change Score by 1', a 'repeat 3 times' block containing a 'turn' block, then 'say', then 'play sound' — in that order.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      final sets = script.where((b) => b.defId == 'variables_set').toList();
      if (sets.isEmpty) return const LessonResult(false, "Keep a 'set Score to' block at the top.");
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      if (script.indexOf(sets.first) > script.indexOf(forevers.first)) {
        return const LessonResult(false, "Put 'set Score to' BEFORE the forever loop.");
      }
      final body = forevers.first.body;
      if (!cqFlatten(body).any((b) => b.defId == 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      final edges = body.where((b) => b.defId == 'control_if_on_edge').toList();
      if (edges.isEmpty) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final inside = edges.first.body;
      final changeIdx = inside.indexWhere((b) => b.defId == 'variables_change');
      final repeatIdx = inside.indexWhere((b) => b.defId == 'control_repeat');
      final sayIdx = inside.indexWhere((b) => b.defId == 'looks_say');
      final soundIdx = inside.indexWhere((b) => b.defId == 'sound_play_click');
      if (changeIdx == -1) return const LessonResult(false, "Put 'change Score by' inside 'if on edge'.");
      if (repeatIdx == -1) return const LessonResult(false, "Put a 'repeat 3 times' block inside 'if on edge' too.");
      if (sayIdx == -1) return const LessonResult(false, "Put 'say' inside 'if on edge' too.");
      if (soundIdx == -1) return const LessonResult(false, "Put 'play sound' inside 'if on edge' too.");
      if (!(changeIdx < repeatIdx && repeatIdx < sayIdx && sayIdx < soundIdx)) {
        return const LessonResult(false, "Order matters — log, THEN the repeated turn, THEN say, THEN beep.");
      }
      if (!cqFlatten(inside[repeatIdx].body).any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Put a 'turn' block inside the 'repeat' block.");
      }
      return const LessonResult(true, "Fair, efficient, layered, and confident. Sensing mastery achieved! 👑");
    },
  ),
];
