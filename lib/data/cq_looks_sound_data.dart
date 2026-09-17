import '../models/cq_models.dart';
import 'cq_blocks.dart';

/// "Animate & Add Sound" (Costume Carnival) — topic id 'looks-sound'.
///
/// IMPORTANT: this engine has no costume/sprite-switching system — Process
/// is always the same turtle emoji. "Animation" here means timed sequences
/// of say/show/hide/wait/motion (blink = hide+wait+show, a wave-and-greet =
/// say+move+say, a walk-cycle feel = repeat(move+wait)), never a costume
/// swap. "Sound" means sound_play_click only, a real native click/beep used
/// for emphasis or feedback.
///
/// Lessons 721-780, growing in complexity from single looks/sound blocks up
/// through nested forever/repeat loops combined with motion and the Score
/// variable.

int _idx(List<BlockInstance> flat, String defId) =>
    flat.indexWhere((b) => b.defId == defId);

int _lastIdx(List<BlockInstance> flat, String defId) {
  for (var i = flat.length - 1; i >= 0; i--) {
    if (flat[i].defId == defId) return i;
  }
  return -1;
}

int _count(List<BlockInstance> flat, String defId) =>
    flat.where((b) => b.defId == defId).length;

String _text(BlockInstance b) => (b.inputs['text'] ?? '').toString();

final cqLooksSoundLessons = <Lesson>[
  // ---------------------------------------------------------------------
  // Complexity 1 (721-735): single looks/sound blocks, simple two-step
  // ordering.
  // ---------------------------------------------------------------------
  Lesson(
    id: 721,
    topicId: 'looks-sound',
    title: 'Say Hello',
    glyph: '💬',
    complexity: 1,
    target: 'Make Process say something out loud.',
    narrator: "I've got a lot to say — let's give me a voice!",
    steps: const ["Open the Looks tray.", "Tap 'say' to add it to your script.", 'Tap Run and read my message.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final say = flat.where((b) => b.defId == 'looks_say').toList();
      if (say.isEmpty) return const LessonResult(false, "Add a 'say' block from Looks.");
      if (_text(say.first).trim().isEmpty) {
        return const LessonResult(false, 'Give the say block some actual words to say!');
      }
      return const LessonResult(true, "There we go — I'm talking now! 💬");
    },
  ),
  Lesson(
    id: 722,
    topicId: 'looks-sound',
    title: 'Vanish Act',
    glyph: '👻',
    complexity: 1,
    target: 'Make Process disappear.',
    narrator: 'Watch this — now you see me...',
    steps: const ["Add a 'hide' block from Looks.", 'Tap Run and watch me vanish.'],
    starter: () => [],
    check: (script) {
      if (!cqHas(script, 'looks_hide')) {
        return const LessonResult(false, "Add a 'hide' block.");
      }
      return const LessonResult(true, 'Poof! Gone. 👻');
    },
  ),
  Lesson(
    id: 723,
    topicId: 'looks-sound',
    title: 'Reappear',
    glyph: '✨',
    complexity: 1,
    target: 'Make Process hide, then come back with show.',
    narrator: '...now you don\'t! But I always come back.',
    steps: const ["Keep the 'hide' block.", "Add a 'show' block after it."],
    starter: () => [BlockInstance('looks_hide')],
    check: (script) {
      final flat = cqFlatten(script);
      final h = _idx(flat, 'looks_hide');
      final s = _idx(flat, 'looks_show');
      if (h == -1) return const LessonResult(false, "Keep a 'hide' block in your script.");
      if (s == -1) return const LessonResult(false, "Add a 'show' block after hide.");
      if (s < h) return const LessonResult(false, "'show' should come after 'hide', not before.");
      return const LessonResult(true, "Ta-da — back and better than ever! ✨");
    },
  ),
  Lesson(
    id: 724,
    topicId: 'looks-sound',
    title: 'Click Clack',
    glyph: '🔊',
    complexity: 1,
    target: 'Make Process play a sound.',
    narrator: "I've got wheels AND a voice AND sound effects. Let's hear one!",
    steps: const ["Open the Sound tray.", "Add 'play sound' to your script.", 'Tap Run and listen.'],
    starter: () => [],
    check: (script) {
      if (!cqHas(script, 'sound_play_click')) {
        return const LessonResult(false, "Add a 'play sound' block from Sound.");
      }
      return const LessonResult(true, 'Click! Did you hear that? 🔊');
    },
  ),
  Lesson(
    id: 725,
    topicId: 'looks-sound',
    title: 'Say & Sound',
    glyph: '📣',
    complexity: 1,
    target: 'Say something, then play a sound to punctuate it.',
    narrator: 'Words are good, but words PLUS a sound effect? Even better.',
    steps: const ["Add a 'say' block.", "Add 'play sound' right after it."],
    starter: () => [BlockInstance('looks_say', inputs: {'text': 'Ta-da!'})],
    check: (script) {
      final flat = cqFlatten(script);
      final say = _idx(flat, 'looks_say');
      final snd = _idx(flat, 'sound_play_click');
      if (say == -1) return const LessonResult(false, "Keep the 'say' block.");
      if (snd == -1) return const LessonResult(false, "Add a 'play sound' block after say.");
      if (snd < say) return const LessonResult(false, 'Play the sound AFTER you say something, for emphasis.');
      return const LessonResult(true, 'Say it loud, then seal it with a click! 📣');
    },
  ),
  Lesson(
    id: 726,
    topicId: 'looks-sound',
    title: 'Peek-a-boo',
    glyph: '🙈',
    complexity: 1,
    target: 'Hide, then show — a tiny peek-a-boo moment.',
    narrator: 'Peek-a-boo works best when the order is right!',
    steps: const ["Add 'hide' from Looks.", "Add 'show' from Looks, after hide."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final h = _idx(flat, 'looks_hide');
      final s = _idx(flat, 'looks_show');
      if (h == -1 || s == -1) return const LessonResult(false, 'Use both hide and show.');
      if (s < h) return const LessonResult(false, 'Hide first, then show — that\'s peek-a-boo!');
      return const LessonResult(true, 'Peek-a-boo! Found me. 🙈');
    },
  ),
  Lesson(
    id: 727,
    topicId: 'looks-sound',
    title: 'Announce Yourself',
    glyph: '📢',
    complexity: 1,
    target: 'Change the say block\'s text to your own message.',
    narrator: "Don't just leave the default text — tell me what YOU want me to say!",
    steps: const ["Tap the 'say' block's text and change it.", 'Make it something other than the default.'],
    starter: () => [BlockInstance('looks_say', inputs: {'text': 'Hello!'})],
    check: (script) {
      final flat = cqFlatten(script);
      final say = flat.where((b) => b.defId == 'looks_say').toList();
      if (say.isEmpty) return const LessonResult(false, "Keep a 'say' block in your script.");
      if (_text(say.first).trim().isEmpty || _text(say.first) == 'Hello!') {
        return const LessonResult(false, "Change the text to something other than the default 'Hello!'.");
      }
      return const LessonResult(true, 'Now that sounds like YOU! 📢');
    },
  ),
  Lesson(
    id: 728,
    topicId: 'looks-sound',
    title: 'Silent Treatment',
    glyph: '🤐',
    complexity: 1,
    target: 'Hide Process, then have it say something anyway.',
    narrator: "Even when you can't see me, I've still got things to say!",
    steps: const ["Add 'hide' from Looks.", "Add 'say' from Looks, after hide."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      if (!flat.any((b) => b.defId == 'looks_hide')) {
        return const LessonResult(false, "Add a 'hide' block.");
      }
      if (!flat.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Add a 'say' block after hide.");
      }
      return const LessonResult(true, "A voice from the void! 🤐");
    },
  ),
  Lesson(
    id: 729,
    topicId: 'looks-sound',
    title: 'Sound Off',
    glyph: '🔔',
    complexity: 1,
    target: 'Play two sounds, one after another.',
    narrator: 'One click is fun. Two clicks is a rhythm!',
    steps: const ["Add 'play sound' twice from Sound."],
    starter: () => [BlockInstance('sound_play_click')],
    check: (script) {
      final flat = cqFlatten(script);
      if (_count(flat, 'sound_play_click') < 2) {
        return const LessonResult(false, "Add a second 'play sound' block.");
      }
      return const LessonResult(true, 'Click-click! A little rhythm. 🔔');
    },
  ),
  Lesson(
    id: 730,
    topicId: 'looks-sound',
    title: 'Two Things to Say',
    glyph: '🗨️',
    complexity: 1,
    target: 'Say two different things, one after another.',
    narrator: "I've got more than one sentence in me, you know.",
    steps: const ["Add a 'say' block with one message.", 'Add another say block with a different message.'],
    starter: () => [BlockInstance('looks_say', inputs: {'text': 'Hi there!'})],
    check: (script) {
      final flat = cqFlatten(script);
      final says = flat.where((b) => b.defId == 'looks_say').toList();
      if (says.length < 2) return const LessonResult(false, "Add a second 'say' block.");
      if (_text(says[0]) == _text(says[1])) {
        return const LessonResult(false, 'Make the two say blocks say different things.');
      }
      return const LessonResult(true, "Now that's a conversation! 🗨️");
    },
  ),
  Lesson(
    id: 731,
    topicId: 'looks-sound',
    title: 'Show Off',
    glyph: '🌟',
    complexity: 1,
    target: 'Show Process, then have it say something proud.',
    narrator: "Step into the spotlight, then say your line!",
    steps: const ["Add 'show' from Looks.", "Add 'say' from Looks, right after show."],
    starter: () => [BlockInstance('looks_show')],
    check: (script) {
      final flat = cqFlatten(script);
      final show = _idx(flat, 'looks_show');
      final say = _idx(flat, 'looks_say');
      if (show == -1) return const LessonResult(false, "Keep the 'show' block.");
      if (say == -1) return const LessonResult(false, "Add a 'say' block after show.");
      if (say < show) return const LessonResult(false, 'Show yourself BEFORE you say your line.');
      return const LessonResult(true, 'Spotlight, then the line — perfect! 🌟');
    },
  ),
  Lesson(
    id: 732,
    topicId: 'looks-sound',
    title: 'Bye For Now',
    glyph: '👋',
    complexity: 1,
    target: 'Say goodbye, then hide.',
    narrator: 'Every good exit needs a line before the curtain drops.',
    steps: const ["Add 'say' from Looks.", "Add 'hide' from Looks, after say."],
    starter: () => [BlockInstance('looks_say', inputs: {'text': 'Bye for now!'})],
    check: (script) {
      final flat = cqFlatten(script);
      final say = _idx(flat, 'looks_say');
      final hide = _idx(flat, 'looks_hide');
      if (say == -1) return const LessonResult(false, "Keep the 'say' block.");
      if (hide == -1) return const LessonResult(false, "Add a 'hide' block after say.");
      if (hide < say) return const LessonResult(false, 'Say your line BEFORE you hide.');
      return const LessonResult(true, 'Smooth exit! 👋');
    },
  ),
  Lesson(
    id: 733,
    topicId: 'looks-sound',
    title: 'Click Then Show',
    glyph: '🎬',
    complexity: 1,
    target: 'Play a sound, then reveal Process with show.',
    narrator: "Cue the sound effect... aaaand reveal!",
    steps: const ["Add 'play sound' from Sound.", "Add 'show' from Looks, right after it."],
    starter: () => [BlockInstance('sound_play_click')],
    check: (script) {
      final flat = cqFlatten(script);
      final snd = _idx(flat, 'sound_play_click');
      final show = _idx(flat, 'looks_show');
      if (snd == -1) return const LessonResult(false, "Keep the 'play sound' block.");
      if (show == -1) return const LessonResult(false, "Add a 'show' block after the sound.");
      if (show < snd) return const LessonResult(false, 'Play the sound BEFORE you show yourself.');
      return const LessonResult(true, 'Cue and reveal — showbiz! 🎬');
    },
  ),
  Lesson(
    id: 734,
    topicId: 'looks-sound',
    title: 'Full Intro',
    glyph: '🎭',
    complexity: 1,
    target: 'Show, say, then play a sound — a tiny intro routine.',
    narrator: "This is my whole intro: appear, speak, and drop a beat.",
    steps: const ["Add 'show' from Looks.", "Add 'say' from Looks.", "Add 'play sound' from Sound."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final show = _idx(flat, 'looks_show');
      final say = _idx(flat, 'looks_say');
      final snd = _idx(flat, 'sound_play_click');
      if (show == -1 || say == -1 || snd == -1) {
        return const LessonResult(false, 'Use show, say, AND play sound in your script.');
      }
      if (!(show < say && say < snd)) {
        return const LessonResult(false, 'Order matters: show, then say, then play sound.');
      }
      return const LessonResult(true, 'That is a proper intro! 🎭');
    },
  ),
  Lesson(
    id: 735,
    topicId: 'looks-sound',
    title: 'Hide and Click',
    glyph: '🕶️',
    complexity: 1,
    target: 'Hide Process, then play a sound as a sneaky signal.',
    narrator: "You can't see me, but you can still hear me sneaking around.",
    steps: const ["Add 'hide' from Looks.", "Add 'play sound' from Sound, after hide."],
    starter: () => [BlockInstance('looks_hide')],
    check: (script) {
      final flat = cqFlatten(script);
      final hide = _idx(flat, 'looks_hide');
      final snd = _idx(flat, 'sound_play_click');
      if (hide == -1) return const LessonResult(false, "Keep the 'hide' block.");
      if (snd == -1) return const LessonResult(false, "Add a 'play sound' block after hide.");
      if (snd < hide) return const LessonResult(false, 'Hide first, THEN play the sneaky sound.');
      return const LessonResult(true, 'Sneaky and stylish. 🕶️');
    },
  ),

  // ---------------------------------------------------------------------
  // Complexity 2 (736-745): waits, mini conversations, single blinks,
  // sound/say combined with a single motion block.
  // ---------------------------------------------------------------------
  Lesson(
    id: 736,
    topicId: 'looks-sound',
    title: 'Wait For It',
    glyph: '⏳',
    complexity: 2,
    target: 'Say something, wait, then say something else — a mini conversation.',
    narrator: "Good conversations have pauses. Let's add one.",
    steps: const ["Add 'say' with a first message.", "Add 'wait 1 seconds' from Control.", 'Add another say with a different message.'],
    starter: () => [BlockInstance('looks_say', inputs: {'text': 'Ready?'})],
    check: (script) {
      final flat = cqFlatten(script);
      final says = flat.where((b) => b.defId == 'looks_say').toList();
      final wait = _idx(flat, 'control_wait');
      if (says.length < 2) return const LessonResult(false, 'Add a second say block.');
      if (wait == -1) return const LessonResult(false, "Add a 'wait' block between the two say blocks.");
      final firstSay = _idx(flat, 'looks_say');
      final lastSay = _lastIdx(flat, 'looks_say');
      if (!(firstSay < wait && wait < lastSay)) {
        return const LessonResult(false, 'The wait should sit between the two say blocks.');
      }
      if (_text(says[0]) == _text(says[1])) {
        return const LessonResult(false, 'Make the two messages different.');
      }
      return const LessonResult(true, 'Timed just right — a real chat! ⏳');
    },
  ),
  Lesson(
    id: 737,
    topicId: 'looks-sound',
    title: 'Blink Once',
    glyph: '😉',
    complexity: 2,
    target: 'Hide, wait a moment, then show — a single blink.',
    narrator: "That's animation! No costumes needed, just a well-timed blink.",
    steps: const ["Add 'hide' from Looks.", "Add 'wait 1 seconds' from Control.", "Add 'show' from Looks."],
    starter: () => [BlockInstance('looks_hide')],
    check: (script) {
      final flat = cqFlatten(script);
      final hide = _idx(flat, 'looks_hide');
      final wait = _idx(flat, 'control_wait');
      final show = _idx(flat, 'looks_show');
      if (hide == -1 || wait == -1 || show == -1) {
        return const LessonResult(false, 'Use hide, wait, and show together.');
      }
      if (!(hide < wait && wait < show)) {
        return const LessonResult(false, 'Order: hide, then wait, then show.');
      }
      return const LessonResult(true, "That's a blink! 😉");
    },
  ),
  Lesson(
    id: 738,
    topicId: 'looks-sound',
    title: 'Dramatic Pause',
    glyph: '🎪',
    complexity: 2,
    target: 'Say something, wait at least 1 second, then play a sound for drama.',
    narrator: "Great reveals need a beat of silence before the sound hits.",
    steps: const ["Add 'say'.", "Add 'wait' and set it to 1 second or more.", "Add 'play sound' after the wait."],
    starter: () => [BlockInstance('looks_say', inputs: {'text': 'Wait for it...'})],
    check: (script) {
      final flat = cqFlatten(script);
      final say = _idx(flat, 'looks_say');
      final waits = flat.where((b) => b.defId == 'control_wait').toList();
      final snd = _idx(flat, 'sound_play_click');
      if (say == -1) return const LessonResult(false, "Keep the 'say' block.");
      if (waits.isEmpty) return const LessonResult(false, "Add a 'wait' block.");
      final seconds = (waits.first.inputs['seconds'] ?? 0) as num;
      if (seconds < 1) return const LessonResult(false, 'Set the wait to at least 1 second for real drama.');
      if (snd == -1) return const LessonResult(false, "Add 'play sound' after the wait.");
      return const LessonResult(true, 'The pause made it land. 🎪');
    },
  ),
  Lesson(
    id: 739,
    topicId: 'looks-sound',
    title: 'Vanish With Delay',
    glyph: '🌫️',
    complexity: 2,
    target: 'Say something, hide, wait, then show again.',
    narrator: "I'll say my piece, disappear for a beat, then come right back.",
    steps: const ["Add 'say'.", "Add 'hide'.", "Add 'wait'.", "Add 'show'."],
    starter: () => [BlockInstance('looks_say', inputs: {'text': 'Watch this...'})],
    check: (script) {
      final flat = cqFlatten(script);
      final say = _idx(flat, 'looks_say');
      final hide = _idx(flat, 'looks_hide');
      final wait = _idx(flat, 'control_wait');
      final show = _idx(flat, 'looks_show');
      if ([say, hide, wait, show].any((i) => i == -1)) {
        return const LessonResult(false, 'Use say, hide, wait, and show — all four.');
      }
      if (!(say < hide && hide < wait && wait < show)) {
        return const LessonResult(false, 'Order matters: say, hide, wait, show.');
      }
      return const LessonResult(true, 'A perfectly timed disappearing act! 🌫️');
    },
  ),
  Lesson(
    id: 740,
    topicId: 'looks-sound',
    title: 'Click After Move',
    glyph: '🎯',
    complexity: 2,
    target: 'Move Process, then play a sound to mark the landing.',
    narrator: "Every good landing deserves a sound effect.",
    steps: const ["Add 'move steps' from Motion.", "Add 'play sound' from Sound, right after."],
    starter: () => [BlockInstance('motion_move_steps', inputs: {'steps': 10})],
    check: (script) {
      final flat = cqFlatten(script);
      final move = _idx(flat, 'motion_move_steps');
      final snd = _idx(flat, 'sound_play_click');
      if (move == -1) return const LessonResult(false, "Keep the 'move steps' block.");
      if (snd == -1) return const LessonResult(false, "Add 'play sound' after the move.");
      if (snd < move) return const LessonResult(false, 'Move first, THEN play the sound.');
      return const LessonResult(true, 'Nailed the landing! 🎯');
    },
  ),
  Lesson(
    id: 741,
    topicId: 'looks-sound',
    title: 'Move & Announce',
    glyph: '🚀',
    complexity: 2,
    target: 'Move Process, then have it announce where it went.',
    narrator: "I moved! Someone should mention that out loud.",
    steps: const ["Add 'move steps' from Motion.", "Add 'say' from Looks, after the move."],
    starter: () => [BlockInstance('motion_move_steps', inputs: {'steps': 20})],
    check: (script) {
      final flat = cqFlatten(script);
      final move = _idx(flat, 'motion_move_steps');
      final say = _idx(flat, 'looks_say');
      if (move == -1) return const LessonResult(false, "Keep the 'move steps' block.");
      if (say == -1) return const LessonResult(false, "Add a 'say' block after the move.");
      if (say < move) return const LessonResult(false, 'Move first, then announce it.');
      return const LessonResult(true, 'Moved and mentioned it! 🚀');
    },
  ),
  Lesson(
    id: 742,
    topicId: 'looks-sound',
    title: 'Turn and Talk',
    glyph: '🔄',
    complexity: 2,
    target: 'Turn Process, then have it say something about the new direction.',
    narrator: "New direction, new attitude — let's hear about it.",
    steps: const ["Add 'turn' from Motion.", "Add 'say' from Looks, after the turn."],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final turn = flat.indexWhere((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left');
      final say = _idx(flat, 'looks_say');
      if (turn == -1) return const LessonResult(false, "Add a 'turn' block from Motion.");
      if (say == -1) return const LessonResult(false, "Add a 'say' block after the turn.");
      if (say < turn) return const LessonResult(false, 'Turn first, then talk about it.');
      return const LessonResult(true, 'New direction, new declaration! 🔄');
    },
  ),
  Lesson(
    id: 743,
    topicId: 'looks-sound',
    title: 'Two-Beat Greeting',
    glyph: '👋',
    complexity: 2,
    target: 'Build a three-part greeting: say, wait, say, wait, say.',
    narrator: "A REAL greeting needs rhythm — say a bit, pause, say more.",
    steps: const ["Add 'say', 'wait', 'say', 'wait', 'say' in that order.", 'Give each say block different text.'],
    starter: () => [],
    check: (script) {
      final flat = cqFlatten(script);
      final says = flat.where((b) => b.defId == 'looks_say').toList();
      final waitCount = _count(flat, 'control_wait');
      if (says.length < 3) return const LessonResult(false, 'Use three say blocks.');
      if (waitCount < 2) return const LessonResult(false, 'Use two wait blocks between the say blocks.');
      final texts = says.take(3).map(_text).toSet();
      if (texts.length < 3) return const LessonResult(false, 'Make all three say messages different.');
      return const LessonResult(true, 'That has real rhythm! 👋');
    },
  ),
  Lesson(
    id: 744,
    topicId: 'looks-sound',
    title: 'Sound Sandwich',
    glyph: '🥪',
    complexity: 2,
    target: 'Play a sound, wait, then play a sound again.',
    narrator: "Two clicks with a pause in the middle — that's a beat!",
    steps: const ["Add 'play sound'.", "Add 'wait'.", "Add 'play sound' again."],
    starter: () => [BlockInstance('sound_play_click')],
    check: (script) {
      final flat = cqFlatten(script);
      if (_count(flat, 'sound_play_click') < 2) {
        return const LessonResult(false, 'Use two play sound blocks.');
      }
      final firstSnd = _idx(flat, 'sound_play_click');
      final lastSnd = _lastIdx(flat, 'sound_play_click');
      final wait = _idx(flat, 'control_wait');
      if (wait == -1 || !(firstSnd < wait && wait < lastSnd)) {
        return const LessonResult(false, 'Put a wait block between the two sounds.');
      }
      return const LessonResult(true, 'Click... wait... click! A beat! 🥪');
    },
  ),
  Lesson(
    id: 745,
    topicId: 'looks-sound',
    title: 'Full Wave',
    glyph: '🌊',
    complexity: 2,
    target: 'Wave and greet: say, move a bit, then say again.',
    narrator: "Watch me wave — well, shuffle sideways and say hi twice!",
    steps: const ["Add 'say'.", "Add 'change x by' from Motion.", "Add another 'say' with different text."],
    starter: () => [BlockInstance('looks_say', inputs: {'text': 'Hey!'})],
    check: (script) {
      final flat = cqFlatten(script);
      final says = flat.where((b) => b.defId == 'looks_say').toList();
      final moveIdx = _idx(flat, 'motion_change_x');
      if (says.length < 2) return const LessonResult(false, 'Use two say blocks.');
      if (moveIdx == -1) return const LessonResult(false, "Add a 'change x by' block between the two say blocks.");
      final firstSay = _idx(flat, 'looks_say');
      final lastSay = _lastIdx(flat, 'looks_say');
      if (!(firstSay < moveIdx && moveIdx < lastSay)) {
        return const LessonResult(false, 'Order: say, then move, then say again.');
      }
      if (_text(says[0]) == _text(says[1])) {
        return const LessonResult(false, 'Make the two greetings different.');
      }
      return const LessonResult(true, 'That is a proper wave-and-greet! 🌊');
    },
  ),

  // ---------------------------------------------------------------------
  // Complexity 3 (746-760): repeat containers, variables (Score)
  // introduced, combined with looks/sound/motion.
  // ---------------------------------------------------------------------
  Lesson(
    id: 746,
    topicId: 'looks-sound',
    title: 'Repeat the Click',
    glyph: '🥁',
    complexity: 3,
    target: 'Play a sound inside a repeat loop.',
    narrator: "Why click once when a loop can click for you?",
    steps: const ["Add a 'repeat' block from Control.", "Put 'play sound' inside it."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeats = script.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(repeats.first.body);
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the repeat loop.");
      }
      return const LessonResult(true, 'A drumline of clicks! 🥁');
    },
  ),
  Lesson(
    id: 747,
    topicId: 'looks-sound',
    title: 'Blinking Loop Lite',
    glyph: '👁️',
    complexity: 3,
    target: 'Put a hide-wait-show blink inside a repeat loop.',
    narrator: "One blink is cute. A LOOP of blinks is animation.",
    steps: const ["Add a 'repeat' block.", "Inside it, add 'hide', 'wait', then 'show'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeats = script.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(repeats.first.body);
      final h = _idx(inside, 'looks_hide');
      final w = _idx(inside, 'control_wait');
      final s = _idx(inside, 'looks_show');
      if (h == -1 || w == -1 || s == -1) {
        return const LessonResult(false, 'Inside the repeat: put hide, wait, and show.');
      }
      if (!(h < w && w < s)) {
        return const LessonResult(false, 'Order inside the loop: hide, wait, show.');
      }
      return const LessonResult(true, 'Now THAT blinks like an animation! 👁️');
    },
  ),
  Lesson(
    id: 748,
    topicId: 'looks-sound',
    title: 'Say It Three Times',
    glyph: '📯',
    complexity: 3,
    target: 'Repeat a say block at least 3 times.',
    narrator: "If it's worth saying, it's worth saying three times.",
    steps: const ["Add a 'repeat' block and set it to 3 or more.", "Put 'say' inside it."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeats = script.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final times = (repeats.first.inputs['times'] ?? 0) as num;
      if (times < 3) return const LessonResult(false, 'Set the repeat to 3 or more times.');
      final inside = cqFlatten(repeats.first.body);
      if (!inside.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the repeat loop.");
      }
      return const LessonResult(true, 'Loud and clear, three times over! 📯');
    },
  ),
  Lesson(
    id: 749,
    topicId: 'looks-sound',
    title: 'Score Starts Now',
    glyph: '🏁',
    complexity: 3,
    target: 'Set the Score to 0, then announce it with say.',
    narrator: "Every game needs a fresh start. Zero it out, then tell the crowd.",
    steps: const ["Add 'set Score to' from Variables and set it to 0.", "Add 'say' after it."],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 0})],
    check: (script) {
      final flat = cqFlatten(script);
      final set = _idx(flat, 'variables_set');
      final say = _idx(flat, 'looks_say');
      if (set == -1) return const LessonResult(false, "Keep the 'set Score to' block.");
      if (say == -1) return const LessonResult(false, "Add a 'say' block after setting the score.");
      if (say < set) return const LessonResult(false, 'Set the score first, then announce it.');
      return const LessonResult(true, 'Fresh start, announced! 🏁');
    },
  ),
  Lesson(
    id: 750,
    topicId: 'looks-sound',
    title: 'Add a Point',
    glyph: '➕',
    complexity: 3,
    target: 'Change the Score, then celebrate with a sound.',
    narrator: "A point earned deserves a little fanfare!",
    steps: const ["Add 'change Score by' from Variables.", "Add 'play sound' right after."],
    starter: () => [BlockInstance('variables_change', inputs: {'value': 1})],
    check: (script) {
      final flat = cqFlatten(script);
      final change = _idx(flat, 'variables_change');
      final snd = _idx(flat, 'sound_play_click');
      if (change == -1) return const LessonResult(false, "Keep the 'change Score by' block.");
      if (snd == -1) return const LessonResult(false, "Add 'play sound' after changing the score.");
      if (snd < change) return const LessonResult(false, 'Change the score first, then celebrate with sound.');
      return const LessonResult(true, 'Point earned, sound played! ➕');
    },
  ),
  Lesson(
    id: 751,
    topicId: 'looks-sound',
    title: 'Announce the Score',
    glyph: '📊',
    complexity: 3,
    target: 'Set the Score, then say something about it, mentioning "Score".',
    narrator: "Numbers are boring until someone announces them out loud.",
    steps: const ["Add 'set Score to' from Variables.", "Add 'say' after it — mention the word Score in your message."],
    starter: () => [BlockInstance('variables_set', inputs: {'value': 10})],
    check: (script) {
      final flat = cqFlatten(script);
      final set = _idx(flat, 'variables_set');
      final says = flat.where((b) => b.defId == 'looks_say').toList();
      if (set == -1) return const LessonResult(false, "Keep the 'set Score to' block.");
      if (says.isEmpty) return const LessonResult(false, "Add a 'say' block after setting the score.");
      if (!says.any((b) => _text(b).toLowerCase().contains('score'))) {
        return const LessonResult(false, "Make one of your say messages mention 'Score'.");
      }
      return const LessonResult(true, 'Now the crowd knows the score! 📊');
    },
  ),
  Lesson(
    id: 752,
    topicId: 'looks-sound',
    title: 'Walk Cycle Feel',
    glyph: '🚶‍♂️',
    complexity: 3,
    target: 'Give Process a walk-cycle feel with move+wait inside a repeat.',
    narrator: "No costumes needed — a repeating move-and-pause FEELS like walking.",
    steps: const ["Add a 'repeat' block.", "Inside it, add 'move steps' then 'wait'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeats = script.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(repeats.first.body);
      final m = _idx(inside, 'motion_move_steps');
      final w = _idx(inside, 'control_wait');
      if (m == -1 || w == -1) {
        return const LessonResult(false, 'Inside the repeat: put move steps, then wait.');
      }
      if (m > w) return const LessonResult(false, 'Move first, then wait, inside the loop.');
      return const LessonResult(true, 'That has a real walk-cycle feel! 🚶‍♂️');
    },
  ),
  Lesson(
    id: 753,
    topicId: 'looks-sound',
    title: 'Repeat and React',
    glyph: '🔁',
    complexity: 3,
    target: 'Inside a repeat loop, say something then play a sound.',
    narrator: "Every lap of the loop, I say my line and drop a beat.",
    steps: const ["Add a 'repeat' block.", "Inside it, add 'say' then 'play sound'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeats = script.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(repeats.first.body);
      final say = _idx(inside, 'looks_say');
      final snd = _idx(inside, 'sound_play_click');
      if (say == -1 || snd == -1) {
        return const LessonResult(false, 'Inside the repeat: put say and play sound.');
      }
      if (snd < say) return const LessonResult(false, 'Say first, then play the sound, inside the loop.');
      return const LessonResult(true, 'Every lap, right on cue! 🔁');
    },
  ),
  Lesson(
    id: 754,
    topicId: 'looks-sound',
    title: 'Double Blink',
    glyph: '👀',
    complexity: 3,
    target: 'Repeat a full hide-wait-show blink at least twice.',
    narrator: "One blink is a moment. Two blinks is a habit.",
    steps: const ["Add a 'repeat' block set to 2 or more.", "Inside it, add 'hide', 'wait', 'show'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 2})],
    check: (script) {
      final repeats = script.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final times = (repeats.first.inputs['times'] ?? 0) as num;
      if (times < 2) return const LessonResult(false, 'Set the repeat to at least 2.');
      final inside = cqFlatten(repeats.first.body);
      final h = _idx(inside, 'looks_hide');
      final w = _idx(inside, 'control_wait');
      final s = _idx(inside, 'looks_show');
      if (h == -1 || w == -1 || s == -1 || !(h < w && w < s)) {
        return const LessonResult(false, 'Inside the loop: hide, wait, show, in that order.');
      }
      return const LessonResult(true, "Blink, blink — that's a habit! 👀");
    },
  ),
  Lesson(
    id: 755,
    topicId: 'looks-sound',
    title: 'Countdown Click',
    glyph: '⏱️',
    complexity: 3,
    target: 'Repeat wait+sound at least 3 times to make a countdown.',
    narrator: "Tick, tick, tick — every count gets its own click.",
    steps: const ["Add a 'repeat' block set to 3 or more.", "Inside it, add 'wait' then 'play sound'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeats = script.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final times = (repeats.first.inputs['times'] ?? 0) as num;
      if (times < 3) return const LessonResult(false, 'Set the repeat to at least 3 for a real countdown.');
      final inside = cqFlatten(repeats.first.body);
      final w = _idx(inside, 'control_wait');
      final snd = _idx(inside, 'sound_play_click');
      if (w == -1 || snd == -1 || snd < w) {
        return const LessonResult(false, 'Inside the loop: wait, then play sound.');
      }
      return const LessonResult(true, 'Tick, tick, tick, click! ⏱️');
    },
  ),
  Lesson(
    id: 756,
    topicId: 'looks-sound',
    title: 'Score and Cheer',
    glyph: '🎉',
    complexity: 3,
    target: 'Change the Score, play a sound, then say something to cheer.',
    narrator: "Score goes up, sound plays, and then I brag about it!",
    steps: const ["Add 'change Score by'.", "Add 'play sound'.", "Add 'say' after them."],
    starter: () => [BlockInstance('variables_change', inputs: {'value': 1})],
    check: (script) {
      final flat = cqFlatten(script);
      final change = _idx(flat, 'variables_change');
      final snd = _idx(flat, 'sound_play_click');
      final say = _idx(flat, 'looks_say');
      if (change == -1 || snd == -1 || say == -1) {
        return const LessonResult(false, 'Use change Score, play sound, AND say.');
      }
      if (!(change < snd && snd < say)) {
        return const LessonResult(false, 'Order: change score, play sound, then say.');
      }
      return const LessonResult(true, "That's a proper celebration! 🎉");
    },
  ),
  Lesson(
    id: 757,
    topicId: 'looks-sound',
    title: 'Move, Wait, Say',
    glyph: '🧩',
    complexity: 3,
    target: 'Inside a repeat, nudge x, wait, then say.',
    narrator: "Shuffle a bit, pause, then narrate — that's a routine!",
    steps: const ["Add a 'repeat' block.", "Inside it, add 'change x by', then 'wait', then 'say'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeats = script.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(repeats.first.body);
      final x = _idx(inside, 'motion_change_x');
      final w = _idx(inside, 'control_wait');
      final s = _idx(inside, 'looks_say');
      if (x == -1 || w == -1 || s == -1) {
        return const LessonResult(false, 'Inside the repeat: change x, wait, and say.');
      }
      if (!(x < w && w < s)) {
        return const LessonResult(false, 'Order inside the loop: change x, wait, then say.');
      }
      return const LessonResult(true, 'A tidy little routine! 🧩');
    },
  ),
  Lesson(
    id: 758,
    topicId: 'looks-sound',
    title: 'Turn and Announce Loop',
    glyph: '🌀',
    complexity: 3,
    target: 'Inside a repeat, turn then say something, every lap.',
    narrator: "Spin a bit, announce it, spin again — dizzying but fun.",
    steps: const ["Add a 'repeat' block.", "Inside it, add 'turn' then 'say'."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 4})],
    check: (script) {
      final repeats = script.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(repeats.first.body);
      final turn = inside.indexWhere((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left');
      final say = _idx(inside, 'looks_say');
      if (turn == -1 || say == -1) {
        return const LessonResult(false, 'Inside the repeat: turn, then say.');
      }
      if (say < turn) return const LessonResult(false, 'Turn first, then say, inside the loop.');
      return const LessonResult(true, 'Spinning and narrating — a show! 🌀');
    },
  ),
  Lesson(
    id: 759,
    topicId: 'looks-sound',
    title: 'Bounce and Beep',
    glyph: '🏐',
    complexity: 3,
    target: 'Inside an "if on edge" block, play a sound to signal the bounce.',
    narrator: "Every time I hit an edge, that deserves a beep!",
    steps: const ["Add 'if on edge' from Control.", "Put 'play sound' inside it."],
    starter: () => [BlockInstance('control_if_on_edge')],
    check: (script) {
      final ifs = script.where((b) => b.defId == 'control_if_on_edge').toList();
      if (ifs.isEmpty) return const LessonResult(false, "Add an 'if on edge' block.");
      final inside = cqFlatten(ifs.first.body);
      if (!inside.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Put 'play sound' inside the if-on-edge block.");
      }
      return const LessonResult(true, 'Beep! Right on the edge. 🏐');
    },
  ),
  Lesson(
    id: 760,
    topicId: 'looks-sound',
    title: 'Full Combo Lite',
    glyph: '🎊',
    complexity: 3,
    target: 'Inside a repeat, combine say, wait, play sound, and move steps.',
    narrator: "Time to combine everything I know into one loop.",
    steps: const ["Add a 'repeat' block.", "Inside it, add 'say', 'wait', 'play sound', and 'move steps' — in that order."],
    starter: () => [BlockInstance('control_repeat', inputs: {'times': 3})],
    check: (script) {
      final repeats = script.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Add a 'repeat' block.");
      final inside = cqFlatten(repeats.first.body);
      final say = _idx(inside, 'looks_say');
      final wait = _idx(inside, 'control_wait');
      final snd = _idx(inside, 'sound_play_click');
      final move = _idx(inside, 'motion_move_steps');
      if ([say, wait, snd, move].any((i) => i == -1)) {
        return const LessonResult(false, 'Inside the loop, use say, wait, play sound, and move steps.');
      }
      if (!(say < wait && wait < snd && snd < move)) {
        return const LessonResult(false, 'Order inside the loop: say, wait, play sound, move steps.');
      }
      return const LessonResult(true, "That's a full combo move! 🎊");
    },
  ),

  // ---------------------------------------------------------------------
  // Complexity 4 (761-770): forever loops combined with looks/sound/motion
  // and the Score variable.
  // ---------------------------------------------------------------------
  Lesson(
    id: 761,
    topicId: 'looks-sound',
    title: 'Forever Blink',
    glyph: '♾️',
    complexity: 4,
    target: 'Make Process blink forever: hide, wait, show, wait, repeating.',
    narrator: "A single blink is nice. A FOREVER blink is alive.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'hide', 'wait', 'show', 'wait'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final h = _idx(inside, 'looks_hide');
      final s = _idx(inside, 'looks_show');
      if (h == -1 || s == -1) return const LessonResult(false, 'Inside forever: put hide and show.');
      if (s < h) return const LessonResult(false, 'Hide should come before show, inside the loop.');
      if (_count(inside, 'control_wait') < 2) {
        return const LessonResult(false, 'Add two wait blocks — one after hide, one after show.');
      }
      return const LessonResult(true, "Now I blink forever — alive! ♾️");
    },
  ),
  Lesson(
    id: 762,
    topicId: 'looks-sound',
    title: 'Forever Greeting',
    glyph: '📻',
    complexity: 4,
    target: 'Say a greeting on repeat, forever, with a wait between each.',
    narrator: "I'll never stop saying hi — that's a personality trait now.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'say' then 'wait'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final say = _idx(inside, 'looks_say');
      final wait = _idx(inside, 'control_wait');
      if (say == -1 || wait == -1) return const LessonResult(false, 'Inside forever: put say and wait.');
      if (wait < say) return const LessonResult(false, 'Say first, then wait, inside the loop.');
      return const LessonResult(true, "I'll be greeting people all day. 📻");
    },
  ),
  Lesson(
    id: 763,
    topicId: 'looks-sound',
    title: 'Forever Click Beat',
    glyph: '🎵',
    complexity: 4,
    target: 'Make a metronome: play sound and wait, forever.',
    narrator: "Click... wait... click... wait... forever. A steady beat.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'play sound' then 'wait'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final snd = _idx(inside, 'sound_play_click');
      final wait = _idx(inside, 'control_wait');
      if (snd == -1 || wait == -1) return const LessonResult(false, 'Inside forever: put play sound and wait.');
      if (wait < snd) return const LessonResult(false, 'Play the sound first, then wait, inside the loop.');
      return const LessonResult(true, 'A steady beat, forever. 🎵');
    },
  ),
  Lesson(
    id: 764,
    topicId: 'looks-sound',
    title: 'Score Watcher',
    glyph: '👓',
    complexity: 4,
    target: 'Inside forever, change the Score and announce it, mentioning "Score".',
    narrator: "I'll keep tallying and telling you the score, non-stop.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'change Score by' then 'say' (mention Score in the message)."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final change = _idx(inside, 'variables_change');
      final says = inside.where((b) => b.defId == 'looks_say').toList();
      if (change == -1) return const LessonResult(false, "Inside forever: add 'change Score by'.");
      if (says.isEmpty) return const LessonResult(false, "Inside forever: add a 'say' block too.");
      if (!says.any((b) => _text(b).toLowerCase().contains('score'))) {
        return const LessonResult(false, "Make the say block mention 'Score'.");
      }
      return const LessonResult(true, "Keeping score, forever. 👓");
    },
  ),
  Lesson(
    id: 765,
    topicId: 'looks-sound',
    title: 'Animated Patrol',
    glyph: '🛰️',
    complexity: 4,
    target: 'Inside forever, move, bounce off edges, and beep every lap.',
    narrator: "Patrolling forever, bouncing off walls, beeping the whole time.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'move steps', 'if on edge bounce', and 'play sound'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final move = _idx(inside, 'motion_move_steps');
      final bounce = _idx(inside, 'motion_if_on_edge_bounce');
      final snd = _idx(inside, 'sound_play_click');
      if ([move, bounce, snd].any((i) => i == -1)) {
        return const LessonResult(false, 'Inside forever: use move steps, if-on-edge-bounce, and play sound.');
      }
      return const LessonResult(true, "On patrol, bouncing and beeping! 🛰️");
    },
  ),
  Lesson(
    id: 766,
    topicId: 'looks-sound',
    title: 'Talking Patrol',
    glyph: '🗺️',
    complexity: 4,
    target: 'Inside forever, move, bounce, and say something every lap.',
    narrator: "Patrolling AND narrating my patrol. Multitasking!",
    steps: const ["Add a 'forever' block.", "Inside it, add 'move steps', 'if on edge bounce', and 'say'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final move = _idx(inside, 'motion_move_steps');
      final bounce = _idx(inside, 'motion_if_on_edge_bounce');
      final say = _idx(inside, 'looks_say');
      if ([move, bounce, say].any((i) => i == -1)) {
        return const LessonResult(false, 'Inside forever: use move steps, if-on-edge-bounce, and say.');
      }
      return const LessonResult(true, 'Narrating my own patrol! 🗺️');
    },
  ),
  Lesson(
    id: 767,
    topicId: 'looks-sound',
    title: 'Blink and Beep Loop',
    glyph: '🚨',
    complexity: 4,
    target: 'Inside forever, blink AND beep every cycle.',
    narrator: "Hide, wait, show, then beep — like a warning light.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'hide', 'wait', 'show', then 'play sound'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final h = _idx(inside, 'looks_hide');
      final w = _idx(inside, 'control_wait');
      final s = _idx(inside, 'looks_show');
      final snd = _idx(inside, 'sound_play_click');
      if ([h, w, s, snd].any((i) => i == -1)) {
        return const LessonResult(false, 'Inside forever: use hide, wait, show, and play sound.');
      }
      if (!(h < w && w < s && s < snd)) {
        return const LessonResult(false, 'Order inside the loop: hide, wait, show, play sound.');
      }
      return const LessonResult(true, 'Like a warning beacon! 🚨');
    },
  ),
  Lesson(
    id: 768,
    topicId: 'looks-sound',
    title: 'Repeat Inside Forever',
    glyph: '🪆',
    complexity: 4,
    target: 'Nest a repeat block (with say inside) inside a forever block.',
    narrator: "Loops inside loops — like nesting dolls, but with dialogue.",
    steps: const ["Add a 'forever' block.", "Inside it, add a 'repeat' block.", "Inside the repeat, add 'say'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final nestedRepeats = forevers.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (nestedRepeats.isEmpty) {
        return const LessonResult(false, "Put a 'repeat' block directly inside the forever block.");
      }
      final innerFlat = cqFlatten(nestedRepeats.first.body);
      if (!innerFlat.any((b) => b.defId == 'looks_say')) {
        return const LessonResult(false, "Put a 'say' block inside the nested repeat.");
      }
      return const LessonResult(true, 'A loop within a loop — nested nicely! 🪆');
    },
  ),
  Lesson(
    id: 769,
    topicId: 'looks-sound',
    title: 'Score Blink',
    glyph: '💡',
    complexity: 4,
    target: 'Inside forever, change the Score, then blink hide-wait-show.',
    narrator: "Score ticks up, and I flash to celebrate it — every single lap.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'change Score by', 'hide', 'wait', 'show'."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final change = _idx(inside, 'variables_change');
      final h = _idx(inside, 'looks_hide');
      final w = _idx(inside, 'control_wait');
      final s = _idx(inside, 'looks_show');
      if ([change, h, w, s].any((i) => i == -1)) {
        return const LessonResult(false, 'Inside forever: change Score, hide, wait, show.');
      }
      if (!(change < h && h < w && w < s)) {
        return const LessonResult(false, 'Order inside the loop: change score, hide, wait, show.');
      }
      return const LessonResult(true, 'Flashing every time the score ticks up! 💡');
    },
  ),
  Lesson(
    id: 770,
    topicId: 'looks-sound',
    title: 'Full Loop Show',
    glyph: '🎡',
    complexity: 4,
    target: 'Inside forever, combine move, wait, say, and sound into one act.',
    narrator: "This is my whole show, looping forever: move, pause, speak, click.",
    steps: const ["Add a 'forever' block.", "Inside it, add 'move steps', 'wait', 'say', 'play sound' — in that order."],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final move = _idx(inside, 'motion_move_steps');
      final wait = _idx(inside, 'control_wait');
      final say = _idx(inside, 'looks_say');
      final snd = _idx(inside, 'sound_play_click');
      if ([move, wait, say, snd].any((i) => i == -1)) {
        return const LessonResult(false, 'Inside forever: use move steps, wait, say, and play sound.');
      }
      if (!(move < wait && wait < say && say < snd)) {
        return const LessonResult(false, 'Order inside the loop: move, wait, say, play sound.');
      }
      return const LessonResult(true, "That's a full show, running forever! 🎡");
    },
  ),

  // ---------------------------------------------------------------------
  // Complexity 5 (771-780): nested containers, forever + repeat combined
  // with motion, variables, looks, and sound all together.
  // ---------------------------------------------------------------------
  Lesson(
    id: 771,
    topicId: 'looks-sound',
    title: 'Double Loop Dance',
    glyph: '💃',
    complexity: 5,
    target: 'Nest a repeat (move+wait) inside forever, then beep after the repeat.',
    narrator: "A dance step on repeat, then a beep to mark the routine's end.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat' block containing 'move steps' then 'wait'.",
      "After the repeat (still inside forever), add 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final foreverBody = forevers.first.body;
      final repeats = foreverBody.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Nest a 'repeat' block directly inside forever.");
      final repeatInside = cqFlatten(repeats.first.body);
      final move = _idx(repeatInside, 'motion_move_steps');
      final wait = _idx(repeatInside, 'control_wait');
      if (move == -1 || wait == -1 || wait < move) {
        return const LessonResult(false, "Inside the repeat: 'move steps' then 'wait'.");
      }
      final foreverFlat = cqFlatten(foreverBody);
      if (!foreverFlat.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add 'play sound' inside forever, after the repeat.");
      }
      return const LessonResult(true, 'A choreographed dance, beeped to a close! 💃');
    },
  ),
  Lesson(
    id: 772,
    topicId: 'looks-sound',
    title: "Scorekeeper's Cheer",
    glyph: '🏆',
    complexity: 5,
    target: 'Inside forever: change Score, play sound, wait, then say mentioning "Score".',
    narrator: "Every lap: earn a point, celebrate with a click, breathe, then brag.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'change Score by', 'play sound', 'wait', then 'say' (mention Score).",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final change = _idx(inside, 'variables_change');
      final snd = _idx(inside, 'sound_play_click');
      final wait = _idx(inside, 'control_wait');
      final says = inside.where((b) => b.defId == 'looks_say').toList();
      if ([change, snd, wait].any((i) => i == -1) || says.isEmpty) {
        return const LessonResult(false, 'Inside forever: change Score, play sound, wait, and say.');
      }
      final say = _idx(inside, 'looks_say');
      if (!(change < snd && snd < wait && wait < say)) {
        return const LessonResult(false, 'Order inside the loop: change score, play sound, wait, say.');
      }
      if (!says.any((b) => _text(b).toLowerCase().contains('score'))) {
        return const LessonResult(false, "Make the say block mention 'Score'.");
      }
      return const LessonResult(true, 'The crowd goes wild every lap! 🏆');
    },
  ),
  Lesson(
    id: 773,
    topicId: 'looks-sound',
    title: 'Wandering Talker',
    glyph: '🧳',
    complexity: 5,
    target: 'Inside forever, combine move, bounce, wait, say, and sound — a full wandering character.',
    narrator: "I roam, bounce off walls, pause to think, talk about it, and beep. That's a whole personality.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'move steps', 'if on edge bounce', 'wait', 'say', and 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final move = _idx(inside, 'motion_move_steps');
      final bounce = _idx(inside, 'motion_if_on_edge_bounce');
      final wait = _idx(inside, 'control_wait');
      final say = _idx(inside, 'looks_say');
      final snd = _idx(inside, 'sound_play_click');
      if ([move, bounce, wait, say, snd].any((i) => i == -1)) {
        return const LessonResult(false, 'Inside forever: use move, bounce, wait, say, AND play sound — all five.');
      }
      return const LessonResult(true, "Now that's a fully-formed wandering character! 🧳");
    },
  ),
  Lesson(
    id: 774,
    topicId: 'looks-sound',
    title: 'Nested Blink Party',
    glyph: '🎈',
    complexity: 5,
    target: 'Nest a repeat (hide+wait+show) inside forever, then play a sound after it.',
    narrator: "A little blinking party inside every lap of forever, capped with a beep.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat' block containing 'hide', 'wait', 'show'.",
      "After the repeat, still inside forever, add 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final foreverBody = forevers.first.body;
      final repeats = foreverBody.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Nest a 'repeat' block directly inside forever.");
      final repeatInside = cqFlatten(repeats.first.body);
      final h = _idx(repeatInside, 'looks_hide');
      final w = _idx(repeatInside, 'control_wait');
      final s = _idx(repeatInside, 'looks_show');
      if (h == -1 || w == -1 || s == -1 || !(h < w && w < s)) {
        return const LessonResult(false, 'Inside the nested repeat: hide, wait, show, in order.');
      }
      final foreverFlat = cqFlatten(foreverBody);
      if (!foreverFlat.any((b) => b.defId == 'sound_play_click')) {
        return const LessonResult(false, "Add 'play sound' inside forever, after the repeat.");
      }
      return const LessonResult(true, "A blinking party, every single lap! 🎈");
    },
  ),
  Lesson(
    id: 775,
    topicId: 'looks-sound',
    title: 'The Full Routine',
    glyph: '🌈',
    complexity: 5,
    target: 'Inside forever, run a whole routine: say, wait, move, sound, hide, wait, show.',
    narrator: "This is my complete act: announce it, move, beep, vanish, then reappear. Forever.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'say', 'wait', 'move steps', 'play sound', 'hide', 'wait', 'show' — in that order.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final say = _idx(inside, 'looks_say');
      final move = _idx(inside, 'motion_move_steps');
      final snd = _idx(inside, 'sound_play_click');
      final h = _idx(inside, 'looks_hide');
      final s = _idx(inside, 'looks_show');
      if ([say, move, snd, h, s].any((i) => i == -1)) {
        return const LessonResult(false, 'Use say, move, play sound, hide, AND show inside the forever loop.');
      }
      if (_count(inside, 'control_wait') < 2) {
        return const LessonResult(false, 'Use two wait blocks — one after moving, one after hiding.');
      }
      if (!(say < move && move < snd && snd < h && h < s)) {
        return const LessonResult(false, 'Order matters: say, move, sound, hide, then show.');
      }
      return const LessonResult(true, 'The full routine, running forever! 🌈');
    },
  ),
  Lesson(
    id: 776,
    topicId: 'looks-sound',
    title: 'Score Race',
    glyph: '🏁',
    complexity: 5,
    target: 'Nest a repeat (change Score + sound) inside forever, then say the score after.',
    narrator: "Rack up points in quick bursts, then step back and announce the tally.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat' block containing 'change Score by' then 'play sound'.",
      "After the repeat, still inside forever, add 'say' (mention Score).",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final foreverBody = forevers.first.body;
      final repeats = foreverBody.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Nest a 'repeat' block directly inside forever.");
      final repeatInside = cqFlatten(repeats.first.body);
      final change = _idx(repeatInside, 'variables_change');
      final snd = _idx(repeatInside, 'sound_play_click');
      if (change == -1 || snd == -1 || snd < change) {
        return const LessonResult(false, "Inside the nested repeat: 'change Score by' then 'play sound'.");
      }
      final foreverFlat = cqFlatten(foreverBody);
      final says = foreverFlat.where((b) => b.defId == 'looks_say').toList();
      if (says.isEmpty) return const LessonResult(false, "Add a 'say' block inside forever, after the repeat.");
      if (!says.any((b) => _text(b).toLowerCase().contains('score'))) {
        return const LessonResult(false, "Make the say block mention 'Score'.");
      }
      return const LessonResult(true, 'Points racked up, tally announced! 🏁');
    },
  ),
  Lesson(
    id: 777,
    topicId: 'looks-sound',
    title: 'Choreographed Loop',
    glyph: '🕺',
    complexity: 5,
    target: 'Nest a repeat (turn+wait) inside forever, then say and play a sound after it.',
    narrator: "Spin through the routine, then land it with a line and a beep.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat' block containing 'turn' then 'wait'.",
      "After the repeat, still inside forever, add 'say' then 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final foreverBody = forevers.first.body;
      final repeats = foreverBody.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Nest a 'repeat' block directly inside forever.");
      final repeatInside = cqFlatten(repeats.first.body);
      final turn = repeatInside.indexWhere((b) => b.defId == 'motion_turn_right' || b.defId == 'motion_turn_left');
      final wait = _idx(repeatInside, 'control_wait');
      if (turn == -1 || wait == -1 || wait < turn) {
        return const LessonResult(false, "Inside the nested repeat: 'turn' then 'wait'.");
      }
      final foreverFlat = cqFlatten(foreverBody);
      final say = _idx(foreverFlat, 'looks_say');
      final snd = _idx(foreverFlat, 'sound_play_click');
      if (say == -1 || snd == -1 || snd < say) {
        return const LessonResult(false, "After the repeat, inside forever, add 'say' then 'play sound'.");
      }
      return const LessonResult(true, 'A choreographed loop, landed perfectly! 🕺');
    },
  ),
  Lesson(
    id: 778,
    topicId: 'looks-sound',
    title: 'Ultimate Blink-Talk-Walk',
    glyph: '🌟',
    complexity: 5,
    target: 'Inside forever combine say, move, wait, hide, wait, show, and sound — say first, sound last.',
    narrator: "This is everything I've learned: talk, walk, blink, and beep — all in one breath, forever.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add 'say', 'move steps', 'wait', 'hide', 'wait', 'show', 'play sound' — in that order.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final inside = cqFlatten(forevers.first.body);
      final say = _idx(inside, 'looks_say');
      final move = _idx(inside, 'motion_move_steps');
      final h = _idx(inside, 'looks_hide');
      final s = _idx(inside, 'looks_show');
      final snd = _idx(inside, 'sound_play_click');
      if ([say, move, h, s, snd].any((i) => i == -1)) {
        return const LessonResult(false, 'Use say, move, hide, show, AND play sound inside the forever loop.');
      }
      if (_count(inside, 'control_wait') < 2) {
        return const LessonResult(false, 'Use two wait blocks in the routine.');
      }
      if (say != 0) return const LessonResult(false, 'Say should be the very first thing in the loop.');
      if (snd != inside.length - 1) {
        return const LessonResult(false, 'Play sound should be the very last thing in the loop.');
      }
      if (!(move < h && h < s)) {
        return const LessonResult(false, 'Move before hiding, and hide before showing.');
      }
      return const LessonResult(true, 'The ultimate routine — talk, walk, blink, beep! 🌟');
    },
  ),
  Lesson(
    id: 779,
    topicId: 'looks-sound',
    title: 'Recursive Repeat Show',
    glyph: '🎢',
    complexity: 5,
    target: 'Nest a repeat inside forever with say, change x, and sound all inside the nested repeat.',
    narrator: "A tiny 3-move show, repeated inside a loop that never ends.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, add a 'repeat' block.",
      "Inside that repeat, add 'say', 'change x by', and 'play sound' — in that order.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final repeats = forevers.first.body.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) return const LessonResult(false, "Nest a 'repeat' block directly inside forever.");
      final inner = cqFlatten(repeats.first.body);
      final say = _idx(inner, 'looks_say');
      final x = _idx(inner, 'motion_change_x');
      final snd = _idx(inner, 'sound_play_click');
      if (say == -1 || x == -1 || snd == -1) {
        return const LessonResult(false, "Inside the nested repeat: use say, change x by, AND play sound.");
      }
      if (!(say < x && x < snd)) {
        return const LessonResult(false, 'Order inside the nested repeat: say, change x, play sound.');
      }
      return const LessonResult(true, 'A tiny show, looping inside a loop! 🎢');
    },
  ),
  Lesson(
    id: 780,
    topicId: 'looks-sound',
    title: 'Grand Finale',
    glyph: '🎆',
    complexity: 5,
    target: 'Build the finale: forever containing a nested blink repeat, plus move, bounce, score change, and a say mentioning "Score", ending in sound.',
    narrator: "Everything I've learned, in one grand finale: blink, wander, bounce, score, brag, beep — forever.",
    steps: const [
      "Add a 'forever' block.",
      "Inside it, nest a 'repeat' block containing 'hide', 'wait', 'show'.",
      "After the nested repeat, still inside forever, add 'move steps', 'if on edge bounce', 'change Score by', 'say' (mention Score), and 'play sound'.",
    ],
    starter: () => [BlockInstance('control_forever')],
    check: (script) {
      final forevers = script.where((b) => b.defId == 'control_forever').toList();
      if (forevers.isEmpty) return const LessonResult(false, "Add a 'forever' block.");
      final foreverBody = forevers.first.body;
      final repeats = foreverBody.where((b) => b.defId == 'control_repeat').toList();
      if (repeats.isEmpty) {
        return const LessonResult(false, "Nest a 'repeat' block directly inside forever for the blink.");
      }
      final repeatInside = cqFlatten(repeats.first.body);
      final h = _idx(repeatInside, 'looks_hide');
      final w = _idx(repeatInside, 'control_wait');
      final s = _idx(repeatInside, 'looks_show');
      if (h == -1 || w == -1 || s == -1 || !(h < w && w < s)) {
        return const LessonResult(false, 'Inside the nested repeat: hide, wait, show, in order.');
      }
      final foreverFlat = cqFlatten(foreverBody);
      final move = _idx(foreverFlat, 'motion_move_steps');
      final bounce = _idx(foreverFlat, 'motion_if_on_edge_bounce');
      final change = _idx(foreverFlat, 'variables_change');
      final says = foreverFlat.where((b) => b.defId == 'looks_say').toList();
      final snd = _idx(foreverFlat, 'sound_play_click');
      if ([move, bounce, change, snd].any((i) => i == -1) || says.isEmpty) {
        return const LessonResult(
          false,
          'Inside forever (after the blink repeat): use move, bounce, change Score, say, AND play sound.',
        );
      }
      if (!says.any((b) => _text(b).toLowerCase().contains('score'))) {
        return const LessonResult(false, "Make the say block mention 'Score'.");
      }
      return const LessonResult(true, 'A grand finale — everything, all at once, forever! 🎆');
    },
  ),
];
