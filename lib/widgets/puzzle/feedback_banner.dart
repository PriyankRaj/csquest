import 'package:flutter/material.dart';
import '../../theme.dart';

/// Inline correct/incorrect feedback — Duolingo-style banner right under the
/// puzzle, not a popup. Best practice for quiz feedback: keep it in place so
/// the question stays visible while you read why you got it right/wrong.
class FeedbackBanner extends StatelessWidget {
  final bool ok;
  final String text;
  const FeedbackBanner({super.key, required this.ok, required this.text});

  @override
  Widget build(BuildContext context) {
    final color = ok ? QuestColors.accent : QuestColors.danger;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ok ? Icons.check_circle : Icons.error, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
