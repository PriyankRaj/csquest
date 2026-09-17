import 'package:flutter/material.dart';

/// Code Quest — mobile-native block model. The web version used a free-form
/// mouse-drag canvas (x/y positions, snap targets) — that's desktop UX. On
/// mobile, best practice for block coding (see Scratch Jr., Tynker) is a
/// vertical script list you build by tapping blocks in from a bottom-sheet
/// palette and reorder with long-press drag — no canvas, no coordinates.
enum BlockParamKind { number, text }

class BlockParam {
  final String name;
  final String label;
  final BlockParamKind kind;
  final Object defaultValue; // num for .number, String for .text
  const BlockParam(this.name, this.label, this.defaultValue, {this.kind = BlockParamKind.number});
}

class BlockCategory {
  final String id;
  final String name;
  final Color color;
  const BlockCategory(this.id, this.name, this.color);
}

class BlockDef {
  final String id;
  final String label; // may contain {param} placeholders in order
  final Color color;
  final String category;
  final List<BlockParam> params;
  final bool isContainer; // true = has a nested body (e.g. forever)
  const BlockDef({
    required this.id,
    required this.label,
    required this.color,
    required this.category,
    this.params = const [],
    this.isContainer = false,
  });
}

class BlockInstance {
  final String defId;
  final Map<String, Object> inputs; // num for number params, String for text params
  final List<BlockInstance> body; // only used when defId's BlockDef.isContainer
  BlockInstance(this.defId, {Map<String, Object>? inputs, List<BlockInstance>? body})
      : inputs = inputs ?? {},
        body = body ?? [];
}

class Topic {
  final String id;
  final String name;
  final String place;
  final String icon;
  final Color color;
  final String tagline;
  final bool available;
  const Topic({
    required this.id,
    required this.name,
    required this.place,
    required this.icon,
    required this.color,
    required this.tagline,
    this.available = false,
  });
}

class Lesson {
  final int id;
  final String topicId;
  final String title;
  final String glyph;
  final int complexity; // 1-5
  final String target;
  final String narrator;
  final List<String> steps;
  final List<BlockInstance> Function() starter;
  final LessonResult Function(List<BlockInstance> script) check;
  const Lesson({
    required this.id,
    required this.topicId,
    required this.title,
    required this.glyph,
    required this.complexity,
    required this.target,
    required this.narrator,
    required this.steps,
    required this.starter,
    required this.check,
  });
}

class LessonResult {
  final bool ok;
  final String message;
  const LessonResult(this.ok, this.message);
}
