import '../models/pq_models.dart';

/// Ported from process-quest/subjects/compilers.js — "Compiler Coast".
/// All 60 chapters (levels 1-15), same ids, same order, same puzzles/answers.
final compilersChapters = <Chapter>[
  const Chapter(
    id: 1,
    title: 'Two Ways to Read a Recipe',
    avatar: '📜',
    role: 'Narrator — rolling onto Compiler Coast',
    bodyIntro:
        "🌊 I just rolled onto Compiler Coast, where every program starts life as plain "
        "text — just words a human typed — and has to somehow become something a computer "
        "can actually run.\n\n"
        "📖 Imagine a cookbook written in French, but the cook only speaks English. There "
        "are two ways to get dinner made:\n\n"
        "📘 Compiler — translate the entire cookbook into English first, cover to cover. "
        "Once it's translated, you can cook from it as many times as you like, fast, "
        "without ever needing the translator again.\n\n"
        "🗣️ Interpreter — keep a translator standing right next to the cook, translating "
        "one line at a time, while the cooking happens.\n\n"
        "🔤 A compiler reads my whole program and produces a new file — usually machine "
        "code, or some other form — before anything runs. An interpreter reads and executes "
        "my program's instructions directly, one piece at a time, with no separate "
        "\"translated\" file left behind.",
    calloutHints: [
      "🐢 Real talk: C and Rust use compilers. Python and (classic) Ruby use interpreters. "
          "Many modern languages — Java, JavaScript, Python (via bytecode) — actually blend "
          "both ideas, which you'll meet later on this coast.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which statement best describes what a compiler does?",
      options: [
        'It translates the entire program into another form (like machine code) before the program ever runs',
        'It reads and executes the program one line at a time, with no separate translation step',
        'It only checks spelling mistakes in the source code',
        'It deletes comments from the source code and nothing else',
      ],
      answerIndex: 0,
      explainOk:
          "Exactly — a compiler does its whole translation job up front, producing "
          "something new (often machine code) that can be run later, independently.",
      explainBad:
          "A compiler's defining trait is translating the WHOLE program before execution. "
          "Line-by-line execution during translation describes an interpreter instead.",
    ),
  ),
  const Chapter(
    id: 2,
    title: 'Compile Once, Run Many Times',
    avatar: '⏱️',
    role: 'Narrator — noticing a pattern',
    bodyIntro:
        "⏱️ Here's something neat I noticed: translating that whole French cookbook takes "
        "a while up front. But afterward, cooking from it is instant — no more waiting on "
        "a translator.\n\n"
        "That's the classic compiler tradeoff:\n\n"
        "🏗️ Compile time — the (possibly slow) step where your source code gets turned "
        "into something runnable. This happens once.\n\n"
        "🏃 Run time — every time you actually execute the finished program. This can "
        "happen thousands of times, and it's fast because the translation work is already "
        "done.\n\n"
        "🗣️ An interpreter instead pays a little translation cost every single run, since "
        "it re-reads and re-translates your source text each time — which is part of why "
        "compiled programs often start up and run faster than interpreted ones.",
    calloutHints: [
      "📦 This is why you \"compile\" a C program once into an .exe, then just "
          "double-click it forever after — all the translation work already happened at "
          "compile time.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each event into the bucket describing when it happens for a typical "
          "compiled language.",
      bucketALabel: '🏗️ Compile time',
      bucketBLabel: '🏃 Run time',
      items: [
        Sort2Item('syn', "The compiler checks your code's syntax for mistakes", true),
        Sort2Item('print', 'The program prints a message to the screen', false),
        Sort2Item('machine', 'Source code is translated into machine code', true),
        Sort2Item('userinput', 'The program reads a number the user just typed', false),
      ],
      explainOk:
          "Exactly — translation and syntax checking happen once, up front, at compile "
          "time. Anything involving live user interaction only happens at run time.",
      explainBad:
          "Compile time is about turning source code INTO something runnable (translation, "
          "syntax checks). Run time is everything that happens while that finished program "
          "is actually executing.",
    ),
  ),
  const Chapter(
    id: 3,
    title: 'Process Meets a Syntax Error',
    avatar: '🚧',
    role: 'Narrator — hitting a typo',
    bodyIntro:
        "🚧 I typed a tiny program with a typo in it — a missing closing parenthesis. "
        "Watch what happens with each approach:\n\n"
        "📘 With a compiler, it refuses to produce ANY runnable program at all. It reads "
        "my whole file first, notices the typo is broken grammar, and stops — I never even "
        "get to try running it.\n\n"
        "🗣️ With an interpreter, it might happily run the first five correct lines, and "
        "only crash when it finally reaches my broken line.\n\n"
        "🎯 Neither behavior is \"wrong\" — they're just different tradeoffs. Catching every "
        "mistake before anything runs feels stricter but safer. Running as far as you can "
        "feels more forgiving, but a bug deep in your program might not show up until "
        "someone actually triggers that exact line.",
    calloutHints: [
      "🧪 This is the seed of a much bigger idea you'll meet later: catching problems as "
          "EARLY as possible (compile time) vs. discovering them only when a specific path "
          "of your program actually executes (run time).",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A program has a broken line #50, but lines 1-49 are perfectly valid. What's "
          "the key difference between a compiler and an interpreter here?",
      options: [
        'There is no difference — both behave identically',
        'A compiler refuses to run ANY of the program because it checks the whole file first; an interpreter can execute lines 1-49 before crashing on line 50',
        'An interpreter refuses to run any of the program, while a compiler runs lines 1-49 first',
        'Both always successfully run the entire program, typo or not',
      ],
      answerIndex: 1,
      explainOk:
          "Right — a compiler processes the whole source file before producing anything "
          "runnable, so a broken line anywhere blocks the whole program. An interpreter can "
          "make partial progress before hitting the bad line.",
      explainBad:
          "Flip it around: the COMPILER is the strict one — it reads everything first and "
          "refuses to run if anything's broken. The INTERPRETER can execute the good lines "
          "before it ever reaches the broken one.",
    ),
  ),
  const Chapter(
    id: 4,
    title: 'The Big Picture Pipeline',
    avatar: '🏭',
    role: 'Narrator — touring the whole factory',
    bodyIntro:
        "🏭 Before I dive deep into any one stage, let's tour the whole factory floor. "
        "Turning my typed-out source code into something that actually runs isn't one "
        "giant leap — it's a pipeline of smaller, understandable steps:\n\n"
        "Source code → Tokens → AST → (checks/optimizations) → Machine code\n\n"
        "✍️ Source code — the plain text I typed, exactly as written.\n\n"
        "🧩 Tokens — the source chopped into meaningful little pieces (words, numbers, "
        "symbols).\n\n"
        "🌳 AST (Abstract Syntax Tree) — those tokens rebuilt into a tree shape that "
        "captures the program's actual structure.\n\n"
        "🤖 Machine code — the final instructions the CPU can directly run.",
    calloutHints: [
      "🗺️ You'll spend the next several levels living inside each of these stages, one at "
          "a time — starting with tokens next. Think of this chapter as the map before the "
          "journey.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these stages into the order source code actually flows through them.",
      items: [
        OrderItem('src', 'Source code — the text I typed'),
        OrderItem('tok', 'Tokens — chopped into words, numbers, symbols'),
        OrderItem('ast', 'AST — tokens rebuilt into a tree'),
        OrderItem('mc', 'Machine code — final CPU instructions'),
      ],
      explainOk:
          "That's the map! Source → Tokens → AST → Machine code. Every later level zooms "
          "into one of these stages.",
      explainBad:
          "Order matters: you always need raw text FIRST, then break it into tokens, then "
          "build a tree from those tokens, and only at the very end produce machine code.",
    ),
  ),
  const Chapter(
    id: 5,
    title: 'Chopping Sentences into Words',
    avatar: '✂️',
    role: 'Narrator — meeting the lexer',
    bodyIntro:
        "✂️ The very first real stage is called lexing (or tokenizing), done by a piece of "
        "the compiler called the lexer (or scanner).\n\n"
        "Picture this sentence with no spaces at all: thequickbrownfox. Painful to read! "
        "The lexer's whole job is exactly the opposite problem: take a stream of raw "
        "characters and chop it into meaningful chunks called tokens.\n\n"
        "let total = 5 + count;\n\n"
        "The lexer reads this character by character and groups them into tokens:\n\n"
        "let | total | = | 5 | + | count | ;",
    calloutHints: [
      "🔍 The lexer doesn't understand MEANING yet — it has no idea total is a variable "
          "that will hold a number. It only knows how to recognize the SHAPE of each token: "
          "letters clump into a word-token, digits clump into a number-token, and so on.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "The line was `let total = 5 + count;`. Drag these tokens into the order they "
          "appear, left to right.",
      items: [
        OrderItem('t1', 'let'),
        OrderItem('t2', 'total'),
        OrderItem('t3', '='),
        OrderItem('t4', '5'),
        OrderItem('t5', '+'),
        OrderItem('t6', 'count'),
        OrderItem('t7', ';'),
      ],
      explainOk:
          "Exactly the token stream the lexer would produce — same order as the source "
          "text, just chopped into meaningful pieces.",
      explainBad:
          "The lexer preserves left-to-right order exactly as written: let, total, =, 5, "
          "+, count, ; — it only chops, never reorders.",
    ),
  ),
  const Chapter(
    id: 6,
    title: 'Naming the Pieces',
    avatar: '🏷️',
    role: 'Narrator — labeling every token',
    bodyIntro:
        "🏷️ Every token the lexer produces also gets a category label, so later stages "
        "know roughly what kind of thing they're looking at:\n\n"
        "🔑 Keyword — a reserved word built into the language, like let, if, or return.\n\n"
        "🪪 Identifier — a name the programmer made up, like total or count.\n\n"
        "🔢 Number literal — a numeric value written directly, like 5.\n\n"
        "📝 String literal — quoted text, like \"hello\".\n\n"
        "➕ Operator — a symbol that does something, like + or =.\n\n"
        "🔘 Punctuation — structural symbols like ;, (, or {.",
    calloutHints: [
      "🧠 let and letter look similar character by character, but the lexer knows let is "
          "a reserved keyword while letter is just an identifier the programmer chose — it "
          "checks against the language's exact list of reserved words.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a token on the left, then click its category on the right.",
      pairs: [
        MatchPair('m1', 'let', 'Keyword'),
        MatchPair('m2', 'total', 'Identifier'),
        MatchPair('m3', '42', 'Number literal'),
        MatchPair('m4', '"hello"', 'String literal'),
        MatchPair('m5', '+', 'Operator'),
      ],
      explainOk:
          "All matched! Categorizing tokens is what lets the parser (next up) know what "
          "kind of grammar rule might apply to each one.",
    ),
  ),
  const Chapter(
    id: 7,
    title: 'Whitespace, Comments, and Getting Ignored',
    avatar: '🌬️',
    role: 'Narrator — watching things disappear',
    bodyIntro:
        "🌬️ Not everything in my source file becomes a token! Spaces, blank lines, and "
        "comments exist purely to help humans read the code — most lexers throw them away "
        "entirely, because later stages don't need them to understand the program's "
        "meaning.\n\n"
        "let total = 5;   // add the starting count\n"
        "let count = 0;\n\n"
        "The lexer sees this and quietly discards the comment and the extra spacing, "
        "producing just: let | total | = | 5 | ; | let | count | = | 0 | ;",
    calloutHints: [
      "🐍 Exception worth knowing: in whitespace-sensitive languages like Python, "
          "indentation itself IS meaningful and does get turned into real tokens (marking "
          "where a block starts and ends) — so \"whitespace is always ignored\" isn't "
          "universally true, just the common case.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each item into the correct bucket.",
      bucketALabel: '🧩 Becomes a token',
      bucketBLabel: '🗑️ Discarded by the lexer',
      items: [
        Sort2Item('kw', 'The keyword `return`', true),
        Sort2Item('comment', 'A single-line comment `// note to self`', false),
        Sort2Item('space', 'Extra spaces between two tokens', false),
        Sort2Item('num', 'The number literal `100`', true),
      ],
      explainOk:
          "Correct — real keywords, identifiers, and literals become tokens; comments and "
          "incidental whitespace are just thrown away by most lexers.",
      explainBad:
          "Anything carrying real meaning for the program (keywords, identifiers, "
          "literals, operators) becomes a token. Comments and incidental spacing exist only "
          "for humans and get discarded.",
    ),
  ),
  const Chapter(
    id: 8,
    title: 'When the Lexer Gets Confused',
    avatar: '😵',
    role: 'Narrator — hitting a weird character',
    bodyIntro:
        "😵 Sometimes the lexer itself can't even figure out what a chunk of text is "
        "supposed to be — before the parser ever gets a chance to think about grammar. "
        "That's a lexical error.\n\n"
        "💥 An unterminated string: \"hello — no closing quote, so the lexer never finds "
        "where the string token ends.\n\n"
        "❓ A completely unrecognized character, like @ in a language that never defined "
        "any meaning for it at all.\n\n"
        "🆚 This is different from a syntax error (which you'll meet formally at the "
        "parsing stage) — a lexical error means the text couldn't even be chopped into "
        "valid tokens in the first place; a syntax error means the tokens WERE valid "
        "individually, but arranged in an order the grammar doesn't allow.",
    calloutHints: [
      "🚨 Lexical errors happen earliest of all — before parsing, before type checking, "
          "before anything else. If the lexer can't even produce a clean token stream, none "
          "of the later stages can even begin.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Which of these is a classic LEXICAL error (something the lexer itself chokes "
          "on, before parsing even begins)?",
      options: [
        '`if (x` — missing the closing parenthesis and the rest of the if-statement',
        '`"hello` — a string literal that\'s missing its closing quote',
        '`x = y +` — an operator with no right-hand operand',
        'Calling a function with the wrong number of arguments',
      ],
      answerIndex: 1,
      explainOk:
          "Right — an unterminated string breaks tokenization itself; the lexer can't even "
          "decide where that token ends. The others are grammar/semantic problems from "
          "later stages.",
      explainBad:
          "Think about which problem breaks CHOPPING INTO TOKENS itself, not just arranging "
          "valid tokens. An unterminated string confuses the lexer before parsing even "
          "starts; missing parens or wrong argument counts are later-stage problems.",
    ),
  ),
  const Chapter(
    id: 9,
    title: 'Grammar Rules — A Recipe for Sentences',
    avatar: '📐',
    role: 'Narrator — learning the rulebook',
    bodyIntro:
        "📐 Once I have a clean stream of tokens, the next stage is parsing, done by the "
        "parser. It checks whether my tokens are arranged in a way the language's grammar "
        "actually allows.\n\n"
        "A grammar is just a set of rules describing valid shapes. A tiny example for "
        "simple math expressions:\n\n"
        "expr → expr + term\n"
        "expr → term\n"
        "term → NUMBER\n\n"
        "Read that as: \"an expr can be an expr plus a term, OR just a term by itself; a "
        "term can be a plain number.\" These rules let the parser recognize that 2 + 3 is "
        "a valid expr, built from two terms joined by +.",
    calloutHints: [
      "🍳 Think of a grammar like a recipe template: \"a sandwich is bread, then filling, "
          "then bread.\" It doesn't care WHAT filling you use, only that the overall shape "
          "is followed.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Using the grammar above, drag these derivation steps for `2 + 3` into the "
          "correct order.",
      items: [
        OrderItem('s1', 'Start with: expr'),
        OrderItem('s2', 'Apply rule: expr → expr + term'),
        OrderItem('s3', 'Reduce the left expr down to: term (which is 2)'),
        OrderItem('s4', 'Reduce the term on the right down to: NUMBER (which is 3)'),
      ],
      explainOk:
          "That's exactly how a grammar builds up recognition of `2 + 3` step by step, "
          "applying one rule at a time.",
      explainBad:
          "You always start from the top-level symbol (expr), apply a rule that matches "
          "the `+` shape, then work down each side until you hit actual numbers.",
    ),
  ),
  const Chapter(
    id: 10,
    title: 'Building the Tree (AST)',
    avatar: '🌳',
    role: 'Narrator — planting a tree',
    bodyIntro:
        "🌳 As the parser recognizes grammar rules, it doesn't just say \"yes, valid!\" — "
        "it builds an actual data structure capturing the program's shape: the Abstract "
        "Syntax Tree (AST).\n\n"
        "For 2 + 3 * 4, the AST looks like this (note: * binds tighter, so it's deeper in "
        "the tree — more on that next chapter):\n\n"
        "       +\n"
        "      / \\\n"
        "     2   *\n"
        "        / \\\n"
        "       3   4\n\n"
        "🧩 \"Abstract\" means the tree throws away things that don't matter for meaning — "
        "like exact spacing or parentheses used only for grouping — and keeps only the "
        "structural relationships: this node's children are its operands.",
    calloutHints: [
      "🎯 Every later stage (type checking, optimization, code generation) operates on "
          "this TREE, not on the original flat text. The AST is the shared internal "
          "\"shape\" the rest of the compiler actually works with.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In the AST for `2 + 3 * 4` shown above, what are the two direct children of "
          "the root `+` node?",
      options: [
        '2 and 3',
        '2 and the subtree representing `3 * 4`',
        '3 and 4',
        'The root has no children',
      ],
      answerIndex: 1,
      explainOk:
          "Right — the root `+` combines the literal `2` with the whole `3 * 4` subtree "
          "as its right child, which is exactly why multiplication happens before the "
          "addition.",
      explainBad:
          "Look at the tree again: the root `+` has two children — the leaf `2`, and the "
          "entire `*` subtree (which itself contains 3 and 4) as the other operand.",
    ),
  ),
  const Chapter(
    id: 11,
    title: 'Operator Precedence — Who Goes First?',
    avatar: '🥇',
    role: 'Narrator — settling an argument',
    bodyIntro:
        "🥇 Why does 2 + 3 * 4 equal 14, not 20? Because operator precedence says "
        "multiplication binds tighter than addition — it happens \"first,\" deeper in the "
        "tree, regardless of the order you read the symbols left to right.\n\n"
        "2 + 3 * 4\n"
        "= 2 + (3 * 4)     ← multiplication groups tighter\n"
        "= 2 + 12\n"
        "= 14\n\n"
        "📏 Associativity is the related rule for chains of the SAME operator: 10 - 3 - 2 "
        "is left-associative, meaning it groups as (10 - 3) - 2 = 5, not 10 - (3 - 2) = 9.",
    calloutHints: [
      "✍️ The parser encodes both precedence AND associativity directly into the SHAPE of "
          "the AST it builds — by the time you have the tree, you never need to remember "
          "precedence rules again; you just evaluate children before parents.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What does `10 - 4 / 2` evaluate to, respecting standard operator precedence?",
      options: ['3', '8', '5', '1'],
      answerIndex: 1,
      explainOk:
          "Right — division binds tighter than subtraction: 4 / 2 = 2 first, then 10 - 2 = 8.",
      explainBad:
          "Division happens first because it has higher precedence than subtraction: "
          "4 / 2 = 2, then 10 - 2 = 8.",
    ),
  ),
  const Chapter(
    id: 12,
    title: 'Syntax Errors — The Parser Gets Stuck',
    avatar: '🧱',
    role: 'Narrator — hitting a wall',
    bodyIntro:
        "🧱 Unlike a lexical error (bad characters), a syntax error means every individual "
        "token was perfectly valid — but their ARRANGEMENT doesn't match any grammar rule.\n\n"
        "let x = 5 +;   // '+' has no right-hand side — syntax error\n"
        "if x > 5 {     // missing the required parentheses around the condition\n\n"
        "🔍 The parser typically reports the exact spot it got stuck: \"expected an "
        "expression after '+', but found ';' instead.\" Good parsers also attempt error "
        "recovery — skipping ahead to a likely-safe point (like the next semicolon) so "
        "they can keep checking the REST of the file and report multiple errors in one "
        "pass, instead of stopping at the very first one.",
    calloutHints: [
      "🎯 This is a real production concern: a parser that stops dead at the first typo "
          "forces you to fix-and-recompile one error at a time. Good error recovery reports "
          "a whole batch of real problems in a single pass — a huge productivity "
          "difference on large files.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "`let x = 5 +;` — every character here is individually valid (no unterminated "
          "strings, no unknown symbols). What kind of error is the missing right-hand "
          "operand for `+`?",
      options: [
        'A lexical error, because `+` is an unusual character',
        "A syntax error — the tokens are all individually valid, but their arrangement doesn't match any grammar rule",
        'Not an error at all — the parser will just insert a default value',
        'A runtime error that only appears when the program executes',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — every token here is legitimate; the problem is purely about the "
          "ARRANGEMENT not matching the grammar. That's the textbook definition of a "
          "syntax error.",
      explainBad:
          "All the individual tokens (`let`, `x`, `=`, `5`, `+`, `;`) are perfectly valid "
          "tokens. The problem is their ORDER doesn't fit any grammar rule — that makes it "
          "a syntax error, not a lexical one.",
    ),
  ),
  const Chapter(
    id: 13,
    title: 'Naming Boxes',
    avatar: '📦',
    role: 'Narrator — labeling containers',
    bodyIntro:
        "📦 A variable is just a labeled box that holds a value. When I write "
        "let age = 10;, I'm asking the compiler to set aside a little storage slot, label "
        "it age, and put the value 10 inside.\n\n"
        "let age = 10;\n"
        "age = age + 1;   // open the box, take out 10, add 1, put 11 back in",
    calloutHints: [
      "🏷️ The NAME (age) is just for humans and the compiler to refer to the box by — "
          "under the hood, the compiler translates that name into an actual memory "
          "location (a stack slot, a register, whatever it decides is best).",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "After running `let age = 10;` then `age = age + 1;`, what value does `age` hold?",
      options: ['10', '11', '1', "It's undefined"],
      answerIndex: 1,
      explainOk:
          "Right — the box starts at 10, we read that value, add 1, and store 11 back "
          "into the very same box.",
      explainBad:
          "Read it step by step: age starts as 10. `age = age + 1` reads the CURRENT "
          "value (10), adds 1, and stores the result (11) back into the box.",
    ),
  ),
  const Chapter(
    id: 14,
    title: 'Who Can See My Box?',
    avatar: '🚪',
    role: 'Narrator — exploring rooms',
    bodyIntro:
        "🚪 Not every box is visible from everywhere in a program. Scope is the region of "
        "code where a variable's name is actually recognized.\n\n"
        "let outer = \"I'm global\";\n\n"
        "function greet() {\n"
        "  let inner = \"I'm local\";\n"
        "  print(outer);   // ✅ works — outer is visible everywhere\n"
        "  print(inner);   // ✅ works — inner is visible inside its own function\n"
        "}\n\n"
        "print(inner);      // ❌ error — inner doesn't exist out here!\n\n"
        "🏠 Think of scope like rooms in a house: a variable declared inside a room (a "
        "function, or often even a single block like an if) can usually only be seen from "
        "inside that same room or rooms nested within it — not from the hallway outside.",
    calloutHints: [
      "🌍 A global variable is visible from basically anywhere; a local variable only "
          "exists inside the block/function that declared it, and disappears once that "
          "block finishes.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Given the code above, drag each access into whether it's visible (valid) or not.",
      bucketALabel: '✅ Visible',
      bucketBLabel: '❌ Not visible / error',
      items: [
        Sort2Item('a', 'Reading `outer` from inside greet()', true),
        Sort2Item('b', 'Reading `inner` from inside greet()', true),
        Sort2Item('c', 'Reading `inner` from outside greet(), after it returns', false),
        Sort2Item('d', 'Reading `outer` from anywhere in the file', true),
      ],
      explainOk:
          "Correct — globals are visible everywhere; locals only live inside the block "
          "that declared them and vanish once that block ends.",
      explainBad:
          "Globals (like `outer`) are visible from anywhere in the file. Locals (like "
          "`inner`) only exist inside the function/block that declared them.",
    ),
  ),
  const Chapter(
    id: 15,
    title: "What's Inside the Box?",
    avatar: '🏷️',
    role: 'Narrator — reading the label',
    bodyIntro:
        "🏷️ A type describes what KIND of value is allowed to live inside a box — and "
        "what you're allowed to DO with it.\n\n"
        "🔢 int — whole numbers, like 42\n\n"
        "🌊 float — numbers with decimals, like 3.14\n\n"
        "📝 string — text, like \"hello\"\n\n"
        "✅ bool — just true or false\n\n"
        "Types matter because they define valid operations: adding two ints makes sense, "
        "but adding a string to a bool usually doesn't — the compiler can catch that kind "
        "of mistake before it ever causes a crash.",
    calloutHints: [
      "🧠 You'll see MUCH more on this soon — the entire next level is dedicated to WHEN "
          "a language decides to check these types (before running vs. while running).",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a value on the left, then click its type on the right.",
      pairs: [
        MatchPair('p1', '42', 'int'),
        MatchPair('p2', '3.14', 'float'),
        MatchPair('p3', '"hello"', 'string'),
        MatchPair('p4', 'true', 'bool'),
      ],
      explainOk:
          "All correct! Types are the compiler's way of knowing what a value can be used for.",
    ),
  ),
  const Chapter(
    id: 16,
    title: 'Shadowing — Two Boxes, Same Name',
    avatar: '👥',
    role: 'Narrator — meeting a twin',
    bodyIntro:
        "👥 What happens if I declare a variable with the SAME name as one that already "
        "exists in an outer scope? This is called shadowing — the inner variable "
        "temporarily \"hides\" the outer one, without destroying it.\n\n"
        "let x = \"outer\";\n\n"
        "function test() {\n"
        "  let x = \"inner\";   // shadows the outer x, inside this function only\n"
        "  print(x);          // prints \"inner\"\n"
        "}\n\n"
        "test();\n"
        "print(x);            // prints \"outer\" — completely untouched!",
    calloutHints: [
      "🎭 Shadowing isn't reassignment — it creates a totally SEPARATE box that just "
          "happens to share a name. Once the inner scope ends, the outer variable is "
          "exactly as it was, because it was never actually modified.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Given the code above, what does the final `print(x)` (outside the function, "
          "after `test()` runs) print?",
      options: ['"inner"', '"outer"', 'An error, because x is used twice', 'Nothing — the program crashes'],
      answerIndex: 1,
      explainOk:
          "Right — the inner `x` was a completely separate box that only existed inside "
          "test(). The outer `x` was never touched, so it still holds \"outer\".",
      explainBad:
          "Shadowing creates a NEW, separate box inside the function — it doesn't modify "
          "the outer one at all. So once test() finishes, the outer `x` is untouched and "
          "still says \"outer\".",
    ),
  ),
  const Chapter(
    id: 17,
    title: 'Deciding Types Early vs Late',
    avatar: '⚖️',
    role: 'Narrator — weighing two philosophies',
    bodyIntro:
        "⚖️ Every variable has a type — but WHEN does the language pin that type down?\n\n"
        "🏗️ Static typing — every variable's type is known and checked at compile time, "
        "before the program ever runs. Languages: Java, C, Rust, TypeScript.\n\n"
        "🌀 Dynamic typing — a variable's type is only known at run time, once it "
        "actually holds a real value, and can even change later. Languages: Python, "
        "JavaScript, Ruby.\n\n"
        "// static (e.g. Java-like):\n"
        "int age = 10;\n"
        "age = \"hello\";   // ❌ compile-time error — age must always hold an int\n\n"
        "// dynamic (e.g. Python-like):\n"
        "age = 10\n"
        "age = \"hello\"    // ✅ totally fine — age can hold anything, anytime",
    calloutHints: [
      "🎯 Neither is objectively \"better\" — static typing catches whole categories of "
          "bugs before your users ever see them; dynamic typing lets you write and change "
          "code faster with less upfront ceremony. You'll compare the tradeoffs directly "
          "soon.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A variable is declared to hold an int at compile time, and reassigning it to "
          "a string produces a compile error before the program ever runs. What kind of "
          "typing is this?",
      options: ['Dynamic typing', 'Static typing', 'Duck typing', 'No typing at all'],
      answerIndex: 1,
      explainOk:
          "Right — types being fixed and checked BEFORE the program runs is the defining "
          "trait of static typing.",
      explainBad:
          "The key signal is WHEN the check happens: catching a type mismatch at compile "
          "time, before running, is exactly what static typing means.",
    ),
  ),
  const Chapter(
    id: 18,
    title: 'Type Errors: Caught by the Teacher vs Caught by You',
    avatar: '🧑‍🏫',
    role: 'Narrator — comparing report cards',
    bodyIntro:
        "🧑‍🏫 Here's the practical consequence of the last chapter's split. Imagine this "
        "bug: a function expects a number but somewhere gets a string instead.\n\n"
        "🏗️ In a statically typed language, the compiler is like a strict teacher grading "
        "your homework BEFORE you hand it in — it flags the mismatch immediately, and you "
        "fix it before the program ever ships.\n\n"
        "🌀 In a dynamically typed language, there's no teacher checking ahead of time — "
        "the mistake only surfaces when that exact buggy line actually executes, which "
        "might be in production, months later, on a path nobody tested.",
    calloutHints: [
      "🚨 This is a REAL, well-documented production risk: dynamically typed codebases "
          "often lean hard on automated tests and gradual typing tools (like Python's type "
          "hints + mypy, or TypeScript over JavaScript) specifically to get some of static "
          "typing's early-catching benefits back.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A dynamically typed function is accidentally called with a string where a "
          "number was expected, on a code path with no test coverage. When will this bug "
          "most likely be discovered?",
      options: [
        'Immediately, at compile time, before the program runs',
        'Only when that exact code path actually executes at run time — potentially in production',
        'It can never be discovered',
        'The language will automatically convert the string into the correct number',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — dynamic typing defers the check to run time, so an untested code "
          "path can ship with a type bug hiding in it until it's actually triggered.",
      explainBad:
          "Without compile-time type checking, the mismatch simply isn't caught until "
          "that specific line actually runs — which, without test coverage, could be well "
          "after shipping.",
    ),
  ),
  const Chapter(
    id: 19,
    title: 'Duck Typing and Flexibility',
    avatar: '🦆',
    role: 'Narrator — meeting a duck',
    bodyIntro:
        "🦆 Many dynamically typed languages embrace a philosophy called duck typing: "
        "\"if it walks like a duck and quacks like a duck, treat it like a duck\" — "
        "meaning code cares about WHAT a value can do, not what its declared type is.\n\n"
        "function makeItSpeak(thing) {\n"
        "  thing.speak();   // works on ANY object that has a speak() method —\n"
        "}                   // Dog, Cat, Robot — no shared type required!\n\n"
        "🎯 This buys real flexibility: you can write one function that works with many "
        "unrelated types, as long as they each happen to support the right operations — "
        "no upfront class hierarchy required.",
    calloutHints: [
      "⚠️ The tradeoff: if thing DOESN'T have a speak() method, you don't find out until "
          "that exact call actually runs and crashes — there's no compiler "
          "double-checking every possible caller ahead of time.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What does \"duck typing\" mean in a dynamically typed language?",
      options: [
        'Every value must inherit from a class literally named Duck',
        'Code cares only about whether a value SUPPORTS the operations it needs (like having a speak() method), not its declared type',
        "It's a compiler feature exclusive to statically typed languages",
        'It means the language cannot have any functions at all',
      ],
      answerIndex: 1,
      explainOk:
          "Right — duck typing means \"can it do what I need\" matters more than \"what "
          "type is it officially declared as.\"",
      explainBad:
          "Duck typing is about behavior over declared type: if an object supports the "
          "method/operation you call, it works — regardless of its formal type or class "
          "hierarchy.",
    ),
  ),
  const Chapter(
    id: 20,
    title: 'The Tradeoffs, Compared',
    avatar: '📊',
    role: 'Narrator — drawing the final scoreboard',
    bodyIntro:
        "📊 Time to put static and dynamic typing side by side, one last time, with the "
        "full picture in view:\n\n"
        "Static: type errors caught at compile time; more upfront ceremony "
        "(declarations); tooling can autocomplete/refactor confidently; great for large, "
        "long-lived codebases.\n\n"
        "Dynamic: type errors caught at run time; faster to write and prototype; tooling "
        "has to guess more; great for quick scripts and experiments.",
    calloutHints: [
      "🌉 Many real languages now blend both worlds — TypeScript adds static types on "
          "top of dynamic JavaScript; Python supports optional type hints checked by "
          "external tools. This \"gradual typing\" trend is exactly engineers trying to "
          "get the best of both.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each strength into the typing discipline it's most associated with.",
      bucketALabel: '🏗️ Static typing',
      bucketBLabel: '🌀 Dynamic typing',
      items: [
        Sort2Item('s1', 'A large refactor is safer because the compiler flags every broken usage', true),
        Sort2Item('s2', 'A quick one-off script can be written with almost no ceremony', false),
        Sort2Item('s3', 'One function can trivially accept many unrelated types via duck typing', false),
        Sort2Item('s4', "IDE autocomplete can reliably suggest a value's exact available methods", true),
      ],
      explainOk:
          "That's the honest scoreboard — static typing shines on safety and tooling at "
          "scale, dynamic typing shines on speed and flexibility.",
      explainBad:
          "Static typing's strengths come from checking EVERYTHING ahead of time (safe "
          "refactors, precise tooling). Dynamic typing's strengths come from having NO "
          "upfront type ceremony (fast scripts, flexible duck typing).",
    ),
  ),
  const Chapter(
    id: 21,
    title: 'Functions as Recipes',
    avatar: '🍳',
    role: 'Narrator — writing a recipe card',
    bodyIntro:
        "🍳 A function is a reusable recipe: give it some ingredients (parameters), it "
        "does its steps, and it hands back a result (the return value).\n\n"
        "function double(n) {\n"
        "  return n * 2;\n"
        "}\n\n"
        "double(5);   // → 10\n"
        "double(21);  // → 42\n\n"
        "🔁 The whole point is reuse — write the recipe once, and \"call\" it as many "
        "times as you like with different ingredients, instead of copy-pasting the steps "
        "everywhere.",
    calloutHints: [
      "📇 Compilers actually implement each function call using that call stack you may "
          "have already met in other subjects — calling double(5) pushes a new stack frame "
          "holding n = 5, runs the recipe, and pops the frame away once it returns.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Given `function square(n) { return n * n; }`, what does `square(6)` return?",
      options: ['12', '36', '6', '0'],
      answerIndex: 1,
      explainOk: "Right — 6 * 6 = 36.",
      explainBad:
          "The function body multiplies its input by itself: n * n. With n = 6, that's "
          "6 * 6 = 36.",
    ),
  ),
  const Chapter(
    id: 22,
    title: 'Passing Ingredients',
    avatar: '🧺',
    role: 'Narrator — handing over the basket',
    bodyIntro:
        "🧺 When you call a function, its parameters get filled in with whatever "
        "arguments you pass — but exactly HOW they're handed over matters.\n\n"
        "📋 Pass by value — the function gets its OWN copy of the value. Changing the "
        "parameter inside the function never affects the caller's original.\n\n"
        "📌 Pass by reference — the function gets a way to reach the SAME underlying data "
        "as the caller. Changes inside the function ARE visible to the caller.\n\n"
        "function tryToChange(x) {\n"
        "  x = 99;   // if passed by value: caller's variable is untouched\n"
        "}\n\n"
        "let a = 5;\n"
        "tryToChange(a);\n"
        "print(a);   // prints 5 if pass-by-value",
    calloutHints: [
      "🌍 Real languages mix these: many pass simple values (numbers, bools) by value, "
          "but pass objects/arrays by a reference to the same underlying data — which is "
          "exactly why mutating an object INSIDE a function can surprise you if you "
          "expected value semantics everywhere.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A function reassigns its parameter `x = 99` internally, and the caller's "
          "original variable is completely unaffected afterward. Which passing style does "
          "this describe?",
      options: ['Pass by reference', 'Pass by value', 'Pass by name', 'This can never happen in any language'],
      answerIndex: 1,
      explainOk:
          "Right — the function got its own independent copy, so reassigning it inside "
          "had zero effect on the caller's variable.",
      explainBad:
          "If the caller's original variable is unaffected by changes made inside the "
          "function, the function must have been working on its OWN copy — that's pass by "
          "value.",
    ),
  ),
  const Chapter(
    id: 23,
    title: 'The Backpack a Function Carries',
    avatar: '🎒',
    role: 'Narrator — packing a backpack',
    bodyIntro:
        "🎒 A closure is a function that \"remembers\" variables from the scope it was "
        "created in, even after that outer scope has finished running.\n\n"
        "function makeCounter() {\n"
        "  let count = 0;\n"
        "  return function() {\n"
        "    count = count + 1;   // remembers 'count' from makeCounter's scope!\n"
        "    return count;\n"
        "  };\n"
        "}\n\n"
        "let counter = makeCounter();\n"
        "counter();   // → 1\n"
        "counter();   // → 2\n\n"
        "🎒 Even though makeCounter() already finished and returned, the little inner "
        "function still carries a \"backpack\" holding a live reference to count — that's "
        "the closure. Each call to counter() reaches into that same backpack.",
    calloutHints: [
      "🧠 This is exactly WHY that memory can't simply live on the stack and be thrown "
          "away when makeCounter() returns — the compiler must keep count alive on the "
          "heap instead, for as long as the closure that references it still exists. "
          "You'll connect this directly to stack vs. heap in the next level.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Using the makeCounter() example above, what does a SECOND call to `counter()` "
          "return?",
      options: ['1', '2', '0', 'undefined, because makeCounter() already returned'],
      answerIndex: 1,
      explainOk:
          "Right — the closure remembers `count` between calls. First call: count becomes "
          "1. Second call: count becomes 2.",
      explainBad:
          "The closure keeps `count` alive between calls, and each call increments it by "
          "1. First call → 1. Second call → 2, not back to 1 or 0.",
    ),
  ),
  const Chapter(
    id: 24,
    title: 'Higher-Order Functions',
    avatar: '🎩',
    role: 'Narrator — treating functions like values',
    bodyIntro:
        "🎩 In many languages, functions are just values, like numbers or strings — you "
        "can pass them as arguments, return them from other functions, and store them in "
        "variables. A function that takes or returns another function is called a "
        "higher-order function.\n\n"
        "function applyTwice(fn, value) {\n"
        "  return fn(fn(value));\n"
        "}\n\n"
        "applyTwice(double, 5);   // double(double(5)) → double(10) → 20\n\n"
        "🧰 This is the foundation behind familiar tools like map, filter, and reduce — "
        "each is just a higher-order function that takes YOUR function and applies it "
        "across a collection.",
    calloutHints: [
      "🔗 Higher-order functions and closures (last chapter) pair naturally: a function "
          "that RETURNS a customized function (like makeCounter) is both at once — a "
          "higher-order function producing a closure.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Given `function double(n) { return n * 2; }`, what does `applyTwice(double, "
          "3)` return, using the definition above?",
      options: ['6', '9', '12', '3'],
      answerIndex: 2,
      explainOk: "Right — double(double(3)) = double(6) = 12.",
      explainBad:
          "applyTwice calls fn twice, nested: fn(fn(value)). That's double(double(3)) = "
          "double(6) = 12.",
    ),
  ),
  const Chapter(
    id: 25,
    title: 'Two Kinds of Storage, Revisited',
    avatar: '🗄️',
    role: 'Narrator — reopening two drawers',
    bodyIntro:
        "🗄️ Every compiled or interpreted program needs somewhere to put its data while "
        "running. Two very different storage areas handle almost all of it:\n\n"
        "📚 The stack — fast, automatic, and strictly ordered (last in, first out). It "
        "grows and shrinks precisely as functions are called and return.\n\n"
        "📦 The heap — flexible, but must be managed (manually, or by a garbage "
        "collector). Data here can outlive the function that created it.",
    calloutHints: [
      "🎯 Here's the compiler's job specifically: for every single value your program "
          "creates, the compiler must DECIDE — stack or heap? — and that decision quietly "
          "shapes your program's performance far more than most programmers realize.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each trait into the storage area it describes.",
      bucketALabel: '📚 Stack',
      bucketBLabel: '📦 Heap',
      items: [
        Sort2Item('t1', 'Grows/shrinks automatically with function calls, LIFO order', true),
        Sort2Item('t2', 'Data can outlive the function that created it', false),
        Sort2Item('t3', 'Extremely fast to allocate — just move a pointer', true),
        Sort2Item('t4', 'Requires explicit management (manual free or a garbage collector)', false),
      ],
      explainOk:
          "Correct — stack is fast/automatic/short-lived; heap is flexible/managed/long-lived.",
      explainBad:
          "Stack memory is automatic and fast but temporary (tied to function calls). "
          "Heap memory can live longer, but always requires some form of explicit "
          "management.",
    ),
  ),
  const Chapter(
    id: 26,
    title: 'Where Local Variables Live',
    avatar: '🥞',
    role: 'Narrator — watching frames stack up',
    bodyIntro:
        "🥞 When the compiler generates code for a function, it decides how much stack "
        "space that call needs, and lays out every local variable at a fixed offset "
        "inside that function's stack frame.\n\n"
        "function sum3(a, b, c) {\n"
        "  let total = a + b + c;   // 'total' gets a fixed slot in sum3's stack frame\n"
        "  return total;\n"
        "}\n\n"
        "📏 Because the compiler can usually calculate the exact size a function's frame "
        "needs (each local variable has a known, fixed size) BEFORE the program even "
        "runs, stack allocation is essentially free at run time — the CPU just moves a "
        "stack pointer.",
    calloutHints: [
      "⚠️ The catch: everything in that frame disappears the instant the function "
          "returns. If you need a value to survive past the function call that created it, "
          "the stack alone can't help — that's where the heap comes in, next chapter.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Why is allocating a local variable on the stack essentially free at run time?",
      options: [
        'Because the compiler can compute the exact frame size ahead of time, so allocating is just moving a stack pointer',
        "Because stack memory doesn't actually exist in real hardware",
        'Because local variables are always stored as string literals',
        'Because the garbage collector pre-allocates every possible local variable in advance',
      ],
      answerIndex: 0,
      explainOk:
          "Exactly — known sizes at compile time mean the run-time cost is just adjusting "
          "one pointer, no search or bookkeeping needed.",
      explainBad:
          "The key reason is that sizes are known ahead of time (at compile time), so the "
          "actual run-time work is trivial: bump a stack pointer by a fixed, precomputed "
          "amount.",
    ),
  ),
  const Chapter(
    id: 27,
    title: 'Where Objects Live',
    avatar: '🏠',
    role: 'Narrator — building something that outlasts a visit',
    bodyIntro:
        "🏠 Some data needs to outlive the function that created it — like an object "
        "returned from a function, or a value shared between many parts of a program. "
        "That data goes on the heap instead.\n\n"
        "function makeUser(name) {\n"
        "  let user = { name: name, age: 0 };   // allocated on the heap\n"
        "  return user;   // survives after makeUser() returns!\n"
        "}\n\n"
        "🔑 Since the compiler generally CAN'T know exactly when heap data will stop "
        "being needed just from looking at the function's structure, it either requires "
        "explicit cleanup (manual languages) or hands the job to a garbage collector "
        "(most modern languages) — the subject of the very next level.",
    calloutHints: [
      "💸 The tradeoff: heap allocation is more flexible than the stack but slower — it "
          "usually involves searching for free space and bookkeeping, rather than just "
          "bumping a pointer.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A function creates an object and returns it to its caller, who keeps using it "
          "long after the function call ends. Where must that object live?",
      options: [
        "On the stack, in the function's own frame",
        'On the heap, since it must outlive the function call that created it',
        "It doesn't need to be stored anywhere",
        "In the CPU's registers permanently",
      ],
      answerIndex: 1,
      explainOk:
          "Right — anything that needs to survive past the function call that made it "
          "can't live in that call's stack frame; it has to be heap-allocated.",
      explainBad:
          "Stack frames are destroyed the instant their function returns. Since this "
          "object needs to survive AFTER the function returns, it must be allocated on "
          "the heap instead.",
    ),
  ),
  const Chapter(
    id: 28,
    title: 'Escape Analysis — Does It Have to Go on the Heap?',
    avatar: '🕵️',
    role: 'Narrator — investigating an escape route',
    bodyIntro:
        "🕵️ Here's a clever optimization real compilers perform: escape analysis. Even "
        "if you write code that LOOKS like it should heap-allocate an object, the "
        "compiler can sometimes prove that object never actually \"escapes\" the "
        "function — meaning nothing outside keeps a reference to it after the function "
        "returns.\n\n"
        "function distanceSquared(x, y) {\n"
        "  let point = { x: x, y: y };   // looks heap-like...\n"
        "  return point.x * point.x + point.y * point.y;\n"
        "}   // ...but 'point' never escapes! Compiler can safely put it on the stack instead.\n\n"
        "🚀 If the compiler proves the object doesn't escape, it can allocate it on the "
        "much cheaper stack instead of the heap — a real, measurable performance win "
        "that requires zero changes to your source code.",
    calloutHints: [
      "🏭 This is exactly the kind of optimization production compilers (Go's compiler "
          "is a famous example) perform automatically — you write natural-looking code, "
          "and the compiler quietly figures out the cheapest safe place to put your data.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What question is escape analysis specifically trying to answer about an allocated value?",
      options: [
        "Whether the value's type is static or dynamic",
        'Whether any reference to this value could still be used after the function that created it returns',
        'Whether the value is a number or a string',
        'Whether the program will run out of memory',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — if nothing outlives the function (the value never 'escapes'), the "
          "compiler can safely use cheap stack allocation instead of the heap.",
      explainBad:
          "Escape analysis is about LIFETIME, not type: it asks whether a reference to "
          "the value could possibly be used after its creating function returns. If not, "
          "stack allocation is safe.",
    ),
  ),
  const Chapter(
    id: 29,
    title: 'Who Cleans Up?',
    avatar: '🧹',
    role: "Narrator — asking who's on cleanup duty",
    bodyIntro:
        "🧹 Heap memory that's no longer needed has to be freed, or your program's "
        "memory usage just keeps growing forever. Who does that cleanup?\n\n"
        "✋ Manual management (C, C++) — YOU explicitly call free() / delete when you're "
        "done with something. Powerful, but forgetting causes a memory leak, and freeing "
        "too early causes a dangling pointer.\n\n"
        "🤖 Automatic (garbage collection) (Java, Python, Go, JavaScript) — the language "
        "runtime figures out on its own when memory is no longer reachable, and frees it "
        "for you.",
    calloutHints: [
      "⚖️ Manual management gives precise control and can be faster, but puts the entire "
          "burden of correctness on the programmer. Garbage collection removes that whole "
          "category of bugs, at the cost of some unpredictability in exactly when memory "
          "gets freed — the next two chapters cover the two classic ways GC actually works.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each language's typical memory management style into the correct bucket.",
      bucketALabel: '✋ Manual',
      bucketBLabel: '🤖 Garbage collected',
      items: [
        Sort2Item('c', 'C — you call free() yourself', true),
        Sort2Item('java', "Java — the JVM's garbage collector handles it", false),
        Sort2Item('cpp', 'C++ — you call delete yourself (unless using smart pointers)', true),
        Sort2Item('py', "Python — the interpreter's GC handles it", false),
      ],
      explainOk:
          "Correct — C and (raw) C++ hand memory management to the programmer; Java and "
          "Python hand it to an automatic garbage collector.",
      explainBad:
          "Manual languages require an explicit free/delete call from the programmer. "
          "Garbage-collected languages have the runtime detect and reclaim unreachable "
          "memory automatically.",
    ),
  ),
  const Chapter(
    id: 30,
    title: 'Reference Counting',
    avatar: '🔢',
    role: 'Narrator — keeping a tally',
    bodyIntro:
        "🔢 Reference counting is one of the simplest GC strategies: every heap object "
        "keeps a running count of how many references point to it. When a new reference "
        "is made, the count goes up. When a reference goes away, the count goes down. "
        "The instant it hits zero, nothing can reach that object anymore, so it's freed "
        "immediately.\n\n"
        "let a = makeObject();   // refcount = 1\n"
        "let b = a;               // refcount = 2 (b points at the same object)\n"
        "a = null;                // refcount = 1\n"
        "b = null;                // refcount = 0 → freed immediately!",
    calloutHints: [
      "✅ Big advantage: memory is reclaimed the MOMENT it becomes unreachable — no "
          "waiting, no unpredictable pauses. This is exactly how Python and Swift manage "
          "most of their memory. But there's a serious weakness coming next chapter.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "An object starts with refcount 1 (from `a`). Then `b = a` runs (refcount 2). "
          "Then `a = null` runs. What is the refcount now, and is the object freed?",
      options: [
        'Refcount 0, freed',
        'Refcount 1, not freed — `b` still points to it',
        'Refcount 2, not freed',
        'Refcount -1, error',
      ],
      answerIndex: 1,
      explainOk:
          "Right — removing just one of two references drops the count to 1, and since "
          "it's still above zero (b still holds it), the object survives.",
      explainBad:
          "Refcount only reaches 0 (and gets freed) when EVERY reference is gone. Here "
          "`b` still points to the object after `a = null`, so the count is 1, not 0.",
    ),
  ),
  const Chapter(
    id: 31,
    title: 'Mark-and-Sweep',
    avatar: '🔍',
    role: 'Narrator — hunting for the reachable',
    bodyIntro:
        "🔍 Mark-and-sweep works completely differently from reference counting. Instead "
        "of tracking counts continuously, it periodically pauses and does a full sweep:\n\n"
        "🌱 Mark — starting from a set of known \"roots\" (global variables, "
        "currently-active stack variables), follow every reference outward, marking "
        "every object you can actually reach.\n\n"
        "🧹 Sweep — walk through ALL heap objects. Anything left unmarked was "
        "unreachable, and gets freed.",
    calloutHints: [
      "🎯 This is a much better fit for one specific case that breaks reference counting "
          "entirely — you'll see exactly which one next chapter. The tradeoff: "
          "mark-and-sweep runs periodically rather than instantly, and a full sweep can "
          "pause your program noticeably if not carefully engineered.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these steps of a single mark-and-sweep collection cycle into the correct order.",
      items: [
        OrderItem('s1', 'Start from the roots (globals, active stack variables)'),
        OrderItem('s2', 'Follow every reference outward, marking every reachable object'),
        OrderItem('s3', 'Walk the entire heap looking for unmarked objects'),
        OrderItem('s4', 'Free every object that was never marked'),
      ],
      explainOk:
          "That's the full cycle — mark everything reachable from the roots first, then "
          "sweep away everything that was never touched.",
      explainBad:
          "You must mark BEFORE you sweep: first trace out everything reachable from the "
          "roots, THEN walk the whole heap and free whatever was never marked.",
    ),
  ),
  const Chapter(
    id: 32,
    title: 'Cycles — The Reference Counting Weakness',
    avatar: '🔄',
    role: 'Narrator — finding a loop',
    bodyIntro:
        "🔄 Here's reference counting's fatal weakness: reference cycles. If object A "
        "points to object B, and B points right back to A, their refcounts can NEVER "
        "reach zero — even if nothing outside the cycle can reach either of them "
        "anymore!\n\n"
        "let a = makeObject();\n"
        "let b = makeObject();\n"
        "a.friend = b;   // a → b\n"
        "b.friend = a;   // b → a  (a cycle!)\n"
        "a = null;\n"
        "b = null;\n"
        "// Both objects are now unreachable from outside...\n"
        "// ...but a.friend and b.friend still point to each other, refcount stays 1 "
        "each — LEAK!\n\n"
        "✅ Mark-and-sweep never has this problem — it only cares about what's reachable "
        "FROM THE ROOTS, and a cycle with no path from any root is simply never marked, "
        "so it gets swept away correctly regardless of internal cycles.",
    calloutHints: [
      "🏭 This is exactly why production garbage collectors (Python's, Go's, the JVM's) "
          "either add a periodic cycle-detecting pass ON TOP of reference counting, or "
          "abandon reference counting entirely in favor of tracing (mark-and-sweep-style) "
          "collection.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Two objects reference each other (A→B, B→A) and nothing outside points to "
          "either. Under PURE reference counting (no cycle detection), what happens?",
      options: [
        'Both are freed immediately, since nothing external references them',
        'Neither is ever freed — their refcounts stay above zero forever because they reference each other',
        'The program crashes instantly',
        'Only one of the two objects is freed',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — each object still has one incoming reference (from its cycle "
          "partner), so its refcount never drops to zero, even though the pair is "
          "completely unreachable from outside.",
      explainBad:
          "Refcounting only frees an object when ITS OWN count hits zero. Since A and B "
          "point at each other, each keeps the other's count at 1 forever — a classic "
          "memory leak, invisible to pure refcounting.",
    ),
  ),
  const Chapter(
    id: 33,
    title: 'One More Translation Step: IR',
    avatar: '🔗',
    role: 'Narrator — inserting a middle layer',
    bodyIntro:
        "🔗 Real compilers rarely jump straight from AST to machine code. In between, "
        "they usually translate the AST into an Intermediate Representation (IR) — a "
        "simpler, more uniform, lower-level format that's still independent of any "
        "specific CPU.\n\n"
        "AST for \"a + b * c\"     IR (three-address code style)\n"
        "                          t1 = b * c\n"
        "                          t2 = a + t1\n\n"
        "🧱 IR breaks complex nested expressions down into small, uniform steps — usually "
        "one operation per line, with explicit temporary variables (t1, t2) holding "
        "intermediate results. This uniform shape makes it MUCH easier to write analysis "
        "and optimization passes than working directly on a tangled tree.",
    calloutHints: [
      "🏭 Real-world example: LLVM IR is used by Clang (C/C++), Rust, and Swift compilers "
          "alike — all three completely different front-end languages funnel down into "
          "the SAME intermediate format, which is exactly what the next chapters build "
          "toward understanding why that's so powerful.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these stages into the correct, more complete pipeline order.",
      items: [
        OrderItem('src', 'Source code'),
        OrderItem('tok', 'Tokens'),
        OrderItem('ast', 'AST'),
        OrderItem('ir', 'Intermediate Representation (IR)'),
        OrderItem('mc', 'Machine code'),
      ],
      explainOk:
          "Right — IR sits between the AST and final machine code, giving optimizations a "
          "simpler, uniform format to work on.",
      explainBad:
          "The AST is built first from tokens, THEN lowered into a simpler IR, and only "
          "the IR gets translated into final machine code — IR is a middle step, not the "
          "final one.",
    ),
  ),
  const Chapter(
    id: 34,
    title: 'Constant Folding',
    avatar: '➗',
    role: 'Narrator — doing the math early',
    bodyIntro:
        "➗ Constant folding is one of the simplest, most common optimizations: if the "
        "compiler can compute a result at compile time (because all the inputs are "
        "known constants), why make the CPU redo that exact same math every single time "
        "the program runs?\n\n"
        "// Before folding:\n"
        "let area = 3.14159 * 10 * 10;\n\n"
        "// After constant folding — the compiler already did the math:\n"
        "let area = 314.159;",
    calloutHints: [
      "🎯 This works transitively too: let x = 2 + 3; let y = x * 4; can fold all the "
          "way down to let y = 20; if the compiler can prove x is never reassigned — real "
          "optimizers chain many small passes like this together.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which expression can a compiler safely constant-fold entirely at compile time?",
      options: [
        '`5 * userInputValue` where userInputValue comes from something typed by the user at run time',
        '`3 + 4 * 2` where every operand is a literal number known right in the source code',
        '`readFromNetwork() + 1`',
        '`currentTimestamp() * 2`',
      ],
      answerIndex: 1,
      explainOk:
          "Right — every value in `3 + 4 * 2` is a literal known at compile time, so the "
          "compiler can just compute 11 once and bake it in.",
      explainBad:
          "Constant folding only works when EVERY operand is known at compile time. User "
          "input, network calls, and timestamps are only known at run time, so those "
          "can't be folded.",
    ),
  ),
  const Chapter(
    id: 35,
    title: 'Dead Code Elimination',
    avatar: '🗑️',
    role: 'Narrator — sweeping out the unused',
    bodyIntro:
        "🗑️ Dead code elimination removes code that provably has no effect on the "
        "program's observable behavior — because its result is never used, or because "
        "it's unreachable entirely.\n\n"
        "function compute() {\n"
        "  let unused = expensiveCalculation();   // result never used anywhere — DEAD\n"
        "  return 42;\n"
        "}\n\n"
        "if (false) {\n"
        "  doSomething();   // unreachable — DEAD\n"
        "}\n\n"
        "🚀 Removing dead code shrinks the final program and can speed it up, since the "
        "CPU never wastes time running instructions that couldn't possibly matter.",
    calloutHints: [
      "⚠️ The compiler has to be careful: it must PROVE a piece of code has no "
          "observable effect (no side effects like printing, writing to a file, or "
          "network calls) before it's safe to delete — this is why calling an unused "
          "pure function is safer to eliminate than calling an unused function that "
          "might, say, send an email.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each snippet into whether it's safe to eliminate as dead code, or must be kept.",
      bucketALabel: '🗑️ Safe to eliminate',
      bucketBLabel: '✅ Must be kept',
      items: [
        Sort2Item('d1', '`let x = 5 + 3;` where x is never read anywhere afterward', true),
        Sort2Item('d2', '`if (false) { doThing(); }` — the branch can never execute', true),
        Sort2Item('d3', '`sendEmail(); ` even though its return value is never used', false),
        Sort2Item('d4', '`print("done");` at the end of the function', false),
      ],
      explainOk:
          "Correct — unused pure results and unreachable branches are safe to remove; "
          "anything with an observable side effect (sending an email, printing) must "
          "stay, whether or not its return value is used.",
      explainBad:
          "Safe-to-remove code has NO observable effect at all (an unused computation, an "
          "unreachable branch). Code with side effects — printing, sending, writing — "
          "must be kept even if its return value is unused.",
    ),
  ),
  const Chapter(
    id: 36,
    title: 'Why IR Makes Multiple Backends Possible',
    avatar: '🌉',
    role: 'Narrator — seeing the bridge',
    bodyIntro:
        "🌉 Here's the payoff for introducing IR: it acts as a shared bridge between "
        "many frontends (one per source language) and many backends (one per target CPU "
        "architecture).\n\n"
        "C, Rust, and Swift all lower down into a shared, optimized IR, which is then "
        "translated to x86 machine code, ARM machine code, or WebAssembly.\n\n"
        "🧩 Without a shared IR, you'd need a completely separate optimizer written for "
        "every single (language × CPU architecture) combination. WITH a shared IR, you "
        "write your optimizations ONCE against the IR, and every frontend/backend pair "
        "benefits automatically.",
    calloutHints: [
      "🏭 This is precisely how LLVM works in the real world: Clang, Rust's compiler "
          "(rustc), and Swift's compiler all lower down to LLVM IR, share the SAME "
          "battle-tested optimization passes, and can each target x86, ARM, WebAssembly, "
          "and more — without reinventing optimization logic per language.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the main engineering benefit of multiple languages sharing one common "
          "IR, rather than each having its own separate optimizer for each target CPU?",
      options: [
        "It makes the compiler's source code shorter to read",
        'Optimizations written once against the shared IR automatically benefit every language and every target CPU that lowers into that IR',
        'It removes the need for a lexer or parser entirely',
        'It guarantees the program will never have bugs',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — a shared IR means N languages and M targets need roughly N+M pieces "
          "of work, not N×M — a huge engineering leverage win.",
      explainBad:
          "The core win is reuse: instead of writing (languages × target CPUs) separate "
          "optimizers, you write optimizations ONCE against the shared IR, and every "
          "language/target combination benefits.",
    ),
  ),
  const Chapter(
    id: 37,
    title: 'Type Inference — Letting the Compiler Guess',
    avatar: '🕵️‍♀️',
    role: 'Narrator — professional tier begins',
    bodyIntro:
        "🏆 Welcome to the professional tier. From here on, we're operating at the depth "
        "expected of a working compiler/language engineer, not a classroom overview.\n\n"
        "🕵️‍♀️ Type inference lets a statically typed language determine a variable's "
        "type automatically, from context, without an explicit annotation:\n\n"
        "let x = 5;          // inferred as int, from the literal\n"
        "let y = x + 2.5;     // must reconcile int and float — inferred as float (or a "
        "compile error, language-dependent)\n"
        "let items = [];      // harder: no elements to infer FROM at all!\n\n"
        "⚙️ The compiler works this out by walking the AST and propagating type "
        "constraints: \"whatever x is, y must be compatible with adding 2.5 to it.\" Full "
        "inference (as in Haskell or OCaml) can even infer the types of entire function "
        "signatures with zero annotations, based purely on how their parameters are used "
        "inside the body.",
    calloutHints: [
      "💼 Production reality: TypeScript, Rust, Kotlin, and Swift all use substantial "
          "inference so you rarely need to annotate every single variable — but each also "
          "has known cases where inference genuinely can't determine a type (like the "
          "empty array above) and requires an explicit annotation or defaults to "
          "something imprecise like any.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In a statically typed language with inference, which of these is HARDEST for "
          "the compiler to infer a precise type for, with zero context?",
      options: [
        '`let x = 5;` — an integer literal',
        '`let items = [];` — an empty array literal, with no elements and no later usage in scope',
        '`let name = "Ada";` — a string literal',
        '`let flag = true;` — a boolean literal',
      ],
      answerIndex: 1,
      explainOk:
          "Right — literals directly reveal their type, but an empty collection gives the "
          "inference engine nothing to work from until it sees how the collection is "
          "actually used.",
      explainBad:
          "Literal values (numbers, strings, booleans) directly reveal their own type. An "
          "EMPTY collection gives no such clue — the compiler needs to see later usage "
          "(or an explicit annotation) to pin down what it holds.",
    ),
  ),
  const Chapter(
    id: 38,
    title: 'Unification and the Hindley-Milner Idea',
    avatar: '🧩',
    role: 'Narrator — solving a puzzle of constraints',
    bodyIntro:
        "🧩 Full type inference (as done by Haskell, OCaml, and F#) is formalized by the "
        "Hindley-Milner algorithm, built around a core idea called unification: collect "
        "type constraints from the whole program, then solve them like a system of "
        "equations.\n\n"
        "function identity(x) { return x; }\n"
        "// Constraint: identity's parameter type = identity's return type\n"
        "// Solution: identity : forall T. T -> T   (works for ANY type T)\n\n"
        "🔬 Unification walks the AST generating constraints (\"this expression's type "
        "must equal that expression's type\"), then solves them by finding the most "
        "GENERAL type that satisfies every constraint simultaneously — producing a "
        "principal type: the single most general type from which every valid, more "
        "specific usage can be derived.",
    calloutHints: [
      "💼 Production reality: Hindley-Milner inference is why OCaml/Haskell programmers "
          "write remarkably few type annotations yet still get full static type safety — "
          "but it's also why type error messages in these languages can be notoriously "
          "confusing: the REAL mistake might be far from where the unification solver "
          "finally detects a contradiction.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "In Hindley-Milner style inference, what is unification's core job?",
      options: [
        'Deleting dead code from the program',
        'Collecting type constraints from across the program and solving them to find the most general type consistent with all of them',
        'Converting the AST directly into machine code',
        'Detecting reference cycles for garbage collection',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — unification is a constraint-solving process that finds the most "
          "general (principal) type satisfying every usage in the program simultaneously.",
      explainBad:
          "Unification's job is constraint solving for TYPES specifically: gather every "
          "'these two types must match' requirement from the program, then solve for the "
          "most general type consistent with all of them at once.",
    ),
  ),
  const Chapter(
    id: 39,
    title: 'Generics / Parametric Polymorphism',
    avatar: '🧬',
    role: 'Narrator — writing one function for every type',
    bodyIntro:
        "🧬 Generics (a.k.a. parametric polymorphism) let you write one function or data "
        "structure that works correctly across many types, WITHOUT sacrificing static "
        "type safety — unlike duck typing, the compiler still checks everything.\n\n"
        "function first<T>(list: T[]): T {\n"
        "  return list[0];\n"
        "}\n\n"
        "first<int>([1, 2, 3]);       // T = int\n"
        "first<string>([\"a\", \"b\"]);   // T = string\n\n"
        "🔐 The key guarantee: the compiler still verifies EVERY usage is type-safe, for "
        "EVERY concrete type T ends up being — first can never accidentally be called in "
        "a way that breaks type safety, no matter what T turns out to be.",
    calloutHints: [
      "💼 Production reality: generics are how you write a single, reusable, type-safe "
          "List<T>, Map<K,V>, or Optional<T> instead of either duplicating code per type "
          "or giving up type safety with something like Object/any. Nearly every modern "
          "statically typed language (Java, C#, Rust, TypeScript, Go since 1.18) has them.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the core benefit of parametric polymorphism (generics) over just using "
          "duck typing or an `any`/`Object` type?",
      options: [
        'Generics make the program run without a compiler at all',
        'Generics let one implementation work across many types while the compiler STILL fully verifies type safety for every concrete type used',
        'Generics remove the need for functions entirely',
        'Generics only work with the int type',
      ],
      answerIndex: 1,
      explainOk:
          "Right — generics give you reuse across types WITHOUT losing the compiler's "
          "type-safety guarantees, unlike duck typing or a catch-all `any` type.",
      explainBad:
          "The key distinction from duck typing/`any` is that generics keep FULL "
          "compiler-checked type safety for every type substituted in — you get reuse "
          "without giving up static guarantees.",
    ),
  ),
  const Chapter(
    id: 40,
    title: 'Monomorphization vs Type Erasure',
    avatar: '⚙️',
    role: 'Narrator — comparing two implementation strategies',
    bodyIntro:
        "⚙️ Generics are a source-level feature — but how does the compiler actually "
        "IMPLEMENT them at run time? Two dominant strategies, with very different "
        "tradeoffs:\n\n"
        "🏭 Monomorphization (Rust, C++ templates) — generate a SEPARATE specialized "
        "copy of the function for every concrete type it's used with at compile time. "
        "first<int> and first<string> become two distinct compiled functions.\n\n"
        "🎭 Type erasure (Java generics, historically) — compile ONE single version of "
        "the function that operates on a generic \"object\" representation, and erase "
        "the specific type information after compile-time checking.\n\n"
        "Monomorphization is faster at run time (no boxing, no indirection) but can "
        "bloat binary size (code duplicated per type). Type erasure keeps one copy "
        "(smaller compiled binary) but often needs boxing/casting, slightly slower.",
    calloutHints: [
      "💼 Production reality: this is precisely why generic-heavy Rust binaries can grow "
          "large (\"code bloat\") while Java's erased generics stay compact but pay a "
          "small run-time indirection tax — a real, measurable tradeoff engineers "
          "actively manage.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each consequence into the strategy it belongs to.",
      bucketALabel: '🏭 Monomorphization',
      bucketBLabel: '🎭 Type erasure',
      items: [
        Sort2Item('a1', 'A separate compiled copy exists per concrete type used', true),
        Sort2Item('a2', 'Can increase compiled binary size as more types are used', true),
        Sort2Item('a3', 'Only one compiled version exists for all types', false),
        Sort2Item('a4', 'Often needs boxing/casting at run time, costing a little speed', false),
      ],
      explainOk:
          "Correct — monomorphization trades binary size for run-time speed; type "
          "erasure trades a little run-time speed for a smaller, single compiled "
          "implementation.",
      explainBad:
          "Monomorphization duplicates code per type (bigger binary, faster). Type "
          "erasure keeps one shared implementation (smaller binary, some run-time "
          "indirection cost).",
    ),
  ),
  const Chapter(
    id: 41,
    title: 'Ahead-of-Time Compilation, Production Tradeoffs',
    avatar: '📦',
    role: 'Narrator — shipping a finished binary',
    bodyIntro:
        "📦 Ahead-of-Time (AOT) compilation — the \"classic\" compiler model you've been "
        "learning — produces a finished native binary before the program is ever "
        "distributed or run: C, Rust, Go, and Swift all compile this way by default.\n\n"
        "💼 Production tradeoffs that matter at this depth:\n\n"
        "🚀 Instant startup — no compilation work happens at launch, which matters "
        "enormously for CLI tools and serverless functions billed by cold-start latency.\n\n"
        "🔒 Predictable performance — the exact same optimized machine code runs every "
        "single time, with no warm-up variability.\n\n"
        "🚫 No run-time specialization — the compiler must optimize for whatever inputs "
        "it GUESSES are typical, since it can never see the ACTUAL data your program "
        "will process in production.",
    calloutHints: [
      "🏭 This is exactly why AOT dominates for CLI tools, embedded systems, and "
          "cold-start-sensitive serverless functions — but it means AOT-compiled code "
          "can't adapt to real run-time behavior the way the next chapters' approaches "
          "can.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Why does AOT compilation matter so much for serverless functions billed by cold-start time?",
      options: [
        'AOT-compiled binaries have zero compilation work left to do at launch, so they start running immediately',
        "AOT compilation makes the program's logic bug-free automatically",
        'AOT compilation is only possible for interpreted languages',
        'AOT-compiled programs cannot be run more than once',
      ],
      answerIndex: 0,
      explainOk:
          "Right — since translation already happened before deployment, an AOT binary "
          "has no compile-time cost left at startup, which is exactly what "
          "cold-start-sensitive workloads need.",
      explainBad:
          "The relevant advantage is startup speed: because all translation happened "
          "BEFORE the binary was deployed, there's no compile work left to slow down a "
          "cold start.",
    ),
  ),
  const Chapter(
    id: 42,
    title: 'Bytecode Virtual Machines',
    avatar: '🖥️',
    role: 'Narrator — inventing a fake CPU',
    bodyIntro:
        "🖥️ Many languages (Java, Python, C#, the Erlang BEAM) don't compile straight to "
        "REAL machine code — they compile to bytecode: instructions for an imaginary, "
        "simplified CPU that the language designers invented, then run that bytecode "
        "inside a virtual machine (VM) that emulates that imaginary CPU.\n\n"
        "Java source → javac → .class bytecode → JVM interprets/JITs it → runs\n\n"
        "🎯 Why bother with a fake CPU? Portability. The exact same bytecode file runs "
        "unmodified on Windows, macOS, Linux, ARM, x86 — anywhere a JVM exists — because "
        "the VM is the only thing that needs a real, platform-specific implementation. "
        "\"Write once, run anywhere\" is a direct consequence of this architecture.",
    calloutHints: [
      "💼 Production reality: bytecode VMs also enable rich run-time services that pure "
          "AOT binaries don't get for free — like the JVM's garbage collector, class "
          "loading, security sandboxing, and (next chapter) JIT compilation that adapts "
          "to real observed behavior, not just guesses made at compile time.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the primary engineering motivation for compiling to bytecode run on a "
          "VM, rather than directly to native machine code for one specific CPU?",
      options: [
        'Bytecode always runs faster than native machine code',
        'Portability — the same bytecode file runs unmodified anywhere a compatible VM exists, since only the VM needs a platform-specific implementation',
        'Bytecode eliminates the need for a lexer or parser',
        'Bytecode makes garbage collection impossible, which simplifies the runtime',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — bytecode's big win is portability: build once, ship the same "
          "bytecode everywhere a VM for that bytecode format exists.",
      explainBad:
          "Bytecode is generally NOT faster than well-optimized native code by default — "
          "its real advantage is portability, since only the VM (not every program) "
          "needs a platform-specific implementation.",
    ),
  ),
  const Chapter(
    id: 43,
    title: 'JIT Compilation — Warming Up',
    avatar: '🔥',
    role: 'Narrator — watching the engine warm up',
    bodyIntro:
        "🔥 A Just-In-Time (JIT) compiler compiles bytecode into real native machine "
        "code WHILE the program is running — combining bytecode's portability with "
        "near-native speed, by compiling only the parts that actually turn out to "
        "matter.\n\n"
        "🔬 Typical JIT strategy:\n\n"
        "▶️ Run the bytecode via a simple interpreter at first (slower, but instant to "
        "start).\n\n"
        "🌡️ Track which functions run often (\"hot\" code) using run-time profiling.\n\n"
        "🏗️ Compile those hot functions into optimized native machine code — using REAL "
        "observed data (actual argument types, actual branch frequencies) that an AOT "
        "compiler could never have seen ahead of time.\n\n"
        "♻️ Swap in the compiled version so future calls run at near-native speed.",
    calloutHints: [
      "💼 Production reality: this is why JVM/V8 (Chrome's JS engine) benchmarks often "
          "show a \"warm-up\" period where a program starts slower and speeds up over the "
          "first several seconds — the JIT hasn't finished compiling the hot paths yet. "
          "This is a real operational consideration for short-lived processes.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these JIT compilation events into the order they typically happen for one hot function.",
      items: [
        OrderItem('j1', 'Function runs via the plain bytecode interpreter (first few calls)'),
        OrderItem('j2', 'Run-time profiler notices this function is called very frequently'),
        OrderItem('j3', 'JIT compiles the function into optimized native machine code'),
        OrderItem('j4', 'Future calls to this function run the fast, compiled native version'),
      ],
      explainOk:
          "Right — interpret first, profile to find hot code, compile it natively, then "
          "reap the speedup on every future call.",
      explainBad:
          "The JIT always starts by interpreting (to get running fast), THEN profiles to "
          "find what's actually hot, THEN compiles just that hot code, and only "
          "afterward do calls speed up.",
    ),
  ),
  const Chapter(
    id: 44,
    title: 'Tiered Compilation & Deoptimization',
    avatar: '🎢',
    role: 'Narrator — riding the tiers',
    bodyIntro:
        "🎢 Modern production JITs (HotSpot JVM, V8) don't jump straight from "
        "\"interpreted\" to \"maximally optimized\" — they use tiered compilation: "
        "multiple compilation levels, each trading compile speed for run-time speed.\n\n"
        "Tier 0: Interpreter (instant, slowest to run)\n"
        "Tier 1: Quick, lightly-optimized JIT\n"
        "Tier 2: Aggressive, speculative JIT (slow to compile, fastest to run)\n\n"
        "🎯 The aggressive tier often makes speculative optimizations based on what's "
        "been true SO FAR — e.g. \"this variable has only ever held integers, so assume "
        "it always will and generate code without a type check.\" If that speculation is "
        "later violated (e.g. a string suddenly shows up), the VM must deoptimize: throw "
        "away the speculative machine code and fall back to a safer, more general tier.",
    calloutHints: [
      "💼 Production reality: this exact mechanism is why a JavaScript function that's "
          "called millions of times with only numbers, then suddenly called once with a "
          "string, can trigger a real, measurable performance cliff — V8 deoptimizes and "
          "falls back to a slower path. Senior engineers profiling hot JS/Java code "
          "watch for exactly this pattern.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A JIT speculatively compiled a function assuming a variable is always an "
          "integer, generating code with no type check for speed. What forces the VM to "
          "deoptimize?",
      options: [
        'The function is simply called too many times',
        'The speculative assumption is violated at run time — e.g. the variable holds a string instead of an int — so the unsafe optimized code can no longer be trusted',
        'The program reaches the end of main()',
        'Deoptimization happens on a fixed timer, unrelated to program behavior',
      ],
      answerIndex: 1,
      explainOk:
          "Right — deoptimization is triggered specifically when a speculative "
          "assumption baked into the optimized code turns out to be false at run time.",
      explainBad:
          "Deoptimization is a SAFETY mechanism: it fires when the run-time behavior "
          "actually contradicts an assumption the speculative optimizer baked in (like "
          "'always an int'), forcing a fallback to correct, unoptimized code.",
    ),
  ),
  const Chapter(
    id: 45,
    title: 'Generational GC',
    avatar: '👶',
    role: 'Narrator — sorting the young from the old',
    bodyIntro:
        "👶 Production garbage collectors exploit a well-established empirical pattern "
        "called the generational hypothesis: most objects die young, and objects that "
        "survive a while tend to keep surviving much longer. Generational GC is built "
        "directly around this.\n\n"
        "Young generation (nursery) — small, collected VERY frequently, cheap scans. "
        "Objects that survive several collections get \"promoted\" to the old "
        "generation — large, collected rarely, more expensive scans.\n\n"
        "🎯 Because the young generation is small, scanning it is fast — and since most "
        "garbage IS young garbage, frequent cheap young-gen collections reclaim most "
        "memory without ever touching the (much larger, much more expensive to scan) "
        "old generation.",
    calloutHints: [
      "💼 Production reality: the JVM's default collectors, .NET's GC, and V8's GC (for "
          "JavaScript objects) are all generational for exactly this reason — it's the "
          "single biggest lever for making GC throughput scale to large, long-running "
          "server processes without constantly re-scanning everything that's alive.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What empirical observation is generational GC's design directly exploiting?",
      options: [
        'All objects live for exactly the same amount of time',
        'Most objects die young, while objects that survive a while tend to keep surviving — so scanning young objects frequently reclaims most garbage cheaply',
        'Objects never actually become unreachable in real programs',
        'The heap is always exactly the same size regardless of workload',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the generational hypothesis (most garbage is young) is precisely "
          "why frequent, cheap young-generation scans reclaim the bulk of memory without "
          "constantly rescanning long-lived old objects.",
      explainBad:
          "The core insight is about object LIFETIME distribution: most objects die "
          "young, and survivors tend to keep surviving — which is why segregating young "
          "vs. old objects and scanning young ones far more often pays off.",
    ),
  ),
  const Chapter(
    id: 46,
    title: 'Stop-the-World Pauses and Why They Hurt',
    avatar: '⏸️',
    role: 'Narrator — freezing the whole show',
    bodyIntro:
        "⏸️ A naive garbage collector performs a stop-the-world (STW) pause: every "
        "single application thread is frozen while the collector traces and reclaims "
        "memory, to guarantee nothing mutates the object graph mid-scan.\n\n"
        "🚨 For a latency-sensitive production service, STW pauses are a direct, "
        "user-visible problem: a request that would normally complete in 5ms can "
        "suddenly take 200ms+ if it's unlucky enough to land during a full GC pause — "
        "and at p99/p999 percentiles, these pauses are frequently the dominant source "
        "of tail latency, not your actual business logic.",
    calloutHints: [
      "💼 Production reality: this is why teams running latency-sensitive services "
          "(trading systems, real-time bidding, gaming backends) obsess over GC pause "
          "times specifically, often choosing a GC algorithm (next chapter) purely to "
          "minimize worst-case pause duration — sometimes even accepting LOWER total "
          "throughput as the tradeoff.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why do stop-the-world GC pauses disproportionately hurt p99/p999 latency for "
          "a production service, even if average latency looks fine?",
      options: [
        "STW pauses only affect the CPU's clock speed, not requests",
        'A request unlucky enough to be in-flight during a full STW pause is completely frozen for the pause\'s duration, creating a latency spike that shows up specifically in the tail percentiles',
        'STW pauses only happen once, at program startup',
        'STW pauses make the average latency worse but never affect the tail',
      ],
      answerIndex: 1,
      explainOk:
          "Right — STW pauses freeze everything, so any request unlucky enough to be "
          "mid-flight during one takes a direct latency hit — which shows up as tail "
          "latency spikes even when the average looks fine.",
      explainBad:
          "The mechanism is about WHICH requests get hurt: only requests that happen to "
          "be in-flight DURING a pause get delayed — which is exactly why the effect "
          "concentrates in tail percentiles (p99/p999) rather than the average.",
    ),
  ),
  const Chapter(
    id: 47,
    title: 'Concurrent & Low-Pause Collectors',
    avatar: '🤹',
    role: 'Narrator — juggling without stopping',
    bodyIntro:
        "🤹 Modern production collectors (ZGC, Shenandoah on the JVM; Go's collector) "
        "are designed specifically to minimize or nearly eliminate STW pauses, using "
        "techniques like:\n\n"
        "🎨 Concurrent marking — trace reachable objects WHILE application threads keep "
        "running, using careful synchronization (like write barriers that track "
        "mutations happening mid-scan) instead of freezing everything.\n\n"
        "📐 Incremental/region-based collection — collect small regions of the heap at "
        "a time instead of the whole heap at once, keeping any pause tiny and bounded.",
    calloutHints: [
      "💼 Production reality: Go's GC famously targets sub-millisecond STW pauses by "
          "doing almost all tracing work concurrently with your running goroutines. "
          "Java's ZGC advertises pause times that stay in the low single-digit "
          "milliseconds EVEN ON MULTI-TERABYTE heaps — a deliberate design tradeoff, "
          "usually accepting somewhat higher CPU overhead in exchange for that "
          "pause-time guarantee.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What do concurrent/low-pause garbage collectors typically trade away to achieve dramatically shorter pause times?",
      options: [
        'They give up correctness — objects can be incorrectly freed',
        'They typically accept higher overall CPU overhead (extra bookkeeping like write barriers, running concurrently with app threads) in exchange for much shorter pauses',
        'They only work on single-core machines',
        'They eliminate garbage collection entirely',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the classic tradeoff is more total CPU work (synchronization "
          "machinery, concurrent tracing overhead) in exchange for pause times that stay "
          "small and predictable.",
      explainBad:
          "Concurrent collectors remain correct — they don't sacrifice that. What they "
          "DO trade away is some raw throughput/CPU efficiency, in exchange for "
          "dramatically shorter, more predictable pause times.",
    ),
  ),
  const Chapter(
    id: 48,
    title: 'Choosing/Tuning a GC in Production',
    avatar: '🎛️',
    role: 'Narrator — turning the real knobs',
    bodyIntro:
        "🎛️ Picking and tuning a GC for a real production service is a genuine "
        "senior-engineer decision, not a default you leave alone forever. Key questions "
        "that actually drive the choice:\n\n"
        "⏱️ Is latency or throughput the priority? A batch data pipeline cares about "
        "total throughput; a user-facing API cares about tail latency far more.\n\n"
        "📏 How large is the live heap? Bigger heaps make STW full collections more "
        "expensive, pushing you toward concurrent/regionalized collectors.\n\n"
        "🌡️ What's the allocation rate? High-allocation-rate workloads (lots of "
        "short-lived objects) benefit enormously from a well-tuned young generation.",
    calloutHints: [
      "💼 Production reality: this is exactly why the JVM ships MULTIPLE collectors "
          "(G1, ZGC, Shenandoah, Parallel) rather than one-size-fits-all, and why real "
          "incident postmortems sometimes trace a latency regression directly back to a "
          "GC configuration change (or an unexpectedly increased allocation rate) rather "
          "than to application code at all.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A user-facing API needs predictable low tail latency far more than raw "
          "throughput, and runs with a large heap. Which GC design philosophy fits best?",
      options: [
        "A simple stop-the-world collector that pauses the whole heap at once, since it's the simplest to reason about",
        'A concurrent, low-pause collector (like ZGC/Shenandoah), even if it costs somewhat more total CPU overhead',
        'No garbage collector at all — disable memory management entirely',
        'A GC that only runs once, at program startup',
      ],
      answerIndex: 1,
      explainOk:
          "Right — when tail latency dominates the requirements, accepting extra CPU "
          "overhead for a concurrent, low-pause collector is exactly the correct "
          "production tradeoff.",
      explainBad:
          "Given the stated priority (predictable low tail latency over raw throughput), "
          "the correct choice accepts more CPU overhead in exchange for short, bounded "
          "pauses — that's a concurrent/low-pause collector, not a simple STW one.",
    ),
  ),
  const Chapter(
    id: 49,
    title: 'Memory Safety — What Goes Wrong Without It',
    avatar: '🛡️',
    role: 'Narrator — inspecting the cracks',
    bodyIntro:
        "🛡️ A language is memory-safe if it's impossible (by design, not just by "
        "programmer discipline) to access memory outside what you're actually supposed "
        "to. Languages like C and C++ are famously NOT memory-safe by default; Rust, "
        "Java, Go, and Python are.\n\n"
        "💥 Buffer overflow — writing past the end of an array into adjacent memory, "
        "corrupting whatever happens to live there.\n\n"
        "👻 Use-after-free — using a pointer to memory that's already been freed, which "
        "may now hold completely unrelated data (or an attacker-controlled payload).\n\n"
        "🚨 These aren't just crashes — they're historically the root cause behind a "
        "huge fraction of real-world critical security vulnerabilities (buffer "
        "overflows alone have powered decades of remote code execution exploits).",
    calloutHints: [
      "💼 Production reality: this is precisely why major C/C++ codebases (browsers, OS "
          "kernels) invest heavily in sanitizers, fuzzing, and increasingly in rewriting "
          "security-critical components in memory-safe languages like Rust — Google and "
          "Microsoft have both published data attributing the large majority of their "
          "critical security vulnerabilities specifically to memory-safety bugs.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each language into whether it's memory-safe by default.",
      bucketALabel: '🛡️ Memory-safe by default',
      bucketBLabel: '⚠️ NOT memory-safe by default',
      items: [
        Sort2Item('rust', 'Rust — the borrow checker enforces safety at compile time', true),
        Sort2Item('c', 'C — raw pointers, manual memory, no built-in bounds checking', false),
        Sort2Item('java', 'Java — bounds-checked arrays, no raw pointers, GC-managed heap', true),
        Sort2Item('cpp', 'C++ — raw pointers and manual memory management remain fully available', false),
      ],
      explainOk:
          "Correct — Rust and Java guarantee memory safety by construction; C and C++ "
          "allow (and historically require) unsafe raw memory access as the default mode.",
      explainBad:
          "Memory-safe-by-default languages make out-of-bounds access structurally "
          "impossible without an explicit escape hatch. C and C++ give you raw pointers "
          "and manual memory management with no such guarantee built in.",
    ),
  ),
  const Chapter(
    id: 50,
    title: 'Sandboxing a Language Runtime',
    avatar: '🏝️',
    role: 'Narrator — building a fence around danger',
    bodyIntro:
        "🏝️ Sandboxing means running untrusted or partially-trusted code inside a "
        "restricted environment that limits what it can actually do — even if the code "
        "itself is malicious or buggy.\n\n"
        "☕ The JVM's original SecurityManager (now deprecated/removed) let you run "
        "untrusted Java applets with restricted filesystem/network access.\n\n"
        "🐍 Python's eval() is notoriously HARD to sandbox safely — clever attackers "
        "routinely find escape paths through Python's rich, dynamic reflection "
        "features.\n\n"
        "🧱 Modern approach: run untrusted code inside a purpose-built sandboxed VM "
        "(like WebAssembly, next chapter) that never exposes dangerous capabilities in "
        "the first place.",
    calloutHints: [
      "💼 Production reality: \"just don't call the dangerous function\" is NOT a real "
          "security boundary — a genuine sandbox must make the dangerous capability "
          "structurally unreachable, not merely undocumented or discouraged. This "
          "distinction has burned real production systems that assumed a soft "
          "convention was an actual security guarantee.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What's the key requirement for a sandbox to be a genuine security boundary, rather than just a convention that could be bypassed?",
      options: [
        "The dangerous capability must be documented as 'please don't use this'",
        'The dangerous capability must be structurally unreachable from inside the sandbox — not merely discouraged or hidden by convention',
        'The sandboxed code must be written in a dynamically typed language',
        'Sandboxes are purely a marketing term with no technical meaning',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — a real sandbox makes the dangerous operation impossible to reach at "
          "all, not just unlikely or against the rules. Anything less is a soft "
          "convention, not a security boundary.",
      explainBad:
          "A true security boundary must make forbidden capabilities STRUCTURALLY "
          "unreachable, not just discouraged. Relying on 'nobody will call that "
          "function' is exactly the kind of soft convention that real attackers "
          "routinely defeat.",
    ),
  ),
  const Chapter(
    id: 51,
    title: 'WebAssembly as a Security Boundary',
    avatar: '🕸️',
    role: 'Narrator — meeting a modern sandbox by design',
    bodyIntro:
        "🕸️ WebAssembly (Wasm) is a portable bytecode format (much like the previous "
        "level's bytecode VMs) explicitly designed from the ground up as a genuine "
        "security sandbox — not just a performance format.\n\n"
        "🧱 Wasm code runs inside a linear memory region that's completely separate "
        "from the host's own memory — a Wasm module simply CANNOT address memory "
        "outside its own sandbox, by construction, not by convention.\n\n"
        "🚪 Wasm has NO built-in ambient access to the filesystem, network, or system "
        "calls at all — every capability (reading a file, making a network call) must "
        "be EXPLICITLY granted by the host through imported functions.",
    calloutHints: [
      "💼 Production reality: this is exactly why browsers run untrusted third-party "
          "Wasm code (from any website) with real confidence, and why serverless "
          "platforms (Fastly, Cloudflare Workers) increasingly run untrusted customer "
          "code in Wasm sandboxes instead of full VMs or containers — genuine "
          "capability-based security, baked directly into the bytecode format itself, "
          "not bolted on afterward.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What structurally makes WebAssembly a strong sandbox, rather than just a fast bytecode format?",
      options: [
        'Wasm modules run faster than any other bytecode, which automatically makes them secure',
        'Wasm code is confined to its own linear memory and has zero ambient access to the filesystem/network unless the host explicitly grants specific capabilities',
        'Wasm requires every program to be written in Rust',
        "Wasm modules can freely access the host's entire memory space by default",
      ],
      answerIndex: 1,
      explainOk:
          "Right — memory isolation plus zero ambient capabilities (everything must be "
          "explicitly imported/granted by the host) is exactly what makes Wasm a real, "
          "structural security boundary.",
      explainBad:
          "Speed has nothing to do with the security guarantee. The real story is "
          "structural: Wasm code is confined to its own isolated memory and starts with "
          "NO capabilities at all — the host must explicitly grant each one.",
    ),
  ),
  const Chapter(
    id: 52,
    title: 'Supply Chain & Language-Level Attack Surface',
    avatar: '📦',
    role: 'Narrator — inspecting every ingredient',
    bodyIntro:
        "📦 Even a perfectly memory-safe language doesn't protect you from a deeper "
        "risk: the package/dependency supply chain your compiler pulls in and trusts "
        "at compile time.\n\n"
        "🎭 Typosquatting — a malicious package named almost identically to a popular "
        "one (reqeusts instead of requests), hoping for a typo during install.\n\n"
        "🧨 Build-time code execution — many package managers run arbitrary install "
        "scripts during npm install / pip install / build steps — malicious code can "
        "execute on YOUR machine before your program even runs once.\n\n"
        "🔗 Transitive dependencies — your direct dependency might itself depend on "
        "dozens of other packages you never explicitly chose or reviewed.",
    calloutHints: [
      "💼 Production reality: several real, high-profile incidents (compromised npm "
          "packages, malicious PyPI uploads) have exploited exactly this attack surface "
          "— this is why mature engineering orgs pin exact dependency versions, use "
          "lockfiles, run supply-chain scanners, and increasingly sandbox even the "
          "BUILD process itself, not just the running program.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Why is a memory-safe language's compiler/build toolchain still a genuine security risk, even if the language itself prevents buffer overflows?",
      options: [
        'It isn\'t a risk at all — memory safety covers every possible attack vector',
        'Package managers can execute arbitrary install/build scripts from third-party dependencies (including deep transitive ones you never directly chose), which can compromise your machine regardless of the target language\'s memory safety',
        'Memory-safe languages cannot use any external dependencies at all',
        'The build process never runs any code, only the final compiled program does',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — supply-chain risk lives in the build/install pipeline itself "
          "(arbitrary scripts, transitive dependencies), which is completely orthogonal "
          "to whether the target LANGUAGE is memory-safe.",
      explainBad:
          "Memory safety protects the target program's OWN memory operations — it says "
          "nothing about a malicious dependency (direct or transitive) running arbitrary "
          "code during install/build, which is a separate, very real attack surface.",
    ),
  ),
  const Chapter(
    id: 53,
    title: 'Performance Tradeoffs in Language Choice',
    avatar: '⚡',
    role: 'Narrator — weighing raw speed',
    bodyIntro:
        "⚡ Choosing a language for a real production system is rarely about which "
        "language is \"best\" in the abstract — it's about which tradeoffs fit THIS "
        "system's actual constraints.\n\n"
        "🏎️ Latency-critical, resource-constrained systems (trading engines, embedded "
        "firmware, game engines) often need AOT-compiled, non-GC'd languages (C, C++, "
        "Rust) — predictable performance with no GC pauses and no JIT warm-up.\n\n"
        "🌊 High-throughput services with more forgiving per-request latency (typical "
        "web backends) often do fine on GC'd, JIT-compiled languages (Java, Go, C#) — "
        "developer velocity often outweighs the last 10% of raw speed.",
    calloutHints: [
      "💼 Production reality: \"just use the fastest language\" is almost never the "
          "right framing — the real question is whether THIS system's "
          "latency/throughput requirements actually demand that level of control, or "
          "whether a GC'd, higher-level language's development speed is worth its "
          "performance ceiling for this particular workload.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A team is building a firmware component for a pacemaker, requiring "
          "microsecond-level deterministic timing with zero tolerance for unpredictable "
          "pauses. Which factor should dominate the language choice?",
      options: [
        'Whichever language the team happens to already know best, regardless of runtime guarantees',
        'Avoiding any language whose runtime can introduce unpredictable GC pauses or JIT warm-up variability, favoring AOT-compiled, non-GC\'d languages instead',
        'Choosing the language with the largest package ecosystem',
        'Choosing whichever language compiles the fastest',
      ],
      answerIndex: 1,
      explainOk:
          "Right — hard real-time, zero-pause-tolerance systems specifically need to "
          "avoid GC pauses and JIT warm-up unpredictability, which is exactly why "
          "domains like this lean on AOT, non-GC'd languages.",
      explainBad:
          "For hard real-time constraints, the dominant factor has to be eliminating "
          "unpredictable pauses (GC, JIT warm-up) — everything else (familiarity, "
          "ecosystem size, compile speed) is secondary to that hard requirement.",
    ),
  ),
  const Chapter(
    id: 54,
    title: 'Safety Tradeoffs in Language Choice',
    avatar: '🦺',
    role: 'Narrator — weighing what happens when things go wrong',
    bodyIntro:
        "🦺 Beyond raw performance, a language choice also encodes how much protection "
        "you get against entire CATEGORIES of bugs, before they ever reach production.\n\n"
        "🛡️ Memory safety (Rust, Java, Go) eliminates buffer overflows and "
        "use-after-free bugs by construction — a huge win for anything "
        "security-sensitive or internet-facing.\n\n"
        "🏗️ Static typing (Rust, Java, TypeScript) catches whole classes of type errors "
        "before deployment, which matters more as team size and codebase lifetime grow.\n\n"
        "⚠️ Choosing a memory-UNSAFE language (C, C++) is sometimes still the right "
        "call — e.g. writing a kernel driver that must directly manipulate "
        "hardware memory-mapped registers — but that choice should be a deliberate, "
        "informed tradeoff, not a default.",
    calloutHints: [
      "💼 Production reality: this exact reasoning is why major organizations have "
          "published policies steering new internet-facing, security-sensitive code "
          "toward memory-safe languages by default, reserving memory-unsafe languages "
          "specifically for the narrow cases (like direct hardware access) where they're "
          "genuinely required.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "According to sound production engineering judgment, when is choosing a memory-unsafe language like C still a defensible choice?",
      options: [
        'Never — memory-unsafe languages should always be banned outright in every context',
        'When there\'s a specific, deliberate technical requirement (e.g. direct hardware register access in a kernel driver) that genuinely demands it, treated as an informed tradeoff rather than a default',
        'Whenever the team simply prefers its syntax, with no other justification needed',
        'Only for writing unit tests',
      ],
      answerIndex: 1,
      explainOk:
          "Right — the sound framing is a deliberate tradeoff for a genuine technical "
          "requirement, not a blanket ban OR a default choice made out of habit.",
      explainBad:
          "Neither extreme is right: a blanket ban ignores real cases (like direct "
          "hardware access) that genuinely need it, but choosing it purely out of habit "
          "ignores the real safety cost. The sound answer is a deliberate, justified "
          "tradeoff.",
    ),
  ),
  const Chapter(
    id: 55,
    title: 'Ecosystem & Team Tradeoffs',
    avatar: '🌱',
    role: 'Narrator — looking past the language spec',
    bodyIntro:
        "🌱 Two systems with IDENTICAL performance and safety requirements can still "
        "have very different correct language choices, because of factors that have "
        "nothing to do with the language's technical design:\n\n"
        "👥 Team expertise — a team of 20 experienced Go engineers will likely ship a "
        "reliable system faster in Go than in an unfamiliar language with theoretically "
        "better properties.\n\n"
        "📚 Library/ecosystem maturity — if the exact library you need (a specific "
        "database driver, a mature ML framework) only exists in one language, that can "
        "outweigh most other considerations entirely.\n\n"
        "🔧 Hiring and long-term maintainability — a niche language might be "
        "technically elegant but leave you unable to hire, or unable to find engineers "
        "years later who can safely maintain the system.",
    calloutHints: [
      "💼 Production reality: many real \"which language\" postmortems, when you dig "
          "into them, actually come down to ecosystem or staffing realities far more "
          "than raw technical merits — a senior engineer's job is weighing ALL of these "
          "together, not just the benchmark numbers.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each language-choice factor into the correct bucket.",
      bucketALabel: '⚙️ Technical (language design)',
      bucketBLabel: '🌱 Organizational / ecosystem',
      items: [
        Sort2Item('f1', 'Whether the language guarantees memory safety by construction', true),
        Sort2Item('f2', 'Whether your team already has deep expertise in this language', false),
        Sort2Item('f3', 'Whether the language is statically or dynamically typed', true),
        Sort2Item('f4', 'Whether a mature, well-supported library exists for your exact use case', false),
      ],
      explainOk:
          "Correct — memory safety and typing discipline are properties of the language "
          "itself; team expertise and library maturity are organizational realities that "
          "matter just as much in practice.",
      explainBad:
          "Technical factors are inherent to the LANGUAGE's design (safety guarantees, "
          "typing discipline). Organizational factors are about your TEAM and ECOSYSTEM "
          "(expertise, library availability) — both genuinely belong in a real decision.",
    ),
  ),
  const Chapter(
    id: 56,
    title: 'Case Study — Picking a Language for a New Service',
    avatar: '🧭',
    role: 'Narrator — making the actual call',
    bodyIntro:
        "🧭 Let's put it all together with a real-shaped scenario. You're picking a "
        "language for a new internet-facing payments-processing service. Requirements:\n\n"
        "🔒 Must be internet-facing and handle sensitive financial data (security "
        "matters a lot).\n\n"
        "📈 Needs to handle rising traffic without a full rewrite (some room to scale).\n\n"
        "👥 Your team already has deep production experience in Go, and none in Rust.\n\n"
        "⏱️ Sub-millisecond latency is NOT a hard requirement — sub-100ms p99 is fine.\n\n"
        "🎯 Reasoning through the tradeoffs you've now learned: memory safety matters "
        "here (security-sensitive), but the latency bar isn't extreme enough to require "
        "a non-GC'd language — and team expertise strongly favors a language you "
        "already run in production. Go (memory-safe, GC'd but with mature low-pause "
        "collectors, and the team's strongest skill) is a well-justified choice; a "
        "switch to Rust would trade away team velocity for safety/speed margins this "
        "system doesn't actually need.",
    calloutHints: [
      "💼 This is exactly the kind of reasoning a staff/principal engineer is expected "
          "to walk a design review through — not \"Rust is theoretically the best,\" but "
          "\"given OUR actual constraints, here's the fit.\"",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Given the scenario above, what's the STRONGEST justification for choosing Go over Rust for this service?",
      options: [
        'Go is objectively the best language for every kind of system, full stop',
        'The system\'s latency requirements don\'t demand a non-GC\'d language, and the team\'s deep existing Go expertise outweighs Rust\'s theoretical safety/performance edge for this specific workload',
        'Rust cannot be used for internet-facing services under any circumstances',
        'Memory safety doesn\'t matter for payments-processing systems',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the justification is CONTEXTUAL: given this system's actual "
          "latency bar and the team's real expertise, Go's tradeoffs fit better here, "
          "not because Go universally beats Rust.",
      explainBad:
          "There's no universally 'best' language here. The strongest justification "
          "weighs THIS system's actual requirements (latency bar, team's real "
          "expertise) against the tradeoffs — not an abstract, context-free ranking.",
    ),
  ),
  const Chapter(
    id: 57,
    title: 'Design a Language Feature End-to-End — Part 1: Spec, Lexer & Parser',
    avatar: '🏗️',
    role: 'Narrator — the gauntlet begins',
    bodyIntro:
        "🏆 The final gauntlet. Over these last four chapters, you'll design and reason "
        "through a real language feature end-to-end, at the depth expected of the "
        "engineer actually shipping it.\n\n"
        "🎯 The feature: add a ?. \"optional chaining\" operator to a language — "
        "user?.address?.city should evaluate to null as soon as ANY step in the chain is "
        "null, short-circuiting the rest, instead of crashing.\n\n"
        "Step 1 — Lexing: the lexer must recognize ?. as ONE single token, not as "
        "separate ? and . tokens — this requires careful \"maximal munch\" lexing: "
        "always greedily match the LONGEST valid token starting at the current "
        "position, so ?. beats matching just ? alone.\n\n"
        "Step 2 — Parsing: the grammar must handle chains correctly: "
        "expr → expr ?. IDENTIFIER | expr . IDENTIFIER | IDENTIFIER, and the resulting "
        "AST must record, at EACH link in the chain, whether that specific link is a "
        "safe (?.) or unsafe (.) access — this distinction can't be lost by parse time.",
    calloutHints: [
      "💼 Real-world grounding: this is essentially how optional chaining was actually "
          "added to JavaScript (ES2020) and Kotlin's ?. — a small-looking syntax "
          "addition that requires real lexer/grammar care to avoid ambiguity with the "
          "existing ternary ?: and plain . operators.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Why must the lexer specifically apply 'maximal munch' (always matching the longest valid token) when scanning `?.`?",
      options: [
        'Because `?.` is only ever used in comments',
        'Without maximal munch, the lexer might match just `?` as its own token and leave a dangling `.` — breaking the intended single `?.` operator into two separate, wrong tokens',
        'Maximal munch only matters for number literals, never for operators',
        'Because `?.` must always be the very first token in the file',
      ],
      answerIndex: 1,
      explainOk:
          "Right — without greedily preferring the longest match, a naive lexer could "
          "split `?.` into `?` and `.` separately, silently breaking the new operator's "
          "meaning.",
      explainBad:
          "The risk is a naive lexer stopping too early — matching just `?` and leaving "
          "`.` as a separate token, which is NOT the single optional-chaining operator "
          "you intended. Maximal munch prevents exactly that.",
    ),
  ),
  const Chapter(
    id: 58,
    title: 'Design a Language Feature End-to-End — Part 2: Type-Checking & Codegen',
    avatar: '🧪',
    role: 'Narrator — the gauntlet continues',
    bodyIntro:
        "🧪 Continuing the ?. feature from Part 1 — now the harder half: type checking "
        "and code generation.\n\n"
        "Step 3 — Type checking: if user has type User | null, then user?.address must "
        "have type Address | null — the \"possibly null\" property has to PROPAGATE "
        "through the whole chain. Critically: user.address (unsafe . on a "
        "possibly-null type) should be a compile-time type error, forcing the "
        "programmer to either null-check or use ?..\n\n"
        "Step 4 — Codegen (lowering): a?.b lowers into IR resembling:\n\n"
        "t1 = a\n"
        "if t1 == null:\n"
        "    result = null      // short-circuit — never even touch t1.b\n"
        "else:\n"
        "    result = t1.b\n\n"
        "🔗 For a LONGER chain like a?.b?.c, this short-circuit must apply "
        "transitively — as soon as ANY link evaluates to null, the entire rest of the "
        "chain must be skipped, without ever attempting to access a property on a "
        "value that might be null.",
    calloutHints: [
      "💼 Real-world grounding: getting this short-circuiting lowering subtly wrong "
          "(e.g. evaluating a twice, or evaluating .c before checking b) is exactly the "
          "kind of miscompilation bug that ships when a \"small feature\" doesn't get "
          "end-to-end scrutiny — precisely the theme of the next capstone chapter.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these steps into the correct order for correctly lowering `a?.b?.c` with proper short-circuiting.",
      items: [
        OrderItem('e1', 'Evaluate `a` once, store it in a temporary'),
        OrderItem('e2', 'If that temporary is null, the whole expression is null — stop here'),
        OrderItem('e3', 'Otherwise, access `.b` on it and store the result in a new temporary'),
        OrderItem('e4', 'If THAT temporary is null, the whole expression is null — stop here'),
        OrderItem('e5', 'Otherwise, access `.c` on it — this is the final result'),
      ],
      explainOk:
          "That's correct short-circuiting lowering — check for null after EVERY link "
          "before ever accessing the next property, and never re-evaluate the same "
          "sub-expression twice.",
      explainBad:
          "Each link must be checked for null immediately after being evaluated, BEFORE "
          "attempting the next property access — skipping a null check, or accessing a "
          "property before checking, breaks the whole point of the feature.",
    ),
  ),
  const Chapter(
    id: 59,
    title: 'Capstone — Debugging a Miscompilation in Production',
    avatar: '🕵️',
    role: 'Narrator — the incident call',
    bodyIntro:
        "🚨 Incident scenario: your company's language runtime just shipped a new "
        "release. Within hours, a customer reports that a perfectly ordinary-looking "
        "function is silently returning the WRONG result in production — no crash, no "
        "error, just a subtly incorrect number, and only for SOME inputs.\n\n"
        "🔬 The investigation, done right, follows this order:\n\n"
        "🎯 Minimize the reproduction — shrink the customer's real program down to the "
        "smallest possible snippet that still reproduces the wrong answer. This alone "
        "often reveals the actual pattern.\n\n"
        "🔍 Bisect by pipeline stage — dump the AST, then the IR, then the generated "
        "machine code for the minimized case, and compare each against what you'd "
        "expect BY HAND. Find the exact stage where correct input first produces "
        "incorrect output.\n\n"
        "🌡️ Suspect recent optimizer changes first — miscompilations are "
        "disproportionately likely to be optimizer bugs (constant folding, dead code "
        "elimination, or — as in Part 1/2 — a new lowering rule) rather than "
        "lexer/parser bugs, because optimizations are the passes that REWRITE code "
        "based on assumptions that can be subtly wrong.\n\n"
        "🧪 Turn it into a permanent regression test — the minimized reproduction "
        "becomes a test case that runs on every future compiler build, forever.",
    calloutHints: [
      "💼 This exact workflow — minimize, bisect by stage, suspect the optimizer, and "
          "lock in a regression test — is the real, standard operating procedure real "
          "compiler teams (LLVM, V8, the JVM) use for miscompilation reports, and it's "
          "precisely the discipline a principal engineer is expected to lead during an "
          "incident like this.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these steps into the correct order for investigating a production miscompilation report.",
      items: [
        OrderItem('i1', "Minimize the customer's program to the smallest reproducing snippet"),
        OrderItem('i2', 'Bisect by pipeline stage — compare AST, IR, and machine code against expected output by hand'),
        OrderItem('i3', 'Focus suspicion on recently changed optimizer passes first'),
        OrderItem('i4', 'Turn the minimized case into a permanent regression test'),
      ],
      explainOk:
          "That's the disciplined order real compiler teams use — you can't bisect a "
          "huge, messy repro efficiently, so minimizing always comes first, and locking "
          "in a regression test always comes last.",
      explainBad:
          "You must minimize the repro BEFORE you can efficiently bisect it stage by "
          "stage. Only after finding the faulty stage does it make sense to suspect "
          "specific passes, and the regression test always comes last, once the bug is "
          "understood.",
    ),
  ),
  const Chapter(
    id: 60,
    title: "The Principal Engineer's Language Postmortem",
    avatar: '🎓',
    role: 'Narrator — the final scene on Compiler Coast',
    bodyIntro:
        "🎓 Final scenario. The miscompilation from the previous chapter turned out to "
        "be real: a new dead-code-elimination pass incorrectly deleted a function call "
        "that LOOKED unused, but actually had an observable side effect the analysis "
        "failed to detect. You're now writing the postmortem.\n\n"
        "📝 A rigorous postmortem for a compiler bug covers, at minimum:\n\n"
        "🎯 Root cause, precisely stated — not \"the optimizer had a bug,\" but \"the "
        "dead-code-elimination pass's side-effect analysis failed to recognize that "
        "this specific function call type could mutate external state, and incorrectly "
        "treated it as pure.\"\n\n"
        "🌐 Blast radius — every other optimization pass built on the SAME flawed "
        "side-effect analysis is equally suspect and must be re-audited, not just this "
        "one call site.\n\n"
        "🛡️ Systemic fix, not just a patch — the real fix isn't only correcting THIS "
        "specific case; it's strengthening the side-effect analysis itself (or making "
        "it deliberately conservative by default) so an entire CLASS of future bugs "
        "like this becomes structurally harder to introduce.\n\n"
        "🧪 Verification strategy going forward — beyond one regression test, should "
        "the compiler add property-based/fuzz testing specifically targeting optimizer "
        "correctness, comparing optimized vs. unoptimized output on random programs?",
    calloutHints: [
      "🐢 You've now walked the entire coast: from \"what's a compiler\" all the way to "
          "leading a real production compiler incident like a principal engineer. "
          "That's the whole journey — Process is proud, and (as always) is finally just "
          "getting up to speed. 🐢💨",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "The team wants to close this incident by just adding one regression test for the exact reported case. What's the strongest argument for doing MORE than that?",
      options: [
        'There\'s no need to do more — one regression test for the exact reported bug is always sufficient',
        'The root cause (a flawed side-effect analysis) likely affects every OTHER optimization pass built on that same analysis, so the systemic fix must address the analysis itself, not just this one reported symptom',
        'Postmortems should never include a systemic fix, only a list of who to blame',
        'The bug can never happen again once one test is added, regardless of the underlying analysis',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — a single regression test only guards against the EXACT reported "
          "case. Since the flawed analysis is shared infrastructure, a real fix has to "
          "address the analysis itself, or the same class of bug will resurface "
          "elsewhere.",
      explainBad:
          "A single test only protects against the one case you already found. Since "
          "the root cause is a shared, flawed analysis used by multiple passes, a "
          "genuinely complete fix must correct that shared analysis — otherwise the "
          "same class of bug will simply reappear somewhere else.",
    ),
  ),
];
