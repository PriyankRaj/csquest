import '../models/cq_models.dart';
import 'cq_blocks.dart';

/// Topic: "events" — reinterpreted for this engine.
///
/// This engine has NO event/broadcast system and NO keyboard/click-input
/// blocks — there is no "when key pressed" or "when this sprite clicked".
/// Every script just runs top-to-bottom on Run. So "events" here means the
/// one real reactive thing this engine can do: automatically notice and
/// respond to Process reaching the edge of the world, via
/// `control_if_on_edge`. Lessons build from a single one-shot edge-reaction
/// up to continuously-watching (`control_forever` + `control_if_on_edge`),
/// counted reactions (`variables_change`), and layered multi-step reaction
/// sequences (`control_repeat` + say/sound inside the reaction). No
/// key/click/broadcast/receive block is invented anywhere below — the only
/// legitimate "click"-shaped thing used is the real `sound_play_click`
/// block, which is an existing Sound block, not an input event.

BlockInstance? _findBlock(List<BlockInstance> script, String defId) {
  for (final b in script) {
    if (b.defId == defId) return b;
    if (b.body.isNotEmpty) {
      final found = _findBlock(b.body, defId);
      if (found != null) return found;
    }
  }
  return null;
}

bool _bodyHas(BlockInstance? container, String defId) {
  if (container == null) return false;
  return cqFlatten(container.body).any((b) => b.defId == defId);
}

final cqEventsLessons = <Lesson>[
  // ---------------------------------------------------------------------
  // Tier 1 (781-795, complexity 1): one control_if_on_edge, one reaction.
  // ---------------------------------------------------------------------
  Lesson(
    id: 781,
    topicId: 'events',
    title: 'Edge Alert!',
    glyph: '🚨',
    complexity: 1,
    target: 'Make Process react the moment it reaches the edge of the world.',
    narrator: "I can't hear or see much, but I CAN feel the edge of the world. Let's react when it happens!",
    steps: const ["Add an 'if on edge' block (Control).", "Inside it, add a 'say' block (Looks) with a message."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Whoa — I felt that edge and said something! 🚨");
    },
  ),
  Lesson(
    id: 782,
    topicId: 'events',
    title: 'Boundary Beep',
    glyph: '🔊',
    complexity: 1,
    target: 'React to the edge with a sound instead of words.',
    narrator: "Words are nice, but a beep gets attention fast. Let's react with sound this time.",
    steps: const ["Add an 'if on edge' block.", "Inside it, add 'play sound' (Sound)."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'sound_play_click')) {
        return const LessonResult(false, "Put a 'play sound' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Beep! That's me reacting to the edge. 🔊");
    },
  ),
  Lesson(
    id: 783,
    topicId: 'events',
    title: 'Vanish at the Wall',
    glyph: '👻',
    complexity: 1,
    target: "Make Process disappear the instant it touches the edge.",
    narrator: "Watch this — the moment I feel the edge, I'll just... vanish.",
    steps: const ["Add an 'if on edge' block.", "Inside it, add 'hide' (Looks)."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'looks_hide')) {
        return const LessonResult(false, "Put a 'hide' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "Poof! Gone the instant I hit the edge. 👻");
    },
  ),
  Lesson(
    id: 784,
    topicId: 'events',
    title: 'Reappear on Contact',
    glyph: '✨',
    complexity: 1,
    target: 'React to the edge by showing Process again.',
    narrator: "Now the opposite trick — I'll pop back into view the second I reach the edge.",
    steps: const ["Add an 'if on edge' block.", "Inside it, add 'show' (Looks)."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'looks_show')) {
        return const LessonResult(false, "Put a 'show' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "There I am — reacting by reappearing! ✨");
    },
  ),
  Lesson(
    id: 785,
    topicId: 'events',
    title: 'Sound and Word',
    glyph: '📢',
    complexity: 1,
    target: 'Give the edge reaction two parts: a sound AND a word.',
    narrator: "One reaction is good. Two reactions at once is better!",
    steps: const ["Add an 'if on edge' block.", "Inside it, add 'play sound', then 'say'."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      return const LessonResult(true, "Beep AND a shout — a proper two-part reaction! 📢");
    },
  ),
  Lesson(
    id: 786,
    topicId: 'events',
    title: 'Recoil Turn',
    glyph: '↻',
    complexity: 1,
    target: 'React to the edge by spinning around.',
    narrator: "Sometimes the best reaction is a physical one. Let's spin when I hit the edge.",
    steps: const ["Add an 'if on edge' block.", "Inside it, add a 'turn' block (Motion)."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'motion_turn_right') && !_bodyHas(edge, 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "A dramatic spin the moment I hit the edge! ↻");
    },
  ),
  Lesson(
    id: 787,
    topicId: 'events',
    title: 'Nudge Back',
    glyph: '↕️',
    complexity: 1,
    target: 'React to the edge by nudging away from it.',
    narrator: "Instead of a full bounce, let's just nudge myself back a little when I feel the edge.",
    steps: const ["Add an 'if on edge' block.", "Inside it, add 'change y by' (Motion)."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'motion_change_y') && !_bodyHas(edge, 'motion_change_x')) {
        return const LessonResult(false, "Add a 'change x/y by' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "A little nudge away from the edge — nice reflex! ↕️");
    },
  ),
  Lesson(
    id: 788,
    topicId: 'events',
    title: 'Tally One',
    glyph: '🔢',
    complexity: 1,
    target: 'React to the edge by counting it — change the Score.',
    narrator: "Reactions can be invisible too — like counting how many times something happened.",
    steps: const ["Add an 'if on edge' block.", "Inside it, add 'change Score by' (Variables)."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'variables_change')) {
        return const LessonResult(false, "Add a 'change Score by' block inside the 'if on edge' block.");
      }
      return const LessonResult(true, "That's one tally mark for the edge! 🔢");
    },
  ),
  Lesson(
    id: 789,
    topicId: 'events',
    title: 'Say Something',
    glyph: '💬',
    complexity: 1,
    target: 'Give the edge reaction real, non-empty words.',
    narrator: "An empty shout is no shout at all — give me actual words to say when I hit the edge.",
    steps: const ["Add an 'if on edge' block.", "Inside it, add 'say' with real text in it."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      final say = edge.body.where((b) => b.defId == 'looks_say').toList();
      if (say.isEmpty) return const LessonResult(false, "Add a 'say' block inside the 'if on edge' block.");
      final text = (say.first.inputs['text'] ?? '').toString().trim();
      if (text.isEmpty) return const LessonResult(false, "Give the 'say' block some actual words!");
      return const LessonResult(true, "Now that's a real reaction with real words! 💬");
    },
  ),
  Lesson(
    id: 790,
    topicId: 'events',
    title: 'Beep Then Speak',
    glyph: '🔔',
    complexity: 1,
    target: 'Order the reaction: sound first, then a word.',
    narrator: "The order of a reaction matters — beep first to grab attention, THEN speak.",
    steps: const ["Add an 'if on edge' block.", "Put 'play sound' first, then 'say' after it, inside."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      final soundIdx = edge.body.indexWhere((b) => b.defId == 'sound_play_click');
      final sayIdx = edge.body.indexWhere((b) => b.defId == 'looks_say');
      if (soundIdx == -1 || sayIdx == -1) {
        return const LessonResult(false, "Put both 'play sound' and 'say' inside the 'if on edge' block.");
      }
      if (soundIdx > sayIdx) return const LessonResult(false, "Put 'play sound' BEFORE 'say' inside the block.");
      return const LessonResult(true, "Beep, then a word — a clean two-step reaction! 🔔");
    },
  ),
  Lesson(
    id: 791,
    topicId: 'events',
    title: 'Show and Tell',
    glyph: '🎤',
    complexity: 1,
    target: 'React to the edge by reappearing AND announcing it.',
    narrator: "If I've been hidden, the edge is my cue to reappear and tell everyone about it.",
    steps: const ["Add an 'if on edge' block.", "Inside it, add 'show', then 'say'."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'looks_show')) return const LessonResult(false, "Add 'show' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      return const LessonResult(true, "Show up AND speak up — great combo reaction! 🎤");
    },
  ),
  Lesson(
    id: 792,
    topicId: 'events',
    title: 'Hide and Beep',
    glyph: '🙈',
    complexity: 1,
    target: 'React to the edge by hiding AND making a sound.',
    narrator: "Sometimes the reaction is to duck out of sight — but still make some noise about it.",
    steps: const ["Add an 'if on edge' block.", "Inside it, add 'hide', then 'play sound'."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'looks_hide')) return const LessonResult(false, "Add 'hide' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block too.");
      return const LessonResult(true, "Hidden but not silent — nice reaction! 🙈");
    },
  ),
  Lesson(
    id: 793,
    topicId: 'events',
    title: 'Count and Announce',
    glyph: '🧾',
    complexity: 1,
    target: 'React to the edge by counting it AND announcing it.',
    narrator: "Let's combine a silent reaction (counting) with a loud one (saying it out loud).",
    steps: const ["Add an 'if on edge' block.", "Inside it, add 'change Score by', then 'say'."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      return const LessonResult(true, "Counted AND announced — a complete reaction! 🧾");
    },
  ),
  Lesson(
    id: 794,
    topicId: 'events',
    title: 'Spin and Beep',
    glyph: '🌀',
    complexity: 1,
    target: 'React to the edge with motion AND sound.',
    narrator: "A physical reaction plus a sound reaction — let's stack them.",
    steps: const ["Add an 'if on edge' block.", "Inside it, add a 'turn' block, then 'play sound'."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'motion_turn_right') && !_bodyHas(edge, 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside the 'if on edge' block.");
      }
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block too.");
      return const LessonResult(true, "Spin AND beep — a very lively reaction! 🌀");
    },
  ),
  Lesson(
    id: 795,
    topicId: 'events',
    title: 'The Triple Reaction',
    glyph: '🎯',
    complexity: 1,
    target: 'Build a three-part reaction: count, speak, and beep — all in one edge touch.',
    narrator: "Let's put everything together — my biggest reaction yet, all from one edge touch.",
    steps: const [
      "Add an 'if on edge' block.",
      "Inside it, add 'change Score by', 'say', and 'play sound' — all three.",
    ],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final edge = _findBlock(script, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block from Control.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the block.");
      return const LessonResult(true, "Count, speak, and beep — a full triple reaction! 🎯");
    },
  ),

  // ---------------------------------------------------------------------
  // Tier 2 (796-820, complexity 2-3): forever + if_on_edge, continuous
  // watching, counting reactions, sound+say combos, plus moving.
  // ---------------------------------------------------------------------
  Lesson(
    id: 796,
    topicId: 'events',
    title: 'Always Watching',
    glyph: '👀',
    complexity: 2,
    target: "Make Process watch for the edge forever, not just once.",
    narrator: "One reaction was fine, but a real reaction system never stops watching. Let's loop it.",
    steps: const ["Add a 'forever' block.", "Inside it, add an 'if on edge' block.", "Inside THAT, add 'say'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Put a 'say' block inside the 'if on edge' block.");
      return const LessonResult(true, "Now I'm always watching for the edge! 👀");
    },
  ),
  Lesson(
    id: 797,
    topicId: 'events',
    title: 'Endless Beep',
    glyph: '🔁',
    complexity: 2,
    target: 'Keep reacting with sound every single time the edge happens.',
    narrator: "Let's make the beep reaction permanent — every edge touch, forever.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'if on edge'.", "Inside that, add 'play sound'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Put 'play sound' inside the 'if on edge' block.");
      return const LessonResult(true, "An endless beep reaction — always ready! 🔁");
    },
  ),
  Lesson(
    id: 798,
    topicId: 'events',
    title: 'Reaction Counter',
    glyph: '📊',
    complexity: 2,
    target: 'Continuously count every edge reaction in the Score.',
    narrator: "Now let's keep a running tally of every single time I react to the edge.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'if on edge'.", "Inside that, add 'change Score by'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Put 'change Score by' inside the 'if on edge' block.");
      return const LessonResult(true, "Every reaction now adds to the tally! 📊");
    },
  ),
  Lesson(
    id: 799,
    topicId: 'events',
    title: 'Double Reaction Loop',
    glyph: '🔂',
    complexity: 2,
    target: 'Continuously react with both a word and a sound.',
    narrator: "Let's make the two-part reaction permanent, not just a one-off.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'if on edge'.", "Inside that, add 'say' and 'play sound'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block too.");
      return const LessonResult(true, "A permanent word-and-beep reaction! 🔂");
    },
  ),
  Lesson(
    id: 800,
    topicId: 'events',
    title: 'Count and Say Forever',
    glyph: '🧮',
    complexity: 2,
    target: 'Continuously count AND announce every edge reaction.',
    narrator: "Now every edge touch both adds to my score AND gets announced out loud.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'if on edge'.", "Inside that, add 'change Score by' and 'say'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      return const LessonResult(true, "Counted AND announced, every single time! 🧮");
    },
  ),
  Lesson(
    id: 801,
    topicId: 'events',
    title: 'Count and Beep Forever',
    glyph: '📈',
    complexity: 2,
    target: 'Continuously count AND beep on every edge reaction.',
    narrator: "Let's pair the tally with a beep this time, looping forever.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'if on edge'.", "Inside that, add 'change Score by' and 'play sound'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block too.");
      return const LessonResult(true, "Tally plus beep, on repeat! 📈");
    },
  ),
  Lesson(
    id: 802,
    topicId: 'events',
    title: 'The Full Loop Reaction',
    glyph: '💯',
    complexity: 2,
    target: 'Continuously count, speak, and beep — all three, forever.',
    narrator: "This is the complete reaction, looping forever: count it, say it, beep it.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'if on edge'.",
      "Inside that, add 'change Score by', 'say', and 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      return const LessonResult(true, "The full reaction, forever — count, speak, beep! 💯");
    },
  ),
  Lesson(
    id: 803,
    topicId: 'events',
    title: 'Moving Watch',
    glyph: '🏃',
    complexity: 3,
    target: 'Keep moving AND watching for the edge at the same time.',
    narrator: "A stationary watcher is easy. A MOVING watcher that still reacts? That's the real skill.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'move steps', then 'if on edge'.", "Inside 'if on edge', add 'say'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Put 'say' inside the 'if on edge' block.");
      return const LessonResult(true, "Moving AND reacting — a true patrol! 🏃");
    },
  ),
  Lesson(
    id: 804,
    topicId: 'events',
    title: 'Patrol and Beep',
    glyph: '📡',
    complexity: 3,
    target: 'Move continuously and beep on every edge touch.',
    narrator: "Now I'm on patrol, moving nonstop and beeping whenever I hit the boundary.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'move steps', then 'if on edge'.", "Inside 'if on edge', add 'play sound'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Put 'play sound' inside the 'if on edge' block.");
      return const LessonResult(true, "Patrolling and beeping — reliable reactions! 📡");
    },
  ),
  Lesson(
    id: 805,
    topicId: 'events',
    title: 'Roaming Reactor',
    glyph: '🛰️',
    complexity: 3,
    target: 'Move continuously and count every edge touch.',
    narrator: "Every lap I make around the world, let's silently tally the edges I hit.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'move steps', then 'if on edge'.", "Inside 'if on edge', add 'change Score by'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Put 'change Score by' inside the 'if on edge' block.");
      return const LessonResult(true, "Roaming and counting every reaction! 🛰️");
    },
  ),
  Lesson(
    id: 806,
    topicId: 'events',
    title: 'Roam, Count, Announce',
    glyph: '🧭',
    complexity: 3,
    target: 'Move continuously, count, AND announce every edge touch.',
    narrator: "Let's combine moving, counting, and announcing into one continuous patrol.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'move steps', then 'if on edge'.",
      "Inside 'if on edge', add 'change Score by' and 'say'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      return const LessonResult(true, "Roam, count, announce — a solid patrol system! 🧭");
    },
  ),
  Lesson(
    id: 807,
    topicId: 'events',
    title: 'Reset Before Reacting',
    glyph: '0️⃣',
    complexity: 2,
    target: 'Reset the Score to 0 before starting the reaction loop.',
    narrator: "A fair tally starts at zero. Let's set the Score first, then start reacting.",
    steps: const ["Add 'set Score to 0' before the loop.", "Add a 'forever' block with 'if on edge' inside.", "Inside that, add 'change Score by'."],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (!(script.isNotEmpty && script.first.defId == 'variables_set')) {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Put 'change Score by' inside the 'if on edge' block.");
      return const LessonResult(true, "A clean start and an honest tally! 0️⃣");
    },
  ),
  Lesson(
    id: 808,
    topicId: 'events',
    title: 'Patrol With a Fair Count',
    glyph: '🧾',
    complexity: 3,
    target: 'Reset the Score, then move, watch, count, and beep — forever.',
    narrator: "Let's build my most complete patrol system yet: fair start, movement, counting, beeping.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by' and 'play sound'.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block too.");
      return const LessonResult(true, "Fair start, real patrol, real reactions! 🧾");
    },
  ),
  Lesson(
    id: 809,
    topicId: 'events',
    title: 'Duck and Tell',
    glyph: '🙊',
    complexity: 3,
    target: 'React continuously by hiding, then announcing it, in that order.',
    narrator: "Let's react in a specific order — duck out of sight first, then explain myself.",
    steps: const ["Add a 'forever' block with 'if on edge' inside.", "Inside it, add 'hide' first, then 'say'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final hideIdx = edge.body.indexWhere((b) => b.defId == 'looks_hide');
      final sayIdx = edge.body.indexWhere((b) => b.defId == 'looks_say');
      if (hideIdx == -1 || sayIdx == -1) return const LessonResult(false, "Add both 'hide' and 'say' inside the 'if on edge' block.");
      if (hideIdx > sayIdx) return const LessonResult(false, "Put 'hide' BEFORE 'say' inside the block.");
      return const LessonResult(true, "Duck, then explain — perfect order! 🙊");
    },
  ),
  Lesson(
    id: 810,
    topicId: 'events',
    title: 'Reappear and Beep',
    glyph: '🎬',
    complexity: 3,
    target: 'React continuously by showing, then beeping, in that order.',
    narrator: "The reverse trick — reappear first, THEN make some noise about it.",
    steps: const ["Add a 'forever' block with 'if on edge' inside.", "Inside it, add 'show' first, then 'play sound'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final showIdx = edge.body.indexWhere((b) => b.defId == 'looks_show');
      final soundIdx = edge.body.indexWhere((b) => b.defId == 'sound_play_click');
      if (showIdx == -1 || soundIdx == -1) return const LessonResult(false, "Add both 'show' and 'play sound' inside the 'if on edge' block.");
      if (showIdx > soundIdx) return const LessonResult(false, "Put 'show' BEFORE 'play sound' inside the block.");
      return const LessonResult(true, "Reappear, then beep — great timing! 🎬");
    },
  ),
  Lesson(
    id: 811,
    topicId: 'events',
    title: 'Spin, Then Speak',
    glyph: '🗣️',
    complexity: 3,
    target: 'React continuously with a turn, then an announcement, in order.',
    narrator: "A physical flinch, then a verbal explanation — a very believable reaction.",
    steps: const ["Add a 'forever' block with 'if on edge' inside.", "Inside it, add a 'turn' block first, then 'say'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      final turnIdx = edge.body.indexWhere((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left');
      final sayIdx = edge.body.indexWhere((b) => b.defId == 'looks_say');
      if (turnIdx == -1 || sayIdx == -1) return const LessonResult(false, "Add both a 'turn' block and 'say' inside the 'if on edge' block.");
      if (turnIdx > sayIdx) return const LessonResult(false, "Put the 'turn' block BEFORE 'say' inside the block.");
      return const LessonResult(true, "Spin, then speak — very believable! 🗣️");
    },
  ),
  Lesson(
    id: 812,
    topicId: 'events',
    title: 'Nudge and Note',
    glyph: '📝',
    complexity: 3,
    target: 'React continuously by nudging position, then counting it.',
    narrator: "A tiny nudge away from the edge, then a quiet note in the tally.",
    steps: const ["Add a 'forever' block with 'if on edge' inside.", "Inside it, add 'change y by', then 'change Score by'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!_bodyHas(edge, 'motion_change_y') && !_bodyHas(edge, 'motion_change_x')) {
        return const LessonResult(false, "Add a 'change x/y by' block inside the 'if on edge' block.");
      }
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block too.");
      return const LessonResult(true, "A nudge and a note — subtle but real! 📝");
    },
  ),
  Lesson(
    id: 813,
    topicId: 'events',
    title: 'Patient Patrol',
    glyph: '⏱️',
    complexity: 3,
    target: 'Wait a moment on each loop, but still react instantly to the edge.',
    narrator: "Even a patient, slower patrol still needs to react the moment the edge happens.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'wait 1 seconds', then 'if on edge'.", "Inside that, add 'say'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Add a 'wait' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Put 'say' inside the 'if on edge' block.");
      return const LessonResult(true, "Patient, but still ready to react! ⏱️");
    },
  ),
  Lesson(
    id: 814,
    topicId: 'events',
    title: 'Triple Reaction on the Move',
    glyph: '🚀',
    complexity: 3,
    target: 'Move continuously and react with all three: count, say, beep.',
    narrator: "Let's take the full triple reaction and put it on a moving patrol.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'move steps', then 'if on edge'.",
      "Inside 'if on edge', add 'change Score by', 'say', and 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      return const LessonResult(true, "The full triple reaction, on the move! 🚀");
    },
  ),
  Lesson(
    id: 815,
    topicId: 'events',
    title: 'Fair Patrol, Full Reaction',
    glyph: '🏁',
    complexity: 3,
    target: 'Reset the Score, then patrol with a count-and-say reaction.',
    narrator: "Start fair, patrol forever, and react with both a tally and an announcement.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by' and 'say'.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      return const LessonResult(true, "Fair start, full patrol reaction! 🏁");
    },
  ),
  Lesson(
    id: 816,
    topicId: 'events',
    title: 'React, Then Rest',
    glyph: '😌',
    complexity: 3,
    target: 'React fully to the edge, then pause before checking again.',
    narrator: "After a big reaction, I deserve a little breather before watching again.",
    steps: const [
      "Add a 'forever' block with 'if on edge' inside.",
      "Inside it, add 'change Score by', 'say', and 'play sound'.",
      "After the 'if on edge' block (still inside forever), add 'wait 1 seconds'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      if (!forever.body.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Add a 'wait' block inside the forever loop, after the 'if on edge' block.");
      }
      return const LessonResult(true, "React fully, then a well-earned rest! 😌");
    },
  ),
  Lesson(
    id: 817,
    topicId: 'events',
    title: 'Two Steps, Then Check',
    glyph: '👣',
    complexity: 3,
    target: 'Take two steps in a repeat, then check the edge and react.',
    narrator: "Let's move in short bursts of two steps, checking for the edge after each burst.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat 2 times' block containing 'move steps'.",
      "After the repeat (still inside forever), add 'if on edge' with 'say' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final repeat = _findBlock(forever.body, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block inside the forever loop.");
      if (!_bodyHas(repeat, 'motion_move_steps')) return const LessonResult(false, "Put a 'move steps' block inside the repeat block.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Put 'say' inside the 'if on edge' block.");
      return const LessonResult(true, "Burst of steps, then a check — nicely paced! 👣");
    },
  ),
  Lesson(
    id: 818,
    topicId: 'events',
    title: 'Move, Count, Beep, Speak',
    glyph: '🎇',
    complexity: 3,
    target: 'Move continuously, reacting with count, beep, and speech every time.',
    narrator: "Let's stack the order differently this time: count, beep, THEN speak.",
    steps: const [
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by', 'play sound', then 'say'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      final changeIdx = edge.body.indexWhere((b) => b.defId == 'variables_change');
      final soundIdx = edge.body.indexWhere((b) => b.defId == 'sound_play_click');
      final sayIdx = edge.body.indexWhere((b) => b.defId == 'looks_say');
      if (changeIdx == -1 || soundIdx == -1 || sayIdx == -1) {
        return const LessonResult(false, "Add 'change Score by', 'play sound', and 'say' inside the 'if on edge' block.");
      }
      if (!(changeIdx < soundIdx && soundIdx < sayIdx)) {
        return const LessonResult(false, "Order them: 'change Score by', then 'play sound', then 'say'.");
      }
      return const LessonResult(true, "Count, beep, speak — great order! 🎇");
    },
  ),
  Lesson(
    id: 819,
    topicId: 'events',
    title: 'Reset, Roam, Rest, React',
    glyph: '🌙',
    complexity: 3,
    target: 'Reset Score, then move, wait, and react with count and say — forever.',
    narrator: "A calm, complete patrol: start fair, move a little, rest a little, then react.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'wait 1 seconds' inside.",
      "After those (still inside forever), add 'if on edge' with 'change Score by' and 'say' inside.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      if (!forever.body.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Put a 'wait' block inside the forever loop too.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      return const LessonResult(true, "A calm, fair, complete patrol! 🌙");
    },
  ),
  Lesson(
    id: 820,
    topicId: 'events',
    title: 'The Complete Patrol',
    glyph: '🏆',
    complexity: 3,
    target: 'Move continuously and react with all three parts: count, say, beep.',
    narrator: "This is the patrol system I've been building toward — moving, watching, and reacting fully.",
    steps: const [
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by', 'say', and 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      return const LessonResult(true, "The complete patrol system, fully wired! 🏆");
    },
  ),

  // ---------------------------------------------------------------------
  // Tier 3 (821-840, complexity 4-5): deep nesting, repeat-based reaction
  // sequences, variable-driven multi-step reactions.
  // ---------------------------------------------------------------------
  Lesson(
    id: 821,
    topicId: 'events',
    title: 'Fair Start, Real Patrol',
    glyph: '🔰',
    complexity: 4,
    target: 'Reset Score to 0, then move and react with count + say, forever.',
    narrator: "Every serious reaction system starts with a clean slate. Let's make this one solid.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by' and 'say'.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      return const LessonResult(true, "A fair, real, working patrol! 🔰");
    },
  ),
  Lesson(
    id: 822,
    topicId: 'events',
    title: 'Double Beep Reaction',
    glyph: '📣',
    complexity: 4,
    target: 'React with a repeated double-beep, then an announcement.',
    narrator: "One beep is a hint. Two beeps in a row is unmistakable. Let's build that reaction.",
    steps: const [
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add a 'repeat 2 times' block containing 'play sound'.",
      "After the repeat (still inside 'if on edge'), add 'say'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      final repeat = edge.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the 'if on edge' block.");
      if (!_bodyHas(repeat.first, 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the repeat block.");
      }
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add a 'say' block inside the 'if on edge' block too.");
      return const LessonResult(true, "Beep-beep, then a word — unmistakable! 📣");
    },
  ),
  Lesson(
    id: 823,
    topicId: 'events',
    title: 'Count Then Double Beep',
    glyph: '🎊',
    complexity: 4,
    target: 'React by counting once, then beeping twice.',
    narrator: "Silent tally first, then a loud, repeated beep to match.",
    steps: const [
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by'.",
      "Then add a 'repeat 2 times' block containing 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      final repeat = edge.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the 'if on edge' block.");
      if (!_bodyHas(repeat.first, 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the repeat block.");
      }
      return const LessonResult(true, "Count, then a proper double beep! 🎊");
    },
  ),
  Lesson(
    id: 824,
    topicId: 'events',
    title: 'Full Layered Reaction',
    glyph: '🧱',
    complexity: 4,
    target: 'React with count, say, then a triple-beep sequence.',
    narrator: "Let's layer a reaction sequence: count it, say it, then beep it three times for emphasis.",
    steps: const [
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by' and 'say'.",
      "Then add a 'repeat 3 times' block containing 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      final repeat = edge.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the 'if on edge' block.");
      if (!_bodyHas(repeat.first, 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the repeat block.");
      }
      return const LessonResult(true, "Count, speak, and a triple beep — layered perfectly! 🧱");
    },
  ),
  Lesson(
    id: 825,
    topicId: 'events',
    title: 'React, Then Recover',
    glyph: '🔄',
    complexity: 4,
    target: 'Fully react (count, say, beep), then turn away before continuing the patrol.',
    narrator: "After a full reaction, I should turn myself away so I don't just hit the edge again immediately.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by', 'say', and 'play sound'.",
      "After the 'if on edge' block (still inside forever), add a 'turn' block.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      if (!forever.body.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside the forever loop, after 'if on edge'.");
      }
      return const LessonResult(true, "React fully, then recover gracefully! 🔄");
    },
  ),
  Lesson(
    id: 826,
    topicId: 'events',
    title: 'Two Steps, Full Reaction',
    glyph: '🥾',
    complexity: 4,
    target: 'Move twice per loop, then fully react with count, say, and beep.',
    narrator: "Bigger strides, then a bigger reaction when I finally hit that edge.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat 2 times' block containing 'move steps'.",
      "After the repeat (still inside forever), add 'if on edge' with 'change Score by', 'say', and 'play sound' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final repeat = forever.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the forever loop.");
      if (!_bodyHas(repeat.first, 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the repeat block.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      return const LessonResult(true, "Bigger strides, bigger reaction! 🥾");
    },
  ),
  Lesson(
    id: 827,
    topicId: 'events',
    title: 'The Encore Reaction',
    glyph: '🎭',
    complexity: 4,
    target: 'React by counting, then repeating a say+beep pair twice, like an encore.',
    narrator: "Some reactions deserve an encore — say it and beep it, then do that whole pair again.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by'.",
      "Then add a 'repeat 2 times' block containing 'say' and 'play sound'.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      final repeat = edge.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the 'if on edge' block.");
      if (!_bodyHas(repeat.first, 'looks_say') || !_bodyHas(repeat.first, 'sound_play_click')) {
        return const LessonResult(false, "Put both 'say' and 'play sound' inside the repeat block.");
      }
      return const LessonResult(true, "An encore reaction, twice over! 🎭");
    },
  ),
  Lesson(
    id: 828,
    topicId: 'events',
    title: 'React, Then Breathe',
    glyph: '🫁',
    complexity: 4,
    target: 'React with count and say, then pause, on a moving patrol.',
    narrator: "A full reaction, then a breath before the next lap. Sustainable patrolling.",
    steps: const [
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by' and 'say'.",
      "After the 'if on edge' block (still inside forever), add 'wait 1 seconds'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      if (!forever.body.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Add a 'wait' block inside the forever loop, after 'if on edge'.");
      }
      return const LessonResult(true, "React, then breathe — sustainable! 🫁");
    },
  ),
  Lesson(
    id: 829,
    topicId: 'events',
    title: 'React and Reorient',
    glyph: '🧿',
    complexity: 4,
    target: 'Fully react, then turn twice to reorient before the next lap.',
    narrator: "After a big reaction, I need a proper reorientation — two full turns before I move again.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by', 'play sound', and 'say'.",
      "After 'if on edge' (still inside forever), add a 'repeat 2 times' block containing a 'turn' block.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      final repeat = forever.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the forever loop, after 'if on edge'.");
      if (!(_bodyHas(repeat.first, 'motion_turn_left') || _bodyHas(repeat.first, 'motion_turn_right'))) {
        return const LessonResult(false, "Put a 'turn' block inside the repeat block.");
      }
      return const LessonResult(true, "React fully, then reorient properly! 🧿");
    },
  ),
  Lesson(
    id: 830,
    topicId: 'events',
    title: 'The Patrol Pattern',
    glyph: '🕸️',
    complexity: 4,
    target: 'Move and turn in a repeated pattern, still reacting fully to the edge.',
    narrator: "A patrol with style: move-and-turn a few times, but still react the instant the edge shows up.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat 3 times' block containing 'move steps' and a 'turn' block.",
      "After the repeat (still inside forever), add 'if on edge' with 'change Score by' and 'say' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final repeat = forever.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the forever loop.");
      if (!_bodyHas(repeat.first, 'motion_move_steps')) return const LessonResult(false, "Put 'move steps' inside the repeat block.");
      if (!(_bodyHas(repeat.first, 'motion_turn_left') || _bodyHas(repeat.first, 'motion_turn_right'))) {
        return const LessonResult(false, "Put a 'turn' block inside the repeat block too.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      return const LessonResult(true, "A stylish patrol pattern, fully reactive! 🕸️");
    },
  ),
  Lesson(
    id: 831,
    topicId: 'events',
    title: 'The Dramatic Vanish',
    glyph: '🎇',
    complexity: 5,
    target: 'Fully react — count, say, beep — then dramatically hide.',
    narrator: "My biggest reaction yet: count it, announce it, beep it, and THEN vanish for effect.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by', 'say', 'play sound', then 'hide'.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_hide')) return const LessonResult(false, "Add 'hide' inside the 'if on edge' block, for dramatic effect.");
      return const LessonResult(true, "Count, speak, beep, and vanish — dramatic! 🎇");
    },
  ),
  Lesson(
    id: 832,
    topicId: 'events',
    title: 'Vanish, Wait, Return, Report',
    glyph: '🌗',
    complexity: 5,
    target: 'React with a hide-wait-show-say sequence, all inside the edge check.',
    narrator: "My most theatrical reaction: disappear, pause for suspense, reappear, then explain myself.",
    steps: const [
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'hide', 'wait 1 seconds', 'show', then 'say', in that order.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      final hideIdx = edge.body.indexWhere((b) => b.defId == 'looks_hide');
      final waitIdx = edge.body.indexWhere((b) => b.defId == 'control_wait');
      final showIdx = edge.body.indexWhere((b) => b.defId == 'looks_show');
      final sayIdx = edge.body.indexWhere((b) => b.defId == 'looks_say');
      if (hideIdx == -1 || waitIdx == -1 || showIdx == -1 || sayIdx == -1) {
        return const LessonResult(false, "Add 'hide', 'wait', 'show', and 'say' inside the 'if on edge' block.");
      }
      if (!(hideIdx < waitIdx && waitIdx < showIdx && showIdx < sayIdx)) {
        return const LessonResult(false, "Order them: 'hide', then 'wait', then 'show', then 'say'.");
      }
      return const LessonResult(true, "A truly theatrical reaction sequence! 🌗");
    },
  ),
  Lesson(
    id: 833,
    topicId: 'events',
    title: 'Fair, Fast, Full, Patient',
    glyph: '⚙️',
    complexity: 5,
    target: 'Reset Score, move twice per loop, react fully, then rest.',
    narrator: "This is my most complete system: fair start, fast bursts of movement, full reaction, a rest.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block. Inside it, add a 'repeat 2 times' block containing 'move steps'.",
      "After the repeat (still in forever), add 'if on edge' with 'change Score by', 'play sound', and 'say' inside.",
      "After 'if on edge' (still in forever), add 'wait 1 seconds'.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      final repeat = forever.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the forever loop.");
      if (!_bodyHas(repeat.first, 'motion_move_steps')) return const LessonResult(false, "Put 'move steps' inside the repeat block.");
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!forever.body.any((b) => b.defId == 'control_wait')) {
        return const LessonResult(false, "Add a 'wait' block inside the forever loop, after 'if on edge'.");
      }
      return const LessonResult(true, "Fair, fast, full, and patient — a complete system! ⚙️");
    },
  ),
  Lesson(
    id: 834,
    topicId: 'events',
    title: 'Say, Beep-Beep, Spin',
    glyph: '🌪️',
    complexity: 5,
    target: 'React with say, then a double beep, then a recovery turn.',
    narrator: "Announce it, beep it twice for emphasis, then spin to get moving again.",
    steps: const [
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by' and 'say'.",
      "Then add a 'repeat 2 times' block containing 'play sound'.",
      "After 'if on edge' (still inside forever), add a 'turn' block.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      final repeat = edge.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the 'if on edge' block.");
      if (!_bodyHas(repeat.first, 'sound_play_click')) return const LessonResult(false, "Put 'play sound' inside the repeat block.");
      if (!forever.body.any((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left')) {
        return const LessonResult(false, "Add a 'turn' block inside the forever loop, after 'if on edge'.");
      }
      return const LessonResult(true, "Announce, beep-beep, then spin away! 🌪️");
    },
  ),
  Lesson(
    id: 835,
    topicId: 'events',
    title: 'Reaction, Rhythm, Rest',
    glyph: '🎶',
    complexity: 5,
    target: 'React with count and say, then a repeated beep-and-pause rhythm.',
    narrator: "This reaction has rhythm: count it, say it, then beep-and-pause, twice.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by' and 'say'.",
      "Then add a 'repeat 2 times' block containing 'play sound' and 'wait 1 seconds'.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      final repeat = edge.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the 'if on edge' block.");
      if (!_bodyHas(repeat.first, 'sound_play_click') || !_bodyHas(repeat.first, 'control_wait')) {
        return const LessonResult(false, "Put both 'play sound' and 'wait' inside the repeat block.");
      }
      return const LessonResult(true, "Reaction with real rhythm! 🎶");
    },
  ),
  Lesson(
    id: 836,
    topicId: 'events',
    title: 'Every Burst, Every Check',
    glyph: '🧨',
    complexity: 5,
    target: 'Move and check for the edge inside every repeat burst, deeply nested.',
    narrator: "This time the check lives INSIDE the movement burst — react after every single step, not just at the end.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat 2 times' block.",
      "Inside the repeat, add 'move steps', then 'if on edge' with 'change Score by' and 'say' inside.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      final repeat = forever.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the forever loop.");
      final r = repeat.first;
      if (!r.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the repeat block.");
      }
      final edge = _findBlock(r.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the repeat block too (not just the forever).");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block too.");
      return const LessonResult(true, "Checking on every single burst — deep nesting mastered! 🧨");
    },
  ),
  Lesson(
    id: 837,
    topicId: 'events',
    title: 'Count, Triple Beep, Speak',
    glyph: '🔊',
    complexity: 5,
    target: 'React by counting, beeping three times, then finally speaking.',
    narrator: "Save the words for last this time — count first, beep three times, THEN speak.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by'.",
      "Then add a 'repeat 3 times' block containing 'play sound', then add 'say' after the repeat.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      final changeIdx = edge.body.indexWhere((b) => b.defId == 'variables_change');
      final repeatIdx = edge.body.indexWhere((b) => b.defId == 'control_repeat');
      final sayIdx = edge.body.indexWhere((b) => b.defId == 'looks_say');
      if (changeIdx == -1 || repeatIdx == -1 || sayIdx == -1) {
        return const LessonResult(false, "Add 'change Score by', a 'repeat' block, and 'say' inside the 'if on edge' block.");
      }
      if (!(changeIdx < repeatIdx && repeatIdx < sayIdx)) {
        return const LessonResult(false, "Order them: 'change Score by', then 'repeat', then 'say'.");
      }
      if (!_bodyHas(edge.body[repeatIdx], 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the repeat block.");
      }
      return const LessonResult(true, "Count, triple-beep, then speak — dramatic order! 🔊");
    },
  ),
  Lesson(
    id: 838,
    topicId: 'events',
    title: 'React, Then Retreat Twice',
    glyph: '🛡️',
    complexity: 5,
    target: 'React fully, then nudge away from the edge twice in a row.',
    narrator: "One nudge might not be enough. Let's retreat twice after a full reaction.",
    steps: const [
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by', 'say', and 'play sound'.",
      "After 'if on edge' (still in forever), add a 'repeat 2 times' block containing 'change y by'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block to your script.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      final repeat = forever.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the forever loop, after 'if on edge'.");
      if (!(_bodyHas(repeat.first, 'motion_change_y') || _bodyHas(repeat.first, 'motion_change_x'))) {
        return const LessonResult(false, "Put a 'change x/y by' block inside the repeat block.");
      }
      return const LessonResult(true, "React fully, then retreat twice — safe and sound! 🛡️");
    },
  ),
  Lesson(
    id: 839,
    topicId: 'events',
    title: 'The Patterned Patrol',
    glyph: '🕹️',
    complexity: 5,
    target: 'Patrol in a move-and-turn pattern, reacting fully to every edge.',
    narrator: "A stylish, patterned patrol that still reacts with everything I've got, every single time.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block. Inside it, add a 'repeat 2 times' block containing 'move steps' and a 'turn' block.",
      "After the repeat (still in forever), add 'if on edge' with 'change Score by', 'say', and 'play sound' inside.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      final repeat = forever.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the forever loop.");
      if (!_bodyHas(repeat.first, 'motion_move_steps')) return const LessonResult(false, "Put 'move steps' inside the repeat block.");
      if (!(_bodyHas(repeat.first, 'motion_turn_left') || _bodyHas(repeat.first, 'motion_turn_right'))) {
        return const LessonResult(false, "Put a 'turn' block inside the repeat block too.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Add an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      return const LessonResult(true, "A patterned patrol with a full reaction — masterful! 🕹️");
    },
  ),
  Lesson(
    id: 840,
    topicId: 'events',
    title: 'Process, Fully Wired',
    glyph: '🏆',
    complexity: 5,
    target: 'Build the ultimate reaction system: reset, patrol, react with count+say+beep, then a hide-and-show flourish.',
    narrator: "This is it — everything I've learned about reacting to the edge, all wired together into one system.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add a 'forever' block with 'move steps' and 'if on edge' inside.",
      "Inside 'if on edge', add 'change Score by', 'say', and 'play sound'.",
      "Then add a 'repeat 2 times' block containing 'hide' and 'show'.",
    ],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0}), BlockInstance('control_forever')],
    check: (script) {
      if (script.isEmpty || script.first.defId != 'variables_set') {
        return const LessonResult(false, "Start your script with 'set Score to 0'.");
      }
      final forever = _findBlock(script, 'control_forever');
      if (forever == null) return const LessonResult(false, "Add a 'forever' block after the set block.");
      if (!forever.body.any((b) => b.defId == 'motion_move_steps')) {
        return const LessonResult(false, "Put a 'move steps' block inside the forever loop.");
      }
      final edge = _findBlock(forever.body, 'control_if_on_edge');
      if (edge == null) return const LessonResult(false, "Put an 'if on edge' block inside the forever loop too.");
      if (!_bodyHas(edge, 'variables_change')) return const LessonResult(false, "Add 'change Score by' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'looks_say')) return const LessonResult(false, "Add 'say' inside the 'if on edge' block.");
      if (!_bodyHas(edge, 'sound_play_click')) return const LessonResult(false, "Add 'play sound' inside the 'if on edge' block.");
      final repeat = edge.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeat.isEmpty) return const LessonResult(false, "Add a 'repeat' block inside the 'if on edge' block, for a flourish.");
      if (!_bodyHas(repeat.first, 'looks_hide') || !_bodyHas(repeat.first, 'looks_show')) {
        return const LessonResult(false, "Put both 'hide' and 'show' inside the repeat block.");
      }
      return const LessonResult(true, "Process, fully wired and ready to react to anything! 🏆");
    },
  ),
];
