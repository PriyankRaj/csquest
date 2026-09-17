import '../models/cq_models.dart';
import 'cq_blocks.dart';

/// "Build an Interactive Story" (Chatterbox Channel) — the CAPSTONE topic.
/// There is no real click/key input in this engine, so "interactive" here
/// means a story that unfolds through a *timed sequence* of say/wait/motion/
/// sound/variables beats, like a scripted conversation or stage play — not a
/// player-driven branching narrative. Lessons 1081-1140 grow from a single
/// say block up to a full multi-beat story combining every block family
/// learned in earlier topics.
///
/// Small local helpers (mirroring the style used by cq_movement_data.dart)
/// let checks inspect say-block text content and the order/pacing of a
/// script rather than just "does this block exist somewhere".

/// All say-block texts in a flattened script, in script order, trimmed.
List<String> _sayTexts(List<BlockInstance> flat) => flat
    .where((b) => b.defId == 'looks_say')
    .map((b) => ((b.inputs['text'] as String?) ?? '').trim())
    .toList();

bool _allNonEmpty(List<String> texts) => texts.isNotEmpty && texts.every((t) => t.isNotEmpty);

bool _allDistinct(List<String> texts) => texts.toSet().length == texts.length;

num _num(BlockInstance b, String key) => (b.inputs[key] as num?) ?? 0;

int _count(List<BlockInstance> flat, String defId) => flat.where((b) => b.defId == defId).length;

/// First direct child of [list] with defId [defId] (does not recurse) —
/// use to grab a specific container like control_repeat.
BlockInstance? _find(List<BlockInstance> list, String defId) {
  for (final b in list) {
    if (b.defId == defId) return b;
  }
  return null;
}

/// True if the defIds in [ids] all appear in [flat], in that relative
/// order (as a subsequence — later blocks may sit in between). This is
/// how these checks verify pacing, e.g. that a wait sits between two say
/// blocks, without demanding byte-for-byte adjacency.
bool _seq(List<BlockInstance> flat, List<String> ids) {
  var idx = -1;
  for (final id in ids) {
    final next = flat.indexWhere((b) => b.defId == id, idx + 1);
    if (next == -1) return false;
    idx = next;
  }
  return true;
}

const _turnIds = {'motion_turn_right', 'motion_turn_left'};

bool _isTurn(BlockInstance b) => _turnIds.contains(b.defId);

final cqComboTalkingLessons = <Lesson>[
  Lesson(
    id: 1081,
    topicId: 'combo-talking',
    title: 'Say Something!',
    glyph: '💬',
    complexity: 1,
    target: 'Make Process say a line out loud.',
    narrator: "Every great story starts with a single line. Let's give me something to say!",
    steps: const ["Open the Looks tray.", "Tap 'say' and add it to your script.", 'Type a line of dialogue, then tap Run.'],
    starter: () => [],
    check: (script) {
      final texts = _sayTexts(cqFlatten(script));
      if (texts.isEmpty) return const LessonResult(false, "Add a 'say' block from Looks.");
      if (texts.first.isEmpty) return const LessonResult(false, 'Type some words into the say block!');
      return const LessonResult(true, "I'm talking! This is the start of something big. 💬");
    },
  ),
  Lesson(
    id: 1082,
    topicId: 'combo-talking',
    title: 'Once Upon a Time',
    glyph: '📖',
    complexity: 1,
    target: "Open your story with the classic line, \"Once upon a time...\"",
    narrator: 'Every fairy tale needs its famous opening line. Let\'s start ours the same way.',
    steps: const ["Add a 'say' block.", "Type a line that starts with 'Once upon a time'."],
    starter: () => [],
    check: (script) {
      final texts = _sayTexts(cqFlatten(script));
      if (texts.isEmpty) return const LessonResult(false, "Add a 'say' block from Looks.");
      if (!texts.first.toLowerCase().contains('once upon a time')) {
        return const LessonResult(false, "Make your say block's text start with 'Once upon a time'.");
      }
      return const LessonResult(true, 'And so the story begins... 📖');
    },
  ),
  Lesson(
    id: 1083,
    topicId: 'combo-talking',
    title: 'Two-Line Scene',
    glyph: '🎬',
    complexity: 1,
    target: 'Give Process two different lines to say, one after another.',
    narrator: "A single line is a start, but stories need more than one sentence!",
    steps: const ["Keep the first 'say' block.", "Add a second 'say' block underneath with a *different* line."],
    starter: () => [BlockInstance('looks_say', inputs: {'text': 'It was a dark and stormy night.'})],
    check: (script) {
      final texts = _sayTexts(cqFlatten(script));
      if (texts.length < 2) return const LessonResult(false, 'Add a second say block after the first.');
      if (!_allNonEmpty(texts)) return const LessonResult(false, 'Every say block needs some text in it.');
      if (!_allDistinct(texts)) return const LessonResult(false, 'Make the second line different from the first.');
      return const LessonResult(true, 'Now we have a scene, not just a sentence! 🎬');
    },
  ),
  Lesson(
    id: 1084,
    topicId: 'combo-talking',
    title: 'A Beat of Silence',
    glyph: '⏳',
    complexity: 2,
    target: 'Say a line, pause a moment, then say the next line.',
    narrator: "Real conversations have pauses. Let's add a beat of silence between two lines.",
    steps: const [
      "Add a 'say' block.",
      "Add a 'wait 1 seconds' block (Control) after it.",
      "Add another 'say' block after the wait.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_say', 'control_wait', 'looks_say'])) {
        return const LessonResult(false, "Line up say, then wait, then say — in that order.");
      }
      final wait = flat.firstWhere((b) => b.defId == 'control_wait');
      if (_num(wait, 'seconds') <= 0) return const LessonResult(false, 'Set the wait to more than 0 seconds.');
      return const LessonResult(true, 'That pause made it feel real. ⏳');
    },
  ),
  Lesson(
    id: 1085,
    topicId: 'combo-talking',
    title: 'Walk and Talk',
    glyph: '🚶',
    complexity: 2,
    target: 'Make Process narrate while it moves.',
    narrator: "Let's narrate while I'm on the move — say a line about the journey, then walk.",
    steps: const ["Add a 'say' block describing where you're heading.", "Add a 'move steps' block (Motion) after it."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_say', 'motion_move_steps'])) {
        return const LessonResult(false, "Add a say block, then a move steps block after it.");
      }
      final move = flat.firstWhere((b) => b.defId == 'motion_move_steps');
      if (_num(move, 'steps') == 0) return const LessonResult(false, "Set the move block's steps to something other than 0.");
      return const LessonResult(true, 'A story that moves is a story that lives! 🚶');
    },
  ),
  Lesson(
    id: 1086,
    topicId: 'combo-talking',
    title: 'Enter the Character',
    glyph: '🎭',
    complexity: 1,
    target: 'Show Process on stage, then have it speak.',
    narrator: 'A good scene starts with the character appearing before they talk.',
    steps: const ["Add a 'show' block (Looks).", "Add a 'say' block after it with an introduction line."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_show', 'looks_say'])) {
        return const LessonResult(false, "Add 'show' first, then a say block after it.");
      }
      if (_sayTexts(flat).first.isEmpty) return const LessonResult(false, 'Type an introduction line into the say block.');
      return const LessonResult(true, 'Lights up, and there I am! 🎭');
    },
  ),
  Lesson(
    id: 1087,
    topicId: 'combo-talking',
    title: 'Sound Effect!',
    glyph: '🔊',
    complexity: 2,
    target: 'Say a line, play a sound effect, then say the next line.',
    narrator: 'Every good story has sound effects punctuating the drama.',
    steps: const ["Add a 'say' block.", "Add 'play sound' (Sound) after it.", "Add another 'say' block after that."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_say', 'sound_play_click', 'looks_say'])) {
        return const LessonResult(false, 'Line up say, play sound, then say again.');
      }
      return const LessonResult(true, 'That sound cue landed perfectly. 🔊');
    },
  ),
  Lesson(
    id: 1088,
    topicId: 'combo-talking',
    title: 'Three Lines Deep',
    glyph: '📜',
    complexity: 2,
    target: 'Write three different lines of dialogue in a row.',
    narrator: "Let's stretch the scene out — three lines, three different thoughts.",
    steps: const ["Add three 'say' blocks in a row.", 'Give each one a different line of text.'],
    starter: () => [],
    check: (script) {
      final texts = _sayTexts(cqFlatten(script));
      if (texts.length < 3) return const LessonResult(false, 'Add three say blocks in a row.');
      if (!_allNonEmpty(texts)) return const LessonResult(false, 'Every say block needs text.');
      if (!_allDistinct(texts)) return const LessonResult(false, 'Make all three lines different from each other.');
      return const LessonResult(true, 'A three-line scene, all in your own words! 📜');
    },
  ),
  Lesson(
    id: 1089,
    topicId: 'combo-talking',
    title: 'Three Beats',
    glyph: '⏱️',
    complexity: 2,
    target: 'Say three lines with a pause between each one.',
    narrator: "Let's give each line room to breathe with waits between them.",
    steps: const ["Add: say, wait, say, wait, say — in that order.", 'Make every wait at least 1 second.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_say'])) {
        return const LessonResult(false, 'Line up say, wait, say, wait, say — in that exact order.');
      }
      final waits = flat.where((b) => b.defId == 'control_wait');
      if (waits.any((w) => _num(w, 'seconds') < 1)) {
        return const LessonResult(false, 'Set every wait to at least 1 second.');
      }
      return const LessonResult(true, 'Perfectly paced! I can feel the rhythm. ⏱️');
    },
  ),
  Lesson(
    id: 1090,
    topicId: 'combo-talking',
    title: 'Face and Speak',
    glyph: '🧭',
    complexity: 2,
    target: 'Turn Process to face someone, walk toward them, then speak.',
    narrator: "Before I talk to a character, I should turn to face them and walk over.",
    steps: const ["Add a 'point in direction' block (Motion).", "Add a 'move steps' block.", "Add a 'say' block after that."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['motion_point_direction', 'motion_move_steps', 'looks_say'])) {
        return const LessonResult(false, 'Line up point in direction, then move steps, then say.');
      }
      return const LessonResult(true, "Faced them, walked over, and spoke. Smooth! 🧭");
    },
  ),
  Lesson(
    id: 1091,
    topicId: 'combo-talking',
    title: 'Story Points Begin',
    glyph: '⭐',
    complexity: 2,
    target: "Set the Score to 0 to start tracking story points, then announce the story's start.",
    narrator: "Let's track how the story unfolds — a Score of story points, starting at zero.",
    steps: const ["Add 'set Score to 0' (Variables).", "Add a 'say' block after it, announcing the story is starting."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['variables_set', 'looks_say'])) {
        return const LessonResult(false, "Add 'set Score to 0' first, then a say block after it.");
      }
      final set = flat.firstWhere((b) => b.defId == 'variables_set');
      if (_num(set, 'value') != 0) return const LessonResult(false, 'Set the Score to exactly 0 to start.');
      return const LessonResult(true, 'Story points: zero. Adventure: about to begin. ⭐');
    },
  ),
  Lesson(
    id: 1092,
    topicId: 'combo-talking',
    title: 'The Dramatic Pause',
    glyph: '🎪',
    complexity: 2,
    target: 'Say a setup line, then wait a long dramatic pause, then say the reveal.',
    narrator: 'The best reveals need a long, dramatic pause first.',
    steps: const ["Add 'say' with a setup line.", "Add 'wait 2 seconds' (Control).", "Add 'say' with the reveal line."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_say', 'control_wait', 'looks_say'])) {
        return const LessonResult(false, 'Line up say, wait, say — in that order.');
      }
      final wait = flat.firstWhere((b) => b.defId == 'control_wait');
      if (_num(wait, 'seconds') < 2) return const LessonResult(false, 'Make the wait at least 2 seconds for real drama.');
      final texts = _sayTexts(flat);
      if (texts[0] == texts[1]) return const LessonResult(false, 'The reveal line should be different from the setup line.');
      return const LessonResult(true, 'The crowd gasps! What a reveal. 🎪');
    },
  ),
  Lesson(
    id: 1093,
    topicId: 'combo-talking',
    title: 'Vanish and Return',
    glyph: '👻',
    complexity: 2,
    target: 'Hide Process, wait, then show it again with a line.',
    narrator: 'A character who vanishes and reappears always makes an entrance.',
    steps: const ["Add 'hide' (Looks).", "Add 'wait 1 seconds'.", "Add 'show', then a 'say' block."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_hide', 'control_wait', 'looks_show', 'looks_say'])) {
        return const LessonResult(false, 'Line up hide, wait, show, say — in that exact order.');
      }
      return const LessonResult(true, 'Poof — gone, then back with a flourish! 👻');
    },
  ),
  Lesson(
    id: 1094,
    topicId: 'combo-talking',
    title: 'Turn to the Crowd',
    glyph: '↩️',
    complexity: 2,
    target: 'Say a line, turn to face someone new, then say another line to them.',
    narrator: 'When a new character joins the scene, turn toward them before speaking.',
    steps: const ["Add 'say'.", "Add a 'turn' block (Motion), left or right.", "Add another 'say' block."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final firstSayIdx = flat.indexWhere((b) => b.defId == 'looks_say');
      if (firstSayIdx == -1) return const LessonResult(false, "Add a 'say' block first.");
      final turnIdx = flat.indexWhere(_isTurn, firstSayIdx + 1);
      if (turnIdx == -1) return const LessonResult(false, 'Add a turn block after the first say block.');
      final secondSayIdx = flat.indexWhere((b) => b.defId == 'looks_say', turnIdx + 1);
      if (secondSayIdx == -1) return const LessonResult(false, 'Add a second say block after the turn.');
      return const LessonResult(true, "Turned, and now I'm talking to someone new! ↩️");
    },
  ),
  Lesson(
    id: 1095,
    topicId: 'combo-talking',
    title: 'A Short Scene',
    glyph: '🎞️',
    complexity: 2,
    target: 'Write a four-line scene, with a wait between every pair of lines.',
    narrator: "Let's build a full short scene: four lines, each one paced with a wait.",
    steps: const ["Add: say, wait, say, wait, say, wait, say — in that order.", 'Give each say a different line.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, [
        'looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_say',
      ])) {
        return const LessonResult(false, 'Line up say/wait/say/wait/say/wait/say — four lines, three waits, in order.');
      }
      final texts = _sayTexts(flat);
      if (!_allDistinct(texts.take(4).toList())) return const LessonResult(false, 'Make each of the four lines different.');
      return const LessonResult(true, "A full scene, beat by beat. Well told! 🎞️");
    },
  ),
  Lesson(
    id: 1096,
    topicId: 'combo-talking',
    title: 'Three-Line Exchange',
    glyph: '🗣️',
    complexity: 2,
    target: 'Write a three-line back-and-forth with waits between each line.',
    narrator: "Let's make it feel like two people talking — three lines, evenly paced.",
    steps: const ['Line up say, wait, say, wait, say.', 'Make each line different.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_say'])) {
        return const LessonResult(false, 'Line up say, wait, say, wait, say — in that order.');
      }
      final texts = _sayTexts(flat);
      if (!_allDistinct(texts.take(3).toList())) return const LessonResult(false, 'Make each of the three lines different.');
      return const LessonResult(true, 'That felt like a real conversation! 🗣️');
    },
  ),
  Lesson(
    id: 1097,
    topicId: 'combo-talking',
    title: 'New Scene',
    glyph: '🌄',
    complexity: 2,
    target: 'Jump Process to a new spot, then announce the new scene.',
    narrator: "Let's jump to a whole new scene using go-to x,y — then tell me where we are.",
    steps: const ["Add 'go to x y' (Motion) and set new coordinates.", "Add a 'say' block after it describing the new scene."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['motion_goto_xy', 'looks_say'])) {
        return const LessonResult(false, 'Add a go-to-xy block, then a say block after it.');
      }
      return const LessonResult(true, 'New scene, new backdrop, new line. 🌄');
    },
  ),
  Lesson(
    id: 1098,
    topicId: 'combo-talking',
    title: 'First Story Point',
    glyph: '⭐',
    complexity: 3,
    target: 'Increase the Score by 1 story point, and announce it with a line.',
    narrator: "Every time something big happens in the story, let's earn a story point.",
    steps: const ["Add 'change Score by 1' (Variables).", "Add a 'say' block announcing the story point."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['variables_change', 'looks_say'])) {
        return const LessonResult(false, "Add 'change Score by 1', then a say block after it.");
      }
      final change = flat.firstWhere((b) => b.defId == 'variables_change');
      if (_num(change, 'value') <= 0) return const LessonResult(false, 'Change the Score by a positive amount.');
      return const LessonResult(true, 'Story point earned! The plot thickens. ⭐');
    },
  ),
  Lesson(
    id: 1099,
    topicId: 'combo-talking',
    title: 'Cue the Sound',
    glyph: '🔔',
    complexity: 2,
    target: 'Say a line, play a sound cue, pause, then say the next line.',
    narrator: "Sound cues punctuate a scene — let's use one before a pause and the next line.",
    steps: const ["Line up say, play sound, wait, say."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_say', 'sound_play_click', 'control_wait', 'looks_say'])) {
        return const LessonResult(false, 'Line up say, play sound, wait, say — in that order.');
      }
      return const LessonResult(true, "That cue landed right before the next line. 🔔");
    },
  ),
  Lesson(
    id: 1100,
    topicId: 'combo-talking',
    title: 'The Refrain',
    glyph: '🔁',
    complexity: 3,
    target: 'Use a repeat block to say the same refrain line twice, with a wait each time.',
    narrator: "Great stories repeat a phrase for effect — a refrain. Let's repeat one twice.",
    steps: const [
      "Add a 'repeat 2 times' block (Control).",
      "Inside it, add a 'say' block with your refrain line.",
      "Add a 'wait' block after the say, inside the repeat.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final repeat = _find(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block from Control.");
      if (_num(repeat, 'times') < 2) return const LessonResult(false, 'Set the repeat to at least 2 times.');
      final body = cqFlatten(repeat.body);
      if (!_seq(body, ['looks_say', 'control_wait'])) {
        return const LessonResult(false, 'Inside the repeat, add a say block then a wait block.');
      }
      return const LessonResult(true, "The refrain echoes through the story. 🔁");
    },
  ),
  Lesson(
    id: 1101,
    topicId: 'combo-talking',
    title: 'The Long Walk',
    glyph: '🚶‍♂️',
    complexity: 3,
    target: 'Narrate a journey with two legs: say, move, say, move, say.',
    narrator: "A long journey deserves narration at every leg of the trip.",
    steps: const ['Line up say, move, say, move, say — in that order.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_say', 'motion_move_steps', 'looks_say', 'motion_move_steps', 'looks_say'])) {
        return const LessonResult(false, 'Line up say, move, say, move, say — in that exact order.');
      }
      return const LessonResult(true, "Every step of the journey, told in words. 🚶‍♂️");
    },
  ),
  Lesson(
    id: 1102,
    topicId: 'combo-talking',
    title: 'Rising Stakes',
    glyph: '📈',
    complexity: 3,
    target: 'Set Score to 0, then increase it twice, announcing each with a line.',
    narrator: "Let's raise the stakes twice in a row, announcing each rise.",
    steps: const [
      "Add 'set Score to 0'.",
      "Add 'change Score by 1' then a 'say' block.",
      "Add another 'change Score by 1' then another 'say' block.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['variables_set', 'variables_change', 'looks_say', 'variables_change', 'looks_say'])) {
        return const LessonResult(false, 'Line up set Score to 0, then change+say, then change+say again.');
      }
      final set = flat.firstWhere((b) => b.defId == 'variables_set');
      if (_num(set, 'value') != 0) return const LessonResult(false, 'Start by setting the Score to 0.');
      return const LessonResult(true, "The stakes are climbing! 📈");
    },
  ),
  Lesson(
    id: 1103,
    topicId: 'combo-talking',
    title: 'The Four-Line Scene',
    glyph: '🎥',
    complexity: 3,
    target: 'Write four lines of dialogue with a wait between each.',
    narrator: "Let's write a full four-line scene, well-paced from start to finish.",
    steps: const ['Line up say, wait, say, wait, say, wait, say.', 'Make every line different.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, [
        'looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_say',
      ])) {
        return const LessonResult(false, 'Line up say/wait/say/wait/say/wait/say — in that order.');
      }
      final texts = _sayTexts(flat);
      if (!_allDistinct(texts.take(4).toList())) return const LessonResult(false, 'Make all four lines different.');
      return const LessonResult(true, "A complete scene, beautifully paced. 🎥");
    },
  ),
  Lesson(
    id: 1104,
    topicId: 'combo-talking',
    title: 'Two Characters Talk',
    glyph: '👥',
    complexity: 2,
    target: 'Turn Process one way to say a line, then turn the other way to reply.',
    narrator: "Let's play both sides of a conversation — turning to show who's speaking.",
    steps: const [
      "Add a 'turn right' block, then a 'say' block.",
      "Add a 'turn left' block, then a different 'say' block.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final rightIdx = flat.indexWhere((b) => b.defId == 'motion_turn_right');
      final leftIdx = flat.indexWhere((b) => b.defId == 'motion_turn_left');
      if (rightIdx == -1 || leftIdx == -1) {
        return const LessonResult(false, 'Use both a turn right and a turn left block, one per speaker.');
      }
      final texts = _sayTexts(flat);
      if (texts.length < 2 || !_allDistinct(texts)) {
        return const LessonResult(false, 'Give each character a different line after their turn.');
      }
      return const LessonResult(true, "Two voices, two turns — a real conversation! 👥");
    },
  ),
  Lesson(
    id: 1105,
    topicId: 'combo-talking',
    title: 'Exit and Return',
    glyph: '🚪',
    complexity: 3,
    target: 'Show, say, hide, wait, show, say — a character leaves the scene and comes back.',
    narrator: "Let's have our character leave the stage, then walk back in for one more line.",
    steps: const ['Line up show, say, hide, wait, show, say — in that order.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_show', 'looks_say', 'looks_hide', 'control_wait', 'looks_show', 'looks_say'])) {
        return const LessonResult(false, 'Line up show, say, hide, wait, show, say — in that exact order.');
      }
      return const LessonResult(true, "They're back! That exit made the return sweeter. 🚪");
    },
  ),
  Lesson(
    id: 1106,
    topicId: 'combo-talking',
    title: 'Chant It Three Times',
    glyph: '🔂',
    complexity: 3,
    target: 'Repeat a chant line three times using a repeat block.',
    narrator: "Some lines deserve a chant — repeated three times for effect.",
    steps: const ["Add a 'repeat 3 times' block.", "Inside it, add a 'say' block with your chant line."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeat = _find(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block from Control.");
      if (_num(repeat, 'times') < 3) return const LessonResult(false, 'Set the repeat to at least 3 times.');
      if (!cqHas(repeat.body, 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the repeat.");
      }
      return const LessonResult(true, "The chant echoes three times over! 🔂");
    },
  ),
  Lesson(
    id: 1107,
    topicId: 'combo-talking',
    title: 'Long Dramatic Pauses',
    glyph: '🕯️',
    complexity: 3,
    target: 'Say, wait 2+ seconds, say, wait 2+ seconds, say — three lines, long pauses.',
    narrator: "This scene needs breathing room — long pauses between every line.",
    steps: const ['Line up say, wait, say, wait, say.', 'Make both waits at least 2 seconds.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_say'])) {
        return const LessonResult(false, 'Line up say, wait, say, wait, say — in that order.');
      }
      final waits = flat.where((b) => b.defId == 'control_wait').toList();
      if (waits.length < 2 || waits.any((w) => _num(w, 'seconds') < 2)) {
        return const LessonResult(false, 'Make both waits at least 2 seconds for real drama.');
      }
      return const LessonResult(true, "The silence between the lines says so much. 🕯️");
    },
  ),
  Lesson(
    id: 1108,
    topicId: 'combo-talking',
    title: 'Double Sound Cue',
    glyph: '🔊',
    complexity: 2,
    target: 'Punctuate two lines with two separate sound cues.',
    narrator: "Let's punctuate two lines, each with its own sound cue right after.",
    steps: const ['Line up say, play sound, say, play sound — in that order.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['looks_say', 'sound_play_click', 'looks_say', 'sound_play_click'])) {
        return const LessonResult(false, 'Line up say, play sound, say, play sound — in that order.');
      }
      return const LessonResult(true, "Two lines, two cues — the crowd is hooked. 🔊");
    },
  ),
  Lesson(
    id: 1109,
    topicId: 'combo-talking',
    title: 'Score Climbs Twice',
    glyph: '📊',
    complexity: 3,
    target: 'Increase the Score and announce it, twice in a row.',
    narrator: "Let's watch the story points climb — twice in a row, each one announced.",
    steps: const ['Line up change Score, say, change Score, say — in that order.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['variables_change', 'looks_say', 'variables_change', 'looks_say'])) {
        return const LessonResult(false, 'Line up change Score, say, change Score, say — in that order.');
      }
      final changes = flat.where((b) => b.defId == 'variables_change');
      if (changes.any((c) => _num(c, 'value') <= 0)) {
        return const LessonResult(false, 'Make each change to the Score a positive amount.');
      }
      return const LessonResult(true, "The story points are really climbing now! 📊");
    },
  ),
  Lesson(
    id: 1110,
    topicId: 'combo-talking',
    title: 'Journey With Stops',
    glyph: '🗺️',
    complexity: 3,
    target: 'Move, say, wait, move, say — a journey with two narrated stops.',
    narrator: "Every good journey has stops along the way — let's narrate two of them.",
    steps: const ['Line up move, say, wait, move, say — in that order.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['motion_move_steps', 'looks_say', 'control_wait', 'motion_move_steps', 'looks_say'])) {
        return const LessonResult(false, 'Line up move, say, wait, move, say — in that exact order.');
      }
      return const LessonResult(true, "Two stops, two stories. The journey continues. 🗺️");
    },
  ),
  Lesson(
    id: 1111,
    topicId: 'combo-talking',
    title: 'Five-Line Scene',
    glyph: '🎦',
    complexity: 3,
    target: 'Write a five-line scene, each line separated by a wait.',
    narrator: "Let's go even further — five whole lines, each one paced with a wait.",
    steps: const ['Line up say, wait, five times in a row, ending on a say.', 'Make all five lines different.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final texts = _sayTexts(flat);
      final waits = _count(flat, 'control_wait');
      if (texts.length < 5) return const LessonResult(false, 'Add at least five say blocks.');
      if (waits < 4) return const LessonResult(false, 'Add waits between the lines — at least four of them.');
      if (!_allDistinct(texts.take(5).toList())) return const LessonResult(false, 'Make all five lines different.');
      if (!_seq(flat, [
        'looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_say',
      ])) {
        return const LessonResult(false, 'Alternate say and wait blocks in order.');
      }
      return const LessonResult(true, "Five lines, perfectly paced. A real scene! 🎦");
    },
  ),
  Lesson(
    id: 1112,
    topicId: 'combo-talking',
    title: 'Two Locations',
    glyph: '🏙️',
    complexity: 3,
    target: 'Tell a scene in two different locations using go-to-xy twice.',
    narrator: "Let's tell a story that hops between two different places.",
    steps: const ['Line up go-to-xy, say, wait, go-to-xy, say — in that order.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, ['motion_goto_xy', 'looks_say', 'control_wait', 'motion_goto_xy', 'looks_say'])) {
        return const LessonResult(false, 'Line up go-to-xy, say, wait, go-to-xy, say — in that order.');
      }
      return const LessonResult(true, "Two places, one story. Nicely told! 🏙️");
    },
  ),
  Lesson(
    id: 1113,
    topicId: 'combo-talking',
    title: 'Two-Line Refrain, Twice',
    glyph: '🔁',
    complexity: 3,
    target: 'Repeat a two-line refrain (say, wait, say) two times.',
    narrator: "This time our refrain has two lines, not one — repeated twice.",
    steps: const [
      "Add a 'repeat 2 times' block.",
      "Inside it, add: say, wait, say.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final repeat = _find(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block from Control.");
      if (_num(repeat, 'times') < 2) return const LessonResult(false, 'Set the repeat to at least 2 times.');
      final body = cqFlatten(repeat.body);
      if (_count(body, 'looks_say') < 2) return const LessonResult(false, 'Put two say blocks inside the repeat.');
      if (!cqHas(repeat.body, 'control_wait')) return const LessonResult(false, 'Put a wait block between the two say blocks.');
      return const LessonResult(true, "A two-line refrain, echoing twice over. 🔁");
    },
  ),
  Lesson(
    id: 1114,
    topicId: 'combo-talking',
    title: 'Counting Up',
    glyph: '🔢',
    complexity: 4,
    target: 'Set Score to 0, then use a repeat to count up three times, announcing each count.',
    narrator: "Let's count up together — a repeat block that raises the Score three times.",
    steps: const [
      "Keep 'set Score to 0' at the start.",
      "Inside the repeat, add 'change Score by 1' then a 'say' block.",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_repeat', inputs: {'times': 3}),
    ],
    check: (script) {
      final set = _find(script, 'variables_set');
      final repeat = _find(script, 'control_repeat');
      if (set == null || _num(set, 'value') != 0) {
        return const LessonResult(false, 'Keep set Score to 0 at the start.');
      }
      if (repeat == null || _num(repeat, 'times') < 3) {
        return const LessonResult(false, 'Set the repeat block to at least 3 times.');
      }
      final body = cqFlatten(repeat.body);
      if (!_seq(body, ['variables_change', 'looks_say'])) {
        return const LessonResult(false, "Inside the repeat, add 'change Score by 1' then a say block.");
      }
      return const LessonResult(true, "One, two, three — the Score climbs with every beat! 🔢");
    },
  ),
  Lesson(
    id: 1115,
    topicId: 'combo-talking',
    title: 'Two Sound Cues, Paced',
    glyph: '🎵',
    complexity: 3,
    target: 'Say, sound, wait, say, sound, wait, say — three lines each punctuated by sound and a pause.',
    narrator: "Let's punctuate a three-line scene with sound cues and pacing together.",
    steps: const ['Line up say, play sound, wait — twice — then a final say.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, [
        'looks_say', 'sound_play_click', 'control_wait', 'looks_say', 'sound_play_click', 'control_wait', 'looks_say',
      ])) {
        return const LessonResult(false, 'Line up say, sound, wait — twice — followed by one more say.');
      }
      return const LessonResult(true, "Sound and silence, working together. 🎵");
    },
  ),
  Lesson(
    id: 1116,
    topicId: 'combo-talking',
    title: 'Turn and Talk',
    glyph: '🔄',
    complexity: 3,
    target: 'Turn right, say, wait, turn left, say, wait, say — a conversation with turns and pacing.',
    narrator: "A back-and-forth conversation, with turns showing who's speaking and waits for pacing.",
    steps: const [
      "Add turn right, say, wait.",
      "Add turn left, say, wait.",
      "Add one final say.",
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final texts = _sayTexts(flat);
      if (texts.length < 3) return const LessonResult(false, 'Add at least three say blocks.');
      if (!flat.any((b) => b.defId == 'motion_turn_right') || !flat.any((b) => b.defId == 'motion_turn_left')) {
        return const LessonResult(false, 'Use both a turn right and a turn left block.');
      }
      if (_count(flat, 'control_wait') < 2) return const LessonResult(false, 'Add at least two wait blocks to pace the exchange.');
      return const LessonResult(true, "Back and forth, turn by turn. Great pacing! 🔄");
    },
  ),
  Lesson(
    id: 1117,
    topicId: 'combo-talking',
    title: 'Appear, Speak, Vanish',
    glyph: '🌫️',
    complexity: 3,
    target: 'Show, say, wait, say, wait, hide, say — the character leaves, but the story goes on.',
    narrator: "Sometimes the narrator keeps talking even after the character disappears.",
    steps: const ['Line up show, say, wait, say, wait, hide, say — in that order.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!_seq(flat, [
        'looks_show', 'looks_say', 'control_wait', 'looks_say', 'control_wait', 'looks_hide', 'looks_say',
      ])) {
        return const LessonResult(false, 'Line up show, say, wait, say, wait, hide, say — in that exact order.');
      }
      return const LessonResult(true, "Gone, but the story didn't end there. 🌫️");
    },
  ),
  Lesson(
    id: 1118,
    topicId: 'combo-talking',
    title: 'Four-Time Refrain',
    glyph: '🔁',
    complexity: 3,
    target: 'Use a repeat block to say a refrain line four times.',
    narrator: "Let's stretch our refrain even further — four times through.",
    steps: const ["Add a 'repeat 4 times' block.", "Inside it, add a 'say' block."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeat = _find(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block from Control.");
      if (_num(repeat, 'times') < 4) return const LessonResult(false, 'Set the repeat to at least 4 times.');
      if (!cqHas(repeat.body, 'looks_say')) return const LessonResult(false, "Put a 'say' block inside the repeat.");
      return const LessonResult(true, "Four times over — that refrain will stick! 🔁");
    },
  ),
  Lesson(
    id: 1119,
    topicId: 'combo-talking',
    title: 'Score Builds Three Times',
    glyph: '📶',
    complexity: 4,
    target: 'Increase the Score, say a line, and wait — three times in a row, hand-placed.',
    narrator: "Let's build suspense the old-fashioned way — three full beats, placed one by one.",
    steps: const ['Line up: change Score, say, wait — three times in a row.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final pattern = [
        'variables_change', 'looks_say', 'control_wait',
        'variables_change', 'looks_say', 'control_wait',
        'variables_change', 'looks_say', 'control_wait',
      ];
      if (!_seq(flat, pattern)) {
        return const LessonResult(false, 'Line up change Score, say, wait — repeated three times in a row.');
      }
      return const LessonResult(true, "Three beats, and the tension is unbearable! 📶");
    },
  ),
  Lesson(
    id: 1120,
    topicId: 'combo-talking',
    title: 'All the Pieces',
    glyph: '🧩',
    complexity: 4,
    target: 'Combine motion, wait, say, sound, and variables in one flowing sequence.',
    narrator: "It's time to bring everything together — motion, pauses, dialogue, sound, and story points, all in one scene.",
    steps: const [
      'Use at least one motion block (move, turn, or go-to).',
      'Use at least two say blocks and one wait.',
      'Use one sound block and one variables block (set or change).',
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      const motionIds = {
        'motion_move_steps', 'motion_turn_right', 'motion_turn_left', 'motion_point_direction',
        'motion_change_x', 'motion_change_y', 'motion_goto_xy', 'motion_if_on_edge_bounce',
      };
      if (!flat.any((b) => motionIds.contains(b.defId))) return const LessonResult(false, 'Add at least one motion block.');
      if (_sayTexts(flat).length < 2) return const LessonResult(false, 'Add at least two say blocks.');
      if (!flat.any((b) => b.defId == 'control_wait')) return const LessonResult(false, 'Add at least one wait block.');
      if (!flat.any((b) => b.defId == 'sound_play_click')) return const LessonResult(false, 'Add a sound block.');
      if (!flat.any((b) => b.defId == 'variables_set' || b.defId == 'variables_change')) {
        return const LessonResult(false, 'Add a variables block (set Score or change Score).');
      }
      return const LessonResult(true, "Every piece of the toolkit, working together! 🧩");
    },
  ),
  Lesson(
    id: 1121,
    topicId: 'combo-talking',
    title: 'Six-Line Scene',
    glyph: '🎭',
    complexity: 4,
    target: 'Write six lines of dialogue, each separated by a wait.',
    narrator: "Let's go big — six lines, each one carefully paced.",
    steps: const ['Alternate say and wait six times, ending on a say.', 'Make all six lines different.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final texts = _sayTexts(flat);
      if (texts.length < 6) return const LessonResult(false, 'Add at least six say blocks.');
      if (_count(flat, 'control_wait') < 5) return const LessonResult(false, 'Add at least five waits between the lines.');
      if (!_allDistinct(texts.take(6).toList())) return const LessonResult(false, 'Make all six lines different.');
      return const LessonResult(true, "Six lines of pure drama! 🎭");
    },
  ),
  Lesson(
    id: 1122,
    topicId: 'combo-talking',
    title: 'Two-Beat Refrain, Twice',
    glyph: '🔁',
    complexity: 4,
    target: 'Use a repeat to say a two-line, waited refrain twice over.',
    narrator: "Two lines, two waits, all inside a repeat that plays it back twice.",
    steps: const [
      "Add a 'repeat 2 times' block.",
      "Inside it, add: say, wait, say, wait.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final repeat = _find(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block from Control.");
      if (_num(repeat, 'times') < 2) return const LessonResult(false, 'Set the repeat to at least 2 times.');
      final body = cqFlatten(repeat.body);
      if (_count(body, 'looks_say') < 2) return const LessonResult(false, 'Put two say blocks inside the repeat.');
      if (_count(body, 'control_wait') < 2) return const LessonResult(false, 'Put two wait blocks inside the repeat.');
      return const LessonResult(true, "That refrain has real rhythm now. 🔁");
    },
  ),
  Lesson(
    id: 1123,
    topicId: 'combo-talking',
    title: 'Final Tally',
    glyph: '🏁',
    complexity: 4,
    target: 'Set Score to 0, repeat a story-point beat four times, then announce the final tally.',
    narrator: "Let's tally up the whole story — story points earned, then a final announcement.",
    steps: const [
      "Keep 'set Score to 0' at the start.",
      "Inside the repeat, add 'change Score by 1' then 'say'.",
      "After the repeat, add one final 'say' announcing the total.",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_repeat', inputs: {'times': 4}),
    ],
    check: (script) {
      final set = _find(script, 'variables_set');
      final repeat = _find(script, 'control_repeat');
      if (set == null || _num(set, 'value') != 0) return const LessonResult(false, 'Keep set Score to 0 at the start.');
      if (repeat == null || _num(repeat, 'times') < 4) return const LessonResult(false, 'Set the repeat to at least 4 times.');
      final body = cqFlatten(repeat.body);
      if (!_seq(body, ['variables_change', 'looks_say'])) {
        return const LessonResult(false, "Inside the repeat, add 'change Score' then 'say'.");
      }
      final afterRepeatIdx = script.indexOf(repeat);
      final hasFinalSay = script.skip(afterRepeatIdx + 1).any((b) => b.defId == 'looks_say');
      if (!hasFinalSay) return const LessonResult(false, "Add a final 'say' block after the repeat, announcing the total.");
      return const LessonResult(true, "And the final tally is in! 🏁");
    },
  ),
  Lesson(
    id: 1124,
    topicId: 'combo-talking',
    title: 'Three-Leg Journey',
    glyph: '🧳',
    complexity: 4,
    target: 'Narrate a three-part journey: move, say, wait — repeated three times.',
    narrator: "A three-leg journey, narrated at every stop along the way.",
    steps: const ['Line up move, say, wait — three times in a row.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      const pattern = [
        'motion_move_steps', 'looks_say', 'control_wait',
        'motion_move_steps', 'looks_say', 'control_wait',
        'motion_move_steps', 'looks_say',
      ];
      if (!_seq(flat, pattern)) {
        return const LessonResult(false, 'Line up move, say, wait — three times, ending on a final say.');
      }
      return const LessonResult(true, "Three legs, three stories. What a trip! 🧳");
    },
  ),
  Lesson(
    id: 1125,
    topicId: 'combo-talking',
    title: 'Grand Entrance',
    glyph: '✨',
    complexity: 4,
    target: 'Show, say, wait, sound, say, wait, hide, say — a full entrance-to-exit scene.',
    narrator: "Let's give this scene a grand entrance and an equally grand exit.",
    steps: const ['Line up show, say, wait, sound, say, wait, hide, say — in that order.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      const pattern = [
        'looks_show', 'looks_say', 'control_wait', 'sound_play_click', 'looks_say', 'control_wait', 'looks_hide', 'looks_say',
      ];
      if (!_seq(flat, pattern)) {
        return const LessonResult(false, 'Line up show, say, wait, sound, say, wait, hide, say — in that exact order.');
      }
      return const LessonResult(true, "What an entrance. What an exit. ✨");
    },
  ),
  Lesson(
    id: 1126,
    topicId: 'combo-talking',
    title: 'Three Scenes',
    glyph: '🗺️',
    complexity: 4,
    target: 'Tell a story across three different scenes: go-to-xy, say, wait — three times.',
    narrator: "Let's hop across three whole scenes, narrating each one.",
    steps: const ['Line up go-to-xy, say, wait — three times in a row.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      const pattern = [
        'motion_goto_xy', 'looks_say', 'control_wait',
        'motion_goto_xy', 'looks_say', 'control_wait',
        'motion_goto_xy', 'looks_say', 'control_wait',
      ];
      if (!_seq(flat, pattern)) {
        return const LessonResult(false, 'Line up go-to-xy, say, wait — three times in a row.');
      }
      return const LessonResult(true, "Three scenes, one unforgettable story. 🗺️");
    },
  ),
  Lesson(
    id: 1127,
    topicId: 'combo-talking',
    title: 'Refrain Then Reward',
    glyph: '🏅',
    complexity: 4,
    target: 'Repeat a say-and-wait refrain three times, then reward it with a story point.',
    narrator: "After the refrain plays out, the story earns a point for the effort.",
    steps: const [
      "Add a 'repeat 3 times' block with say and wait inside.",
      "After the repeat, add 'change Score by 1' then 'say'.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeat = _find(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block from Control.");
      if (_num(repeat, 'times') < 3) return const LessonResult(false, 'Set the repeat to at least 3 times.');
      final body = cqFlatten(repeat.body);
      if (!cqHas(body, 'looks_say') || !cqHas(body, 'control_wait')) {
        return const LessonResult(false, 'Inside the repeat, add both a say block and a wait block.');
      }
      final afterIdx = script.indexOf(repeat);
      final after = cqFlatten(script.sublist(afterIdx + 1));
      if (!_seq(after, ['variables_change', 'looks_say'])) {
        return const LessonResult(false, "After the repeat, add 'change Score by 1' then a say block.");
      }
      return const LessonResult(true, "Refrain complete — story point earned! 🏅");
    },
  ),
  Lesson(
    id: 1128,
    topicId: 'combo-talking',
    title: 'Seven-Line Saga',
    glyph: '📚',
    complexity: 5,
    target: 'Write a seven-line scene, each line separated by a wait.',
    narrator: "This is a saga now — seven lines, each one earning its place.",
    steps: const ['Alternate say and wait seven times, ending on a say.', 'Make all seven lines different.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final texts = _sayTexts(flat);
      if (texts.length < 7) return const LessonResult(false, 'Add at least seven say blocks.');
      if (_count(flat, 'control_wait') < 6) return const LessonResult(false, 'Add at least six waits between the lines.');
      if (!_allDistinct(texts.take(7).toList())) return const LessonResult(false, 'Make all seven lines different.');
      return const LessonResult(true, "A saga worthy of the name! 📚");
    },
  ),
  Lesson(
    id: 1129,
    topicId: 'combo-talking',
    title: 'Counting to the Climax',
    glyph: '🎯',
    complexity: 5,
    target: 'Set Score to 0, say an intro, then repeat a change/say/wait beat three times before a climax line.',
    narrator: "Let's count our way to the climax — three rising beats, then the big moment.",
    steps: const [
      "Keep 'set Score to 0', then a say block, at the start.",
      "Inside the repeat, add: change Score by 1, say, wait.",
      "After the repeat, add a final 'say' for the climax.",
    ],
    starter: () => [
      BlockInstance('variables_set', inputs: {'value': 0}),
      BlockInstance('control_repeat', inputs: {'times': 3}),
    ],
    check: (script) {
      final flat = cqFlatten(script);
      final set = _find(script, 'variables_set');
      final repeat = _find(script, 'control_repeat');
      if (set == null || _num(set, 'value') != 0) return const LessonResult(false, 'Keep set Score to 0 at the start.');
      if (!cqHas(script, 'looks_say')) return const LessonResult(false, "Add an intro 'say' block near the start.");
      if (repeat == null || _num(repeat, 'times') < 3) return const LessonResult(false, 'Set the repeat to at least 3 times.');
      final body = cqFlatten(repeat.body);
      if (!_seq(body, ['variables_change', 'looks_say', 'control_wait'])) {
        return const LessonResult(false, "Inside the repeat: change Score, say, then wait — in that order.");
      }
      final afterIdx = script.indexOf(repeat);
      final after = cqFlatten(script.sublist(afterIdx + 1));
      if (!after.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a final 'say' block after the repeat for the climax.");
      }
      // sanity check across whole flattened script too
      if (_sayTexts(flat).length < 3) return const LessonResult(false, 'Use more say blocks to tell the full climb.');
      return const LessonResult(true, "The count builds, and the climax lands! 🎯");
    },
  ),
  Lesson(
    id: 1130,
    topicId: 'combo-talking',
    title: 'Cross and Confront',
    glyph: '⚔️',
    complexity: 5,
    target: 'Choreograph a confrontation: turn, say, move, wait — twice, then a final say.',
    narrator: "Two characters cross the stage and confront each other. Choreograph the whole scene.",
    steps: const [
      'Line up turn, say, move, wait — twice, using different turns each time.',
      'Finish with one more say.',
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'motion_turn_right') || !flat.any((b) => b.defId == 'motion_turn_left')) {
        return const LessonResult(false, 'Use both a turn right and a turn left block.');
      }
      if (_count(flat, 'motion_move_steps') < 2) return const LessonResult(false, 'Use at least two move blocks.');
      if (_sayTexts(flat).length < 3) return const LessonResult(false, 'Use at least three say blocks.');
      if (_count(flat, 'control_wait') < 2) return const LessonResult(false, 'Use at least two wait blocks to pace the scene.');
      final firstTurnIdx = flat.indexWhere(_isTurn);
      final firstSayAfterTurn = flat.indexWhere((b) => b.defId == 'looks_say', firstTurnIdx + 1);
      if (firstTurnIdx == -1 || firstSayAfterTurn == -1) {
        return const LessonResult(false, 'Make sure a turn happens before the character speaks.');
      }
      return const LessonResult(true, "The confrontation plays out perfectly! ⚔️");
    },
  ),
  Lesson(
    id: 1131,
    topicId: 'combo-talking',
    title: 'Triple Sound Cue',
    glyph: '🎶',
    complexity: 4,
    target: 'Punctuate a triple-beat scene: sound, say, wait — repeated three times.',
    narrator: "A triple-beat scene, each beat announced by a sound cue.",
    steps: const ['Line up sound, say, wait — three times in a row.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      const pattern = [
        'sound_play_click', 'looks_say', 'control_wait',
        'sound_play_click', 'looks_say', 'control_wait',
        'sound_play_click', 'looks_say',
      ];
      if (!_seq(flat, pattern)) {
        return const LessonResult(false, 'Line up sound, say, wait — three times, ending on a final say.');
      }
      return const LessonResult(true, "Three cues, three beats, one unforgettable scene. 🎶");
    },
  ),
  Lesson(
    id: 1132,
    topicId: 'combo-talking',
    title: 'Journey Refrain',
    glyph: '🧭',
    complexity: 5,
    target: 'Repeat a move/say/wait journey beat twice, then close with one final say.',
    narrator: "Let's repeat the journey's rhythm twice, then land on a closing line.",
    steps: const [
      "Add a 'repeat 2 times' block with move, say, wait inside.",
      "After the repeat, add one final 'say'.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final repeat = _find(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block from Control.");
      if (_num(repeat, 'times') < 2) return const LessonResult(false, 'Set the repeat to at least 2 times.');
      final body = cqFlatten(repeat.body);
      if (!_seq(body, ['motion_move_steps', 'looks_say', 'control_wait'])) {
        return const LessonResult(false, 'Inside the repeat: move, say, then wait — in that order.');
      }
      final afterIdx = script.indexOf(repeat);
      final after = cqFlatten(script.sublist(afterIdx + 1));
      if (!after.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a final 'say' block after the repeat.");
      }
      return const LessonResult(true, "The journey's rhythm, and a perfect closing line. 🧭");
    },
  ),
  Lesson(
    id: 1133,
    topicId: 'combo-talking',
    title: 'The Return',
    glyph: '🔙',
    complexity: 4,
    target: 'Show, say, wait, say, wait, hide, wait, show, say — a true departure and return.',
    narrator: "This time the character truly leaves, and truly returns, with a brand-new line.",
    steps: const ['Line up show, say, wait, say, wait, hide, wait, show, say — in that order.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      const pattern = [
        'looks_show', 'looks_say', 'control_wait', 'looks_say', 'control_wait',
        'looks_hide', 'control_wait', 'looks_show', 'looks_say',
      ];
      if (!_seq(flat, pattern)) {
        return const LessonResult(false, 'Line up show, say, wait, say, wait, hide, wait, show, say — in that exact order.');
      }
      return const LessonResult(true, "They left, and they're truly back. 🔙");
    },
  ),
  Lesson(
    id: 1134,
    topicId: 'combo-talking',
    title: 'Four Rising Beats',
    glyph: '📶',
    complexity: 5,
    target: 'Increase the Score, say a line, and wait — four times in a row, hand-placed.',
    narrator: "The tension rises in four full steps — no shortcuts this time.",
    steps: const ['Line up: change Score, say, wait — four times in a row.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final pattern = <String>[];
      for (var i = 0; i < 4; i++) {
        pattern.addAll(['variables_change', 'looks_say', 'control_wait']);
      }
      if (!_seq(flat, pattern)) {
        return const LessonResult(false, 'Line up change Score, say, wait — repeated four times in a row.');
      }
      return const LessonResult(true, "Four beats. The tension is at its peak! 📶");
    },
  ),
  Lesson(
    id: 1135,
    topicId: 'combo-talking',
    title: 'Scene, Sound, Scene',
    glyph: '🎬',
    complexity: 5,
    target: 'Two scene changes, each punctuated with sound, plus a closing line.',
    narrator: "Two scene changes, each with its own sound cue, then one closing line to tie it all together.",
    steps: const ['Line up go-to-xy, say, wait, sound, go-to-xy, say, wait, sound, say — in that order.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      const pattern = [
        'motion_goto_xy', 'looks_say', 'control_wait', 'sound_play_click',
        'motion_goto_xy', 'looks_say', 'control_wait', 'sound_play_click', 'looks_say',
      ];
      if (!_seq(flat, pattern)) {
        return const LessonResult(false, 'Line up go-to-xy, say, wait, sound — twice — then a final say.');
      }
      return const LessonResult(true, "Two scenes, two cues, one closing line. 🎬");
    },
  ),
  Lesson(
    id: 1136,
    topicId: 'combo-talking',
    title: 'Marching Refrain',
    glyph: '🥁',
    complexity: 5,
    target: 'Repeat a say/wait/move marching beat three times, then reward it with a story point.',
    narrator: "The story marches forward in a repeated beat, then earns a point for the effort.",
    steps: const [
      "Add a 'repeat 3 times' block with say, wait, move inside.",
      "After the repeat, add 'change Score by 1' then 'say'.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeat = _find(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block from Control.");
      if (_num(repeat, 'times') < 3) return const LessonResult(false, 'Set the repeat to at least 3 times.');
      final body = cqFlatten(repeat.body);
      if (!cqHas(body, 'looks_say') || !cqHas(body, 'control_wait') || !cqHas(body, 'motion_move_steps')) {
        return const LessonResult(false, 'Inside the repeat, use say, wait, and move together.');
      }
      final afterIdx = script.indexOf(repeat);
      final after = cqFlatten(script.sublist(afterIdx + 1));
      if (!_seq(after, ['variables_change', 'looks_say'])) {
        return const LessonResult(false, "After the repeat, add 'change Score by 1' then a say block.");
      }
      return const LessonResult(true, "The march is complete — story point earned! 🥁");
    },
  ),
  Lesson(
    id: 1137,
    topicId: 'combo-talking',
    title: 'Eight-Line Epic',
    glyph: '📖',
    complexity: 5,
    target: 'Write an eight-line scene, each line separated by a wait — the longest yet.',
    narrator: "This is the longest scene yet — a full eight-line epic.",
    steps: const ['Alternate say and wait eight times, ending on a say.', 'Make all eight lines different.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final texts = _sayTexts(flat);
      if (texts.length < 8) return const LessonResult(false, 'Add at least eight say blocks.');
      if (_count(flat, 'control_wait') < 7) return const LessonResult(false, 'Add at least seven waits between the lines.');
      if (!_allDistinct(texts.take(8).toList())) return const LessonResult(false, 'Make all eight lines different.');
      return const LessonResult(true, "An eight-line epic. What a story! 📖");
    },
  ),
  Lesson(
    id: 1138,
    topicId: 'combo-talking',
    title: 'Dress Rehearsal',
    glyph: '🎟️',
    complexity: 5,
    target:
        'Combine set Score, motion, say, wait, sound, say, wait, motion, say, and change Score into one flowing rehearsal.',
    narrator: "One last rehearsal before the finale — every tool, in one flowing sequence.",
    steps: const [
      'Start with set Score to 0.',
      'Line up: motion, say, wait, sound, say, wait, motion, say.',
      'Finish with change Score by 1, then a final say.',
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      const pattern = [
        'variables_set',
        'motion_move_steps', 'looks_say', 'control_wait',
        'sound_play_click', 'looks_say', 'control_wait',
        'motion_move_steps', 'looks_say',
        'variables_change', 'looks_say',
      ];
      if (!_seq(flat, pattern)) {
        return const LessonResult(
          false,
          'Line up: set Score, move, say, wait, sound, say, wait, move, say, change Score, say — in that order.',
        );
      }
      final set = flat.firstWhere((b) => b.defId == 'variables_set');
      if (_num(set, 'value') != 0) return const LessonResult(false, 'Start by setting the Score to 0.');
      if (_sayTexts(flat).length < 4) return const LessonResult(false, 'Use at least four say blocks total.');
      return const LessonResult(true, "That rehearsal was flawless. Ready for the finale! 🎟️");
    },
  ),
  Lesson(
    id: 1139,
    topicId: 'combo-talking',
    title: 'Almost There',
    glyph: '🌠',
    complexity: 5,
    target: 'Repeat a say/wait/move beat twice, then close with change Score, say, wait, say.',
    narrator: "We're almost at the finale — one more repeated beat, then a closing rise in the story points.",
    steps: const [
      "Add a 'repeat 2 times' block with say, wait, move, wait inside.",
      "After the repeat, add: change Score by 1, say, wait, say.",
    ],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final repeat = _find(script, 'control_repeat');
      if (repeat == null) return const LessonResult(false, "Add a 'repeat' block from Control.");
      if (_num(repeat, 'times') < 2) return const LessonResult(false, 'Set the repeat to at least 2 times.');
      final body = cqFlatten(repeat.body);
      if (!cqHas(body, 'looks_say') || !cqHas(body, 'control_wait') || !cqHas(body, 'motion_move_steps')) {
        return const LessonResult(false, 'Inside the repeat, use say, wait, and move together.');
      }
      final afterIdx = script.indexOf(repeat);
      final after = cqFlatten(script.sublist(afterIdx + 1));
      if (!_seq(after, ['variables_change', 'looks_say', 'control_wait', 'looks_say'])) {
        return const LessonResult(false, 'After the repeat: change Score, say, wait, say — in that order.');
      }
      return const LessonResult(true, "So close to the finale — this scene sings! 🌠");
    },
  ),
  Lesson(
    id: 1140,
    topicId: 'combo-talking',
    title: 'Tell Your Whole Story',
    glyph: '🏆',
    complexity: 5,
    target:
        'The CAPSTONE: combine motion, waits, at least six say blocks, sound, a Score (set and change), '
        'and a repeat block into one complete story from start to finish.',
    narrator:
        "This is it — the whole toolkit, one story. Motion for movement, waits for pacing, say for every line, "
        "sound for punctuation, story points for stakes, and a repeat for a refrain. Tell it all.",
    steps: const [
      'Set the Score to 0 near the start.',
      'Use at least six say blocks and three waits to tell the story.',
      'Use at least one motion block and one sound block.',
      'Use a repeat block somewhere, and change the Score by the end.',
    ],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      const motionIds = {
        'motion_move_steps', 'motion_turn_right', 'motion_turn_left', 'motion_point_direction',
        'motion_change_x', 'motion_change_y', 'motion_goto_xy', 'motion_if_on_edge_bounce',
      };
      final texts = _sayTexts(flat);
      if (!flat.any((b) => b.defId == 'variables_set')) {
        return const LessonResult(false, 'Set the Score to 0 near the start of your story.');
      }
      if (texts.length < 6) return const LessonResult(false, 'Use at least six say blocks to tell your whole story.');
      if (!_allNonEmpty(texts)) return const LessonResult(false, 'Every say block needs real text in it.');
      if (_count(flat, 'control_wait') < 3) return const LessonResult(false, 'Use at least three wait blocks to pace the story.');
      if (!flat.any((b) => motionIds.contains(b.defId))) return const LessonResult(false, 'Use at least one motion block.');
      if (!flat.any((b) => b.defId == 'sound_play_click')) return const LessonResult(false, 'Use at least one sound block.');
      final repeat = _find(script, 'control_repeat');
      if (repeat == null || cqFlatten(repeat.body).isEmpty) {
        return const LessonResult(false, 'Use a repeat block with something inside it — a refrain for your story.');
      }
      if (!flat.any((b) => b.defId == 'variables_change')) {
        return const LessonResult(false, 'Change the Score somewhere to mark a story point.');
      }
      return const LessonResult(
        true,
        "You told a whole story — motion, sound, pacing, stakes, and every line of dialogue. Chatterbox Channel, signing off. 🏆",
      );
    },
  ),
];
