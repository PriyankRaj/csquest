import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemSound, SystemSoundType;
import '../../data/cq_all_lessons.dart';
import '../../data/cq_blocks.dart';
import '../../main.dart';
import '../../models/cq_models.dart';
import '../../theme.dart';
import '../../widgets/home_action.dart';
import '../../widgets/quest_switcher_action.dart';

/// The mobile-native replacement for the web version's free-drag canvas: a
/// vertical script you build by tapping blocks in from a bottom-sheet
/// palette, reorder by long-press drag (ReorderableListView — real touch
/// support, unlike the web version's mouse-only drag), and run against a
/// small animated stage preview. "Check" reports the result in a popup.
class LessonEditorScreen extends StatefulWidget {
  final Lesson lesson;
  const LessonEditorScreen({super.key, required this.lesson});

  @override
  State<LessonEditorScreen> createState() => _LessonEditorScreenState();
}

class _LessonEditorScreenState extends State<LessonEditorScreen> {
  late List<BlockInstance> _script;
  double _x = 0, _y = 0, _dir = 90; // Scratch convention: 90 = facing right
  bool _running = false;
  int _runToken = 0;
  bool _visible = true;
  num _scoreVar = 0;
  String? _sayText;
  int _sayGen = 0; // invalidates a stale "clear the bubble" timer
  late String _character;

  // Not lesson-specific — the same character choice follows you across
  // every lesson, like picking an avatar once.
  static const _characterOptions = ['🐢', '🐱', '🐶', '🦊', '🐰', '🐸', '🐼', '🐧', '🦄', '🤖', '👾', '🦖'];

  @override
  void initState() {
    super.initState();
    _script = widget.lesson.starter();
    _character = progressStore.character;
  }

  @override
  void dispose() {
    _runToken++; // invalidate any in-flight run loop
    super.dispose();
  }

  // ---------- Script editing ----------
  // Numbers are edited in place on the block itself (see _labelNumberField),
  // so adding one just drops in the block's defaults — no extra "enter the
  // value" step in between.
  void _addBlock(String defId, {List<BlockInstance>? into}) {
    setState(() => (into ?? _script).add(BlockInstance(defId, inputs: {
          for (final p in cqBlockDefs[defId]!.params) p.name: p.defaultValue,
        })));
  }

  void _removeBlock(List<BlockInstance> list, BlockInstance b) {
    setState(() => list.remove(b));
  }

  Future<void> _openPalette({required List<BlockInstance> into, bool allowContainer = true}) async {
    final ids = allowContainer
        ? cqBlockDefs.keys.toList()
        : cqBlockDefs.keys.where((id) => !cqBlockDefs[id]!.isContainer).toList();
    final chosen = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: QuestColors.of(context).panel,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      // Without this, the sheet route itself caps height at ~56% of the
      // screen regardless of what our own FractionallySizedBox asks for —
      // isScrollControlled lets our 0.75 factor actually apply against the
      // full screen height instead of that smaller default box.
      isScrollControlled: true,
      builder: (context) => SafeArea(
        // A fixed fraction of the screen height + an internal scroll view —
        // a growing block list must never overflow off the bottom of a
        // short phone screen the way an unconstrained Column would.
        child: FractionallySizedBox(
          heightFactor: 0.75,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text('🧱 Add a block', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: QuestColors.of(context).textPrimary)),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (final cat in cqCategories)
                        if (ids.any((id) => cqBlockDefs[id]!.category == cat.id)) ...[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
                            child: Text(cat.name.toUpperCase(), style: TextStyle(color: cat.color, fontWeight: FontWeight.w800, fontSize: 11, letterSpacing: 0.5)),
                          ),
                          ...ids.where((id) => cqBlockDefs[id]!.category == cat.id).map((id) {
                            final def = cqBlockDefs[id]!;
                            return ListTile(
                              onTap: () => Navigator.of(context).pop(id),
                              leading: CircleAvatar(backgroundColor: def.color, radius: 14),
                              title: Text(_labelPreview(def), style: TextStyle(color: QuestColors.of(context).textPrimary, fontWeight: FontWeight.w600, fontSize: 16)),
                            );
                          }),
                        ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // Numbers are directly editable on the placed block itself, so there's
    // no need for a separate "enter the value" step before adding one —
    // just drop it in with its default and let the inline field take it
    // from there.
    if (chosen != null) _addBlock(chosen, into: into);
  }

  Future<void> _openCharacterPicker() async {
    final chosen = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: QuestColors.of(context).panel,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🎭 Pick your character', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: QuestColors.of(context).textPrimary)),
              const SizedBox(height: 4),
              Text('This is who you\'ll be moving and animating on the stage.', style: TextStyle(fontSize: 12, color: QuestColors.of(context).textDim)),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final emoji in _characterOptions)
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => Navigator.of(context).pop(emoji),
                      child: Container(
                        width: 56,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: emoji == _character ? QuestColors.cqMotion.withValues(alpha: 0.15) : const Color(0xFFF4F6FB),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: emoji == _character ? QuestColors.cqMotion : const Color(0xFFD8DCEA),
                            width: emoji == _character ? 2 : 1,
                          ),
                        ),
                        child: Text(emoji, style: const TextStyle(fontSize: 28)),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (chosen != null && chosen != _character) {
      setState(() => _character = chosen);
      await progressStore.setCharacter(chosen);
    }
  }

  String _labelPreview(BlockDef def) {
    var s = def.label;
    for (final p in def.params) {
      s = s.replaceFirst('{${p.name}}', '${p.defaultValue}');
    }
    return s;
  }

  // ---------- Run ----------
  Future<void> _run() async {
    setState(() {
      _running = true;
      _x = 0;
      _y = 0;
      _dir = 90;
      _visible = true;
      _scoreVar = 0;
      _sayText = null;
    });
    final token = ++_runToken;
    await _runList(_script, token);
    if (mounted && token == _runToken) setState(() => _running = false);
  }

  void _stop() {
    setState(() => _running = false);
    _runToken++;
  }

  // ---------- Reset ----------
  Future<void> _confirmReset() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: QuestColors.of(context).panel,
        title: const Text('Reset this lesson?'),
        content: Text(
          'Your blocks will be cleared and the script restored to its starting point.',
          style: TextStyle(color: QuestColors.of(context).textPrimary),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: const Text('Reset')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    _runToken++; // stop any in-flight run loop
    setState(() {
      _running = false;
      _script = widget.lesson.starter();
      _x = 0;
      _y = 0;
      _dir = 90;
      _visible = true;
      _scoreVar = 0;
      _sayText = null;
    });
  }

  Future<void> _runList(List<BlockInstance> list, int token) async {
    for (final b in list) {
      if (token != _runToken) return;
      await _runBlock(b, token);
    }
  }

  num _numIn(BlockInstance b, String key) => (b.inputs[key] as num?) ?? 0;
  String _textIn(BlockInstance b, String key) => (b.inputs[key] as String?) ?? '';

  bool get _atEdge => _x <= -110 || _x >= 110 || _y <= -70 || _y >= 70;

  Future<void> _runBlock(BlockInstance b, int token) async {
    switch (b.defId) {
      case 'motion_move_steps':
        final steps = _numIn(b, 'steps').toDouble();
        setState(() {
          _x += steps * math.cos(_dir * math.pi / 180);
          _y -= steps * math.sin(_dir * math.pi / 180);
          _x = _x.clamp(-110, 110);
          _y = _y.clamp(-70, 70);
        });
        await Future.delayed(const Duration(milliseconds: 220));
        break;
      case 'motion_turn_right':
        setState(() => _dir += _numIn(b, 'degrees').toDouble());
        await Future.delayed(const Duration(milliseconds: 160));
        break;
      case 'motion_turn_left':
        setState(() => _dir -= _numIn(b, 'degrees').toDouble());
        await Future.delayed(const Duration(milliseconds: 160));
        break;
      case 'motion_point_direction':
        setState(() => _dir = 90 - _numIn(b, 'degrees').toDouble());
        await Future.delayed(const Duration(milliseconds: 160));
        break;
      case 'motion_change_x':
        setState(() => _x = (_x + _numIn(b, 'amount')).clamp(-110, 110));
        await Future.delayed(const Duration(milliseconds: 180));
        break;
      case 'motion_change_y':
        setState(() => _y = (_y - _numIn(b, 'amount')).clamp(-70, 70));
        await Future.delayed(const Duration(milliseconds: 180));
        break;
      case 'motion_goto_xy':
        setState(() {
          _x = _numIn(b, 'x').toDouble().clamp(-110, 110);
          _y = (-_numIn(b, 'y').toDouble()).clamp(-70, 70);
        });
        await Future.delayed(const Duration(milliseconds: 180));
        break;
      case 'motion_if_on_edge_bounce':
        setState(() {
          if (_x <= -110 || _x >= 110) _dir = 180 - _dir;
          if (_y <= -70 || _y >= 70) _dir = -_dir;
        });
        break;
      case 'control_forever':
        var guard = 0;
        while (token == _runToken && guard < 200) {
          await _runList(b.body, token);
          if (b.body.isEmpty) break; // nothing to loop, avoid a busy spin
          guard++;
        }
        break;
      case 'control_repeat':
        final times = _numIn(b, 'times').round();
        for (var i = 0; i < times; i++) {
          if (token != _runToken) return;
          await _runList(b.body, token);
        }
        break;
      case 'control_wait':
        await Future.delayed(Duration(milliseconds: (_numIn(b, 'seconds') * 1000).round()));
        break;
      case 'control_if_on_edge':
        if (_atEdge) await _runList(b.body, token);
        break;
      case 'looks_say':
        final gen = ++_sayGen;
        setState(() => _sayText = _textIn(b, 'text'));
        await Future.delayed(const Duration(milliseconds: 700));
        if (gen == _sayGen && mounted) setState(() => _sayText = null);
        break;
      case 'looks_show':
        setState(() => _visible = true);
        break;
      case 'looks_hide':
        setState(() => _visible = false);
        break;
      case 'sound_play_click':
        SystemSound.play(SystemSoundType.click);
        break;
      case 'variables_set':
        setState(() => _scoreVar = _numIn(b, 'value'));
        break;
      case 'variables_change':
        setState(() => _scoreVar = _scoreVar + _numIn(b, 'value'));
        break;
    }
  }

  // ---------- Check ----------
  // Lessons within a topic keep their authored order in cqAllLessons (each
  // topic's own list is concatenated as-is — see that file's header), so
  // "next lesson" is just the following same-topic entry, if any.
  Lesson? get _nextLesson {
    final topicLessons = cqAllLessons.where((l) => l.topicId == widget.lesson.topicId).toList();
    final i = topicLessons.indexWhere((l) => l.id == widget.lesson.id);
    if (i == -1 || i + 1 >= topicLessons.length) return null;
    return topicLessons[i + 1];
  }

  Future<void> _check() async {
    final result = widget.lesson.check(_script);
    if (!result.ok) {
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: QuestColors.of(context).panel,
          title: const Text('🤔 Not quite'),
          content: Text(result.message, style: TextStyle(color: QuestColors.of(context).textPrimary)),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
          ],
        ),
      );
      return;
    }

    await progressStore.markDone('cq:${widget.lesson.id}');
    if (!mounted) return;
    final next = _nextLesson;
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: QuestColors.of(context).panel,
        title: const Text('🎉 Nailed it!'),
        content: Text(result.message, style: TextStyle(color: QuestColors.of(context).textPrimary)),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Stay here')),
          FilledButton(
            // Uses the screen's own context (not dialogContext, which is
            // gone once the dialog pops) to navigate the underlying route.
            onPressed: () {
              Navigator.of(dialogContext).pop();
              if (next != null) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LessonEditorScreen(lesson: next)));
              } else {
                Navigator.of(context).pop(); // last lesson in the topic — back to the path
              }
            },
            child: Text(next != null ? 'Next lesson ➜' : 'Back to path'),
          ),
        ],
      ),
    );
    if (mounted) setState(() {});
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    final l = widget.lesson;
    // No forced Theme.light() override here any more — the editor follows
    // whatever light/dark theme the rest of the app is using. The app bar
    // keeps its own fixed Code Quest blue regardless, same as block-category
    // colors elsewhere in this screen (see QuestColors.cqMotion).
    return Scaffold(
      backgroundColor: QuestColors.of(context).bg,
      appBar: AppBar(
        backgroundColor: QuestColors.cqMotion,
        foregroundColor: Colors.white,
        title: Text('${l.glyph} ${l.title}'),
        actions: [
          IconButton(
            tooltip: 'Reset lesson',
            icon: const Icon(Icons.replay),
            onPressed: _confirmReset,
          ),
          const HomeAction(),
          const QuestSwitcherAction(current: 2),
        ],
      ),
      // Tapping anywhere outside an input field dismisses the keyboard —
      // without this, a number field's keyboard stays up after typing
      // since nothing else in this screen ever claims focus to replace it.
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            _buildStage(),
            _buildCtaRow(),
            Expanded(child: _buildScriptArea()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openPalette(into: _script),
        icon: const Icon(Icons.add),
        label: const Text('Block'),
      ),
    );
  }

  Widget _buildStage() {
    return Container(
      margin: const EdgeInsets.all(12),
      height: 170,
      decoration: BoxDecoration(
        color: const Color(0xFFEEF1F8),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD8DCEA)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                transform: Matrix4.identity()
                  ..translateByDouble(_x, _y, 0, 1)
                  ..rotateZ((90 - _dir) * math.pi / 180),
                child: Opacity(
                  opacity: _visible ? 1 : 0,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Text(_character, style: const TextStyle(fontSize: 34)),
                      if (_sayText != null)
                        Positioned(
                          bottom: 34,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 140),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black26)),
                            child: Text(_sayText!, style: const TextStyle(fontSize: 11, color: Colors.black), maxLines: 2, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)]),
                child: Text('Score: $_scoreVar', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.black87)),
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Material(
                color: Colors.white.withValues(alpha: 0.9),
                shape: const CircleBorder(),
                elevation: 1,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: _openCharacterPicker,
                  child: const Padding(
                    padding: EdgeInsets.all(7),
                    child: Icon(Icons.face_retouching_natural, size: 16, color: Colors.black87),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Every action — Run, Stop, Check — lives in one row right below the
  // canvas, not floating on top of it (which hid part of the stage) and not
  // scattered between the app bar and a FAB.
  Widget _ctaButton({required VoidCallback? onPressed, required IconData icon, required String label, required Color color}) {
    return Expanded(
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 13), maxLines: 1, overflow: TextOverflow.clip),
          ],
        ),
      ),
    );
  }

  Widget _buildCtaRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      child: Row(
        children: [
          _ctaButton(onPressed: _running ? null : _run, icon: Icons.play_arrow, label: 'Run', color: const Color(0xFF59C059)),
          const SizedBox(width: 6),
          _ctaButton(onPressed: _running ? _stop : null, icon: Icons.stop, label: 'Stop', color: const Color(0xFFFF5C5C)),
          const SizedBox(width: 6),
          _ctaButton(onPressed: _check, icon: Icons.check_circle_outline, label: 'Check', color: QuestColors.cqMotion),
        ],
      ),
    );
  }

  Widget _buildScriptArea() {
    final l = widget.lesson;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              leading: const Text('🎯', style: TextStyle(fontSize: 18)),
              title: Text(l.target, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: QuestColors.of(context).textPrimary)),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.narrator, style: TextStyle(fontSize: 12.5, color: QuestColors.of(context).textDim)),
                      const SizedBox(height: 6),
                      for (final s in l.steps)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text('• $s', style: TextStyle(fontSize: 12.5, color: QuestColors.of(context).textPrimary)),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _scriptList(_script),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  // A dedicated, always-present drag trigger alongside the wider draggable
  // area on the block's literal-text words (see _labelLiteral) — the value
  // chips still need their own tap to open the option picker, so neither
  // this nor the literals wrap the fields themselves: a whole-block wrap
  // (fields included) reliably lost the gesture-arena race against a
  // chip's own tap handling.
  Widget _dragHandle(int index) {
    return ReorderableDragStartListener(
      index: index,
      child: const Padding(
        // Padded well past the icon's own bounds — 18px of icon is too
        // small a touch target to reliably grab on a phone.
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Icon(Icons.drag_handle, color: Colors.white70, size: 20),
      ),
    );
  }

  Widget _blockChrome(BlockInstance b, {required int index, required VoidCallback onDelete, required Widget child}) {
    final def = cqBlockDefs[b.defId]!;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: def.color, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(child: child),
          GestureDetector(onTap: onDelete, child: const Icon(Icons.close, color: Colors.white70, size: 18)),
          _dragHandle(index),
        ],
      ),
    );
  }

  Widget _blockLabelRow(BlockInstance b, int index) {
    final def = cqBlockDefs[b.defId]!;
    final paramsByName = {for (final p in def.params) p.name: p};
    // NOTE: String.split(RegExp) in Dart discards the matched delimiter text
    // entirely — even with a capture group — so splitting on `{param}` threw
    // the placeholder away and the number field never rendered at all. Walk
    // the matches manually instead, keeping every literal and param segment.
    final regex = RegExp(r'\{([a-zA-Z]+)\}');
    final children = <Widget>[];
    var last = 0;
    for (final m in regex.allMatches(def.label)) {
      if (m.start > last) children.add(_labelLiteral(def.label.substring(last, m.start), index));
      children.add(_labelValueField(b, paramsByName[m.group(1)!]!));
      last = m.end;
    }
    if (last < def.label.length) children.add(_labelLiteral(def.label.substring(last), index));
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }

  // Wrapping each literal word (not the number/text fields next to them,
  // which need their own taps for editing) is how the draggable area
  // extends across most of a block's surface instead of just the handle
  // icon — literal spans and field spans are laid out side by side by
  // Wrap, never overlapping, so this can't reintroduce the arena conflict
  // a whole-block wrap had with the fields (see _dragHandle).
  Widget _labelLiteral(String text, int index) {
    return ReorderableDelayedDragStartListener(
      index: index,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.5)),
      ),
    );
  }

  // Tap-to-pick, never a keyboard: every param ships a fixed set of options
  // (see cq_blocks.dart), so choosing a value is always "tap a chip," even
  // for the "say" block's text — no TextFormField anywhere in this screen.
  Widget _labelValueField(BlockInstance b, BlockParam param) {
    final isText = param.kind == BlockParamKind.text;
    final current = b.inputs[param.name] ?? param.defaultValue;
    return GestureDetector(
      onTap: () => _pickOption(b, param),
      child: Container(
        // No `alignment:` here — on a Container this wraps the child in an
        // Align that fills all available width under Wrap's loose-but-bounded
        // constraints instead of shrink-wrapping, which stretched this chip
        // across the entire block. mainAxisSize.min on the Row below is what
        // actually keeps this compact.
        constraints: BoxConstraints(minWidth: isText ? 90 : 46),
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.black26)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$current', style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w700)),
            const SizedBox(width: 2),
            const Icon(Icons.arrow_drop_down, size: 16, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  Future<void> _pickOption(BlockInstance b, BlockParam param) async {
    final current = b.inputs[param.name] ?? param.defaultValue;
    final chosen = await showModalBottomSheet<Object>(
      context: context,
      backgroundColor: QuestColors.of(context).panel,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pick ${param.label}', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: QuestColors.of(context).textPrimary)),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final opt in param.options)
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.of(context).pop(opt),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: opt == current ? QuestColors.cqMotion.withValues(alpha: 0.15) : QuestColors.of(context).panel2,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: opt == current ? QuestColors.cqMotion : QuestColors.of(context).textDim.withValues(alpha: 0.4), width: opt == current ? 2 : 1),
                        ),
                        child: Text('$opt', style: TextStyle(color: QuestColors.of(context).textPrimary, fontWeight: FontWeight.w700, fontSize: 14)),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (chosen != null) setState(() => b.inputs[param.name] = chosen);
  }

  // A block list — the top-level script, and each container block's body —
  // is its own independent ReorderableListView, draggable via the handle
  // icon on each block (see _dragHandle). Container items get their own
  // header handle instead of a whole-card one, so grabbing a block *inside*
  // a loop drags that block, not the loop around it.
  Widget _scriptList(List<BlockInstance> list, {String emptyLabel = 'Tap "+ Block" to start your script'}) {
    if (list.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: QuestColors.of(context).textDim.withValues(alpha: 0.35)), borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text(emptyLabel, style: TextStyle(color: QuestColors.of(context).textDim, fontSize: 12)),
      );
    }
    return ReorderableListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) newIndex -= 1;
          final b = list.removeAt(oldIndex);
          list.insert(newIndex, b);
        });
      },
      children: [
        for (final (i, b) in list.indexed)
          KeyedSubtree(
            key: ValueKey(b),
            child: cqBlockDefs[b.defId]!.isContainer
                ? _containerBlock(list, b, i)
                : _blockChrome(b, index: i, onDelete: () => _removeBlock(list, b), child: _blockLabelRow(b, i)),
          ),
      ],
    );
  }

  Widget _containerBlock(List<BlockInstance> owner, BlockInstance b, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: QuestColors.cqControl, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _blockLabelRow(b, index)),
              GestureDetector(onTap: () => _removeBlock(owner, b), child: const Icon(Icons.close, color: Colors.white70, size: 18)),
              _dragHandle(index),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 6, left: 10),
            padding: const EdgeInsets.only(left: 8),
            decoration: const BoxDecoration(border: Border(left: BorderSide(color: Colors.white54, width: 2))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _scriptList(b.body, emptyLabel: 'Empty — add a block below'),
                TextButton.icon(
                  onPressed: () => _openPalette(into: b.body, allowContainer: false),
                  icon: const Icon(Icons.add, size: 16, color: Colors.white),
                  label: const Text('Add inside', style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
