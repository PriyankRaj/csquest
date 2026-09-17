/// Process Quest — data models. Deliberately simpler than the web version's
/// registry (no levels/professional-tier/story-shard system in this vertical
/// slice) — just enough structure to prove the Duolingo-style lesson-path UX
/// with real content and real puzzle interaction.
enum PuzzleType { mcq, order, sort2, match, circuit }

class McqPuzzle {
  final String question;
  final List<String> options;
  final int answerIndex;
  final String explainOk;
  final String explainBad;
  const McqPuzzle({
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.explainOk,
    required this.explainBad,
  });
}

class OrderItem {
  final String id;
  final String label;
  const OrderItem(this.id, this.label);
}

class OrderPuzzle {
  final String instructions;
  final List<OrderItem> items; // stored in correct order; UI shuffles for display
  final String explainOk;
  final String explainBad;
  const OrderPuzzle({
    required this.instructions,
    required this.items,
    required this.explainOk,
    required this.explainBad,
  });
}

class Sort2Item {
  final String id;
  final String label;
  final bool bucketA; // true = bucket A, false = bucket B
  const Sort2Item(this.id, this.label, this.bucketA);
}

class Sort2Puzzle {
  final String instructions;
  final String bucketALabel;
  final String bucketBLabel;
  final List<Sort2Item> items;
  final String explainOk;
  final String explainBad;
  const Sort2Puzzle({
    required this.instructions,
    required this.bucketALabel,
    required this.bucketBLabel,
    required this.items,
    required this.explainOk,
    required this.explainBad,
  });
}

class MatchPair {
  final String id;
  final String left;
  final String right;
  const MatchPair(this.id, this.left, this.right);
}

class MatchPuzzle {
  final String instructions;
  final List<MatchPair> pairs;
  final String explainOk;
  const MatchPuzzle({required this.instructions, required this.pairs, required this.explainOk});
}

enum CircuitGate { and, or }

class CircuitPuzzle {
  final String instructions;
  final CircuitGate gate;
  final String explainOk;
  final String explainBad;
  const CircuitPuzzle({required this.instructions, required this.gate, required this.explainOk, required this.explainBad});
}

class Chapter {
  final int id;
  final String title;
  final String avatar;
  final String role;
  final String bodyIntro; // short narrative shown above the puzzle
  final List<String> calloutHints; // collapsible "hint" callouts
  final PuzzleType puzzleType;
  final McqPuzzle? mcq;
  final OrderPuzzle? order;
  final Sort2Puzzle? sort2;
  final MatchPuzzle? match;
  final CircuitPuzzle? circuit;
  const Chapter({
    required this.id,
    required this.title,
    required this.avatar,
    required this.role,
    required this.bodyIntro,
    this.calloutHints = const [],
    required this.puzzleType,
    this.mcq,
    this.order,
    this.sort2,
    this.match,
    this.circuit,
  });
}

class Subject {
  final String id;
  final String name;
  final String icon;
  final String place;
  final String tagline;
  final List<Chapter> chapters; // empty for not-yet-ported subjects
  final bool available;
  const Subject({
    required this.id,
    required this.name,
    required this.icon,
    required this.place,
    required this.tagline,
    this.chapters = const [],
    this.available = false,
  });
}
