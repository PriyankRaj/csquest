import '../models/pq_models.dart';

/// Ported from process-quest/subjects/digital-logic.js, chapters 1-60
/// (Levels 1-15). Real content, HTML stripped to plain narrative prose;
/// callout divs become calloutHints. Puzzle types: mcq, order, sort2,
/// match, circuit (never fill/trace).
final digitalLogicChapters = <Chapter>[
  const Chapter(
    id: 1,
    title: 'Switches That Think',
    avatar: '💡',
    role: 'Narrator — flipping my first switch',
    bodyIntro:
        "I just rolled into Logic Land, and wow — everything here is made "
        "of tiny switches! Each switch can only be one of two things: ON or "
        "OFF. Computers love to write ON as 1 and OFF as 0.\n\n"
        "Try this with your own hand: hold up a finger for ON, put it down "
        "for OFF. With just ONE finger you can only show 2 things (up or "
        "down). But line up a few fingers — or a few tiny switches — in a "
        "row, and suddenly you can count much higher than just 0 and 1!\n\n"
        "These 1s and 0s are called bits (short for \"binary digits\"). One "
        "bit is just one switch. With 2 switches, I can make 4 different "
        "patterns:\n\n"
        "00 = 0\n01 = 1\n10 = 2\n11 = 3\n\n"
        "Each switch is worth double the one before it, starting from the "
        "right: 1, then 2, then 4, then 8... To turn binary into a normal "
        "number, just add up the switches that are ON!",
    calloutHints: [
      "🧠 Kid trick: binary 101 means switches worth 4, 2, and 1. Only the "
          "4-switch and the 1-switch are ON, so 101 = 4 + 0 + 1 = 5.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a binary pattern on the left, then click the regular "
          "number it matches on the right.",
      pairs: [
        MatchPair('b10', 'Binary 10', '2'),
        MatchPair('b11', 'Binary 11', '3'),
        MatchPair('b100', 'Binary 100', '4'),
        MatchPair('b101', 'Binary 101', '5'),
      ],
      explainOk:
          "You cracked the switch code! Binary is just counting with only "
          "two fingers: 0 and 1.",
    ),
  ),
  const Chapter(
    id: 2,
    title: 'Gate Keepers',
    avatar: '🚪',
    role: 'Narrator — meeting the gate keepers',
    bodyIntro:
        "Logic Land has little robot doorkeepers called logic gates. Each "
        "one looks at switches coming in, and decides what to send out. "
        "Here are the three friendliest gates:\n\n"
        "AND gate — very strict! Think of a toy car that only zooms if the "
        "WALL switch and the CAR's own switch are BOTH on. One OFF switch "
        "and the answer is NO.\n\n"
        "OR gate — easygoing! Like a porch light that turns on if it's "
        "dark or if you press the button (or both!) — just one is enough.\n\n"
        "NOT gate — a little rebel. It just flips whatever you give it: ON "
        "becomes OFF, and OFF becomes ON.\n\n"
        "Watch the AND gate below. Its two input lights blink ON and OFF, "
        "and its output LED only glows when both inputs happen to be ON at "
        "the same time.",
    calloutHints: [
      "🌍 Real computers stack millions of these simple gates together to "
          "do everything from playing games to sending messages — one tiny "
          "decision at a time!",
    ],
    puzzleType: PuzzleType.circuit,
    circuit: CircuitPuzzle(
      instructions:
          "This is a real, clickable AND gate! Tap switch A and switch B "
          "to flip them between 0 and 1. Get the LED to light up, then hit "
          "Check.",
      gate: CircuitGate.and,
      explainOk:
          "You lit it up! An AND gate only glows when BOTH A and B are 1 — "
          "you just proved it with your own hands.",
      explainBad:
          "Remember, AND is strict — it only says YES when BOTH switches "
          "are ON (1). Keep flipping until both A and B show 1, then check "
          "again.",
    ),
  ),
  const Chapter(
    id: 3,
    title: 'The Truth Table Map',
    avatar: '📋',
    role: "Narrator — reading the gate keepers' rule book",
    bodyIntro:
        "Every gate keeper has a little rule book called a truth table. It "
        "lists every possible pair of switches, and what the gate says "
        "back. Here's the AND gate's whole rule book:\n\n"
        "A=0, B=0 → 0\nA=0, B=1 → 0\nA=1, B=0 → 0\nA=1, B=1 → 1\n\n"
        "See the pattern? Only the very last row — where both A and B are "
        "1 — gets a YES. Every other row gets a NO.\n\n"
        "The OR gate's rule book looks almost the same, but friendlier:\n\n"
        "A=0, B=0 → 0\nA=0, B=1 → 1\nA=1, B=0 → 1\nA=1, B=1 → 1",
    calloutHints: [
      "🍽️ Truth tables are like a menu: you look up your two switches (A "
          "and B), and the table tells you exactly what the gate will "
          "output. No guessing needed!",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these rows so the table reads top to bottom in the "
          "standard order: 00, 01, 10, 11.",
      items: [
        OrderItem('r00', 'A=0, B=0 → output 0'),
        OrderItem('r01', 'A=0, B=1 → output 0'),
        OrderItem('r10', 'A=1, B=0 → output 0'),
        OrderItem('r11', 'A=1, B=1 → output 1'),
      ],
      explainOk:
          "Perfect table! Only A=1 and B=1 together flips the AND gate's "
          "answer to 1.",
      explainBad:
          "Look closely — only the very last row, where A and B are both "
          "1, should output 1. Every other row outputs 0.",
    ),
  ),
  const Chapter(
    id: 4,
    title: 'Building an Adding Machine',
    avatar: '➕',
    role: 'Narrator — snapping gates together',
    bodyIntro:
        "Now for the fun part — snapping gate keepers together to build "
        "something useful: a tiny adding machine called a half adder! It "
        "adds two single switches, A and B, and gives us their sum.\n\n"
        "Picture two coin slots that can each only hold ONE penny. If you "
        "try to push a penny into a slot that already has one, it doesn't "
        "fit — you have to carry it over to the NEXT slot instead! That's "
        "exactly what happens in binary: 1 + 1 doesn't fit in one column, "
        "so you carry a 1 into the next column.\n\n"
        "The half adder needs two answers: a Sum bit and a Carry bit (the "
        "carried-over coin, like carrying the 1 when you add 5 + 5 = 10 by "
        "hand).\n\n"
        "Here's the trick: the Sum comes from an XOR gate (says YES when A "
        "and B are different), and the Carry comes from an AND gate (says "
        "YES only when BOTH are 1).\n\n"
        "A=0, B=0 → Sum 0, Carry 0\nA=0, B=1 → Sum 1, Carry 0\n"
        "A=1, B=0 → Sum 1, Carry 0\nA=1, B=1 → Sum 0, Carry 1 (1+1 = 10 in "
        "binary!)",
    calloutHints: [
      "🪙 When A=1 and B=1, Sum is 0 but Carry is 1 — together that reads "
          "\"10\" in binary, which is exactly 1+1=2. The half adder just "
          "did real addition with gates!",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "With A=1 and B=1: Sum = A XOR B (1 if A and B differ), Carry = "
          "A AND B (1 if both are 1). What are Sum and Carry?",
      options: [
        'Sum=1, Carry=0',
        'Sum=0, Carry=1',
        'Sum=1, Carry=1',
        'Sum=0, Carry=0',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — Sum=0, Carry=1, which together spell 1+1=2 in "
          "binary. You built a real adder out of switches!",
      explainBad:
          "A and B are both 1, so they're the SAME (XOR needs them "
          "different, so Sum=0), and both being 1 means AND fires "
          "(Carry=1). That's Sum=0, Carry=1.",
    ),
  ),
  const Chapter(
    id: 5,
    title: 'XOR — The Difference Detector',
    avatar: '⚔️',
    role: 'Narrator — comparing two switches',
    bodyIntro:
        "Meet XOR (\"exclusive OR\") — a gate that only says YES when its "
        "two inputs disagree. Picture two kids voting on pizza toppings: "
        "XOR lights up only when exactly one of them raises their hand.\n\n"
        "A=0, B=0 → 0 (same, both no)\nA=0, B=1 → 1 (different!)\n"
        "A=1, B=0 → 1 (different!)\nA=1, B=1 → 0 (same, both yes)",
    calloutHints: [
      "🔁 XOR is the \"spot the difference\" gate. You already used it "
          "inside the half adder's Sum bit back in Level 1 — now you know "
          "its name!",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click an input pair on the left, then click the XOR output it "
          "produces on the right.",
      pairs: [
        MatchPair('xor00', 'A=0, B=0', '0 (same)'),
        MatchPair('xor01', 'A=0, B=1', '1 (different)'),
        MatchPair('xor10', 'A=1, B=0', '1 (different)'),
        MatchPair('xor11', 'A=1, B=1', '0 (same)'),
      ],
      explainOk:
          "Exactly — XOR fires only when the two inputs disagree. Same "
          "inputs always give 0.",
    ),
  ),
  const Chapter(
    id: 6,
    title: 'NAND & NOR — The Universal Gates',
    avatar: '🛠️',
    role: 'Narrator — flipping a gate upside down',
    bodyIntro:
        "Take an AND gate and add a tiny bubble on its output that flips "
        "the answer — you get NAND (\"NOT AND\"). Take an OR gate and do "
        "the same — you get NOR (\"NOT OR\").\n\n"
        "A=0, B=0 → AND 0, NAND 1, OR 0, NOR 1\n"
        "A=0, B=1 → AND 0, NAND 1, OR 1, NOR 0\n"
        "A=1, B=0 → AND 0, NAND 1, OR 1, NOR 0\n"
        "A=1, B=1 → AND 1, NAND 0, OR 1, NOR 0\n\n"
        "Here's the amazing part: engineers call NAND and NOR universal "
        "gates because you can build any other gate — AND, OR, NOT, XOR, "
        "everything — using only NAND gates (or only NOR gates). Real chip "
        "factories often build entire processors this way, because it's "
        "cheaper to manufacture just one kind of gate over and over.",
    calloutHints: [
      "🏭 Fun fact: some of the very first computer chips were built "
          "almost entirely out of NAND gates, precisely because one "
          "reliable building block is easier (and cheaper) to mass-produce "
          "than five different ones.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each behavior into the gate that matches it.",
      bucketALabel: 'NAND',
      bucketBLabel: 'NOR',
      items: [
        Sort2Item('n1', 'Outputs 0 only when BOTH inputs are 1', true),
        Sort2Item('n2', 'Outputs 1 only when BOTH inputs are 0', false),
        Sort2Item('n3', 'Is an AND gate with its output flipped', true),
        Sort2Item('n4', 'Is an OR gate with its output flipped', false),
      ],
      explainOk:
          "Correct! NAND flips AND's answer, NOR flips OR's answer — both "
          "are 'universal' building blocks.",
      explainBad:
          "Remember: NAND = NOT(AND) — only 0 when both inputs are 1. NOR "
          "= NOT(OR) — only 1 when both inputs are 0.",
    ),
  ),
  const Chapter(
    id: 7,
    title: 'The Laws of Boolean Algebra',
    avatar: '📐',
    role: 'Narrator — rearranging switches like math',
    bodyIntro:
        "Just like regular math has rules (like 3 + 5 = 5 + 3), Boolean "
        "logic has its own laws you can use to rearrange gates without "
        "changing the answer:\n\n"
        "Commutative: A AND B = B AND A (order doesn't matter)\n\n"
        "Associative: (A AND B) AND C = A AND (B AND C) (grouping doesn't "
        "matter)\n\n"
        "Distributive: A AND (B OR C) = (A AND B) OR (A AND C) (you can "
        "\"spread out\" AND over an OR)\n\n"
        "Kid version of distributive: \"Give Mia (an apple OR an orange)\" "
        "is the same deal as \"(give Mia an apple) OR (give Mia an "
        "orange)\" — same fruit, just described two ways.",
    calloutHints: [
      "🧮 Engineers use these laws to rewrite a messy circuit into an "
          "equivalent one that uses fewer gates — same truth table, "
          "cheaper to build.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a law on the left, then click its matching example on "
          "the right.",
      pairs: [
        MatchPair('comm', 'Commutative', 'A AND B = B AND A'),
        MatchPair(
          'assoc',
          'Associative',
          '(A AND B) AND C = A AND (B AND C)',
        ),
        MatchPair(
          'dist',
          'Distributive',
          'A AND (B OR C) = (A AND B) OR (A AND C)',
        ),
      ],
      explainOk:
          "All matched! These three laws let engineers rearrange circuits "
          "freely without changing what they do.",
    ),
  ),
  const Chapter(
    id: 8,
    title: "De Morgan's Laws",
    avatar: '🔄',
    role: 'Narrator — flipping a whole expression inside-out',
    bodyIntro:
        "De Morgan's Laws are the single most useful trick for simplifying "
        "circuits full of NOT gates:\n\n"
        "NOT (A AND B) = (NOT A) OR (NOT B)\nNOT (A OR B) = (NOT A) AND "
        "(NOT B)\n\n"
        "Kid version: \"It is NOT (raining AND cold)\" means the exact "
        "same thing as \"it is NOT raining OR it is NOT cold.\" Flip the "
        "gate, flip both inputs, done!",
    calloutHints: [
      "🔁 Trick to remember it: when you push a NOT through parentheses, "
          "the gate inside flips (AND ↔ OR) and every input inside also "
          "gets a NOT.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Using De Morgan's Law, what is an equivalent way to write NOT "
          "(A OR B)?",
      options: [
        '(NOT A) OR (NOT B)',
        '(NOT A) AND (NOT B)',
        'A AND B',
        'A OR B',
      ],
      answerIndex: 1,
      explainOk:
          "Right! NOT(A OR B) = (NOT A) AND (NOT B) — the OR flips to AND, "
          "and both inputs get their own NOT.",
      explainBad:
          "Remember the flip: pushing NOT through an OR turns it into "
          "AND, and NOTs land on both A and B individually.",
    ),
  ),
  const Chapter(
    id: 9,
    title: 'The Full Adder — Adding With a Carry-In',
    avatar: '➕',
    role: 'Narrator — adding three bits at once',
    bodyIntro:
        "The half adder from Level 1 only handles two bits. But when you "
        "add multi-bit numbers column by column, each column might ALSO "
        "receive a carry from the column before it. That's what a full "
        "adder handles — it takes three inputs: A, B, and Cin (carry-in), "
        "and produces Sum and Cout (carry-out).\n\n"
        "Sum = A XOR B XOR Cin\nCout = majority vote of A, B, Cin (1 if "
        "two or more are 1)\n\n"
        "Chain many full adders together, each one's Cout feeding the next "
        "one's Cin, and you can add numbers of any size — that's exactly "
        "how a real CPU's adder circuit works.",
    calloutHints: [
      "🔗 A full adder is really just a half adder with one extra input — "
          "proof that big circuits are built by combining small, "
          "well-understood pieces.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A = 1, B = 1, Cin = 1. Sum = A XOR B XOR Cin. Cout = 1 if two "
          "or more inputs are 1. What are Sum and Cout?",
      options: ['Sum=1, Cout=0', 'Sum=0, Cout=1', 'Sum=1, Cout=1', 'Sum=0, Cout=0'],
      answerIndex: 1,
      explainOk:
          "Right — all three inputs are 1, so all three are 1s (majority "
          "= Cout 1), and XOR of three 1s is 1 XOR 1 XOR 1 = 0 for Sum.",
      explainBad:
          "Work it in two steps: XOR all three inputs together for Sum (1 "
          "xor 1 xor 1 = 0), then count how many of the three are 1 for "
          "Cout (all three → Cout=1).",
    ),
  ),
  const Chapter(
    id: 10,
    title: 'The Multiplexer — One Line, Many Choices',
    avatar: '📺',
    role: 'Narrator — flipping through channels',
    bodyIntro:
        "A multiplexer (MUX) is like a TV remote: it has several input "
        "channels, but only ONE \"select\" number decides which channel "
        "actually reaches the screen. A 4-input MUX needs 2 select bits "
        "(since 2 bits can pick 1 of 4 choices).\n\n"
        "Select 00 → Input 0\nSelect 01 → Input 1\nSelect 10 → Input 2\n"
        "Select 11 → Input 3",
    calloutHints: [
      "🎛️ MUXes are everywhere: a CPU uses them to choose which value "
          "flows into a circuit next, based on a tiny control signal — "
          "exactly like picking a channel.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a select code on the left, then click the input it "
          "chooses on the right.",
      pairs: [
        MatchPair('sel00', 'Select = 00', 'Input 0'),
        MatchPair('sel01', 'Select = 01', 'Input 1'),
        MatchPair('sel10', 'Select = 10', 'Input 2'),
        MatchPair('sel11', 'Select = 11', 'Input 3'),
      ],
      explainOk:
          "Perfect tuning! The select code is just a binary address "
          "pointing at which input gets through.",
    ),
  ),
  const Chapter(
    id: 11,
    title: 'The Decoder — Unlocking One Locker',
    avatar: '🔓',
    role: 'Narrator — trying locker codes',
    bodyIntro:
        "A decoder does the opposite job of a multiplexer. Feed it a 2-bit "
        "code, and it activates exactly ONE output line out of 4 — like a "
        "wall of 4 lockers where typing a code opens exactly one specific "
        "door and leaves the rest shut.\n\n"
        "Code 00 → Locker 0\nCode 01 → Locker 1\nCode 10 → Locker 2\n"
        "Code 11 → Locker 3",
    calloutHints: [
      "🏗️ Decoders are the reason a computer with only a handful of "
          "address wires can still uniquely point at millions of "
          "individual memory cells — each combination of wires opens "
          "exactly one \"locker.\"",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a code on the left, then click the locker it unlocks on "
          "the right.",
      pairs: [
        MatchPair('d00', 'Code 00', 'Locker 0 opens'),
        MatchPair('d01', 'Code 01', 'Locker 1 opens'),
        MatchPair('d10', 'Code 10', 'Locker 2 opens'),
        MatchPair('d11', 'Code 11', 'Locker 3 opens'),
      ],
      explainOk:
          "Exactly — a decoder always opens exactly one locker, matching "
          "the binary value of the code.",
    ),
  ),
  const Chapter(
    id: 12,
    title: 'The Comparator — Are They Equal?',
    avatar: '⚖️',
    role: 'Narrator — weighing two switches',
    bodyIntro:
        "Want a circuit that says \"these two bits are EQUAL\"? Combine "
        "an XOR gate (which says 1 when bits DIFFER) with a NOT gate to "
        "flip it: EQUAL = NOT (A XOR B).\n\n"
        "A=0, B=0 → XOR 0, EQUAL 1\nA=0, B=1 → XOR 1, EQUAL 0\n"
        "A=1, B=0 → XOR 1, EQUAL 0\nA=1, B=1 → XOR 0, EQUAL 1",
    calloutHints: [
      "🧮 Chain several of these equality checkers together (one per bit, "
          "then AND all the results) and you get a full multi-bit "
          "comparator — exactly what a CPU uses to check \"are these two "
          "numbers the same?\"",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "For A=0 and B=0, what does EQUAL = NOT(A XOR B) output?",
      options: ['0 — not equal', '1 — equal', 'It depends on C', 'Undefined'],
      answerIndex: 1,
      explainOk:
          "Right — A and B match (both 0), so XOR gives 0, and NOT flips "
          "it to 1, meaning EQUAL.",
      explainBad:
          "A and B are the same value here, so XOR outputs 0 (no "
          "difference), and NOT flips that 0 into a 1 — meaning EQUAL.",
    ),
  ),
  const Chapter(
    id: 13,
    title: 'Why Simplify a Circuit?',
    avatar: '💰',
    role: 'Narrator — comparing two builds',
    bodyIntro:
        "Two circuits can produce the exact same truth table while one "
        "uses 10 gates and the other uses only 3. Why does that matter? "
        "Fewer gates mean: less material to manufacture, less electricity "
        "used, less heat produced, and a faster circuit (fewer steps for a "
        "signal to travel through).",
    calloutHints: [
      "🏭 On a real chip with billions of gates, \"using 3 gates instead "
          "of 10\" repeated billions of times is the difference between a "
          "phone battery lasting a day versus an hour.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Two circuits give the identical truth table. Why would an "
          "engineer still prefer the one with fewer gates?",
      options: [
        'It looks prettier on paper',
        'Fewer gates use less power, generate less heat, and respond faster',
        'It has more colors in the diagram',
        "There is no real reason, it's just tradition",
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — power, heat, cost, and speed are all real engineering "
          "tradeoffs, not just aesthetics.",
      explainBad:
          "Think about what actually costs money and battery life on a "
          "real chip: gate count directly affects power use, heat, and "
          "speed.",
    ),
  ),
  const Chapter(
    id: 14,
    title: 'Reading a Karnaugh Map',
    avatar: '🗺️',
    role: 'Narrator — laying out a special grid',
    bodyIntro:
        "A Karnaugh map (K-map) is a truth table rearranged into a grid so "
        "that any two neighboring cells differ by only ONE bit. That "
        "neighboring trick is what makes patterns of 1s easy to spot with "
        "your eyes instead of algebra.\n\n"
        "A=0: B=0 → 0, B=1 → 1\nA=1: B=0 → 0, B=1 → 1\n\n"
        "This little grid IS the OR gate's truth table, just laid out "
        "differently — each cell is one row from the table you already "
        "know.",
    calloutHints: [
      "🧩 Every cell in a K-map corresponds to exactly one row of the "
          "truth table — nothing new is added, it's just rearranged for "
          "easier pattern-spotting.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a truth-table row on the left, then click its matching "
          "K-map position on the right.",
      pairs: [
        MatchPair('row00', 'A=0, B=0 → 0', 'Top-left cell'),
        MatchPair('row01', 'A=0, B=1 → 1', 'Top-right cell'),
        MatchPair('row10', 'A=1, B=0 → 0', 'Bottom-left cell'),
        MatchPair('row11', 'A=1, B=1 → 1', 'Bottom-right cell'),
      ],
      explainOk:
          "Exactly — every truth table row has exactly one home in the "
          "grid, arranged so neighbors differ by one bit.",
    ),
  ),
  const Chapter(
    id: 15,
    title: 'Grouping the 1s',
    avatar: '⭕',
    role: 'Narrator — circling patterns',
    bodyIntro:
        "Once your 1s are on the grid, you circle them in groups — but "
        "only certain group sizes are allowed: 1, 2, 4, 8... (always a "
        "power of two), and the cells in a group must be adjacent "
        "(touching, including wrap-around edges).",
    calloutHints: [
      "✅ A valid group of 2 or 4 lets you \"cancel out\" a variable that "
          "changes across the group — that's the whole trick behind "
          "simplification.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each grouping description into the correct bucket.",
      bucketALabel: '✅ Valid group',
      bucketBLabel: '❌ Invalid group',
      items: [
        Sort2Item('g1', 'Two adjacent cells, both containing 1', true),
        Sort2Item(
          'g2',
          'Four adjacent cells forming a 2×2 block, all 1s',
          true,
        ),
        Sort2Item(
          'g3',
          'Three cells grouped together (not a power of two)',
          false,
        ),
        Sort2Item(
          'g4',
          'Two cells that are diagonal, not touching edge-to-edge',
          false,
        ),
      ],
      explainOk:
          "Correct! Groups must be a power of two in size (1, 2, 4, 8...) "
          "and made of cells that truly touch.",
      explainBad:
          "Remember the two rules: group size must be a power of two, and "
          "cells must be adjacent (sharing an edge), not diagonal.",
    ),
  ),
  const Chapter(
    id: 16,
    title: 'From K-map to Simplified Expression',
    avatar: '✂️',
    role: 'Narrator — trimming the fat',
    bodyIntro:
        "Once you've circled a valid group, you write down only the "
        "variables that DON'T change across that group — the ones that do "
        "change just cancel out. Group the whole bottom row (A=1, both B "
        "values) and only A survives: the simplified term is just A.",
    calloutHints: [
      "🎯 This is exactly how engineers turn a messy 4-gate expression "
          "into a single-variable one — visually, without grinding "
          "through Boolean algebra by hand.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A K-map group covers the entire top row where A=0 (both B=0 "
          "and B=1 are included, both output 1). What is the simplified "
          "expression for this group?",
      options: ['A', 'NOT A', 'B', 'A AND B'],
      answerIndex: 1,
      explainOk:
          "Right! Since B changes across the group but A stays 0 the "
          "whole time, the surviving term is NOT A.",
      explainBad:
          "Whatever variable stays constant across the whole group is "
          "what survives — here A stays 0 (meaning NOT A), while B "
          "changes and cancels out.",
    ),
  ),
  const Chapter(
    id: 17,
    title: 'The SR Latch — First Memory Cell',
    avatar: '🔒',
    role: 'Narrator — building actual memory',
    bodyIntro:
        "Every gate you've met so far is combinational — its output only "
        "depends on its CURRENT inputs, with no memory of the past. The "
        "SR latch is different: it's the first circuit you'll meet that "
        "actually remembers.\n\n"
        "S=0, R=0 → Hold (remember last value)\nS=0, R=1 → Reset output to "
        "0\nS=1, R=0 → Set output to 1\nS=1, R=1 → Forbidden — avoid this!",
    calloutHints: [
      "🧠 \"Hold\" is the magic row: when both S and R are 0, the latch "
          "just keeps whatever value it last had — that's real memory, "
          "built from ordinary gates wired to feed back into each other.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click an S,R pair on the left, then click what the latch does "
          "on the right.",
      pairs: [
        MatchPair('sr00', 'S=0, R=0', 'Hold (remember)'),
        MatchPair('sr01', 'S=0, R=1', 'Reset to 0'),
        MatchPair('sr10', 'S=1, R=0', 'Set to 1'),
        MatchPair('sr11', 'S=1, R=1', 'Forbidden state'),
      ],
      explainOk:
          "Exactly — S sets it high, R resets it low, both-low holds "
          "memory, and both-high is the one state to avoid.",
    ),
  ),
  const Chapter(
    id: 18,
    title: 'Taming the Latch — The D Latch',
    avatar: '🧯',
    role: 'Narrator — fixing the forbidden state',
    bodyIntro:
        "That \"forbidden state\" (S=1, R=1) is a real design flaw. The D "
        "latch fixes it with one clever trick: use a single Data line D, "
        "and internally feed D straight into S while feeding NOT D into R. "
        "Now S and R can never both be 1 at the same time — the forbidden "
        "state is physically impossible!\n\n"
        "D=0 → internal S=0, internal R=1\nD=1 → internal S=1, internal "
        "R=0",
    calloutHints: [
      "🛡️ This is a beautiful engineering pattern: instead of just "
          "telling users \"don't do that,\" redesign the circuit so the "
          "bad state can't happen at all.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why can the D latch never reach the SR latch's forbidden state "
          "(S=1, R=1)?",
      options: [
        'Because it uses a bigger battery',
        'Because internal S and internal R are always opposite (D and NOT D), so they can never both be 1',
        "Because it doesn't have an S or R at all",
        'Because it runs slower than an SR latch',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — feeding D and NOT D into S and R guarantees they're "
          "always opposites, so both-1 is structurally impossible.",
      explainBad:
          "The key is that internal S = D and internal R = NOT D — since "
          "D and NOT D are always opposite values, S and R can never both "
          "equal 1.",
    ),
  ),
  const Chapter(
    id: 19,
    title: 'The Clock — Ticking in Sync',
    avatar: '⏰',
    role: 'Narrator — listening for the beat',
    bodyIntro:
        "Real circuits don't update memory the instant an input changes — "
        "that would cause chaos with signals racing each other. Instead, "
        "they wait for a clock signal, like a metronome for a marching "
        "band, and only update exactly when the clock \"ticks\" (usually "
        "on its rising edge, the moment it flips from 0 to 1).",
    calloutHints: [
      "🥁 \"Edge-triggered\" means the circuit only listens at that one "
          "precise instant — like a marching band stepping only on the "
          "drumbeat, not continuously drifting.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the steps of a single edge-triggered update in the "
          "order they happen.",
      items: [
        OrderItem('c1', 'Clock signal is LOW — circuit ignores input changes'),
        OrderItem('c2', 'Clock rises from 0 to 1 (the rising edge)'),
        OrderItem('c3', 'At that exact instant, the stored value updates'),
        OrderItem(
          'c4',
          'Clock stays HIGH, then falls back to 0 — circuit waits again',
        ),
      ],
      explainOk:
          "That's the rhythm! Wait, tick, update, wait again — the clock "
          "keeps every part of the circuit in sync.",
      explainBad:
          "The circuit only updates at the RISING edge (0→1) of the "
          "clock — everything else is just waiting.",
    ),
  ),
  const Chapter(
    id: 20,
    title: 'The JK Flip-Flop — Toggle Mode',
    avatar: '🔁',
    role: 'Narrator — flipping instead of forbidding',
    bodyIntro:
        "The JK flip-flop looks a lot like an SR latch (J acts like Set, "
        "K acts like Reset) — but it fixes the forbidden state differently "
        "and more cleverly than the D latch: when J=1 and K=1, instead of "
        "being forbidden, the output simply toggles (flips to the "
        "opposite of whatever it currently is)!\n\n"
        "J=0, K=0 → Hold\nJ=0, K=1 → Reset to 0\nJ=1, K=0 → Set to 1\n"
        "J=1, K=1 → Toggle (flip current value)",
    calloutHints: [
      "🎛️ JK flip-flops are the building block behind binary counters — "
          "wire the toggle mode to a clock and you get a bit that flips "
          "every single tick.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A JK flip-flop currently holds the value 1. J=1 and K=1, and "
          "the clock ticks once. What is the new value?",
      options: [
        'Stays 1',
        'Becomes 0',
        'Becomes forbidden/undefined',
        'Becomes 2',
      ],
      answerIndex: 1,
      explainOk:
          "Right — J=1,K=1 means TOGGLE, so a stored 1 flips to 0 on the "
          "next clock tick.",
      explainBad:
          "J=1 and K=1 means the flip-flop TOGGLES — it flips to the "
          "opposite of its current value. Since it was 1, it becomes 0.",
    ),
  ),
  const Chapter(
    id: 21,
    title: 'Registers — A Row of Memory Cells',
    avatar: '🗃️',
    role: 'Narrator — lining up flip-flops',
    bodyIntro:
        "Line up several flip-flops side by side, all sharing the same "
        "clock, and you get a register — a small storage shelf that holds "
        "multiple bits together as one unit (say, 8 flip-flops = one "
        "8-bit register). This is exactly the kind of tiny, "
        "lightning-fast storage a CPU keeps right next to its own "
        "circuits.",
    calloutHints: [
      "🔗 One flip-flop stores one bit. A register is just a group of "
          "them updated together — the same \"combine simple pieces\" "
          "idea you saw with the full adder.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click its definition on the "
          "right.",
      pairs: [
        MatchPair('ff', 'Flip-flop', 'Stores exactly one bit'),
        MatchPair(
          'reg',
          'Register',
          'A group of flip-flops storing many bits as one unit',
        ),
        MatchPair(
          'clk',
          'Shared clock',
          'Makes every flip-flop in the register update together',
        ),
      ],
      explainOk:
          "Exactly right — a register is just several 1-bit memories "
          "wired to the same clock so they act as one unit.",
    ),
  ),
  const Chapter(
    id: 22,
    title: 'Shift Registers — Passing Bits Down the Line',
    avatar: '🚌',
    role: 'Narrator — running a bucket brigade',
    bodyIntro:
        "A shift register is a chain of flip-flops where, on every clock "
        "tick, each one passes its stored bit to its neighbor — like a "
        "bucket brigade passing water buckets down a line. One new bit "
        "enters at the front each tick, and the oldest bit falls off the "
        "end.\n\n"
        "Start: 1 0 1 1\nAfter tick: X 1 0 1 (new bit X enters, rightmost "
        "1 falls off)",
    calloutHints: [
      "📡 Shift registers are how old serial connections sent data one "
          "bit at a time down a single wire, then reassembled the bits "
          "back into a byte at the other end.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Starting register = 1 0 1 1. A new bit '0' shifts in from the "
          "left each tick. Arrange these states in the order they occur "
          "over 3 ticks.",
      items: [
        OrderItem('t0', 'Start: 1 0 1 1'),
        OrderItem('t1', 'After tick 1: 0 1 0 1'),
        OrderItem('t2', 'After tick 2: 0 0 1 0'),
        OrderItem('t3', 'After tick 3: 0 0 0 1'),
      ],
      explainOk:
          "Perfect trace! Each tick, a fresh 0 enters on the left and the "
          "rightmost bit is pushed off.",
      explainBad:
          "Each tick shifts every bit one spot to the right, drops the "
          "rightmost bit, and inserts the new bit on the left.",
    ),
  ),
  const Chapter(
    id: 23,
    title: 'Synchronous Counters — Counting Together',
    avatar: '🔢',
    role: 'Narrator — counting in step',
    bodyIntro:
        "A synchronous counter is a register where every flip-flop shares "
        "the exact same clock, and the whole thing counts upward in "
        "binary on every tick: 000, 001, 010, 011, 100...",
    calloutHints: [
      "⏱️ \"Synchronous\" means all bits update at the same instant, "
          "which keeps counting fast and predictable — this is exactly "
          "how a CPU's internal program counter advances.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these counter values in the correct counting order, "
          "starting from 000.",
      items: [
        OrderItem('v0', '000'),
        OrderItem('v1', '001'),
        OrderItem('v2', '010'),
        OrderItem('v3', '011'),
        OrderItem('v4', '100'),
      ],
      explainOk:
          "That's binary counting in action — each tick adds exactly 1, "
          "just like the switch math from Level 1!",
      explainBad:
          "Count in plain binary: 000, 001, 010, 011, 100 — each step "
          "adds exactly one, carrying just like decimal counting.",
    ),
  ),
  const Chapter(
    id: 24,
    title: 'Asynchronous (Ripple) Counters',
    avatar: '🌊',
    role: 'Narrator — watching a delay ripple through',
    bodyIntro:
        "An asynchronous (ripple) counter skips the shared clock trick — "
        "instead, each flip-flop is triggered by the PREVIOUS flip-flop's "
        "output. It's simpler and cheaper to wire, but there's a catch: "
        "since each flip-flop reacts slightly after the one before it, a "
        "change has to \"ripple\" through the whole chain, taking longer "
        "to settle on the final correct value than a synchronous "
        "counter.",
    calloutHints: [
      "⚖️ This is a real engineering tradeoff: ripple counters are "
          "simpler and use less wiring, but synchronous counters are "
          "faster and more predictable — bigger, faster chips almost "
          "always choose synchronous designs.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each fact into the counter type it describes.",
      bucketALabel: 'Synchronous',
      bucketBLabel: 'Asynchronous (Ripple)',
      items: [
        Sort2Item('f1', 'All flip-flops share exactly the same clock signal', true),
        Sort2Item(
          'f2',
          "Each flip-flop is triggered by the previous one's output",
          false,
        ),
        Sort2Item(
          'f3',
          'Faster and more predictable, used in most modern chips',
          true,
        ),
        Sort2Item(
          'f4',
          "Simpler wiring, but delay 'ripples' through the chain",
          false,
        ),
      ],
      explainOk:
          "Correct! Synchronous = shared clock, fast and predictable. "
          "Asynchronous = chained triggers, simpler but slower to settle.",
      explainBad:
          "Synchronous counters share one clock (fast, predictable). "
          "Ripple counters chain triggers one flip-flop to the next "
          "(simpler, but slower to settle).",
    ),
  ),
  const Chapter(
    id: 25,
    title: 'Binary, Decimal, and Hex',
    avatar: '🔡',
    role: 'Narrator — switching number costumes',
    bodyIntro:
        "The same value can be written in different number systems. "
        "Hexadecimal (\"hex\") is base 16, using digits 0-9 then A-F for "
        "10-15. Programmers love hex because exactly 4 binary bits (a "
        "\"nibble\") map to exactly 1 hex digit — a much shorter way to "
        "write long binary numbers.\n\n"
        "0000 → 0\n0101 → 5\n1010 → A\n1111 → F",
    calloutHints: [
      "🎨 You've probably already seen hex without knowing it — web "
          "colors like #FF6B6B are just hex numbers describing red, "
          "green, and blue amounts!",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a binary nibble on the left, then click its hex digit on "
          "the right.",
      pairs: [
        MatchPair('n0000', '0000', '0'),
        MatchPair('n0101', '0101', '5'),
        MatchPair('n1010', '1010', 'A'),
        MatchPair('n1111', '1111', 'F'),
      ],
      explainOk:
          "Exactly — one hex digit always packs exactly 4 binary bits, no "
          "more, no less.",
    ),
  ),
  const Chapter(
    id: 26,
    title: "Two's Complement — Negative Numbers in Binary",
    avatar: '➖',
    role: 'Narrator — inventing negative switches',
    bodyIntro:
        "Bits can only be 0 or 1 — so how does a computer represent "
        "NEGATIVE numbers? The answer almost every computer uses is two's "
        "complement: to negate a number, flip every bit, then add 1.\n\n"
        "0000 0101 = 5\n1111 1010 (flip every bit)\n+ 0000 0001 (add 1)\n"
        "= 1111 1011 = -5 in two's complement\n\n"
        "Why go through this trouble instead of just using a \"sign "
        "bit\"? Because two's complement lets the SAME adder circuit "
        "handle both addition and subtraction — no special case needed!",
    calloutHints: [
      "🔧 This is a gorgeous piece of engineering: one design decision "
          "(flip-and-add-1) means a chip needs one adder circuit instead "
          "of two separate ones.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What is the main engineering benefit of representing negative "
          "numbers with two's complement?",
      options: [
        'It makes numbers look prettier',
        'It lets the same adder circuit handle both addition and subtraction, with no special-case hardware',
        'It only works for even numbers',
        'It uses fewer bits than any other method',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — one adder circuit can now do subtraction too, just "
          "by adding a negative (two's complement) number.",
      explainBad:
          "The real win is hardware simplicity: with two's complement, "
          "subtraction becomes 'add a negative number,' so no separate "
          "subtractor circuit is needed.",
    ),
  ),
  const Chapter(
    id: 27,
    title: 'The Binary Adder-Subtractor',
    avatar: '🔀',
    role: 'Narrator — one circuit, two jobs',
    bodyIntro:
        "Combine a chain of full adders with a row of XOR gates on the B "
        "inputs, controlled by one \"subtract?\" control wire, and you get "
        "a circuit that adds OR subtracts using the exact same "
        "hardware:\n\n"
        "Control = 0: B passes through unchanged → normal addition\n\n"
        "Control = 1: every B bit gets flipped by XOR, and a 1 is fed "
        "into the first carry-in → this produces two's complement of B, "
        "so the adder computes A + (-B) = A - B",
    calloutHints: [
      "🎩 This is the same trick from Chapter XXVI, wired directly into "
          "hardware: \"flip and add 1\" becomes \"flip with XOR gates and "
          "feed in a carry of 1.\"",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the steps the adder-subtractor takes to compute A − B.",
      items: [
        OrderItem('s1', 'Control wire is set to 1 (subtract mode)'),
        OrderItem(
          's2',
          'Every bit of B passes through an XOR gate and gets flipped',
        ),
        OrderItem('s3', 'A carry-in of 1 is fed into the first full adder'),
        OrderItem(
          's4',
          'The adder chain computes A + (flipped B + 1), which equals A − B',
        ),
      ],
      explainOk:
          "That's it — flipping B and adding 1 turns it into -B, so the "
          "SAME adder chain performs real subtraction.",
      explainBad:
          "Order matters: first set control=1, then flip B's bits, then "
          "inject the +1 carry, and only then does the adder chain "
          "produce A−B.",
    ),
  ),
  const Chapter(
    id: 28,
    title: "Overflow — When the Answer Doesn't Fit",
    avatar: '🚨',
    role: 'Narrator — watching numbers wrap around',
    bodyIntro:
        "A register only has a fixed number of bits. An 8-bit register "
        "can only hold values from -128 to 127 (in two's complement) or 0 "
        "to 255 (unsigned). Add past that limit and the answer overflows "
        "— it silently wraps around to a wrong-looking number instead of "
        "growing bigger.\n\n"
        "0111 1111 (127, the largest signed 8-bit number)\n"
        "+ 0000 0001 (adding 1)\n"
        "= 1000 0000 (this LOOKS like -128 in two's complement!)",
    calloutHints: [
      "🐛 Real bugs happen this way: a counter that keeps incrementing "
          "can silently overflow and wrap to a negative number, breaking "
          "logic that assumed it would always be positive and growing.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "An 8-bit signed register holds 127 (the maximum). Software "
          "adds 1 to it. What actually happens?",
      options: [
        'It correctly becomes 128',
        'It overflows and wraps around to -128, even though no error was raised',
        'The computer automatically adds more bits',
        'Nothing happens, the value stays 127',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — this is classic signed-integer overflow, a "
          "real source of production bugs when limits aren't checked.",
      explainBad:
          "127 is the largest value 8 signed bits can hold — adding 1 "
          "overflows and silently wraps to -128, not a clean 128.",
    ),
  ),
  const Chapter(
    id: 29,
    title: 'What Is a State Machine?',
    avatar: '🚦',
    role: 'Narrator — watching a traffic light cycle',
    bodyIntro:
        "A finite state machine (FSM) is a system that's always in "
        "exactly one \"state,\" and moves between states based on "
        "triggers. A traffic light is the classic example: it's always "
        "Red, Green, or Yellow (never two at once), and it cycles through "
        "them in a fixed order.\n\n"
        "Red → Green → Yellow → Red → Green → ...",
    calloutHints: [
      "🎮 Video game characters are FSMs too: \"Idle,\" \"Walking,\" "
          "\"Jumping,\" and \"Attacking\" are all states, and pressing "
          "buttons are the triggers that move between them.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the traffic light's states in the order they actually "
          "cycle.",
      items: [
        OrderItem('red', '🔴 Red — stop'),
        OrderItem('green', '🟢 Green — go'),
        OrderItem('yellow', '🟡 Yellow — slow down'),
      ],
      explainOk:
          "That's the cycle! Red leads to Green, Green leads to Yellow, "
          "and Yellow leads back to Red.",
      explainBad:
          "A traffic light always follows Red → Green → Yellow → back to "
          "Red, never skipping or reversing.",
    ),
  ),
  const Chapter(
    id: 30,
    title: 'Moore Machines — Output Depends Only on State',
    avatar: '🎯',
    role: 'Narrator — watching the light itself',
    bodyIntro:
        "In a Moore machine, the output IS the current state — nothing "
        "else matters. The traffic light is a perfect Moore machine: the "
        "color you see (the output) is completely determined by which "
        "state (Red/Green/Yellow) it's currently in, regardless of any "
        "other input.",
    calloutHints: [
      "💡 If you can answer \"what does it output right now?\" using "
          "ONLY the current state (no need to know what just happened), "
          "you're looking at a Moore machine.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click its Moore-machine "
          "description on the right.",
      pairs: [
        MatchPair('output', 'Output', 'Determined entirely by the current state'),
        MatchPair('example', 'Traffic light', 'A classic Moore machine example'),
        MatchPair(
          'trigger',
          'Trigger/input',
          'Only decides which state comes NEXT, not the current output',
        ),
      ],
      explainOk:
          "Exactly — in a Moore machine, the state alone tells you the "
          "output; inputs only affect the future state.",
    ),
  ),
  const Chapter(
    id: 31,
    title: 'Mealy Machines — Output Depends on State AND Input',
    avatar: '🥤',
    role: 'Narrator — watching a vending machine',
    bodyIntro:
        "A Mealy machine is trickier: its output depends on BOTH the "
        "current state AND the current input, and can change instantly — "
        "even before the state itself changes. A vending machine is a "
        "good example: while in the \"waiting for money\" state, "
        "inserting a coin can immediately trigger a \"dispense change\" "
        "output, without first moving through some other state.",
    calloutHints: [
      "⚡ Mealy machines often react one step faster than Moore machines, "
          "because the output can respond to the input immediately, not "
          "just after a state change.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each example into the machine type it best matches.",
      bucketALabel: 'Moore-like',
      bucketBLabel: 'Mealy-like',
      items: [
        Sort2Item(
          'm1',
          "A traffic light's color, fixed by which state it's in",
          true,
        ),
        Sort2Item(
          'm2',
          'A vending machine that beeps the instant a wrong coin is inserted',
          false,
        ),
        Sort2Item(
          'm3',
          "An elevator's floor display, showing only the current floor state",
          true,
        ),
        Sort2Item(
          'm4',
          'A game character that reacts to a button press instantly, before its animation state updates',
          false,
        ),
      ],
      explainOk:
          "Correct! Moore-like = output tied purely to state. Mealy-like "
          "= output reacts instantly to input too.",
      explainBad:
          "Ask: does the output only depend on the CURRENT STATE (Moore), "
          "or can it react immediately to an INPUT too (Mealy)?",
    ),
  ),
  const Chapter(
    id: 32,
    title: 'Fewer States, Same Behavior',
    avatar: '🗜️',
    role: 'Narrator — merging identical twins',
    bodyIntro:
        "Sometimes an FSM design has two states that, despite having "
        "different names, behave IDENTICALLY for every possible future "
        "input — they always produce the same outputs and transition to "
        "equivalent states no matter what happens next. State "
        "minimization is the process of finding and merging these "
        "\"twin\" states, shrinking the machine without changing its "
        "behavior at all.",
    calloutHints: [
      "🎯 This is the FSM version of the same idea from Level 4's "
          "K-maps: simplify the design, but keep the exact same "
          "observable behavior.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Two states in an FSM have different names. Under what "
          "condition can they be safely merged into one state?",
      options: [
        'If they happen to have similar-sounding names',
        'If, for every possible future input, they always produce the same output and move to equivalent states',
        'If the diagram just looks too big',
        'States can never be merged',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — true behavioral equivalence for all future inputs is "
          "the only safe condition for merging states.",
      explainBad:
          "Merging is only safe if the two states are truly "
          "indistinguishable from the outside — same output and same "
          "future behavior for every possible input.",
    ),
  ),
  const Chapter(
    id: 33,
    title: 'Inside a RAM Cell',
    avatar: '🧱',
    role: 'Narrator — touring a memory chip',
    bodyIntro:
        "A single RAM (Random Access Memory) cell is, at its heart, just "
        "one tiny latch storing one bit — wired up to a \"word line\" "
        "(which row to activate) and a \"bit line\" (which carries the "
        "actual 0/1 value in or out). Millions of these cells are "
        "arranged in a grid, and a decoder picks exactly one row and "
        "column to read or write.",
    calloutHints: [
      "🔗 Everything connects: RAM is just latches addressed by decoders "
          "— big memory chips are small ideas, repeated at massive "
          "scale.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click its job on the right.",
      pairs: [
        MatchPair('cell', 'Memory cell', 'Stores exactly one bit, built from a latch'),
        MatchPair('wordline', 'Word line', 'Selects which row of cells is active'),
        MatchPair('bitline', 'Bit line', 'Carries the actual 0/1 value in or out'),
      ],
      explainOk:
          "Exactly — one tiny latch per bit, addressed by word lines and "
          "bit lines arranged in a grid.",
    ),
  ),
  const Chapter(
    id: 34,
    title: 'ROM — Memory That Survives Being Unplugged',
    avatar: '💾',
    role: 'Narrator — comparing two kinds of memory',
    bodyIntro:
        "RAM is volatile — unplug the power and everything stored in it "
        "vanishes instantly. ROM (Read-Only Memory) is non-volatile — it "
        "keeps its contents even with no power at all, which is exactly "
        "why a computer's very first startup instructions (firmware) "
        "live in ROM, not RAM: something has to survive being switched "
        "off in order to boot the computer back up!",
    calloutHints: [
      "🔌 This connects straight to the OS's boot sequence: the very "
          "first thing a computer's boot sequence reads comes from "
          "ROM/firmware, before RAM even has power flowing through it "
          "properly.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each fact into the memory type it describes.",
      bucketALabel: 'RAM',
      bucketBLabel: 'ROM',
      items: [
        Sort2Item('r1', 'Loses all its data the instant power is cut', true),
        Sort2Item('r2', 'Keeps its contents even with zero power', false),
        Sort2Item(
          'r3',
          'Used for fast, constantly-changing working memory',
          true,
        ),
        Sort2Item(
          'r4',
          "Stores a computer's very first boot instructions",
          false,
        ),
      ],
      explainOk:
          "Correct! RAM = fast but volatile working memory. ROM = slower "
          "but survives power loss, perfect for boot firmware.",
      explainBad:
          "RAM forgets everything when powered off (volatile). ROM "
          "remembers even unplugged (non-volatile) — that's why boot "
          "firmware lives there.",
    ),
  ),
  const Chapter(
    id: 35,
    title: "The Register File — A CPU's Tiny Desk",
    avatar: '🗂️',
    role: "Narrator — visiting the CPU's own desk drawer",
    bodyIntro:
        "A CPU keeps a very small number of registers (often just 16 or "
        "32) right inside itself — its own tiny \"desk drawer\" of "
        "storage, addressed by a tiny 4-5 bit address (a MUX and decoder "
        "combo) instead of the huge address bus that RAM needs. Because "
        "they're so small and so close to the processing circuits, "
        "registers are the fastest storage a computer has.",
    calloutHints: [
      "🏎️ Speed vs size tradeoff: a register file might hold only 128 "
          "bytes total, but accessing it can be 100x+ faster than "
          "accessing RAM — that's why compilers work so hard to keep "
          "frequently-used values in registers.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why can a CPU's register file be accessed so much faster than "
          "main RAM?",
      options: [
        'Registers are magic and have no real explanation',
        'There are very few of them, they sit physically right inside the CPU, and need only a tiny address decoder',
        'Registers use a completely different, faster kind of electricity',
        'RAM is intentionally slowed down by the manufacturer',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — small count, tiny decoder, and physical closeness to "
          "the CPU's own circuits all add up to huge speed gains.",
      explainBad:
          "It's about physical distance and scale: a handful of "
          "registers sitting right inside the CPU, addressed by a tiny "
          "decoder, will always beat a huge, physically farther RAM "
          "array.",
    ),
  ),
  const Chapter(
    id: 36,
    title: 'Memory Hierarchy — Why Not Just Use One Kind?',
    avatar: '🏗️',
    role: 'Narrator — stacking storage like a pyramid',
    bodyIntro:
        "No single memory technology is fast, huge, AND cheap all at once "
        "— so real computers stack several kinds together in a memory "
        "hierarchy:\n\n"
        "Registers → tiniest, fastest, most expensive per byte\n"
        "Cache → small, very fast\nRAM → medium size, medium speed\n"
        "Disk/SSD → huge, slow, cheapest per byte",
    calloutHints: [
      "🎯 The goal: keep the data you need RIGHT NOW in the fast-but-tiny "
          "layers, and only reach into the slow-but-huge layers when you "
          "truly have to.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these storage types from FASTEST/smallest to "
          "SLOWEST/largest.",
      items: [
        OrderItem('reg', 'Registers'),
        OrderItem('cache', 'Cache'),
        OrderItem('ram', 'RAM'),
        OrderItem('disk', 'Disk / SSD'),
      ],
      explainOk:
          "Exactly right — registers are fastest and tiniest, disk is "
          "slowest and hugest, with cache and RAM in between.",
      explainBad:
          "Think speed vs size tradeoff: Registers (fastest, tiniest) → "
          "Cache → RAM → Disk (slowest, hugest).",
    ),
  ),
  const Chapter(
    id: 37,
    title: 'Designing a Mini ALU',
    avatar: '🧮',
    role: 'Narrator — assembling a real CPU core piece',
    bodyIntro:
        "Every CPU has an ALU (Arithmetic Logic Unit) — a circuit that "
        "can perform several different operations (ADD, AND, OR...) on "
        "the same two inputs, and uses a MUX controlled by an \"opcode\" "
        "to select which result actually gets passed through to the "
        "output.\n\n"
        "Opcode 00 → A + B (from an adder circuit)\nOpcode 01 → A AND B\n"
        "Opcode 10 → A OR B\nOpcode 11 → A XOR B",
    calloutHints: [
      "🏗️ This is the same MUX idea at the heart of every processor ever "
          "built: run several circuits in parallel, then use a MUX to "
          "choose which answer to keep, based on a tiny control code.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click an opcode on the left, then click the operation it "
          "selects on the right.",
      pairs: [
        MatchPair('op00', 'Opcode 00', 'A + B (addition)'),
        MatchPair('op01', 'Opcode 01', 'A AND B'),
        MatchPair('op10', 'Opcode 10', 'A OR B'),
        MatchPair('op11', 'Opcode 11', 'A XOR B'),
      ],
      explainOk:
          "Correct — you just wired up a real, simplified ALU selection "
          "scheme using nothing but a MUX and an opcode.",
    ),
  ),
  const Chapter(
    id: 38,
    title: 'Timing Hazards & Glitches',
    avatar: '⚡',
    role: 'Narrator — catching a circuit mid-flicker',
    bodyIntro:
        "Every real gate has a tiny propagation delay — it takes a few "
        "nanoseconds for a signal change to travel through it. If a "
        "circuit has two different paths of DIFFERENT lengths that both "
        "feed into the same later gate, the signals can arrive at "
        "slightly different times, causing a brief, incorrect \"glitch\" "
        "output before everything settles to the correct final value.",
    calloutHints: [
      "🐛 This is a genuinely real production concern — chip designers "
          "run timing analysis tools specifically to hunt for these "
          "hazards before manufacturing, because a glitch that gets "
          "sampled by a flip-flop at the wrong instant becomes a real "
          "bug.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What is the root cause of a timing hazard (a brief incorrect "
          "glitch) in a combinational circuit?",
      options: [
        'The circuit is simply broken and needs to be replaced',
        'Signals traveling through paths of different lengths (different gate delays) arrive at a shared gate at slightly different times',
        'Too many colors were used in the circuit diagram',
        'The power supply is too strong',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — mismatched path delays reconverging at one gate is "
          "the classic cause of a timing hazard.",
      explainBad:
          "Look for a race between paths: if two paths of different "
          "lengths (different delay) reconverge at the same gate, a brief "
          "wrong output can appear before things settle.",
    ),
  ),
  const Chapter(
    id: 39,
    title: 'Critical Path & Propagation Delay',
    avatar: '🏁',
    role: 'Narrator — finding the slowest road',
    bodyIntro:
        "A circuit's critical path is its single SLOWEST route from "
        "input to output — the longest total propagation delay through "
        "any chain of gates. This one number directly determines the "
        "fastest possible clock speed the whole circuit can run at: the "
        "clock can't tick faster than the critical path takes to settle, "
        "or you'd be reading not-yet-correct values.",
    calloutHints: [
      "🎯 This is exactly why \"clock speed\" (GHz) has a real physical "
          "limit — shrink the critical path (fewer gates, shorter wires) "
          "and you can legitimately run the chip faster.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A circuit has three possible signal paths from input to "
          "output: Path A takes 4ns through 2 gates, Path B takes 12ns "
          "through 4 gates, and Path C takes 7ns through 3 gates. What "
          "sets this circuit's maximum clock speed?",
      options: [
        "Path A (4ns) — it's the shortest",
        'Path B (12ns) — the critical path is the SLOWEST path, and the clock can\'t tick faster than it settles',
        'The average of all three paths',
        'Path C (7ns), since it has a middle value',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — the critical path is always the SLOWEST path, "
          "since the whole circuit must wait for it to settle before the "
          "next clock tick is safe.",
      explainBad:
          "The critical path is the SLOWEST path, not the fastest or the "
          "average — here that's Path B at 12ns, and it alone caps the "
          "maximum safe clock speed.",
    ),
  ),
  const Chapter(
    id: 40,
    title: 'The Final Circuit — Professional Knowledge Check',
    avatar: '🏆',
    role: 'Narrator — the last gate in Logic Land',
    bodyIntro:
        "You've gone from flipping a single switch to reasoning about "
        "ALUs, memory hierarchies, and timing hazards — real "
        "digital-design thinking. One last integrative scenario before "
        "Logic Land's Shard is yours.",
    calloutHints: [
      "🧠 Real interview-style question: combine what you know about "
          "critical paths with clock cycles to reason about an actual "
          "chip design tradeoff.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A chip's critical path is 12ns through 4 gates. A design team "
          "removes one gate from that specific path by combining two "
          "gates into one custom gate, and the new critical path becomes "
          "8ns. What is the DIRECT engineering consequence of this "
          "change?",
      options: [
        'Nothing changes — clock speed is unrelated to critical path',
        'The chip can now safely run at a faster clock speed, since the clock only needs to wait 8ns instead of 12ns per cycle',
        'The chip will now use more power with no benefit',
        "The chip's memory capacity increases",
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — shortening the critical path directly allows "
          "a faster safe clock speed, since each cycle only needs to wait "
          "for the new, shorter worst-case delay. Logic Land's Shard is "
          "restored!",
      explainBad:
          "Trace the cause and effect: the clock period must be at least "
          "as long as the critical path. Shrink the critical path from "
          "12ns to 8ns, and the safe clock period shrinks too — meaning "
          "a faster clock speed becomes possible.",
    ),
  ),
  const Chapter(
    id: 41,
    title: 'FPGA vs ASIC — Reconfigurable or Set in Silicon',
    avatar: '🧩',
    role: 'Narrator — touring two very different fabs',
    bodyIntro:
        "You've designed a circuit. Now you have to actually ship it. Two "
        "very different paths lead to production silicon, and picking "
        "the wrong one can sink a product: an FPGA (Field-Programmable "
        "Gate Array) is a chip made of thousands of reconfigurable logic "
        "blocks and routing switches that you program AFTER "
        "manufacturing — like buying a giant box of pre-made LEGO gates "
        "and wiring them however you want, as many times as you want. An "
        "ASIC (Application-Specific Integrated Circuit) is custom "
        "silicon, laid out gate-by-gate and etched permanently at a fab "
        "— no rewiring, ever, after it's manufactured.\n\n"
        "FPGA: low NRE cost (~\$0), high unit cost, weeks to market, "
        "worse power/perf, reprogrammable in the field.\n"
        "ASIC: high NRE cost (\$1M-\$50M+ mask costs), very low unit cost "
        "at volume, 6-24 months to market (tape-out + fab), best "
        "power/perf, frozen in silicon forever.\n\n"
        "The real decision is a break-even volume calculation: at low "
        "volumes, the FPGA's zero NRE (non-recurring engineering) cost "
        "wins. At high volumes, the ASIC's tiny per-unit cost wins, "
        "because you're dividing that huge mask/fab cost across millions "
        "of units.",
    calloutHints: [
      "🚀 This is why a startup validating a new network-switch design "
          "ships FPGAs first — bugs found post-shipment are just a "
          "firmware reflash. Only once the design is proven and volume is "
          "guaranteed does the company commit to an ASIC tape-out, "
          "because an ASIC bug found after fabrication means throwing "
          "away the whole mask set and starting over.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each production fact into the chip type it describes.",
      bucketALabel: 'FPGA',
      bucketBLabel: 'ASIC',
      items: [
        Sort2Item(
          'fa1',
          'Near-zero up-front engineering cost, high cost per chip',
          true,
        ),
        Sort2Item(
          'fa2',
          'Multi-million dollar mask/tape-out cost, tiny cost per chip at volume',
          false,
        ),
        Sort2Item(
          'fa3',
          'A firmware bug can be fixed with a field reprogram',
          true,
        ),
        Sort2Item(
          'fa4',
          'A logic bug found after fabrication means scrapping the whole run',
          false,
        ),
      ],
      explainOk:
          "Correct! FPGAs trade higher per-unit cost for near-zero NRE "
          "and field reprogrammability. ASICs trade huge up-front cost "
          "for the lowest possible per-unit cost and best performance at "
          "volume.",
      explainBad:
          "Think about WHEN the cost hits: FPGA cost is spread per-chip "
          "(reprogrammable, forgiving). ASIC cost is a huge one-time mask "
          "investment (frozen, unforgiving) that only pays off at scale.",
    ),
  ),
  const Chapter(
    id: 42,
    title: 'Verilog & VHDL — Describing Hardware, Not Software',
    avatar: '📜',
    role: "Narrator — reading a blueprint that isn't a program",
    bodyIntro:
        "A Hardware Description Language (HDL) — the two industry "
        "standards are Verilog and VHDL — looks like code, but it "
        "describes real, physical, parallel hardware, not a sequential "
        "program. The single biggest mental trap for engineers coming "
        "from software: every line inside a hardware block doesn't "
        "\"run in order\" — it describes wires and logic that all exist "
        "and react simultaneously.\n\n"
        "An HDL design is fed into a synthesis tool, which converts the "
        "abstract description into an actual netlist of real gates and "
        "flip-flops — the same AND/OR/flip-flop primitives you've met "
        "throughout Logic Land, just generated automatically instead of "
        "hand-placed. A separate testbench (also written in the HDL) "
        "simulates the design against known inputs before a single "
        "transistor is ever fabricated, because fixing a bug in "
        "simulation costs minutes — fixing the same bug after tape-out "
        "costs months and millions of dollars.",
    calloutHints: [
      "⚠️ The blocking assignment (=) and non-blocking assignment (<=) "
          "in Verilog aren't stylistic — using = instead of <= inside a "
          "clocked block is one of the most common real bugs new "
          "hardware engineers write, because it changes whether updates "
          "appear to happen \"immediately\" or \"at the next clock edge,\" "
          "which changes what hardware actually gets generated.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click what it does on the "
          "right.",
      pairs: [
        MatchPair(
          'hdl1',
          'Synthesis',
          'Converts the HDL description into real gates and flip-flops',
        ),
        MatchPair(
          'hdl2',
          'Testbench',
          'Simulates the design against known inputs before fabrication',
        ),
        MatchPair(
          'hdl3',
          'always @(posedge clk)',
          "Describes logic that updates on the clock's rising edge",
        ),
        MatchPair(
          'hdl4',
          'Non-blocking assignment (<=)',
          'Update takes effect at the next clock edge, matching real flip-flop behavior',
        ),
      ],
      explainOk:
          "Exactly — HDL isn't a sequential program, it's a blueprint for "
          "real parallel hardware that a synthesis tool turns into "
          "gates.",
    ),
  ),
  const Chapter(
    id: 43,
    title: 'Pipelining Hazards — When the Assembly Line Jams',
    avatar: '🚧',
    role: 'Narrator — watching a real 5-stage pipeline jam',
    bodyIntro:
        "A classic 5-stage pipeline (Fetch, Decode, Execute, Memory, "
        "Write-back) runs multiple instructions overlapped, one per "
        "stage, every cycle — like an assembly line. It's fast, until "
        "one of three real hazards jams the line:\n\n"
        "Structural hazard — two instructions need the SAME hardware "
        "resource at the same time (e.g. both need the one memory port "
        "this cycle).\n\n"
        "Data hazard — an instruction needs a value that a previous, "
        "still-in-flight instruction hasn't produced yet (a RAW: "
        "read-after-write dependency).\n\n"
        "Control hazard — a branch instruction hasn't resolved yet, so "
        "the pipeline doesn't actually know which instruction to fetch "
        "next.\n\n"
        "Real hardware fixes each differently: structural hazards are "
        "fixed by adding more hardware ports/buffers; data hazards are "
        "fixed by forwarding (bypassing the just-computed value directly "
        "from EXECUTE to the next instruction's input, skipping the "
        "write-back wait) or by stalling when forwarding isn't possible; "
        "control hazards are fixed by branch prediction so the pipeline "
        "can guess and keep going instead of stalling on every single "
        "branch.",
    calloutHints: [
      "🐢 A pipeline that stalls on every hazard degrades toward the "
          "speed of a non-pipelined design — the entire point of "
          "forwarding and prediction hardware is to keep the assembly "
          "line moving without waiting for every dependency to fully "
          "resolve.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a hazard on the left, then click its real hardware fix "
          "on the right.",
      pairs: [
        MatchPair(
          'hz1',
          'Structural hazard (resource conflict)',
          'Add more hardware ports/buffers',
        ),
        MatchPair(
          'hz2',
          'Data hazard (RAW dependency)',
          'Forward the value directly from EXECUTE, or stall',
        ),
        MatchPair(
          'hz3',
          'Control hazard (branch unresolved)',
          'Predict the branch direction and speculatively continue',
        ),
      ],
      explainOk:
          "Exactly — each hazard type gets a targeted fix: more "
          "resources, forwarding/stalling, or branch prediction.",
    ),
  ),
  const Chapter(
    id: 44,
    title: 'Clock Domain Crossing — When Two Clocks Meet',
    avatar: '🌉',
    role: 'Narrator — building a bridge between two rhythms',
    bodyIntro:
        "A modern chip rarely runs on a single clock — a USB controller, "
        "a CPU core, and a DDR memory controller often each run on their "
        "OWN independent clock, at different frequencies with no fixed "
        "phase relationship. The moment a signal crosses from one clock "
        "domain into another, you have a clock domain crossing (CDC) — "
        "and it's dangerous.\n\n"
        "If a signal changes right as the destination flip-flop's clock "
        "edge arrives, the flip-flop can enter metastability — briefly "
        "settling to neither a clean 0 nor 1, an unpredictable "
        "in-between voltage that can resolve to either value, or take "
        "extra time to resolve at all, potentially propagating garbage "
        "into the rest of the circuit.",
    calloutHints: [
      "🛡️ The standard fix for a single control bit is a 2-flop "
          "synchronizer: two flip-flops in series in the destination "
          "clock domain. The first flop absorbs the metastability; by "
          "the time the signal reaches the second flop, it has had a "
          "full clock period to settle to a clean, stable value. For "
          "multi-bit buses, engineers instead use an asynchronous FIFO "
          "with gray-coded pointers, because synchronizing multiple bits "
          "independently can let them arrive at different times and "
          "momentarily form a nonsense combined value.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "An engineer tries to cross an 8-bit data bus between clock "
          "domains by putting a separate 2-flop synchronizer on each of "
          "the 8 bits independently. What's the real danger?",
      options: [
        "There's no danger — this is exactly the correct approach",
        'Different bits can resolve their metastability at slightly different times, so the receiver can briefly see a combined value that was never actually sent',
        'It uses too many flip-flops and will overheat the chip',
        '2-flop synchronizers only work on clock signals, never on data',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — independent per-bit synchronizers can resolve "
          "at different moments, creating a momentary 'Frankenstein' "
          "value that matches no real transmitted number. That's exactly "
          "why real designs use async FIFOs (with gray coding) for "
          "multi-bit data crossings.",
      explainBad:
          "The danger isn't overheating or wrong signal types — it's "
          "that each bit's metastability can resolve independently and "
          "at a different time, so the receiver can briefly sample a "
          "mixed, never-actually-sent value. Multi-bit data needs a "
          "coordinated crossing scheme like an async FIFO, not N "
          "independent synchronizers.",
    ),
  ),
  const Chapter(
    id: 45,
    title: 'MESI — Keeping Multi-Core Caches Honest',
    avatar: '🔄',
    role: 'Narrator — watching cores argue over a shared value',
    bodyIntro:
        "Give every CPU core its own private cache, and you create a "
        "real problem: what happens when Core A caches a variable, then "
        "Core B modifies its OWN cached copy of that same variable? "
        "Without a rule, Core A would silently keep reading stale data "
        "forever. The MESI protocol (Modified, Exclusive, Shared, "
        "Invalid) is the industry-standard answer — every cache line is "
        "tagged with one of these four states:\n\n"
        "M (Modified) — this core has the ONLY copy, and it's been "
        "changed (dirty, not yet in RAM)\n"
        "E (Exclusive) — this core has the ONLY copy, and it matches RAM "
        "(clean)\n"
        "S (Shared) — multiple cores may have this copy, all matching "
        "RAM (clean)\n"
        "I (Invalid) — this core's copy is stale/unusable — must "
        "re-fetch before using it\n\n"
        "Cores enforce this by snooping the shared bus (or an equivalent "
        "coherence interconnect): the instant Core B writes to a line, "
        "it broadcasts that fact, and every OTHER core holding that line "
        "in Shared state must immediately transition it to Invalid. The "
        "next time Core A tries to read it, a cache miss forces a fresh "
        "fetch of the now-correct value.",
    calloutHints: [
      "🐌 This is a genuine scaling cost, not a free lunch: heavy "
          "cross-core writing to the same cache line (\"false sharing\" "
          "when it's actually unrelated variables that just happen to "
          "share a cache line) causes constant Invalidate/re-fetch churn "
          "called cache line ping-ponging — a real, measurable "
          "performance bug in production multi-threaded code.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a MESI state on the left, then click its meaning on the "
          "right.",
      pairs: [
        MatchPair(
          'mesi_m',
          'Modified',
          'Only copy, changed, not yet written back to RAM',
        ),
        MatchPair('mesi_e', 'Exclusive', 'Only copy, clean, matches RAM'),
        MatchPair(
          'mesi_s',
          'Shared',
          'Multiple cores may hold this clean copy',
        ),
        MatchPair(
          'mesi_i',
          'Invalid',
          'Stale copy — must re-fetch before use',
        ),
      ],
      explainOk:
          "Exactly — MESI lets many cores cache the same data while "
          "guaranteeing nobody ever silently reads stale, "
          "already-overwritten data.",
    ),
  ),
  const Chapter(
    id: 46,
    title: 'Cache Lines, Sets, and Associativity',
    avatar: '🗄️',
    role: 'Narrator — filing an address into the right drawer',
    bodyIntro:
        "A cache doesn't store single bytes — it stores fixed-size cache "
        "lines (commonly 64 bytes), because programs tend to access "
        "nearby memory soon after (spatial locality), so fetching a "
        "whole neighborhood at once pays off. Every memory address is "
        "split into three fields the cache hardware uses to locate data: "
        "TAG (identifies WHICH block of memory is currently sitting in "
        "this line), INDEX (picks WHICH set/row of the cache to check), "
        "OFFSET (picks WHICH byte within the 64-byte line).\n\n"
        "The real engineering tradeoff is associativity — how many "
        "different cache lines a given INDEX is allowed to map to:\n\n"
        "Direct-mapped (1-way) — each index maps to exactly ONE line. "
        "Simplest and fastest to check, but two frequently-used "
        "addresses that happen to share an index will constantly evict "
        "each other (a \"conflict miss\").\n\n"
        "Set-associative (N-way) — each index maps to a small SET of N "
        "lines (a replacement policy like LRU picks which to evict). "
        "Real CPUs commonly use 4-way to 16-way — the sweet spot between "
        "direct-mapped's conflict misses and fully-associative's "
        "expensive comparator hardware.\n\n"
        "Fully associative — any line can go anywhere. Fewest conflict "
        "misses, but needs a comparator for EVERY line simultaneously — "
        "too expensive for large caches.",
    calloutHints: [
      "🎯 This is a direct, real production tradeoff: going from "
          "direct-mapped to 8-way associative for the same total cache "
          "size measurably cuts conflict misses in real workloads, at "
          "the real hardware cost of more comparators and a slightly "
          "longer critical path per lookup — nothing is free.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A cache designer is choosing between a direct-mapped cache "
          "and an 8-way set-associative cache of the exact same total "
          "capacity. What's the real tradeoff being made?",
      options: [
        'There is no tradeoff — 8-way associative is strictly better with zero downsides',
        '8-way associative reduces conflict misses (fewer evictions from index collisions) at the cost of more comparator hardware and a longer lookup critical path',
        'Direct-mapped caches can store more total data than set-associative ones',
        'Associativity only matters for caches larger than 1MB',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — more ways means fewer conflict-driven "
          "evictions, but every additional way needs its own comparator "
          "running in parallel, which costs silicon area and adds to the "
          "lookup's critical path.",
      explainBad:
          "Nothing in hardware is a strict free win. More ways "
          "(associativity) cuts index-collision evictions, but the "
          "hardware cost is real: more parallel comparators, more "
          "silicon, and a longer critical path per lookup.",
    ),
  ),
  const Chapter(
    id: 47,
    title: 'SIMD — One Instruction, Many Lanes',
    avatar: '🧵',
    role: 'Narrator — watching one command move many hands at once',
    bodyIntro:
        "A normal ALU does one operation on one pair of values per "
        "instruction. A SIMD (Single Instruction, Multiple Data) unit "
        "instead packs several values into one wide register and applies "
        "the SAME operation to all of them at once, in parallel "
        "\"lanes\" — real examples include SSE/AVX on x86 and NEON on "
        "ARM.\n\n"
        "Scalar ADD: [a] + [b] → 1 result per instruction\n"
        "SIMD ADD: [a0 a1 a2 a3] + [b0 b1 b2 b3] → 4 results in the SAME "
        "instruction\n\n"
        "SIMD is a huge win specifically for data-parallel workloads "
        "where the exact same math applies uniformly across a large "
        "array — image filters, audio processing, physics simulation, "
        "and matrix math (which is exactly why GPUs, built almost "
        "entirely from thousands of small SIMD-style lanes, dominate "
        "machine learning training). It's a poor fit for workloads full "
        "of unpredictable branching per-element, because the whole point "
        "requires every lane to be doing the same operation at the same "
        "time.",
    calloutHints: [
      "⚖️ This contrasts with true multi-core parallelism (MIMD — "
          "Multiple Instruction, Multiple Data), where each core "
          "independently runs its own different instruction stream. Real "
          "high-performance systems use BOTH: many cores (MIMD), each "
          "core ALSO running wide SIMD instructions internally.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Which of these workloads benefits the MOST from SIMD (single "
          "instruction, multiple data lanes)?",
      options: [
        'Adding the same brightness value to every pixel in a large image',
        'Running a web server that handles thousands of unrelated, independent HTTP requests',
        'Walking a complex tree data structure with a different branch taken at every node',
        'Parsing a JSON file with deeply nested, irregular structure',
      ],
      answerIndex: 0,
      explainOk:
          "Exactly — uniform, identical math applied across a large "
          "regular array is the textbook case SIMD lanes were built for.",
      explainBad:
          "SIMD wins when the SAME operation applies uniformly across "
          "many data elements at once (like brightening every pixel "
          "identically). Irregular branching per-element or independent "
          "unrelated tasks don't fit the 'one instruction, many lanes' "
          "model.",
    ),
  ),
  const Chapter(
    id: 48,
    title: 'Bandwidth vs Latency at Scale',
    avatar: '🚚',
    role: 'Narrator — comparing a firehose to a fast reflex',
    bodyIntro:
        "Two very different numbers describe how \"fast\" memory or a "
        "network link is, and confusing them causes real production "
        "mistakes:\n\n"
        "Bandwidth — how much total data moves per second (e.g. GB/s). A "
        "firehose: huge total volume, but each individual drop still "
        "takes time to arrive.\n\n"
        "Latency — how long ONE single request takes to get a response "
        "(e.g. nanoseconds or milliseconds). A reflex: how fast can you "
        "respond to just one thing.\n\n"
        "A system can have enormous bandwidth and still feel \"slow\" "
        "for latency-sensitive work: a cargo ship carries way more total "
        "data-per-second across an ocean than a phone call, but a phone "
        "call answers in milliseconds while the cargo ship takes weeks "
        "per trip. This is exactly the real memory wall problem: DRAM "
        "bandwidth has scaled dramatically over decades, but DRAM access "
        "LATENCY has barely improved, because latency is limited by "
        "physics (signal travel time, charge/discharge time of a "
        "capacitor) that doesn't shrink just because you add more "
        "parallel channels.",
    calloutHints: [
      "🏗️ This is exactly why the memory hierarchy exists at all: caches "
          "don't primarily exist to add bandwidth, they exist to HIDE "
          "latency, by keeping frequently-needed data physically close "
          "enough that the long RAM round-trip is avoided entirely for "
          "most accesses.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each fact into the concept it actually describes.",
      bucketALabel: 'Bandwidth',
      bucketBLabel: 'Latency',
      items: [
        Sort2Item(
          'bl1',
          'Total gigabytes per second a memory bus can sustain',
          true,
        ),
        Sort2Item(
          'bl2',
          'How many nanoseconds until a single memory request returns',
          false,
        ),
        Sort2Item(
          'bl3',
          'Improved by adding more parallel channels/lanes',
          true,
        ),
        Sort2Item(
          'bl4',
          'Fundamentally limited by physical signal travel time, hard to shrink',
          false,
        ),
      ],
      explainOk:
          "Correct! Bandwidth is total throughput (scales with more "
          "parallel lanes). Latency is per-request delay (limited by "
          "physics, much harder to improve).",
      explainBad:
          "Bandwidth = total volume per second (add more lanes to "
          "improve it). Latency = delay for ONE request (limited by "
          "physical travel/charge time, not just lane count).",
    ),
  ),
  const Chapter(
    id: 49,
    title: 'Side-Channel Attacks — Listening to the Silicon Itself',
    avatar: '🕵️',
    role: "Narrator — eavesdropping on a chip's secrets",
    bodyIntro:
        "A circuit can be logically perfect — the truth table gives the "
        "right answer every time — and STILL leak its secrets, because "
        "real hardware isn't just logical, it's physical. A side-channel "
        "attack extracts secret information not from the circuit's "
        "output, but from something it accidentally reveals about HOW it "
        "computed that output:\n\n"
        "Timing attack — if comparing a secret password byte-by-byte "
        "exits early on the first mismatch, a wrong guess that matches "
        "more leading bytes takes measurably LONGER to reject than one "
        "that matches fewer — an attacker can recover the secret one "
        "byte at a time purely by measuring response time.\n\n"
        "Power analysis — the current a chip draws changes based on "
        "which bits are flipping internally. Measuring power draw over "
        "many operations (differential power analysis, DPA) can "
        "statistically recover a cryptographic key, even though the key "
        "itself never appears on any output pin.",
    calloutHints: [
      "🛡️ The real production fix is constant-time comparison — code "
          "and circuits deliberately engineered to take the exact same "
          "amount of time (and ideally draw the same power profile) no "
          "matter what the secret value is, so there's nothing "
          "measurable to correlate with the secret at all.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A login system compares a submitted password to the stored "
          "one byte-by-byte, returning false the instant it finds the "
          "first mismatched byte. Why is this a real security bug, even "
          "if the output (true/false) never reveals the password?",
      options: [
        "It isn't a bug — only the final true/false result matters",
        'An attacker can measure how long the rejection takes, and a guess that matches more correct leading bytes takes measurably longer, letting the password be recovered one byte at a time',
        'The bug is that byte comparison is too slow in general',
        'This only matters if the attacker already knows the password',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — this is a textbook timing side-channel: "
          "early-exit comparison leaks information through response "
          "time, letting an attacker recover secrets a byte at a time "
          "without ever seeing the actual output change.",
      explainBad:
          "The output itself (true/false) doesn't need to leak anything "
          "for this to be a real bug — the TIME the comparison takes is "
          "itself a side channel. A longer rejection time reveals more "
          "leading bytes matched, letting an attacker guess byte-by-byte.",
    ),
  ),
  const Chapter(
    id: 50,
    title: 'Secure Boot — A Chain of Trust From Silicon Up',
    avatar: '🔐',
    role: 'Narrator — verifying every link before trusting the next',
    bodyIntro:
        "How does a computer know the firmware it's about to run hasn't "
        "been tampered with, when it hasn't even finished starting up "
        "yet? Secure boot solves this with a chain of trust rooted in "
        "hardware: a tiny, immutable root of trust is burned into "
        "ROM/silicon at manufacturing time (unmodifiable, unlike "
        "anything in ordinary flash), and every single boot stage must "
        "cryptographically verify the NEXT stage's digital signature "
        "before executing a single instruction of it.\n\n"
        "1. Immutable ROM boot code (the root of trust — trusted "
        "unconditionally)\n"
        "2. ROM verifies the signature of Stage 1 bootloader → only runs "
        "it if valid\n"
        "3. Stage 1 bootloader verifies the signature of Stage 2 (OS "
        "bootloader)\n"
        "4. Stage 2 verifies the signature of the OS kernel before "
        "handing off control\n\n"
        "The critical property: if ANY stage's signature check fails, "
        "the chain halts right there — the system refuses to execute "
        "unsigned or tampered code, rather than \"trusting by default "
        "and hoping it's fine.\" Trust flows strictly forward, never "
        "backward: a later stage can never grant itself trust it wasn't "
        "handed by an already-verified earlier stage.",
    calloutHints: [
      "🏭 The ROOT of trust must live in genuinely non-volatile, "
          "unmodifiable memory (masked ROM or write-protected e-fuses) — "
          "because if the very first, most-trusted link in the chain "
          "could itself be silently overwritten by an attacker, the "
          "entire chain of trust collapses from the start.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these secure boot steps in the order they actually "
          "happen.",
      items: [
        OrderItem(
          'sb1',
          'Immutable ROM boot code executes first (the root of trust)',
        ),
        OrderItem(
          'sb2',
          "ROM verifies Stage 1 bootloader's signature before running it",
        ),
        OrderItem(
          'sb3',
          "Stage 1 bootloader verifies Stage 2's signature before running it",
        ),
        OrderItem(
          'sb4',
          "Stage 2 verifies the OS kernel's signature before handing off control",
        ),
      ],
      explainOk:
          "That's the chain! Trust only ever flows forward from the "
          "immutable root — each stage must prove the next is legitimate "
          "before it's allowed to run at all.",
      explainBad:
          "Trust always starts from the one thing that can't be "
          "tampered with (immutable ROM), and each already-trusted stage "
          "verifies the NEXT stage's signature before ever executing it "
          "— never the reverse.",
    ),
  ),
  const Chapter(
    id: 51,
    title: 'Parity, ECC, and Hamming Codes',
    avatar: '🧮',
    role: 'Narrator — building numbers that can heal themselves',
    bodyIntro:
        "A stray cosmic ray or electrical noise can flip a single bit in "
        "memory — rare per bit, but with billions of bits in a server, "
        "it happens often enough to matter in production. Three "
        "escalating levels of defense exist:\n\n"
        "Parity bit — one extra bit makes the total number of 1s always "
        "even (or always odd). It can DETECT that a single bit flipped, "
        "but has no way to know WHICH bit, so it can't fix anything.\n\n"
        "Hamming code — places several parity bits at carefully chosen "
        "positions (each covering a different overlapping subset of "
        "data bits), so that when a single bit flips, the specific "
        "PATTERN of which parity checks fail points to the exact "
        "position of the flipped bit — letting the code both detect AND "
        "correct it.\n\n"
        "ECC (Error-Correcting Code) RAM — real server and datacenter "
        "memory that runs a Hamming-family code (commonly SECDED: "
        "Single-Error-Correct, Double-Error-Detect) continuously in "
        "hardware, transparently fixing single-bit flips before "
        "software ever sees them, and at least flagging (if not fixing) "
        "double-bit flips.\n\n"
        "Parity: detects 1-bit errors, corrects NOTHING. Hamming: "
        "detects 1-bit errors, corrects that 1 bit. SECDED: detects "
        "2-bit errors, corrects 1-bit errors.",
    calloutHints: [
      "🏭 This is a real, constant background process in every "
          "datacenter: ECC RAM silently fixes single-bit flips millions "
          "of times a day across a fleet — without it, \"bit rot\" "
          "would cause unexplainable, unreproducible crashes and silent "
          "data corruption at scale.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A memory system uses a simple parity bit (no Hamming code, no "
          "ECC) per byte. A cosmic ray flips exactly one bit in that "
          "byte. What can the system actually do?",
      options: [
        'It can both detect AND correct the exact bit that flipped',
        'It can detect that SOME bit flipped, but cannot determine which bit, so it cannot correct it',
        'It cannot detect anything at all — parity is purely decorative',
        'It automatically requests a hardware replacement',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — a single parity bit only tells you the count "
          "of 1s is now wrong, which proves an odd number of bits "
          "flipped, but gives zero location information needed to "
          "correct it. That's exactly why real ECC memory needs the "
          "extra structure of a Hamming-family code.",
      explainBad:
          "Parity is detection-only: it can prove something is wrong "
          "(the 1-count parity broke), but it carries no positional "
          "information about WHICH bit flipped, so correction is "
          "impossible with parity alone. Correction needs the "
          "overlapping-coverage structure of a Hamming code.",
    ),
  ),
  const Chapter(
    id: 52,
    title: 'Triple Modular Redundancy — Voting on the Truth',
    avatar: '🗳️',
    role: 'Narrator — running the same circuit three times and voting',
    bodyIntro:
        "Some systems — spacecraft electronics bombarded by radiation, "
        "aircraft flight computers, pacemakers — cannot simply hope a "
        "single-bit flip never corrupts a critical decision. Triple "
        "Modular Redundancy (TMR) builds the SAME critical circuit three "
        "separate, physically independent times, feeds all three the "
        "same inputs, and routes all three outputs into a majority voter "
        "— whichever answer at least 2 of 3 circuits agree on is "
        "trusted, even if the third one is wrong.\n\n"
        "The engineering assumption TMR relies on is that a radiation "
        "event or fault is unlikely to hit all three physically separate "
        "circuits at the SAME instant in the SAME way — so a single "
        "fault gets outvoted by the two still-correct circuits, and the "
        "system keeps running correctly with zero visible interruption.",
    calloutHints: [
      "💰 The cost is real and unavoidable: TMR needs roughly 3x the "
          "silicon area, power, and design/verification effort of the "
          "original circuit, plus the voter logic itself. Real "
          "spacecraft and avionics designs accept this tripled cost "
          "specifically because the alternative — an undetected fault "
          "silently corrupting a flight-critical decision — is "
          "unacceptable at any price.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In a TMR system, Circuit A outputs 1, Circuit B outputs 1, "
          "and Circuit C (hit by a radiation event) outputs 0. What does "
          "the system's final output become?",
      options: [
        '0, because any disagreement makes the output invalid',
        '1, because the majority voter trusts whichever answer at least 2 of the 3 circuits agree on',
        'The system crashes and halts',
        'The average of the three outputs, 0.67',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — the majority voter outputs whatever 2-of-3 "
          "circuits agree on, so a single faulty circuit gets outvoted "
          "and the system keeps producing the correct answer with no "
          "visible interruption.",
      explainBad:
          "TMR's whole point is that a single faulty circuit gets "
          "outvoted, not that any disagreement invalidates the result. "
          "Here A and B agree on 1, so the voter outputs 1 — Circuit C's "
          "wrong answer is simply outvoted.",
    ),
  ),
  const Chapter(
    id: 53,
    title: 'RISC vs CISC — Simple and Fast, or Rich and Compact',
    avatar: '⚖️',
    role: 'Narrator — weighing two whole philosophies of instruction design',
    bodyIntro:
        "Two competing philosophies for designing a CPU's instruction "
        "set have shaped real shipped silicon for decades: RISC (Reduced "
        "Instruction Set Computer — think ARM, RISC-V) favors many "
        "simple, fixed-length instructions, each doing one small thing, "
        "with a strict load/store architecture (arithmetic instructions "
        "only ever touch registers, never memory directly). CISC "
        "(Complex Instruction Set Computer — think x86) favors fewer, "
        "richer, variable-length instructions where a single instruction "
        "can do considerably more work, including directly reading and "
        "writing memory as part of an arithmetic operation.\n\n"
        "The real engineering consequences ripple through the whole "
        "chip: RISC's uniform, fixed-length instructions make pipelining "
        "and decode hardware dramatically simpler — you always know "
        "exactly where the next instruction starts and how long it is, "
        "which is a big reason RISC-style decode is cheaper in both "
        "silicon area and power. CISC's variable-length, memory-touching "
        "instructions pack more work per instruction (better code "
        "density, fewer total instructions fetched), but the decoder "
        "itself becomes far more complex — real x86 chips internally "
        "translate CISC instructions into simpler RISC-like "
        "micro-operations before actually executing them, essentially "
        "running a RISC core underneath a CISC-compatible front end.",
    calloutHints: [
      "📱 This is exactly why ARM (RISC) dominates battery-powered "
          "mobile and embedded devices — simpler decode hardware "
          "directly means lower power draw — while x86 (CISC) has "
          "historically dominated desktops and servers where raw "
          "performance and decades of software compatibility mattered "
          "more than power efficiency.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each fact into the philosophy it describes.",
      bucketALabel: 'RISC',
      bucketBLabel: 'CISC',
      items: [
        Sort2Item(
          'rc1',
          'Fixed-length instructions, simpler decode hardware',
          true,
        ),
        Sort2Item(
          'rc2',
          'A single instruction can read memory, compute, and write memory back',
          false,
        ),
        Sort2Item(
          'rc3',
          'Strict load/store — arithmetic only ever touches registers',
          true,
        ),
        Sort2Item(
          'rc4',
          'Internally translates its own instructions into simpler micro-ops before executing',
          false,
        ),
      ],
      explainOk:
          "Correct! RISC = simple, fixed, load/store-only. CISC = "
          "complex, variable-length, memory-touching, and internally "
          "micro-op-translated on real modern chips.",
      explainBad:
          "RISC keeps instructions uniform and simple (fixed-length, "
          "load/store only). CISC packs more work per instruction "
          "(variable length, memory-touching), which is exactly why real "
          "CISC chips internally decode down to simpler RISC-like "
          "micro-ops.",
    ),
  ),
  const Chapter(
    id: 54,
    title: 'Branch Prediction — Guessing Before You Know',
    avatar: '🔮',
    role: 'Narrator — betting on which way the road forks',
    bodyIntro:
        "A pipelined CPU hits a control hazard at every conditional "
        "branch — it needs to fetch the NEXT instruction long before the "
        "branch's condition is actually known. Rather than stalling the "
        "whole pipeline every single time, real CPUs predict which way "
        "the branch will go, and speculatively keep executing down that "
        "guessed path.\n\n"
        "2-bit saturating counter — a small per-branch history counter "
        "(00, 01, 10, 11) that leans toward \"taken\" or \"not taken\" "
        "based on recent history, and requires TWO consecutive wrong "
        "guesses to flip its prediction — this avoids one single unusual "
        "outcome (e.g. a loop's very last iteration) from immediately "
        "flipping a normally-reliable prediction.\n\n"
        "Branch Target Buffer (BTB) — caches WHERE a branch actually "
        "jumped to last time, so the pipeline can start fetching from "
        "the predicted target immediately, without waiting to recompute "
        "the target address from scratch.\n\n"
        "When a prediction turns out wrong, everything speculatively "
        "executed down the wrong path must be thrown away — a pipeline "
        "flush — and fetching restarts from the correct path. The deeper "
        "the pipeline, the more instructions were \"in flight\" down the "
        "wrong guess, so the misprediction penalty (cycles wasted) grows "
        "directly with pipeline depth.",
    calloutHints: [
      "🎯 This is a genuine, measurable production tradeoff: deeper "
          "pipelines allow higher clock speeds (shorter critical path "
          "per stage) but pay a bigger misprediction penalty when a "
          "branch is guessed wrong — so branch prediction accuracy "
          "matters MORE, not less, as pipelines get deeper.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A CPU has a 20-stage pipeline. It predicts a branch will be "
          "taken and speculatively fetches and partially executes 15 "
          "instructions down that path before discovering the "
          "prediction was WRONG. What must happen?",
      options: [
        'Nothing — wrong predictions are automatically corrected without any cost',
        'All 15 speculatively-executed instructions must be discarded (flushed), and fetching restarts from the correct path — wasting real cycles',
        'The CPU permanently switches to the non-predicted path from then on',
        'The clock speed automatically slows down to compensate',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — a misprediction forces a pipeline flush, "
          "discarding all speculative work down the wrong path, and the "
          "deeper the pipeline, the more wasted work a wrong guess can "
          "cause.",
      explainBad:
          "A wrong prediction isn't free — every speculatively-executed "
          "instruction down the wrong path must be discarded (flushed) "
          "and fetching must restart from the correct target. Deeper "
          "pipelines mean more in-flight speculative work to throw away "
          "per misprediction.",
    ),
  ),
  const Chapter(
    id: 55,
    title: 'Out-of-Order Execution — Reordering for Speed',
    avatar: '🔀',
    role: 'Narrator — letting the fast workers go first',
    bodyIntro:
        "In-order execution forces every instruction to wait its turn, "
        "even if a LATER instruction has all its inputs ready NOW while "
        "an earlier one is stuck waiting on a slow memory load. "
        "Out-of-order execution (OOO) lets the hardware run whichever "
        "ready instructions it can, in whatever order their inputs "
        "actually become available — while still making the final "
        "result look exactly as if everything ran in the original "
        "program order.\n\n"
        "The real hardware pieces that make this both fast AND correct: "
        "instructions decode into a pool called the reservation stations "
        "/ instruction window, where each waits only for its OWN "
        "specific inputs to become ready, then executes as soon as "
        "possible, out of program order. But results are held in a "
        "reorder buffer (ROB) and only committed to visible, permanent "
        "architectural state IN the original program order — this is "
        "what lets the CPU look, from the outside, exactly like a simple "
        "in-order machine, while internally running instructions in "
        "whatever order is actually fastest.",
    calloutHints: [
      "🎯 This \"execute out of order, commit in order\" split is the "
          "single most important idea separating a real modern "
          "high-performance core from a simple textbook pipeline — it's "
          "precisely what lets a slow memory load stall ONLY the "
          "instructions that truly depend on it, instead of stalling the "
          "entire pipeline behind it.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these steps of out-of-order execution in the order "
          "they happen.",
      items: [
        OrderItem(
          'ooo1',
          'Instructions decode and enter the reservation stations / instruction window',
        ),
        OrderItem(
          'ooo2',
          "Each instruction executes as soon as ITS OWN inputs are ready — not necessarily in program order",
        ),
        OrderItem(
          'ooo3',
          'Completed results are held in the reorder buffer (ROB), tagged with their original program order',
        ),
        OrderItem(
          'ooo4',
          'Results are committed to visible architectural state strictly in the ORIGINAL program order',
        ),
      ],
      explainOk:
          "That's the split! Execute whenever inputs are ready (out of "
          "order), but always commit results in the original program "
          "order — fast internally, correct externally.",
      explainBad:
          "The key split is: instructions EXECUTE out of order "
          "(whenever their inputs are ready), but must still COMMIT "
          "their results in the original program order via the reorder "
          "buffer, so external behavior looks exactly like a simple "
          "in-order machine.",
    ),
  ),
  const Chapter(
    id: 56,
    title: 'Superscalar & Register Renaming — Untangling False Dependencies',
    avatar: '🧶',
    role: 'Narrator — cutting the strings that were never really tied',
    bodyIntro:
        "A superscalar CPU issues and executes MULTIPLE instructions in "
        "the SAME cycle (as opposed to just pipelining, which overlaps "
        "instructions across DIFFERENT cycles) — real high-performance "
        "cores routinely issue 4-8 instructions per cycle. But going "
        "wide exposes a subtle problem: not every dependency between "
        "instructions is a REAL data dependency.\n\n"
        "There are three named hazard types, and only ONE of them is a "
        "genuine dependency:\n\n"
        "RAW (Read-After-Write) — a TRUE dependency: an instruction "
        "genuinely needs a value a previous instruction is about to "
        "produce. This one can never be eliminated, only worked around "
        "with forwarding.\n\n"
        "WAW (Write-After-Write) — a FALSE dependency: two instructions "
        "both happen to write the same register name, with no real data "
        "flow between them at all.\n\n"
        "WAR (Write-After-Read) — also a FALSE dependency: one "
        "instruction must read a register's old value before a later "
        "instruction overwrites that same register name.\n\n"
        "Register renaming is the fix: the hardware secretly maps each "
        "architectural register name to one of a much larger pool of "
        "PHYSICAL registers behind the scenes, so two instructions that "
        "just happen to share a register NAME get mapped to genuinely "
        "different physical storage — eliminating WAW and WAR hazards "
        "entirely, since they were never real dependencies to begin "
        "with, just naming collisions.",
    calloutHints: [
      "🎯 This is exactly why real superscalar chips have vastly more "
          "physical registers than the architecture's visible register "
          "names (e.g. x86 exposes only 16 general-purpose registers, "
          "but real chips have hundreds of physical registers "
          "underneath) — the extra physical registers exist purely to "
          "let the renamer break false dependencies and unlock more "
          "true out-of-order parallelism.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a hazard type on the left, then click its correct "
          "description on the right.",
      pairs: [
        MatchPair(
          'hzz1',
          'RAW (Read-After-Write)',
          'A genuine dependency — cannot be eliminated, only worked around',
        ),
        MatchPair(
          'hzz2',
          'WAW (Write-After-Write)',
          'A false dependency — two writes to the same register NAME, no real data flow',
        ),
        MatchPair(
          'hzz3',
          'WAR (Write-After-Read)',
          'A false dependency — a later write to a name that must wait for an earlier read of it',
        ),
        MatchPair(
          'hzz4',
          'Register renaming',
          'Eliminates WAW/WAR by mapping register names to distinct physical registers',
        ),
      ],
      explainOk:
          "Exactly — only RAW is a true dependency. WAW and WAR are "
          "naming collisions that register renaming eliminates entirely "
          "by giving each write its own physical register.",
    ),
  ),
  const Chapter(
    id: 57,
    title: 'Capstone I — A Hazard-Aware Pipeline Under Real Load',
    avatar: '🏗️',
    role: 'Narrator — throwing everything at one pipeline stage at once',
    bodyIntro:
        "Real production pipelines rarely fail from just ONE textbook "
        "hazard in isolation — the hard bugs and hard tradeoffs happen "
        "where hazards, prediction, and caching COLLIDE in the same few "
        "cycles. Consider this genuinely production-shaped scenario:\n\n"
        "1: LOAD R1, [addr] — a cache MISS — this will take ~150 cycles, "
        "not ~4\n"
        "2: BEQ R1, R0, target — branch decision needs R1 — but R1 isn't "
        "ready for ~150 cycles!\n"
        "3: ADD R2, R3, R4 — independent of R1 — a candidate for "
        "out-of-order execution\n\n"
        "Walk through what a real high-performance core actually does "
        "here: the branch predictor doesn't wait for the true value of "
        "R1 — it speculatively guesses the branch direction from history "
        "and keeps fetching down the guessed path immediately. "
        "Meanwhile, out-of-order hardware notices instruction 3 doesn't "
        "depend on R1 at all, and lets it execute immediately rather "
        "than stalling behind the slow load. Only when the cache miss "
        "FINALLY resolves does the CPU learn R1's true value, check "
        "whether the branch prediction was actually correct, and either "
        "continue normally or trigger a full pipeline flush of "
        "everything speculatively done down the wrong path.",
    calloutHints: [
      "🎯 This is the real reason modern high-performance CPUs are so "
          "complicated: a single slow cache miss on a branch's input "
          "touches prediction, speculation, out-of-order scheduling, AND "
          "flush-recovery hardware all at once — none of these ideas "
          "work in isolation on a real chip, they're deeply "
          "intertwined.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In the pipeline above, instruction 3 (ADD, independent of "
          "R1) executes out-of-order while the LOAD is still stalled on "
          "a cache miss. When R1 finally arrives and the branch turns "
          "out to have been MISPREDICTED, what happens to instruction "
          "3's already-computed result?",
      options: [
        "It's kept, since ADD never depended on R1 at all",
        "It depends entirely on whether instruction 3 was itself down the correct or the mispredicted path — if it was fetched as part of the wrong guessed path, it gets flushed regardless of not depending on R1",
        "It's automatically converted into the correct answer",
        'Out-of-order execution is disabled the moment a branch is pending',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — a pipeline flush discards everything fetched "
          "down the WRONG speculative path, regardless of whether any "
          "individual instruction's own inputs were correct. Not "
          "depending on R1 doesn't save instruction 3 if it was itself "
          "part of the mispredicted path; if instruction 3 was actually "
          "on the correct path (before the branch), its result is "
          "safely kept via the reorder buffer's in-order commit.",
      explainBad:
          "The deciding factor isn't whether instruction 3 depended on "
          "R1 — it's whether instruction 3 was fetched as part of the "
          "CORRECT path or the MISPREDICTED path. A flush discards "
          "everything down the wrong guessed path wholesale, "
          "independent of each instruction's own data dependencies.",
    ),
  ),
  const Chapter(
    id: 58,
    title: 'Capstone II — When Speculation Leaks Secrets',
    avatar: '🕳️',
    role: 'Narrator — watching a performance feature become a security hole',
    bodyIntro:
        "Here's the deepest capstone connection in all of Logic Land: "
        "speculative/out-of-order execution and cache-timing side "
        "channels are BOTH individually legitimate, intentional "
        "engineering techniques — and combined, they created one of the "
        "most significant hardware security vulnerability classes ever "
        "found in production CPUs (Spectre-class attacks).\n\n"
        "if (index < array1_length) { // branch predictor speculatively "
        "assumes TRUE\n"
        "    secret = array2[array1[index]]; // speculatively executed "
        "BEFORE the check finishes!\n"
        "} // even though 'index' was chosen to be OUT OF BOUNDS\n\n"
        "Here's the chain of real hardware behavior that makes this "
        "dangerous: the branch predictor guesses the bounds check will "
        "pass and speculatively executes the body anyway, using an "
        "attacker-chosen out-of-bounds index to read secret memory into "
        "a cache line — based on the value of that stolen secret byte. "
        "Even though the CPU eventually discovers the bounds check "
        "actually failed and flushes the speculative RESULT (correctly!) "
        "— the side effect on the cache is NOT undone by the flush. The "
        "attacker then measures which array2 index is now fast to "
        "access (cached) versus slow (not cached) — a pure timing side "
        "channel — and that measurement reveals the secret byte's "
        "value, one bit at a time, entirely bypassing the \"security\" "
        "of the bounds check.",
    calloutHints: [
      "🎯 The deep lesson: a pipeline flush correctly undoes "
          "ARCHITECTURAL state (registers, memory writes) — but it does "
          "NOT undo MICROARCHITECTURAL side effects like cache state, "
          "because caches were never designed with \"must be perfectly "
          "reversible for security\" as a goal. This is exactly why "
          "Spectre-class fixes required rethinking speculation itself, "
          "not just patching software bounds checks.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "The CPU correctly detects the bounds-check misprediction and "
          "flushes the speculative computation's ARCHITECTURAL result "
          "(registers never show the stolen secret). Why does the "
          "attack still succeed?",
      options: [
        "It doesn't succeed — a correct flush fully prevents any information leak",
        'The flush undoes visible architectural state, but does NOT undo the cache-line side effect the speculative access caused — and that leftover cache state is measurable via a timing side channel',
        'The bounds check itself is mathematically wrong',
        'Flushes only work on ARM chips, not x86',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — this is the core insight behind Spectre-class "
          "attacks: architectural flush correctness and "
          "microarchitectural side-effect correctness are two DIFFERENT "
          "properties, and speculation was only ever engineered to "
          "guarantee the first one.",
      explainBad:
          "The flush genuinely does its job for architectural state "
          "(registers, official results) — the leak survives "
          "specifically because CACHE STATE is a microarchitectural side "
          "effect that a flush was never designed to reverse, and that "
          "leftover state is exactly what a timing side channel "
          "measures.",
    ),
  ),
  const Chapter(
    id: 59,
    title: 'Capstone III — Coherence Meets Reliability at Scale',
    avatar: '🛰️',
    role: 'Narrator — designing a memory system that must never quietly lie',
    bodyIntro:
        "Design brief: a multi-core system for a spacecraft's flight "
        "computer must (1) let multiple cores share cached data "
        "correctly, and (2) survive cosmic-ray-induced bit flips without "
        "ever silently computing a wrong answer. This requires combining "
        "THREE separate ideas into one coherent design, because none of "
        "them alone is sufficient:\n\n"
        "MESI coherence ensures every core's cache reads the most "
        "recently WRITTEN value — but MESI has no concept of \"was this "
        "bit accidentally flipped by radiation,\" it only tracks WHO has "
        "the most recent legitimate write.\n\n"
        "ECC/Hamming protection on every cache line detects and corrects "
        "single-bit flips within the DATA itself — but ECC alone says "
        "nothing about whether a whole CORE's logic is computing "
        "correctly, only whether stored bits got corrupted.\n\n"
        "TMR on the CORE's own execution logic protects against a "
        "single core's compute circuits themselves being hit and "
        "computing a wrong result — but TMR triples only the logic it "
        "wraps; it does nothing for data sitting in caches or RAM "
        "outside that boundary.",
    calloutHints: [
      "🎯 The real architectural lesson: MESI, ECC, and TMR protect "
          "three completely different layers — WHO has the freshest "
          "data, WHETHER stored bits are intact, and WHETHER the compute "
          "logic itself is trustworthy. A production fault-tolerant "
          "system needs all three simultaneously, layered together, "
          "because each one is blind to the failure mode the other two "
          "exist to catch.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a technique on the left, then click the specific "
          "failure it protects against on the right.",
      pairs: [
        MatchPair(
          'cap1',
          'MESI coherence',
          "A core reading a stale value after another core's legitimate write",
        ),
        MatchPair(
          'cap2',
          'ECC / Hamming code',
          'A single bit in stored data flipped by radiation or noise',
        ),
        MatchPair(
          'cap3',
          'Triple Modular Redundancy',
          "A core's own compute logic itself producing a wrong result",
        ),
      ],
      explainOk:
          "Exactly right — each technique guards a different layer of "
          "the system, and a genuinely fault-tolerant design needs all "
          "three working together, because none of them can substitute "
          "for the others.",
    ),
  ),
  const Chapter(
    id: 60,
    title: "Capstone IV — The Principal Engineer's Gauntlet",
    avatar: '👑',
    role: 'Narrator — the final, hardest gate in Logic Land',
    bodyIntro:
        "The final trial. A real design review, the kind a principal "
        "hardware engineer runs before a chip commits to tape-out. You "
        "are told: \"We're building a new server CPU core. Target: high "
        "sustained throughput for datacenter workloads, must ship an "
        "ASIC at high volume, must support multiple cores sharing "
        "memory, and must be resilient enough for a datacenter SLA that "
        "cannot tolerate silent data corruption.\"\n\n"
        "Every single decision below has a direct, traceable consequence "
        "you've now learned across all of Logic Land's professional "
        "tier:\n\n"
        "Choosing a deeper pipeline raises clock speed potential but "
        "raises the misprediction penalty — so branch prediction "
        "accuracy investment must scale with pipeline depth, not stay "
        "fixed.\n\n"
        "Choosing wide superscalar + out-of-order raises single-core "
        "throughput but multiplies verification complexity and the "
        "physical register file size needed for renaming.\n\n"
        "Choosing multi-core with shared caches REQUIRES a coherence "
        "protocol — skipping it isn't an option once more than one core "
        "touches shared data.\n\n"
        "Choosing to ship an ASIC at this volume is the right call "
        "economically, but means every one of these decisions is FROZEN "
        "at tape-out — unlike an FPGA, there is no \"we'll patch it "
        "later\" for a logic bug.\n\n"
        "The \"no silent data corruption\" SLA requirement is "
        "non-negotiable, which means ECC memory is mandatory, not "
        "optional, on a server part.",
    calloutHints: [
      "🏆 This is the real shape of senior hardware engineering: there "
          "is no single \"correct\" answer, only a chain of tradeoffs "
          "where each choice constrains the ones after it — and the "
          "engineer's job is tracing those consequences BEFORE tape-out "
          "freezes them forever, because after tape-out, every mistake "
          "costs months and millions, not a quick patch.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "The design review above commits to: a deep pipeline for high "
          "clock speed, wide out-of-order superscalar execution, "
          "multiple cores sharing memory, and an ASIC tape-out at high "
          "volume, under a \"no silent data corruption\" datacenter SLA. "
          "Given everything you've learned across Levels 11-15, which "
          "single statement correctly identifies the ONE choice in this "
          "design that is not actually optional, but strictly mandatory "
          "the moment multiple cores share cached memory?",
      options: [
        "Deep pipelining — it's mandatory for any multi-core chip",
        'A cache coherence protocol (like MESI) — once more than one core can cache the same shared data, skipping coherence means cores can silently read stale, already-overwritten values',
        'Choosing FPGA over ASIC, because ASICs cannot support multiple cores',
        'Branch prediction, because out-of-order execution is impossible without it',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — this is the one decision on the list that "
          "isn't a tradeoff at all, it's a correctness requirement: the "
          "instant multiple cores can cache the same shared memory, some "
          "coherence mechanism is mandatory, or the system will silently "
          "compute wrong answers. Every other choice on the list "
          "(pipeline depth, OOO width, ASIC vs FPGA) is a genuine "
          "tradeoff with valid answers on both sides — coherence is not. "
          "You've completed the Principal Engineer's Gauntlet — Logic "
          "Land's deepest Shard is yours.",
      explainBad:
          "Re-check which item on the list is a TRADEOFF (valid choices "
          "both ways) versus a CORRECTNESS REQUIREMENT (skipping it "
          "produces silently wrong answers). Pipeline depth, OOO width, "
          "and ASIC-vs-FPGA are all genuine tradeoffs — but once "
          "multiple cores share cached memory, some coherence protocol "
          "stops being optional.",
    ),
  ),
];
