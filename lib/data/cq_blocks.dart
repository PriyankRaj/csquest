import 'package:flutter/material.dart';
import '../models/cq_models.dart';
import '../theme.dart';

/// Five real, working categories: Motion, Control, Looks, Sound, Variables.
/// Deliberately NOT included: Operators/Sensing-as-pluggable-reporters and
/// Events/broadcast — those need a generic "drop a reporter into a slot"
/// system and a message-passing model respectively, which is a genuinely
/// different (larger) engine than this tap-to-add script list. Building a
/// hollow version of those just to say the category exists would be worse
/// than not having them, so they're left out rather than faked.
const cqCategories = <BlockCategory>[
  BlockCategory('motion', 'Motion', QuestColors.cqMotion),
  BlockCategory('control', 'Control', QuestColors.cqControl),
  BlockCategory('looks', 'Looks', Color(0xFFFF6680)),
  BlockCategory('sound', 'Sound', Color(0xFFCF63CF)),
  BlockCategory('variables', 'Variables', Color(0xFFFF8C1A)),
];

const _looksColor = Color(0xFFFF6680);
const _soundColor = Color(0xFFCF63CF);
const _varColor = Color(0xFFFF8C1A);

final cqBlockDefs = <String, BlockDef>{
  // ---------- Motion ----------
  'motion_move_steps': const BlockDef(
    id: 'motion_move_steps',
    label: 'move {steps} steps',
    color: QuestColors.cqMotion,
    category: 'motion',
    params: [BlockParam('steps', 'steps', 10, options: [5, 10, 15, 20, 30, 45, 75, 90])],
  ),
  'motion_turn_right': const BlockDef(
    id: 'motion_turn_right',
    label: 'turn ↻ {degrees} degrees',
    color: QuestColors.cqMotion,
    category: 'motion',
    params: [BlockParam('degrees', 'degrees', 15, options: [15, 30, 45, 60, 90, 120, 180, 270, 360])],
  ),
  'motion_turn_left': const BlockDef(
    id: 'motion_turn_left',
    label: 'turn ↺ {degrees} degrees',
    color: QuestColors.cqMotion,
    category: 'motion',
    params: [BlockParam('degrees', 'degrees', 15, options: [15, 30, 45, 60, 90, 120, 180, 270, 360])],
  ),
  'motion_point_direction': const BlockDef(
    id: 'motion_point_direction',
    label: 'point in direction {degrees}',
    color: QuestColors.cqMotion,
    category: 'motion',
    params: [BlockParam('degrees', 'degrees', 90, options: [0, 45, 90, 135, 180, 225, 270, 315])],
  ),
  'motion_change_x': const BlockDef(
    id: 'motion_change_x',
    label: 'change x by {amount}',
    color: QuestColors.cqMotion,
    category: 'motion',
    params: [BlockParam('amount', 'amount', 10, options: [-50, -20, -10, -5, 5, 10, 20, 50])],
  ),
  'motion_change_y': const BlockDef(
    id: 'motion_change_y',
    label: 'change y by {amount}',
    color: QuestColors.cqMotion,
    category: 'motion',
    params: [BlockParam('amount', 'amount', 10, options: [-50, -20, -10, -5, 5, 10, 20, 50])],
  ),
  'motion_goto_xy': const BlockDef(
    id: 'motion_goto_xy',
    label: 'go to x: {x} y: {y}',
    color: QuestColors.cqMotion,
    category: 'motion',
    params: [
      BlockParam('x', 'x', 0, options: [-100, -50, -25, 0, 25, 50, 100]),
      BlockParam('y', 'y', 0, options: [-70, -35, -15, 0, 15, 35, 70]),
    ],
  ),
  'motion_if_on_edge_bounce': const BlockDef(
    id: 'motion_if_on_edge_bounce',
    label: 'if on edge, bounce',
    color: QuestColors.cqMotion,
    category: 'motion',
  ),

  // ---------- Control ----------
  'control_forever': const BlockDef(
    id: 'control_forever',
    label: 'forever',
    color: QuestColors.cqControl,
    category: 'control',
    isContainer: true,
  ),
  'control_repeat': const BlockDef(
    id: 'control_repeat',
    label: 'repeat {times} times',
    color: QuestColors.cqControl,
    category: 'control',
    params: [BlockParam('times', 'times', 4, options: [2, 3, 4, 5, 6, 8, 10, 12])],
    isContainer: true,
  ),
  'control_wait': const BlockDef(
    id: 'control_wait',
    label: 'wait {seconds} seconds',
    color: QuestColors.cqControl,
    category: 'control',
    params: [BlockParam('seconds', 'seconds', 1, options: [0.5, 1, 1.5, 2, 3, 5])],
  ),
  'control_if_on_edge': const BlockDef(
    id: 'control_if_on_edge',
    label: 'if on edge',
    color: QuestColors.cqControl,
    category: 'control',
    isContainer: true,
  ),

  // ---------- Looks ----------
  'looks_say': const BlockDef(
    id: 'looks_say',
    label: 'say {text}',
    color: _looksColor,
    category: 'looks',
    params: [
      BlockParam(
        'text',
        'text',
        'Hello!',
        kind: BlockParamKind.text,
        options: ['Hello!', 'Hi!', "Let's go!", 'Woohoo!', 'Great job!', 'Oops!', 'Oh no!', 'Yay!'],
      ),
    ],
  ),
  'looks_show': const BlockDef(
    id: 'looks_show',
    label: 'show',
    color: _looksColor,
    category: 'looks',
  ),
  'looks_hide': const BlockDef(
    id: 'looks_hide',
    label: 'hide',
    color: _looksColor,
    category: 'looks',
  ),

  // ---------- Sound ----------
  // Plays a real native click sound (SystemSound.play) — no audio asset
  // pipeline needed, but it's an actual sound, not a silent stand-in.
  'sound_play_click': const BlockDef(
    id: 'sound_play_click',
    label: 'play sound 🔊',
    color: _soundColor,
    category: 'sound',
  ),

  // ---------- Variables ----------
  // One project-wide variable, "Score" — not the full multi-variable Scratch
  // system (that needs a "make a variable" flow + a way to reference a
  // specific variable by name in every block), but a real, working counter
  // with a visible on-stage watcher.
  'variables_set': const BlockDef(
    id: 'variables_set',
    label: 'set Score to {value}',
    color: _varColor,
    category: 'variables',
    params: [BlockParam('value', 'value', 0, options: [0, 1, 5, 10, 50, 100])],
  ),
  'variables_change': const BlockDef(
    id: 'variables_change',
    label: 'change Score by {value}',
    color: _varColor,
    category: 'variables',
    params: [BlockParam('value', 'value', 1, options: [-10, -5, -1, 1, 2, 5, 10])],
  ),
};

/// Flattens a script (including inside containers) — mirrors the web
/// version's flattenBlocks() helper used by every lesson.check().
List<BlockInstance> cqFlatten(List<BlockInstance> script) {
  final out = <BlockInstance>[];
  for (final b in script) {
    out.add(b);
    if (b.body.isNotEmpty) out.addAll(cqFlatten(b.body));
  }
  return out;
}

bool cqHas(List<BlockInstance> script, String defId) =>
    cqFlatten(script).any((b) => b.defId == defId);
