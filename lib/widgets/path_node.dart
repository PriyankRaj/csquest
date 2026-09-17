import 'package:flutter/material.dart';
import '../theme.dart';

enum NodeState { locked, current, done }

/// A single circular node on a Duolingo-style vertical lesson path, plus the
/// connecting line above it. Zig-zag offset is handled by the caller via
/// alignment, so this stays a dumb, reusable "node" building block.
class PathNode extends StatelessWidget {
  final String glyph;
  final String label;
  final NodeState state;
  final VoidCallback? onTap;
  final bool showLineAbove;

  const PathNode({
    super.key,
    required this.glyph,
    required this.label,
    required this.state,
    required this.onTap,
    this.showLineAbove = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color ring = switch (state) {
      NodeState.locked => QuestColors.of(context).textDim.withValues(alpha: 0.35),
      NodeState.current => QuestColors.of(context).accent,
      NodeState.done => QuestColors.of(context).accent2,
    };
    final Color fill = switch (state) {
      NodeState.locked => QuestColors.of(context).panel2,
      NodeState.current => QuestColors.of(context).accent.withValues(alpha: 0.18),
      NodeState.done => QuestColors.of(context).accent2.withValues(alpha: 0.18),
    };
    // The whole node — circle AND label — is one tap target, not just the
    // circle: a bigger hit area is both better mobile UX and what a user
    // reasonably expects when the label sits right under the icon.
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          children: [
            if (showLineAbove)
              Container(width: 4, height: 22, color: ring.withValues(alpha: 0.5)),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: fill,
                border: Border.all(color: ring, width: 3),
                boxShadow: state == NodeState.current
                    ? [BoxShadow(color: ring.withValues(alpha: 0.45), blurRadius: 16, spreadRadius: 1)]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                state == NodeState.locked ? '🔒' : (state == NodeState.done ? '✅' : glyph),
                style: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 96,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: state == NodeState.locked ? QuestColors.of(context).textDim : QuestColors.of(context).textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
