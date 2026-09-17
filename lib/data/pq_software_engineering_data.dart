import '../models/pq_models.dart';

/// Ported from process-quest/subjects/software-engineering.js, chapters 1-60
/// (levels 1-15) — real content, HTML-stripped narrative prose, same puzzles
/// and answers. Narrator "Process" is a turtle with wheels instead of feet.
final softwareEngineeringChapters = <Chapter>[
  const Chapter(
    id: 1,
    title: 'What a Bug Actually Is',
    avatar: '🐛',
    role: 'Narrator — rolling into Craft Cove',
    bodyIntro:
        "🐢 Craft Cove! Here, everything is built by hand — workbenches, "
        "half-finished gadgets, little wooden signs everywhere. The first "
        "sign I see says \"Report a bug here.\" 🐛\n\nA bug isn't some scary "
        "creature — it's just this: the program did something DIFFERENT "
        "from what it was supposed to do. That's it. If I write a "
        "calculator that says 2 + 2 = 5, the \"expected\" answer is 4, the "
        "\"actual\" answer is 5, and that gap between them is the bug.\n\n"
        "🎯 Expected — what the program should do\n\n"
        "📤 Actual — what the program really did\n\n"
        "🕳️ Bug — the mismatch between the two\n\n"
        "🔍 Let's check your bug-spotting instincts.",
    calloutHints: [
      "🍪 Kid tip: if you asked for a cookie and got a carrot instead, "
          "that's not a \"carrot problem\" — that's a bug in the kitchen! "
          "Expected cookie, got carrot.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A function called double(x) is supposed to return twice the "
          "input. You call double(5) and get 15. What's the bug here?",
      options: [
        'There is no bug — 15 is a perfectly fine number',
        'Expected 10, got 15 — that mismatch is the bug',
        'The function name is too short',
        '5 is not allowed as an input, ever',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly! Expected double(5) = 10. Getting 15 instead is the "
          "bug — a plain mismatch between expected and actual.",
      explainBad:
          "Focus on the definition: a bug is just expected behavior not "
          "matching actual behavior. double(5) should be 10, not 15.",
    ),
  ),
  const Chapter(
    id: 2,
    title: 'Why Version Control Exists',
    avatar: '📚',
    role: 'Narrator — finding a wall of old drafts',
    bodyIntro:
        "📚 Next to the workbench, I find a wall covered in old drawings, "
        "each one slightly different, labeled things like plan.png, "
        "plan_v2.png, plan_v2_FINAL.png, and plan_v2_FINAL_ACTUALLY.png. "
        "Yikes. 😵\n\nThis is exactly the mess version control was invented "
        "to fix. Instead of copying whole files with confusing names, a "
        "version control system (like Git) keeps track of every single "
        "change to your project, automatically, forever — with a real "
        "history you can look back through.\n\n"
        "⏪ Go back to any earlier point, any time\n\n"
        "👥 Many people can work on the same project without stepping on "
        "each other\n\n"
        "🔍 See exactly WHO changed WHAT, and WHY\n\n"
        "🗂️ Let's sort the \"before Git\" chaos from the \"with Git\" calm.",
    calloutHints: [
      "🧵 Kid tip: think of version control like a very organized diary "
          "that saves a snapshot every time you make a change — you never "
          "have to guess which file is the \"real\" one.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each scenario into the bucket it belongs in.",
      bucketALabel: '😵 Without version control',
      bucketBLabel: '📚 With version control',
      items: [
        Sort2Item('zip', 'Emailing zip files back and forth', true),
        Sort2Item(
          'final',
          'A file named final_v2_FINAL_ACTUALLY.png',
          true,
        ),
        Sort2Item(
          'history',
          'A full history of every change, saved automatically',
          false,
        ),
        Sort2Item(
          'revert',
          "Instantly going back to yesterday's working version",
          false,
        ),
      ],
      explainOk:
          "Exactly — version control replaces guesswork and file-name "
          "chaos with a real, searchable history.",
      explainBad:
          "Look for the pattern: messy filenames and manual copies = no "
          "version control; automatic tracked history = version control.",
    ),
  ),
  const Chapter(
    id: 3,
    title: 'Your First Commit',
    avatar: '📸',
    role: 'Narrator — snapping a photo of my work',
    bodyIntro:
        "📸 The wall has a little camera hanging next to it, labeled "
        "\"commit\". Here's how it works: I make a change to a file, then "
        "I take a labeled snapshot of exactly that change. That snapshot "
        "is called a commit.\n\nThe three steps, every single time:\n\n"
        "1. Edit a file\n"
        "2. git add   → \"I want this change in my next snapshot\"\n"
        "3. git commit → \"Take the snapshot, with a short message "
        "describing it\"\n\n"
        "Each commit gets a message describing WHAT changed and often WHY "
        "— future-me (and everyone else on the team) will thank present-me "
        "for writing a clear one, like \"Fix off-by-one error in "
        "pagination\" instead of just \"fix stuff\".\n\n"
        "🔢 Let's put the steps of making a commit in order.",
    calloutHints: [
      "🧁 Kid tip: a commit is like taking a labeled photo of your Lego "
          "build after every big step — if a piece falls off later, you "
          "know exactly which photo to look at to rebuild it.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these steps in the order you'd actually do them to "
          "save a change.",
      items: [
        OrderItem('edit', 'Edit the file to fix the bug'),
        OrderItem('add', 'git add — stage the change'),
        OrderItem('commit', 'git commit -m "fix bug" — save the snapshot'),
      ],
      explainOk:
          "Exactly — you always edit first, stage what you want saved, "
          "then commit it with a clear message.",
      explainBad:
          "You can't stage or commit a change before you've actually made "
          "it! Edit, then add, then commit.",
    ),
  ),
  const Chapter(
    id: 4,
    title: 'What a Code Review Actually Checks',
    avatar: '🔎',
    role: 'Narrator — watching two workers check a gadget',
    bodyIntro:
        "🔎 At the next workbench, one crafter hands their finished gadget "
        "to a second crafter before it goes out the door. This is a code "
        "review: before a change ships, another person looks it over.\n\n"
        "A good review isn't about nitpicking style forever — it checks a "
        "few things that actually matter:\n\n"
        "✅ Correctness — does it actually do what it's supposed to?\n\n"
        "🧪 Tests — is there proof it works, not just a promise?\n\n"
        "👀 Readability — could a teammate understand this next year?\n\n"
        "⚠️ Edge cases — what happens with weird or missing input?\n\n"
        "🧠 What's a review actually FOR?",
    calloutHints: [
      "🧑‍🏭 Kid tip: a code review is like a friend double-checking your "
          "book report before you hand it in — not to be mean, but because "
          "a second pair of eyes catches things you missed.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What is a code review mainly trying to accomplish?",
      options: [
        'Making the reviewer feel superior to the author',
        'Catching correctness issues, missing tests, and unclear code '
            'before it ships',
        "Rewriting every line to match the reviewer's exact personal style",
        'Slowing the team down as much as possible',
      ],
      answerIndex: 1,
      explainOk:
          "Right — a good review is a safety check for correctness, "
          "tests, and clarity, not a style contest or a power move.",
      explainBad:
          "Think about WHY teams bother reviewing at all: it's to catch "
          "real problems — bugs, missing tests, confusing code — before "
          "they ship.",
    ),
  ),
  const Chapter(
    id: 5,
    title: 'Branches: Parallel Timelines',
    avatar: '🌿',
    role: 'Narrator — discovering a fork in the workshop path',
    bodyIntro:
        "🌿 The path through Craft Cove splits! One sign says main, another "
        "says feature/login. This is a branch: a separate timeline of "
        "commits that starts from the same point but can change "
        "independently, without touching the original.\n\nWhy bother? "
        "Because I can experiment on feature/login — try things, break "
        "things, fix things — while main stays safe and stable the whole "
        "time. When my feature is ready, I bring the two timelines back "
        "together.\n\n"
        "🧠 Why do teams use branches instead of everyone editing main "
        "directly?",
    calloutHints: [
      "🎬 Kid tip: think of branches like alternate story endings — you "
          "can write a whole new ending on a copy of the story without "
          "messing up the original book.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the main benefit of working on a separate branch "
          "instead of editing main directly?",
      options: [
        'Branches make your code run faster',
        'You can experiment and even break things temporarily without '
            'affecting the stable main line',
        'Branches are required by law for all software projects',
        'It uses less disk space than one shared file',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — branches isolate risky, in-progress work so main "
          "always stays in a known-good state.",
      explainBad:
          "The real win is isolation: your half-finished, possibly-broken "
          "work stays off to the side until it's ready.",
    ),
  ),
  const Chapter(
    id: 6,
    title: 'Merging & Conflicts',
    avatar: '🧩',
    role: 'Narrator — fitting two timelines back together',
    bodyIntro:
        "🧩 Time to bring feature/login back into main — that's called a "
        "merge. Usually Git is smart enough to combine both sets of "
        "changes automatically, especially if they touched different "
        "lines or files.\n\nBut sometimes both branches changed the exact "
        "same line of the exact same file, in different ways. Git can't "
        "guess which one you meant — that's a merge conflict, and it "
        "needs a human to pick the right answer (or combine both).\n\n"
        "🎯 Sort these into conflict vs clean merge.",
    calloutHints: [
      "✂️ Kid tip: if you and a friend both tried to redraw the SAME "
          "square on a shared coloring page with different colors, someone "
          "has to decide which color wins — that's a conflict. If you each "
          "colored DIFFERENT squares, there's nothing to argue about.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each scenario into the correct bucket.",
      bucketALabel: '💥 Merge Conflict',
      bucketBLabel: '✅ Clean Merge',
      items: [
        Sort2Item(
          'sameline',
          'Both branches changed line 12 of the same file, differently',
          true,
        ),
        Sort2Item(
          'diffile',
          'One branch edited file A, the other edited file B',
          false,
        ),
        Sort2Item(
          'sameword',
          'Both branches renamed the exact same variable to different '
              'names',
          true,
        ),
        Sort2Item(
          'diffline',
          'Both edited the same file, but completely different lines',
          false,
        ),
      ],
      explainOk:
          "Exactly — conflicts only happen when the SAME spot changed two "
          "different ways; different files or lines merge cleanly.",
      explainBad:
          "The key question: did both changes touch the exact same "
          "line/spot, in different ways? If yes, conflict. If no, clean "
          "merge.",
    ),
  ),
  const Chapter(
    id: 7,
    title: 'Pull Requests: Asking to Merge',
    avatar: '📬',
    role: 'Narrator — dropping a request into a mailbox',
    bodyIntro:
        "📬 Before my branch just gets smashed into main, there's a "
        "mailbox here labeled Pull Request (sometimes called a \"PR\" or "
        "\"merge request\"). It's a formal request: \"here's my branch, "
        "here's what changed, please review it before we merge.\"\n\n"
        "A pull request typically triggers:\n\n"
        "push branch → open PR → teammates review → automated checks run "
        "→ merge\n\n"
        "This gives everyone a chance to comment, ask questions, and "
        "catch problems before the change becomes part of main — instead "
        "of after.\n\n"
        "🔢 Put the PR lifecycle in order.",
    calloutHints: [
      "🎪 Kid tip: a pull request is like raising your hand before adding "
          "your drawing to the class mural — a teacher glances at it "
          "first, so nothing weird ends up on the wall.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange these steps in the order they typically happen.",
      items: [
        OrderItem('push', 'Push your feature branch to the shared repo'),
        OrderItem('open', 'Open a pull request describing the change'),
        OrderItem('review', 'Teammates review and leave comments'),
        OrderItem('checks', 'Automated checks (tests, linters) run and pass'),
        OrderItem('merge', 'The PR is merged into main'),
      ],
      explainOk:
          "That's the standard flow! Push, open, review, pass checks, "
          "THEN merge — never merge before review and checks are done.",
      explainBad:
          "Nothing merges until it's been reviewed AND passed its checks "
          "— those two gates always come before the final merge.",
    ),
  ),
  const Chapter(
    id: 8,
    title: 'Semantic Versioning',
    avatar: '🔢',
    role: 'Narrator — reading a version number on a crate',
    bodyIntro:
        "🔢 A crate in the workshop is stamped v2.5.1. That's not random — "
        "it follows semantic versioning (SemVer): MAJOR.MINOR.PATCH.\n\n"
        "💥 MAJOR — something that could BREAK existing users (v2 → v3)\n\n"
        "✨ MINOR — a new feature that's still backward-compatible "
        "(v2.5 → v2.6)\n\n"
        "🩹 PATCH — a bug fix, no new features, no breakage "
        "(v2.5.1 → v2.5.2)\n\n"
        "This numbering is a promise to anyone depending on your code: "
        "bump the right number so people know instantly how risky it is "
        "to upgrade.\n\n"
        "🧮 Classify each change by SemVer part.",
    calloutHints: [
      "🚦 Kid tip: think of it like a traffic light for upgrades — PATCH "
          "is green (safe), MINOR is yellow (probably fine, check new "
          "stuff), MAJOR is red (stop, read what changed first).",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a change on the left, then click which version part it "
          "should bump on the right.",
      pairs: [
        MatchPair(
          'bugfix',
          'Fixed a typo bug, nothing else changed',
          'PATCH',
        ),
        MatchPair(
          'newfeat',
          'Added an optional new setting, old code still works',
          'MINOR',
        ),
        MatchPair(
          'removed',
          'Removed a function that other code relied on',
          'MAJOR',
        ),
      ],
      explainOk:
          "Correct! Safe fixes are PATCH, backward-compatible additions "
          "are MINOR, and anything breaking is MAJOR.",
    ),
  ),
  const Chapter(
    id: 9,
    title: 'The Testing Pyramid',
    avatar: '🔺',
    role: 'Narrator — climbing a triangular scaffold',
    bodyIntro:
        "🔺 Welcome to Level 3! In the middle of Craft Cove stands a "
        "triangular scaffold of tests, wide at the bottom, narrow at the "
        "top. This is the classic testing pyramid:\n\n"
        "🧱 Unit tests (bottom, most of them) — test one small piece in "
        "isolation. Fast, cheap, run thousands per minute.\n\n"
        "🔗 Integration tests (middle, fewer) — test that several pieces "
        "work together correctly (e.g. code + real database).\n\n"
        "🌐 End-to-end (E2E) tests (top, fewest) — drive the whole app "
        "like a real user would, through a real browser.\n\n"
        "The shape matters: lots of cheap fast tests at the bottom catch "
        "most bugs early; a handful of slow expensive tests at the top "
        "confirm everything really works together.\n\n"
        "🔢 Order these test types from most-numerous to fewest.",
    calloutHints: [
      "🏗️ Kid tip: unit tests are like checking each Lego brick "
          "individually; E2E tests are like checking the whole finished "
          "castle actually stands up.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these test types from the BOTTOM of the pyramid (most "
          "tests) to the TOP (fewest tests).",
      items: [
        OrderItem('unit', 'Unit tests'),
        OrderItem('integration', 'Integration tests'),
        OrderItem('e2e', 'End-to-end tests'),
      ],
      explainOk:
          "Exactly — most tests should be fast unit tests, with fewer "
          "integration tests, and the fewest, slowest E2E tests on top.",
      explainBad:
          "Remember the shape: WIDE base of fast unit tests, narrowing "
          "through integration, to a small tip of slow E2E tests.",
    ),
  ),
  const Chapter(
    id: 10,
    title: 'Unit Tests: One Function at a Time',
    avatar: '🧪',
    role: 'Narrator — testing a single gear',
    bodyIntro:
        "🧪 A unit test checks ONE small piece of logic, completely "
        "isolated from databases, networks, or other code — just input "
        "in, output checked.\n\n"
        "function add(a, b) { return a + b; }\n\n"
        "test(\"add(2, 3) should equal 5\", () => {\n"
        "  expect(add(2, 3)).toBe(5);\n"
        "});\n\n"
        "Because there's no network call or database involved, this test "
        "runs in milliseconds. A healthy codebase might have thousands of "
        "these, running on every single commit.\n\n"
        "🧠 What makes a test a \"unit\" test specifically?",
    calloutHints: [
      "⚙️ Kid tip: testing one gear by itself, off the machine, is way "
          "faster than testing the WHOLE machine just to see if that one "
          "gear turns correctly.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which of these best describes a unit test?",
      options: [
        'It tests the entire application through a real web browser',
        'It tests a small, isolated piece of code with no real database '
            'or network involved',
        'It only runs once a year during a release',
        'It requires a human to click through the app manually',
      ],
      answerIndex: 1,
      explainOk:
          "Right — isolation and small scope are the whole point: fast, "
          "focused, no external dependencies.",
      explainBad:
          "A unit test's defining trait is ISOLATION — one small piece "
          "of logic, with no real database, network, or browser "
          "involved.",
    ),
  ),
  const Chapter(
    id: 11,
    title: 'Integration & End-to-End Tests',
    avatar: '🔗',
    role: 'Narrator — testing two gears meshing together',
    bodyIntro:
        "🔗 Integration tests check that multiple pieces cooperate "
        "correctly — like your code talking to a REAL database, not a "
        "fake one. They catch bugs unit tests physically cannot: \"does "
        "my SQL query actually work against a real database schema?\"\n\n"
        "🌐 End-to-end tests go even further: they drive the actual app "
        "— often through a real browser — clicking buttons, filling "
        "forms, checking what a real user would see. They're the most "
        "realistic, and also the slowest and most fragile (a tiny UI "
        "change can break them).\n\n"
        "🎯 Sort each test description by type.",
    calloutHints: [
      "🚗 Kid tip: a unit test checks one engine part on a workbench. An "
          "integration test checks the engine actually runs when bolted "
          "into the car. An E2E test drives the whole car around the "
          "block.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each test description into the correct bucket.",
      bucketALabel: '🔗 Integration',
      bucketBLabel: '🌐 End-to-End',
      items: [
        Sort2Item(
          'dbcheck',
          'Confirms the order-saving code writes correctly to a real '
              'database',
          true,
        ),
        Sort2Item(
          'browser',
          'Opens a real browser, logs in, adds an item to cart, checks '
              'out',
          false,
        ),
        Sort2Item(
          'apitest',
          'Calls the real API endpoint and checks the real response',
          true,
        ),
        Sort2Item(
          'fullflow',
          'Simulates a full user journey across multiple screens',
          false,
        ),
      ],
      explainOk:
          "Correct! Integration checks a couple of pieces cooperating; "
          "E2E checks the whole user journey works, top to bottom.",
      explainBad:
          "Integration = a FEW real pieces talking (like code + DB). "
          "E2E = the WHOLE app, from a real user's point of view.",
    ),
  ),
  const Chapter(
    id: 12,
    title: 'Test-Driven Development',
    avatar: '🔁',
    role: 'Narrator — writing the test before the code',
    bodyIntro:
        "🔁 Here's a surprising idea: what if you wrote the test BEFORE "
        "the code it's testing? That's test-driven development (TDD), "
        "and it follows a strict little rhythm:\n\n"
        "RED       → write a test that fails (the feature doesn't exist "
        "yet)\n"
        "GREEN     → write just enough code to make it pass\n"
        "REFACTOR  → clean up the code, keeping tests green\n\n"
        "Writing the test first forces you to think clearly about what "
        "\"done\" actually means, BEFORE you start coding — and it "
        "guarantees every piece of logic has test coverage, because the "
        "test came first, not as an afterthought.\n\n"
        "🔢 Put the TDD cycle in order.",
    calloutHints: [
      "🎯 Kid tip: TDD is like deciding what \"a clean room\" means (bed "
          "made, floor clear, toys away) BEFORE you start cleaning — so "
          "you know exactly when you're actually done.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these three steps in the order TDD actually follows.",
      items: [
        OrderItem(
          'red',
          "RED — write a failing test for behavior that doesn't exist "
              "yet",
        ),
        OrderItem('green', 'GREEN — write the minimum code to make the test pass'),
        OrderItem(
          'refactor',
          'REFACTOR — clean up the code while keeping tests green',
        ),
      ],
      explainOk:
          "That's the TDD loop! Fail first (RED), pass minimally "
          "(GREEN), then clean up safely (REFACTOR) — and repeat.",
      explainBad:
          "You can't refactor code that doesn't exist, and you can't "
          "skip writing the failing test first. Order is always RED, "
          "GREEN, REFACTOR.",
    ),
  ),
  const Chapter(
    id: 13,
    title: 'Debugging by Bisecting',
    avatar: '✂️',
    role: 'Narrator — cutting the problem in half',
    bodyIntro:
        "✂️ Something's broken somewhere in a huge pile of code, and I "
        "have no idea where. Instead of reading every line, I use the "
        "same trick as binary search: cut the search space in half, "
        "repeatedly.\n\nComment out (or disable) half the suspects. Still "
        "broken? The bug's in that half — repeat. Fixed? The bug was in "
        "the half you removed — put it back and split THAT half. Each "
        "round eliminates half the remaining possibilities.\n\n"
        "1000 lines of suspects\n"
        "→ disable half → still broken → bug's in these 500\n"
        "→ disable half of THOSE → fixed → bug's in the other 250\n"
        "→ ... keep halving until you find the exact line\n\n"
        "🧠 Why is bisecting faster than reading line by line?",
    calloutHints: [
      "🔍 Kid tip: this is exactly the \"guess the number\" game from "
          "earlier — instead of guessing a number, you're guessing which "
          "HALF of the code the bug hides in.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why is bisecting (cutting the search space in half "
          "repeatedly) usually much faster than reading every line one "
          "by one?",
      options: [
        "It isn't faster — it just feels more fun",
        'Each round eliminates roughly HALF of the remaining '
            'possibilities, so the search shrinks exponentially fast',
        'It only works on Mondays',
        'It skips testing entirely',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — just like binary search, halving the search space "
          "each round finds the culprit in far fewer steps than checking "
          "one at a time.",
      explainBad:
          "Think binary search: eliminating HALF the suspects each "
          "round shrinks the problem exponentially, way faster than "
          "one-by-one checking.",
    ),
  ),
  const Chapter(
    id: 14,
    title: 'Logging Basics',
    avatar: '📝',
    role: 'Narrator — writing in a workshop logbook',
    bodyIntro:
        "📝 Every good workshop keeps a logbook. In software, logging is "
        "how a running program leaves a trail of breadcrumbs, so you (or "
        "a teammate at 2am) can figure out what happened without "
        "re-running it live.\n\nMost systems use a few standard log "
        "levels:\n\n"
        "ℹ️ INFO — normal checkpoints (\"user logged in\")\n\n"
        "⚠️ WARN — something odd, but recoverable (\"retrying request\")\n\n"
        "🚨 ERROR — something genuinely failed\n\n"
        "⚠️ One golden rule: never log secrets — passwords, API keys, "
        "credit card numbers. Logs get read by many eyes and stored for "
        "a long time; treat them like anything but a private vault.\n\n"
        "🎯 Sort each message into the right log level.",
    calloutHints: [
      "🕵️ Kid tip: a good log is like a detective's notebook — enough "
          "detail to reconstruct what happened, but never writing down "
          "someone's actual house key.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each message into the log level it belongs to.",
      bucketALabel: 'ℹ️ INFO / ⚠️ WARN',
      bucketBLabel: '🚨 ERROR',
      items: [
        Sort2Item('login', '"User 4821 logged in successfully"', true),
        Sort2Item(
          'retry',
          '"Request timed out, retrying (attempt 2 of 3)"',
          true,
        ),
        Sort2Item(
          'crash',
          '"Database connection failed, request cannot complete"',
          false,
        ),
        Sort2Item(
          'corrupt',
          '"Payment could not be processed due to invalid data"',
          false,
        ),
      ],
      explainOk:
          "Right! Routine or recoverable events are INFO/WARN; a genuine "
          "failure to complete the operation is ERROR.",
      explainBad:
          "Ask: did the operation actually FAIL to complete? If yes, "
          "that's ERROR. If it's routine or just a recoverable hiccup, "
          "it's INFO/WARN.",
    ),
  ),
  const Chapter(
    id: 15,
    title: 'Defensive Programming',
    avatar: '🛡️',
    role: 'Narrator — building in guardrails',
    bodyIntro:
        "🛡️ A crafter here builds a bridge with railings on both sides "
        "— not because they expect people to fall, but because they "
        "don't want a single stumble to be catastrophic. That's "
        "defensive programming: assume inputs might be wrong, and fail "
        "safely and clearly when they are.\n\n"
        "function divide(a, b) {\n"
        "  if (b === 0) {\n"
        "    throw new Error(\"Cannot divide by zero\");\n"
        "  }\n"
        "  return a / b;\n"
        "}\n\n"
        "Without that check, dividing by zero might silently produce "
        "garbage (or crash confusingly deep inside some other function). "
        "WITH the check, the failure is immediate, clear, and points "
        "straight at the real problem.\n\n"
        "🧠 What's the real benefit of the guard clause above?",
    calloutHints: [
      "🚧 Kid tip: defensive code is like putting a \"wet floor\" sign "
          "right where the spill happened — instead of letting someone "
          "slip three rooms away and wonder why.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why is checking for b === 0 before dividing considered good "
          "defensive programming?",
      options: [
        'It makes the function run twice as fast',
        'It turns a silent, confusing failure into an immediate, clear '
            'error at the actual source of the problem',
        'It is required by every programming language',
        'It prevents the function from ever being called',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — defensive checks convert 'mysterious bug three "
          "functions later' into 'clear error right here, right now.'",
      explainBad:
          "The point isn't speed — it's clarity: catching bad input "
          "immediately, at its source, instead of letting it cause "
          "confusing failures elsewhere.",
    ),
  ),
  const Chapter(
    id: 16,
    title: 'Print Debugging vs a Real Debugger',
    avatar: '🖨️',
    role: 'Narrator — comparing two toolboxes',
    bodyIntro:
        "🖨️ Two crafters are hunting the same bug. One sprinkles print(x) "
        "statements everywhere and reruns the program over and over. The "
        "other attaches a debugger, pauses the program mid-run at a "
        "breakpoint, and inspects every variable's live value on the "
        "spot.\n\nBoth are legitimate tools! Print debugging is quick for "
        "simple cases. But a real debugger lets you pause exactly where "
        "things go wrong, inspect the whole call stack, and step through "
        "line by line — which scales much better on tricky, "
        "hard-to-reproduce bugs.\n\n"
        "🧠 When does a real debugger clearly win over print statements?",
    calloutHints: [
      "🔬 Kid tip: print debugging is like leaving sticky notes "
          "everywhere hoping one explains the mystery. A debugger is "
          "like a magnifying glass you can point at the exact moment "
          "things go wrong.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "For a tricky, hard-to-reproduce bug deep in a complex call "
          "chain, why does a real debugger usually beat sprinkling print "
          "statements?",
      options: [
        'Print statements are always wrong',
        'A debugger lets you pause execution and inspect every variable '
            'and the full call stack live, without rerunning the whole '
            'program repeatedly',
        'Debuggers are required by law for professional code',
        'print() does not exist in most programming languages',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — pausing live at the exact failure point and "
          "inspecting real state beats guessing where to place the next "
          "print statement.",
      explainBad:
          "The real advantage is live inspection: pausing exactly where "
          "things break and looking at everything at once, instead of "
          "guessing where to add the next print().",
    ),
  ),
  const Chapter(
    id: 17,
    title: 'Spotting Code Smells',
    avatar: '👃',
    role: 'Narrator — sniffing out trouble',
    bodyIntro:
        "👃 A \"code smell\" isn't a bug — the code might work perfectly "
        "fine right now. It's a warning sign that something will "
        "probably cause pain LATER. A few classics:\n\n"
        "📋 Duplicated logic — the same fix now has to happen in three "
        "places\n\n"
        "🎭 A function doing five unrelated things — hard to name, hard "
        "to test\n\n"
        "📦 A ten-argument parameter list — easy to pass things in the "
        "wrong order\n\n"
        "🌀 Deeply nested if/else pyramids — hard to trace which branch "
        "you're in\n\n"
        "🎯 Spot the code smell in this snippet.",
    calloutHints: [
      "🥛 Kid tip: a code smell is like milk that's a day before its "
          "expiration date — it's not spoiled YET, but you'd be smart to "
          "deal with it before it actually goes bad.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "function process(a, b, c, d, e, f, g, h, i, j) {\n"
          "    // ... uses all ten in a tangled way\n"
          "}\n\n"
          "What code smell does this function show?",
      options: [
        'It is perfectly fine — more parameters means more flexibility',
        'A parameter list this long is a smell: hard to call correctly '
            'and easy to mix up order',
        'It has a syntax error',
        'It runs too fast',
      ],
      answerIndex: 1,
      explainOk:
          "Right — a wall of similar-looking parameters is a classic "
          "smell; callers easily swap the wrong values by accident.",
      explainBad:
          "Ten loose parameters isn't a syntax problem — it's a design "
          "smell: too easy to accidentally pass arguments in the wrong "
          "order.",
    ),
  ),
  const Chapter(
    id: 18,
    title: 'Refactoring: Same Behavior, Better Shape',
    avatar: '🔨',
    role: 'Narrator — reshaping without breaking',
    bodyIntro:
        "🔨 Refactoring means changing the internal STRUCTURE of code "
        "without changing what it actually DOES from the outside. Same "
        "inputs, same outputs — just cleaner, clearer, easier to work "
        "with.\n\nThe safety net that makes this possible: a solid test "
        "suite (remember the pyramid from Level 3?). If tests still pass "
        "after your changes, you can be confident behavior didn't shift.\n\n"
        "Before: one giant 80-line function\n"
        "After:  five small, clearly-named functions, same overall "
        "result\n\n"
        "Tests pass before AND after → refactor was safe\n\n"
        "🧠 What's the one thing refactoring must NEVER change?",
    calloutHints: [
      "🧱 Kid tip: refactoring is like reorganizing a messy toy chest — "
          "the same toys are still all there, just easier to find now.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What must stay exactly the same when you refactor code?",
      options: [
        'The number of lines of code',
        'The observable behavior — same inputs must still produce the '
            'same outputs',
        'The variable names',
        'The programming language it is written in',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — refactoring is purely structural. If behavior "
          "changes, it's not a refactor anymore, it's a feature change "
          "(or a bug).",
      explainBad:
          "Refactoring is defined by preserving BEHAVIOR — same inputs, "
          "same outputs — while the internal structure improves.",
    ),
  ),
  const Chapter(
    id: 19,
    title: 'What Technical Debt Really Means',
    avatar: '💳',
    role: 'Narrator — seeing a bill come due',
    bodyIntro:
        "💳 A crafter took a shortcut last month to ship faster — glued a "
        "part instead of properly welding it. It worked! But now every "
        "new gadget built on top of it is slower and riskier to build. "
        "That's technical debt: it's a real loan, not a free gift.\n\n"
        "Shortcuts aren't automatically bad — sometimes shipping fast on "
        "purpose is the right call. The mistake is forgetting you took "
        "the loan, and never paying it back. Debt quietly compounds: "
        "each new feature built on shaky ground costs a little more "
        "than it should.\n\n"
        "🧠 Which statement best captures technical debt?",
    calloutHints: [
      "📈 Kid tip: technical debt is like borrowing your friend's "
          "homework answers once — fine in an emergency, but if you "
          "never actually learn the material, every future test gets "
          "harder.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which statement best describes technical debt?",
      options: [
        'It is always a mistake and should never happen',
        'It is a deliberate or accidental shortcut that trades '
            'short-term speed for long-term cost — like a loan that '
            'accrues interest',
        'It only refers to money owed to a software vendor',
        'It disappears automatically over time',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the loan metaphor is precise: debt can be a smart "
          "short-term trade, but it must eventually be paid down or it "
          "compounds.",
      explainBad:
          "Technical debt isn't inherently 'bad' or something that "
          "vanishes — it's a real tradeoff, like a loan with interest, "
          "that needs to be tracked and repaid.",
    ),
  ),
  const Chapter(
    id: 20,
    title: 'The Boy Scout Rule: Paying Down Debt',
    avatar: '🏕️',
    role: 'Narrator — tidying the campsite',
    bodyIntro:
        "🏕️ There's an old scouting rule painted on a Craft Cove sign: "
        "\"leave the campsite better than you found it.\" Applied to "
        "code: every time you touch a file, leave it slightly cleaner "
        "than it was — rename a confusing variable, extract a tangled "
        "block, add a missing test.\n\nThis small-and-continuous approach "
        "beats waiting for a giant \"refactor everything\" project that "
        "never gets scheduled. Debt gets paid down naturally, alongside "
        "regular feature work, instead of being tracked as invisible "
        "tribal knowledge that only lives in one person's head.\n\n"
        "🎯 Sort good vs risky debt-management habits.",
    calloutHints: [
      "🧹 Kid tip: it's easier to tidy your room a little bit every day "
          "than to let it pile up for six months and then face one "
          "giant, dreaded cleaning day.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each habit into the correct bucket.",
      bucketALabel: '✅ Good habit',
      bucketBLabel: '⚠️ Risky habit',
      items: [
        Sort2Item(
          'leave',
          'Leave code slightly cleaner every time you touch it',
          true,
        ),
        Sort2Item(
          'tribal',
          "Keep track of known debt only in one person's memory",
          false,
        ),
        Sort2Item(
          'ticket',
          'File a visible ticket describing the shortcut taken and why',
          true,
        ),
        Sort2Item(
          'waitforever',
          "Wait for a mythical future 'big cleanup sprint' that never "
              "gets scheduled",
          false,
        ),
      ],
      explainOk:
          "Exactly — small continuous cleanup and visible tracking beat "
          "silent tribal knowledge and endlessly deferred 'someday' "
          "cleanups.",
      explainBad:
          "Good debt management is small, continuous, and VISIBLE "
          "(tickets, not tribal memory) — not a giant deferred cleanup "
          "that never actually happens.",
    ),
  ),
  const Chapter(
    id: 21,
    title: 'SOLID: Single Responsibility & Open/Closed',
    avatar: '🧱',
    role: 'Narrator — meeting the SOLID crafters',
    bodyIntro:
        "🧱 Five master crafters teach five principles for building "
        "software that stays easy to change — together they spell "
        "SOLID. Let's meet the first two.\n\n"
        "🎯 S — Single Responsibility Principle: a class or function "
        "should have exactly ONE reason to change. If UserAccount "
        "handles both \"saving to the database\" AND \"formatting an "
        "email,\" a change to either job forces a change to the same "
        "class — that's a tangle waiting to happen.\n\n"
        "🚪 O — Open/Closed Principle: code should be open to extension "
        "(you can add new behavior) but closed to modification (you "
        "don't have to rewrite existing, working code to do it) — often "
        "achieved by adding new classes/functions rather than editing "
        "old ones.\n\n"
        "🧩 Match each SOLID letter to its meaning.",
    calloutHints: [
      "🔌 Kid tip: Open/Closed is like a power strip — you EXTEND what's "
          "plugged in without ever having to rewire the strip itself.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a letter on the left, then click its correct meaning "
          "on the right.",
      pairs: [
        MatchPair(
          's',
          'S — Single Responsibility',
          'One class, one reason to change',
        ),
        MatchPair(
          'o',
          'O — Open/Closed',
          'Extend behavior without modifying existing working code',
        ),
      ],
      explainOk:
          "Correct! S keeps classes focused; O lets you add new "
          "behavior safely without rewriting what already works.",
    ),
  ),
  const Chapter(
    id: 22,
    title: 'SOLID: Liskov, Interface Segregation, Dependency Inversion',
    avatar: '🧱',
    role: 'Narrator — meeting the last three crafters',
    bodyIntro:
        "🧱 The remaining three SOLID principles:\n\n"
        "🔄 L — Liskov Substitution: if Square is a subtype of "
        "Rectangle, you should be able to swap a Square in anywhere a "
        "Rectangle is expected, WITHOUT surprising behavior. A subtype "
        "must honor the promises of its parent type.\n\n"
        "✂️ I — Interface Segregation: don't force a class to implement "
        "methods it doesn't need. Prefer several small, focused "
        "interfaces over one giant \"do everything\" interface.\n\n"
        "🔀 D — Dependency Inversion: high-level code should depend on "
        "abstractions (interfaces), not on concrete low-level details — "
        "so you can swap the database or the payment provider without "
        "rewriting business logic.\n\n"
        "🧩 Match each remaining SOLID letter.",
    calloutHints: [
      "🧩 Kid tip: Dependency Inversion is like a lamp with a standard "
          "plug — the lamp doesn't care WHICH power company you use, as "
          "long as the plug shape (the interface) matches.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a letter on the left, then click its correct meaning "
          "on the right.",
      pairs: [
        MatchPair(
          'l',
          'L — Liskov Substitution',
          'A subtype must behave consistently with its parent type',
        ),
        MatchPair(
          'i',
          'I — Interface Segregation',
          'Prefer small focused interfaces over one giant do-everything '
              'interface',
        ),
        MatchPair(
          'd',
          'D — Dependency Inversion',
          'Depend on abstractions, not concrete low-level implementations',
        ),
      ],
      explainOk:
          "All matched! Liskov protects substitutability, Interface "
          "Segregation avoids bloated contracts, Dependency Inversion "
          "enables swapping implementations.",
    ),
  ),
  const Chapter(
    id: 23,
    title: 'Design Pattern: Strategy',
    avatar: '🎲',
    role: 'Narrator — swapping tools without changing the toolbox',
    bodyIntro:
        "🎲 Imagine sorting a list of gadgets — sometimes by price, "
        "sometimes by weight, sometimes by popularity. Instead of one "
        "giant function stuffed with if/else for every sorting rule, "
        "the Strategy pattern makes each sorting rule its OWN small, "
        "swappable object, all implementing the same simple interface.\n\n"
        "sorter.setStrategy(sortByPrice)\n"
        "sorter.sort(gadgets)     // uses whichever strategy is "
        "currently set\n"
        "sorter.setStrategy(sortByWeight)\n"
        "sorter.sort(gadgets)     // same call, totally different "
        "behavior\n\n"
        "The calling code (sorter.sort(...)) never changes — only the "
        "strategy plugged in changes. This is a direct, practical use "
        "of both Open/Closed and Dependency Inversion from the last two "
        "chapters.\n\n"
        "🧠 What's the core idea behind the Strategy pattern?",
    calloutHints: [
      "🎮 Kid tip: Strategy is like a video game character with "
          "swappable weapons — the \"attack\" button always works the "
          "same way, but what actually happens depends on which weapon "
          "is equipped.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What's the core idea of the Strategy design pattern?",
      options: [
        'Hard-code every possible behavior into one giant if/else block',
        'Make the algorithm itself swappable behind a shared interface, '
            'so the calling code never has to change',
        'Delete all but one possible behavior',
        'Only allow the algorithm to change once, at compile time, '
            'forever',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the calling code stays fixed and simple, while the "
          "plugged-in strategy object is what actually varies.",
      explainBad:
          "The whole point is swappability: the CALLING code never "
          "changes, but you can plug in a different strategy object to "
          "get different behavior.",
    ),
  ),
  const Chapter(
    id: 24,
    title: 'Design Pattern: Observer',
    avatar: '📢',
    role: 'Narrator — ringing a bell for everyone at once',
    bodyIntro:
        "📢 A workbench has a bell wired to several lightbulbs across "
        "the room. Ring the bell, and every connected lightbulb reacts "
        "— without the bell needing to know exactly which bulbs exist "
        "or how many.\n\nThat's the Observer pattern: a subject keeps a "
        "list of observers that want to be notified when something "
        "happens. When the subject's state changes, it notifies "
        "everyone on the list, and each observer decides how to react.\n\n"
        "subject.subscribe(observerA)\n"
        "subject.subscribe(observerB)\n"
        "subject.notify()   // both A and B get notified, independently\n\n"
        "This is everywhere in real software: UI frameworks reacting to "
        "state changes, pub/sub messaging systems, and event listeners "
        "in a browser are all Observer in disguise.\n\n"
        "🧠 Spot the real Observer behavior.",
    calloutHints: [
      "📻 Kid tip: Observer is like a radio station broadcasting a song "
          "— the station doesn't know or care how many radios are tuned "
          "in, it just broadcasts.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which situation best matches the Observer pattern?",
      options: [
        'A function that only ever has one caller, hard-coded by name',
        'A subject that notifies a list of independent, subscribed '
            'listeners whenever its state changes, without knowing '
            'their details',
        'A single object that never communicates with anything else',
        'A function that must be called exactly once at program startup',
      ],
      answerIndex: 1,
      explainOk:
          "Right — the defining trait is one-to-many notification: "
          "subject changes, all subscribed observers react "
          "independently.",
      explainBad:
          "Observer is about one-to-MANY notification: a subject "
          "broadcasts changes to however many observers are currently "
          "subscribed.",
    ),
  ),
  const Chapter(
    id: 25,
    title: 'What a Build System Actually Does',
    avatar: '🏗️',
    role: 'Narrator — watching raw materials become a tool',
    bodyIntro:
        "🏗️ Level 7! Watch this conveyor belt: raw source files go in "
        "one end, a finished, runnable program comes out the other. "
        "That's a build system — it compiles or bundles your code, "
        "resolves dependencies, and often runs checks before producing "
        "the final artifact.\n\n"
        "source files → compile/bundle → run checks → shippable "
        "artifact\n\n"
        "Build systems matter because \"does my code work\" is a totally "
        "different question from \"does my code even successfully turn "
        "into something runnable.\" A build failure catches syntax "
        "errors, type mismatches, and missing dependencies before "
        "anyone ever tries to run the thing.\n\n"
        "🔢 Order the build pipeline.",
    calloutHints: [
      "🍞 Kid tip: think of a build system like a bakery's assembly "
          "line — raw flour and eggs (source code) go in one end, and a "
          "finished, ready-to-eat loaf (a runnable program) comes out "
          "the other.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these stages in the order a typical build actually "
          "runs.",
      items: [
        OrderItem('source', 'Raw source files'),
        OrderItem('compile', 'Compile / bundle the code'),
        OrderItem('tests', 'Run automated tests'),
        OrderItem('artifact', 'Produce the final shippable artifact'),
      ],
      explainOk:
          "That's the pipeline — you can't test what hasn't compiled, "
          "and you shouldn't ship what hasn't passed tests.",
      explainBad:
          "You must compile before you can test, and tests should pass "
          "before you produce the final shippable artifact.",
    ),
  ),
  const Chapter(
    id: 26,
    title: 'The Dependency Tree',
    avatar: '🌲',
    role: 'Narrator — following a chain of borrowed tools',
    bodyIntro:
        "🌲 Your code depends on library left-pad. But left-pad itself "
        "depends on pad-utils, which depends on core-lib. This chain is "
        "your project's dependency tree — direct dependencies you "
        "chose, and transitive dependencies you inherited without "
        "picking them yourself.\n\n"
        "your app\n"
        " └─ left-pad\n"
        "     └─ pad-utils\n"
        "         └─ core-lib\n\n"
        "This is powerful (you get to reuse huge amounts of other "
        "people's work for free) but also risky: a bug, security hole, "
        "or breaking change deep in core-lib can ripple all the way up "
        "to your app, even though you never directly chose to depend on "
        "it.\n\n"
        "🧠 What's a transitive dependency?",
    calloutHints: [
      "🧩 Kid tip: transitive dependencies are like borrowing a friend's "
          "bike, not realizing the bike itself was borrowed from someone "
          "else — if THAT person wants it back, it affects you too.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In the chain your-app → left-pad → pad-utils → core-lib, "
          "what is core-lib from your app's perspective?",
      options: [
        'A direct dependency you explicitly chose to install',
        'A transitive dependency — you never chose it directly, but you '
            'depend on it through left-pad',
        'It is unrelated to your app entirely',
        'A test-only tool with no runtime effect',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — you inherited core-lib through the chain, without "
          "directly choosing it, which is exactly what makes it "
          "'transitive.'",
      explainBad:
          "You only directly chose left-pad. Everything left-pad itself "
          "depends on — like core-lib — is a TRANSITIVE dependency you "
          "inherited.",
    ),
  ),
  const Chapter(
    id: 27,
    title: 'Package Managers',
    avatar: '📦',
    role: 'Narrator — visiting the supply depot',
    bodyIntro:
        "📦 Before package managers, getting a library meant manually "
        "downloading a zip file, unpacking it, and hoping you tracked "
        "which version you used. A package manager (like npm, pip, or "
        "Cargo) automates all of this: it downloads the right versions, "
        "resolves the whole dependency tree, and gives you one command "
        "to update everything.\n\n"
        "npm install     # or pip install, cargo add, etc.\n"
        "→ resolves the FULL dependency tree\n"
        "→ downloads exact versions\n"
        "→ writes them into a manifest file\n\n"
        "🎯 Sort the \"manual\" way vs the \"package manager\" way.",
    calloutHints: [
      "🚚 Kid tip: a package manager is like a supply depot that "
          "automatically finds and delivers every tool AND every "
          "tool-that-the-tool-needs, instead of you hunting down each "
          "one by hand.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each scenario into the right bucket.",
      bucketALabel: '😩 Manual',
      bucketBLabel: '📦 Package Manager',
      items: [
        Sort2Item(
          'ziphunt',
          'Hunting down a .zip file on some website and unpacking it '
              'by hand',
          true,
        ),
        Sort2Item(
          'install',
          'Running one install command that resolves the whole '
              'dependency tree',
          false,
        ),
        Sort2Item(
          'trackversion',
          'Keeping track of exact versions in a spreadsheet by memory',
          true,
        ),
        Sort2Item(
          'update',
          'Running one command to update every dependency safely',
          false,
        ),
      ],
      explainOk:
          "Correct — package managers automate exactly the tedious, "
          "error-prone parts of dependency handling.",
      explainBad:
          "Manual = hunting files and tracking versions by hand. "
          "Package manager = one command handles resolution, download, "
          "and updates.",
    ),
  ),
  const Chapter(
    id: 28,
    title: 'Lockfiles: Reproducible Builds',
    avatar: '🔐',
    role: 'Narrator — comparing a range to an exact pin',
    bodyIntro:
        "🔐 Your package.json says \"react\": \"^18.0.0\" — the ^ means "
        "\"any compatible version 18.x.x is fine,\" a RANGE. But if two "
        "teammates install at different times, they could get different "
        "exact versions inside that range!\n\nThe lockfile "
        "(package-lock.json, Cargo.lock, etc.) pins the EXACT version "
        "that was actually resolved and tested — 18.2.4, not just "
        "\"18-something.\" Everyone who installs from the same lockfile "
        "gets the identical dependency tree, byte for byte.\n\n"
        "🧠 Why do lockfiles matter for teams?",
    calloutHints: [
      "🧬 Kid tip: a version range is like saying \"any red LEGO brick "
          "is fine.\" A lockfile is like saying \"THIS exact brick, part "
          "#3001, in THIS exact red.\" Reproducibility needs the second "
          "one.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why do professional teams commit a lockfile alongside "
          "package.json?",
      options: [
        'It makes the code run faster at runtime',
        'It guarantees everyone installing the project gets the EXACT '
            "same dependency versions, avoiding 'works on my machine' "
            'surprises',
        'It is required to write any tests at all',
        'It replaces the need for version control entirely',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — lockfiles turn a flexible version RANGE into an "
          "exact, reproducible pin everyone shares.",
      explainBad:
          "The lockfile's whole job is reproducibility — pinning EXACT "
          "versions so every install produces the identical dependency "
          "tree.",
    ),
  ),
  const Chapter(
    id: 29,
    title: 'Continuous Integration, End to End',
    avatar: '🔄',
    role: 'Narrator — watching a robot wake up on every push',
    bodyIntro:
        "🔄 Every time anyone pushes a commit, a little robot in Craft "
        "Cove wakes up automatically, grabs the latest code, builds it, "
        "and runs the full test suite — no human has to remember to "
        "trigger it. That's Continuous Integration (CI).\n\n"
        "push commit → CI server wakes → build + test → pass/fail "
        "signal (fast!)\n\n"
        "The core idea: integrate everyone's changes together "
        "CONSTANTLY (many times a day), so conflicts and breakages "
        "surface within minutes — not weeks later when merging becomes "
        "a nightmare.\n\n"
        "🧠 What's the core promise of CI?",
    calloutHints: [
      "🚨 Kid tip: CI is like a smoke detector that checks the whole "
          "house every single time someone lights a candle — instant "
          "feedback, instead of finding out about a fire days later.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What's the main point of Continuous Integration?",
      options: [
        'Every commit is automatically built and tested, giving fast '
            'feedback on problems',
        'It replaces the need for any human code review',
        'It only runs once a month on a schedule',
        'It guarantees code has zero bugs forever',
      ],
      answerIndex: 0,
      explainOk:
          "Right — fast, automatic feedback on every single commit is "
          "the whole point of CI.",
      explainBad:
          "CI's core value is FAST, AUTOMATIC feedback on every commit "
          "— not a monthly check, and not a replacement for human "
          "review.",
    ),
  ),
  const Chapter(
    id: 30,
    title: "A Typical CI Pipeline's Stages",
    avatar: '🪜',
    role: "Narrator — climbing the pipeline's rungs",
    bodyIntro:
        "🪜 Peeking inside the CI robot, its work happens in ordered "
        "stages, each one a gate: if an earlier stage fails, later "
        "stages don't even run (no point testing code that doesn't even "
        "install its dependencies).\n\n"
        "checkout code → install dependencies → lint → run tests → "
        "build artifact\n\n"
        "📥 Checkout — grab the exact commit that was pushed\n\n"
        "📦 Install — pull dependencies from the lockfile\n\n"
        "🧹 Lint — check style/quality rules automatically\n\n"
        "🧪 Test — run the automated test suite\n\n"
        "🏗️ Build — produce the final artifact\n\n"
        "🔢 Put the CI stages in order.",
    calloutHints: [
      "🚦 Kid tip: it's like a relay race — each runner (stage) only "
          "starts once the one before them successfully finishes and "
          "hands off the baton.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these CI stages in the order they typically run.",
      items: [
        OrderItem('checkout', 'Checkout the exact commit'),
        OrderItem('install', 'Install dependencies from the lockfile'),
        OrderItem('lint', 'Run the linter'),
        OrderItem('test', 'Run the automated test suite'),
        OrderItem('build', 'Produce the final build artifact'),
      ],
      explainOk:
          "That's the standard pipeline — each stage is a gate for the "
          "next, all the way to a finished artifact.",
      explainBad:
          "You must checkout and install dependencies before you can "
          "lint or test anything, and the final build comes last.",
    ),
  ),
  const Chapter(
    id: 31,
    title: 'Test Suites as a Safety Net',
    avatar: '🕸️',
    role: 'Narrator — watching a fall get caught',
    bodyIntro:
        "🕸️ A crafter's tool slips off a high shelf. Instead of hitting "
        "the ground, it lands safely in a net strung below. That net is "
        "the automated test suite: it catches regressions (things that "
        "used to work, but broke) automatically, on every single "
        "change, without anyone having to remember to check by hand.\n\n"
        "Without that safety net, every change is scary — \"did I just "
        "quietly break something three features away?\" With it, a full "
        "re-run of the ENTIRE suite happens on every merge, catching "
        "regressions within minutes instead of after they reach real "
        "users.\n\n"
        "🧠 What does a good test suite actually protect against?",
    calloutHints: [
      "🎪 Kid tip: it's the difference between a trapeze artist working "
          "with a net versus without one — the net doesn't stop mistakes "
          "from happening, it just makes sure they don't become "
          "disasters.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What does a good automated test suite mainly protect a team "
          "against?",
      options: [
        'Writing new features at all',
        'Regressions — previously-working behavior silently breaking '
            'because of a new change',
        'Having to write any documentation',
        'Choosing the wrong programming language',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the safety net is specifically about catching "
          "regressions automatically, before they reach real users.",
      explainBad:
          "The whole point is catching REGRESSIONS — things that used "
          "to work quietly breaking — automatically and early.",
    ),
  ),
  const Chapter(
    id: 32,
    title: 'Why Fast Feedback Loops Matter',
    avatar: '⏱️',
    role: 'Narrator — comparing two clocks',
    bodyIntro:
        "⏱️ Two teams both introduce the same bug. Team A finds out from "
        "CI in 3 minutes. Team B finds out from a user complaint 3 weeks "
        "after release.\n\nFor Team A, the context is completely fresh — "
        "the engineer remembers exactly what they changed and why, and "
        "the fix is cheap and fast. For Team B, nobody remembers the "
        "details anymore, other changes have piled on top, and the fix "
        "is expensive, risky, and slow.\n\n"
        "🎯 Sort each situation by feedback speed.",
    calloutHints: [
      "🔥 Kid tip: fast feedback is like a smoke alarm that beeps the "
          "instant you burn toast, versus finding out your kitchen "
          "caught fire a month later — the sooner you know, the cheaper "
          "and easier the fix.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each scenario into the correct bucket.",
      bucketALabel: '🐢 Slow Feedback',
      bucketBLabel: '⚡ Fast Feedback',
      items: [
        Sort2Item(
          'userreport',
          'A bug discovered by a customer complaint weeks after release',
          true,
        ),
        Sort2Item(
          'cifail',
          'CI fails within minutes of pushing the breaking commit',
          false,
        ),
        Sort2Item(
          'quarterlyaudit',
          'A rarely-run quarterly manual audit finds a bug from months '
              'ago',
          true,
        ),
        Sort2Item(
          'prereview',
          'A reviewer catches the issue during the pull request itself',
          false,
        ),
      ],
      explainOk:
          "Exactly — the sooner a problem surfaces after the change "
          "that caused it, the cheaper and easier it is to fix.",
      explainBad:
          "Ask: how much time (and how many other changes) passed "
          "between the mistake and discovering it? Less time = faster "
          "feedback.",
    ),
  ),
  const Chapter(
    id: 33,
    title: 'Writing for Readability',
    avatar: '📖',
    role: 'Narrator — reading a confusing sign',
    bodyIntro:
        "📖 A sign in the workshop reads: x = a?b:(c||d). Technically "
        "correct, but nobody can tell what it MEANS at a glance. "
        "Readable code optimizes for the next human who reads it — "
        "often a future version of you, who has forgotten all the "
        "context.\n\nConcretely, that means:\n\n"
        "🏷️ Intention-revealing names (activeUserCount, not auc)\n\n"
        "🧩 Simple, explicit control flow over clever one-liners\n\n"
        "💬 Comments that explain WHY, not just restate WHAT the code "
        "obviously does\n\n"
        "🧠 Which version of the code is more readable, and why?",
    calloutHints: [
      "🗺️ Kid tip: readable code is like a well-labeled map — you "
          "shouldn't need the original mapmaker standing next to you to "
          "understand where you are.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Version A: x = a?b:(c||d)\n"
          "Version B: result = isValid ? primaryValue : (backupValue "
          "|| defaultValue)\n\n"
          "Which is more readable, and why?",
      options: [
        'Version A — shorter is always better',
        "Version B — the names reveal intent, making the logic clear "
            'at a glance without needing extra context',
        'They are equally readable',
        'Neither is readable; both should be deleted',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — same logic, but Version B's names reveal WHAT is "
          "happening and WHY, without extra explanation needed.",
      explainBad:
          "Readability isn't about brevity — it's about clarity. "
          "Version B uses intention-revealing names so the logic is "
          "clear without extra context.",
    ),
  ),
  const Chapter(
    id: 34,
    title: 'Documentation That Actually Matters',
    avatar: '🗒️',
    role: 'Narrator — reading (and pruning) old notes',
    bodyIntro:
        "🗒️ A shelf of old manuals sits here, half of them describing "
        "tools that don't exist anymore. Stale documentation is often "
        "worse than no documentation — it actively lies to whoever "
        "trusts it.\n\nGood documentation focuses on high-leverage "
        "things:\n\n"
        "🚀 A README that gets someone running the project in 5 minutes\n\n"
        "🤔 The WHY behind non-obvious decisions (the code already "
        "shows the WHAT)\n\n"
        "📍 Docs kept physically close to the code they describe, so "
        "they're easy to update together\n\n"
        "🧠 Why can stale docs be worse than no docs?",
    calloutHints: [
      "🧹 Kid tip: a wrong map is more dangerous than no map at all — "
          "at least with no map you know to ask for directions.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why can outdated documentation be actively worse than "
          "having no documentation at all?",
      options: [
        'Documentation always takes up too much disk space',
        'Readers trust it and follow incorrect instructions confidently, '
            'without knowing to double-check',
        'It is illegal to have outdated docs',
        'It makes the code compile slower',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — stale docs are trusted but wrong, actively "
          "misleading readers who have no reason to suspect them.",
      explainBad:
          "The danger is misplaced trust: a reader follows outdated "
          "instructions confidently, with no signal that anything's "
          "wrong.",
    ),
  ),
  const Chapter(
    id: 35,
    title: 'Pair Programming: Driver & Navigator',
    avatar: '👥',
    role: 'Narrator — watching two crafters share one bench',
    bodyIntro:
        "👥 Two crafters share one workbench. One, the driver, has the "
        "tools in hand and is actively typing. The other, the "
        "navigator, watches the bigger picture — spotting typos, "
        "suggesting the next step, thinking a few moves ahead. They "
        "swap roles regularly.\n\nPair programming isn't about \"two "
        "people doing the work of one\" — it's real-time code review AND "
        "knowledge sharing happening continuously, instead of after the "
        "fact. Bugs get caught the instant they're typed, and both "
        "people learn the whole codebase, not just their own corner of "
        "it.\n\n"
        "🧠 What's the real value pair programming adds?",
    calloutHints: [
      "🚗 Kid tip: pair programming is like driving with a co-pilot "
          "reading the map out loud — you catch wrong turns immediately, "
          "instead of ending up lost thirty minutes later.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the main value pair programming adds over one person "
          "coding alone?",
      options: [
        'It always makes the code twice as fast to write',
        'Real-time review and shared knowledge — mistakes get caught '
            'immediately, and both people understand the whole solution',
        'It eliminates the need for automated tests',
        'Only the navigator learns anything useful',
      ],
      answerIndex: 1,
      explainOk:
          "Right — immediate feedback and shared understanding are the "
          "real payoff, not raw typing speed.",
      explainBad:
          "The value isn't speed — it's catching mistakes immediately "
          "and both people genuinely understanding the code, not just "
          "one.",
    ),
  ),
  const Chapter(
    id: 36,
    title: 'Deep Code Review Practice',
    avatar: '🕵️',
    role: 'Narrator — training a sharper eye',
    bodyIntro:
        "🕵️ You learned the basics of code review back in Level 1. Now "
        "let's go deeper. A rigorous review checks, roughly in this "
        "order of importance:\n\n"
        "✅ Correctness — including edge cases, not just the happy path\n\n"
        "🏛️ Design fit — does this fit how the rest of the system is "
        "shaped?\n\n"
        "🧪 Test quality — do the tests actually PROVE the behavior, or "
        "just run without checking much?\n\n"
        "🎨 Style — least important, and ideally automated away by a "
        "linter entirely\n\n"
        "⚠️ Tone matters too: comment on the CODE, not the CODER. "
        "\"This function doesn't handle empty input\" invites a fix. "
        "\"You forgot empty input, again\" invites defensiveness instead "
        "of a fix.\n\n"
        "🔢 Order these review priorities from most to least important.",
    calloutHints: [
      "🎯 Kid tip: a great review is like a coach reviewing game footage "
          "— pointing at the PLAY that went wrong, not the PLAYER's "
          "character.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these review concerns from MOST important to LEAST "
          "important, in general.",
      items: [
        OrderItem('correctness', 'Correctness, including edge cases'),
        OrderItem('design', 'Design fit within the rest of the system'),
        OrderItem('tests', 'Whether tests genuinely prove the behavior'),
        OrderItem(
          'style',
          'Style preferences (ideally handled by a linter)',
        ),
      ],
      explainOk:
          "Right ordering — correctness first, then design, then test "
          "quality, with style mattering least (and best automated "
          "away).",
      explainBad:
          "Correctness should always come first; style should come "
          "last — a linter should be doing most of that work "
          "automatically anyway.",
    ),
  ),
  const Chapter(
    id: 37,
    title: 'CI/CD Pipelines in Production',
    avatar: '🚀',
    role: 'Narrator — entering the Professional Tier',
    bodyIntro:
        "🚀 🏆 PROFESSIONAL TIER. Everything from here is written at "
        "real production depth — the kind of judgment expected of a "
        "working engineer, not a classroom exercise.\n\nContinuous "
        "Delivery/Deployment (CD) extends CI: instead of just running "
        "tests, a passing build flows automatically toward production.\n\n"
        "build → test → deploy to staging → deploy to production → "
        "monitor\n\n"
        "Continuous Delivery means every passing build is READY to "
        "release at the push of a button — a human still decides when. "
        "Continuous Deployment goes one step further: passing builds "
        "ship to production automatically, no human gate at all. Most "
        "serious production systems land somewhere on this spectrum, "
        "not at either pure extreme.\n\n"
        "🧠 Distinguish Continuous Delivery from Continuous Deployment.",
    calloutHints: [
      "⚙️ Pro note: the deeper this pipeline goes without human "
          "intervention, the MORE your automated tests and monitoring "
          "have to be trustworthy — CD shifts risk from 'a human "
          "double-checks' to 'the pipeline had better be right.'",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the precise difference between Continuous Delivery "
          "and Continuous Deployment?",
      options: [
        'There is no real difference, they are the same thing',
        'Delivery means every passing build is release-ready but a '
            'human still decides when to ship; Deployment ships '
            'automatically with no human gate',
        'Delivery is for staging only; Deployment is for testing only',
        'Deployment means you deploy once a year, on a fixed schedule',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — Delivery keeps a human 'go' decision at the end; "
          "Deployment removes that gate entirely and ships "
          "automatically.",
      explainBad:
          "The distinction is the human gate at the very end: Delivery "
          "keeps it (release-ready, human decides); Deployment removes "
          "it (ships automatically).",
    ),
  ),
  const Chapter(
    id: 38,
    title: 'Feature Flags',
    avatar: '🚩',
    role: 'Narrator — a switch hidden in the code',
    bodyIntro:
        "🚩 A feature flag is a runtime switch that decides whether a "
        "piece of code path is active — without needing a new deploy to "
        "flip it.\n\n"
        "if (flag(\"new-checkout\")) {\n"
        "  return newCheckoutFlow();\n"
        "} else {\n"
        "  return oldCheckoutFlow();   // untouched, still there\n"
        "}\n\n"
        "This decouples deploying code (getting it onto production "
        "servers) from releasing it (turning it on for users). You can "
        "merge and deploy unfinished work continuously, hidden behind a "
        "flag that's off — reducing the risk of giant, rare, terrifying "
        "\"big bang\" releases.\n\n"
        "🧠 What real problem do feature flags solve?",
    calloutHints: [
      "⚠️ Pro pitfall: flags left in code forever become their own form "
          "of technical debt — every permanently-true flag is dead code "
          "and every conditional branch is a path that still has to be "
          "tested. Mature teams schedule flag cleanup, not just flag "
          "creation.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What core problem do feature flags solve in production "
          "systems?",
      options: [
        'They make code compile faster',
        'They decouple deploying code from releasing it, letting '
            "unfinished work ship hidden and reducing risky 'big bang' "
            'releases',
        'They replace the need for automated tests',
        'They are only useful for A/B testing button colors',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — deploy vs release decoupling is the core value; "
          "safer, smaller, reversible releases follow from that.",
      explainBad:
          "The core value is decoupling DEPLOY from RELEASE — code can "
          "be shipped continuously while staying hidden until it's "
          "actually turned on.",
    ),
  ),
  const Chapter(
    id: 39,
    title: 'Trunk-Based Development',
    avatar: '🌳',
    role: 'Narrator — everyone commits to one trunk',
    bodyIntro:
        "🌳 Trunk-based development takes branching (Level 2) to its "
        "logical extreme in the other direction: everyone commits "
        "directly to main (the \"trunk\"), constantly, in small "
        "increments — no long-lived feature branches that drift for "
        "weeks and become painful to merge.\n\n"
        "main branch — always releasable, everyone integrates here, "
        "continuously\n\n"
        "The catch: how do you commit unfinished work directly to a "
        "branch that must always be releasable? Answer: feature flags "
        "from the last chapter. Half-built features merge in, hidden "
        "behind a flag that's off, so main stays shippable at every "
        "single commit.\n\n"
        "🧠 What makes trunk-based development actually SAFE, not "
        "chaotic?",
    calloutHints: [
      "⚖️ Pro tradeoff: trunk-based development demands strong CI "
          "discipline and good flag hygiene — without them, 'everyone "
          "commits to main constantly' turns into 'main is broken "
          "constantly' instead.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Trunk-based development means everyone commits directly to "
          "main, constantly. What keeps main releasable despite "
          "unfinished work landing there?",
      options: [
        'Nothing — main is expected to be broken most of the time',
        'Feature flags hide unfinished work at runtime, combined with '
            'strong CI discipline that keeps main always passing',
        'Only senior engineers are allowed to commit to main',
        'Commits are reviewed once a year in a batch',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — feature flags plus rigorous CI are what make "
          "constant direct-to-main commits safe instead of chaotic.",
      explainBad:
          "The safety net is feature flags (hiding unfinished work) "
          "combined with strong, fast CI — without both, trunk-based "
          "dev breaks down.",
    ),
  ),
  const Chapter(
    id: 40,
    title: 'Progressive Rollout via Flags',
    avatar: '📈',
    role: 'Narrator — turning the dial slowly',
    bodyIntro:
        "📈 A feature flag doesn't have to be simply \"on\" or \"off\" "
        "for everyone at once — professionally, it's usually rolled out "
        "progressively:\n\n"
        "commit → flag on for internal team → flag on for 5% of users\n"
        "       → watch metrics closely → flag on for 100%\n\n"
        "At each step, you watch real production metrics (error rates, "
        "latency, business KPIs) before widening the rollout. If "
        "something looks wrong at 5%, you flip the flag back off — "
        "instantly, without a redeploy, and you've limited the blast "
        "radius to a small fraction of real users instead of everyone.\n\n"
        "🧠 Why roll out to 5% before 100%, instead of straight to "
        "everyone?",
    calloutHints: [
      "🎯 Pro insight: progressive rollout turns 'did this change break "
          "something?' from a scary yes/no gamble into a controlled, "
          "reversible, measured experiment.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why would a team deliberately roll a new feature out to 5% "
          "of users before going to 100%?",
      options: [
        'To make the feature run faster for those 5%',
        "To limit the blast radius — if something's wrong, only a "
            'small fraction of users are affected, and it is caught '
            'before wider rollout',
        'Because feature flags only support 5% at a time',
        'It has no real benefit, it is just tradition',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — limiting blast radius while watching real metrics "
          "is the entire point of progressive rollout.",
      explainBad:
          "The point is risk containment: a small percentage limits how "
          "many users are affected if something's actually broken, "
          "before you find out.",
    ),
  ),
  const Chapter(
    id: 41,
    title: 'Monorepos vs Polyrepos',
    avatar: '🗃️',
    role: 'Narrator — one giant filing cabinet, or many small ones',
    bodyIntro:
        "🗃️ A company with 40 services faces a real architectural "
        "choice: one giant repository holding everything (monorepo), "
        "or one repository per service (polyrepo)?\n\n"
        "📦 Monorepo — a single PR can atomically change a library AND "
        "every service that uses it, in one commit, one review, one CI "
        "run. But it demands serious build tooling (incremental builds, "
        "caching — next chapter) or a large repo becomes agonizingly "
        "slow to work in.\n\n"
        "🧩 Polyrepo — each service releases independently, on its own "
        "cadence, with clear ownership boundaries. But a change that "
        "must touch 5 services at once now means 5 separate PRs, 5 "
        "separate reviews, and careful sequencing of releases so "
        "nothing breaks in between.\n\n"
        "🎯 Sort each tradeoff into the model it belongs to.",
    calloutHints: [
      "⚖️ Pro take: there's no universally 'right' answer — Google and "
          "Meta run giant monorepos with massive investment in tooling; "
          "many orgs choose polyrepos specifically to avoid that tooling "
          "burden. The right choice depends on team size, release "
          "cadence, and tooling maturity.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each tradeoff into the model it best describes.",
      bucketALabel: '📦 Monorepo',
      bucketBLabel: '🧩 Polyrepo',
      items: [
        Sort2Item(
          'atomic',
          'One PR can atomically change a library and all its callers',
          true,
        ),
        Sort2Item(
          'independent',
          'Each service releases on its own independent schedule',
          false,
        ),
        Sort2Item(
          'tooling',
          'Needs heavy investment in build caching/tooling to stay fast '
              'at scale',
          true,
        ),
        Sort2Item(
          'crossrepo',
          'A cross-cutting change requires coordinating several '
              'separate PRs',
          false,
        ),
      ],
      explainOk:
          "Exactly — monorepos trade tooling investment for atomic "
          "cross-cutting changes; polyrepos trade coordination overhead "
          "for independence.",
      explainBad:
          "Monorepo = one atomic change, but needs serious tooling. "
          "Polyrepo = independent release cadence, but cross-cutting "
          "changes need coordination.",
    ),
  ),
  const Chapter(
    id: 42,
    title: 'Build Caching at Scale',
    avatar: '💾',
    role: "Narrator — skipping work that's already been done",
    bodyIntro:
        "💾 In a huge codebase, rebuilding EVERYTHING on every commit "
        "would take hours. Build caching fixes this with a simple, "
        "powerful idea: content-addressed results. If the exact same "
        "inputs (source files, dependencies, compiler flags) produced "
        "an output before, reuse that cached output instead of redoing "
        "the work.\n\n"
        "hash(inputs) → same hash seen before? → reuse cached output "
        "(instant)\n"
        "            → new hash?          → actually rebuild, then "
        "cache it\n\n"
        "This is why tools like Bazel, Buck, and Nx can make monorepo "
        "builds with millions of lines of code still complete in "
        "seconds for most changes — only the parts that actually "
        "changed (and everything downstream of them) get rebuilt.\n\n"
        "🧠 What does build caching fundamentally rely on?",
    calloutHints: [
      "⚠️ Pro pitfall: caching is only safe if the 'inputs' hash truly "
          "captures EVERYTHING that affects the output — a missed "
          "environment variable or implicit dependency causes 'cache "
          "poisoning,' where a stale, wrong result gets reused with "
          "high confidence.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What does build caching at scale fundamentally rely on to "
          "be correct?",
      options: [
        'A fast internet connection to the build server',
        'Accurately capturing ALL relevant inputs in a hash, so '
            'identical inputs reliably mean identical, safely-reusable '
            'outputs',
        'Rebuilding everything from scratch every single time, just '
            'faster hardware',
        "The build server's uptime percentage",
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — correctness depends entirely on the input hash "
          "truly capturing everything that could affect the output.",
      explainBad:
          "The core requirement is INPUT COMPLETENESS — if the hash "
          "misses something that affects output, cached results become "
          "silently wrong.",
    ),
  ),
  const Chapter(
    id: 43,
    title: 'Blue-Green Deployment',
    avatar: '🔵',
    role: 'Narrator — two identical stages, one spotlight',
    bodyIntro:
        "🔵 Blue-green deployment keeps two complete, identical "
        "production environments running: Blue (currently live, "
        "serving 100% of traffic) and Green (the new version, fully "
        "deployed but not yet receiving traffic).\n\n"
        "Deploy v2 fully to GREEN (idle) while BLUE (v1) still serves "
        "100% of traffic\n"
        "Flip the router → GREEN now serves 100%, instantly\n"
        "Problem found? Flip back to BLUE → instant rollback\n\n"
        "The key advantage over a traditional in-place deploy: the "
        "rollback is a router flip, not a redeploy — it's near-instant, "
        "and the old version is still fully intact and warm, ready to "
        "take traffic back immediately.\n\n"
        "🧠 What's the key operational advantage of blue-green over an "
        "in-place deploy?",
    calloutHints: [
      "⚠️ Pro cost: you're running double the infrastructure during the "
          "switch, and database schema changes need extra care — both "
          "BLUE and GREEN often need to tolerate the SAME database "
          "schema during the transition, or you need a more careful "
          "migration strategy.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the key operational advantage of blue-green "
          "deployment over deploying a new version in-place?",
      options: [
        'It uses less infrastructure overall',
        'Rollback is a near-instant router flip back to the still-warm, '
            'fully intact old environment, instead of a fresh redeploy',
        'It eliminates the need for any testing before deploy',
        'It guarantees zero database migrations are ever needed',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the old environment stays fully live and ready, so "
          "rollback is a router flip, not a slow redeploy.",
      explainBad:
          "The advantage is ROLLBACK SPEED: the old environment is "
          "still fully running, so reverting is just a router flip, not "
          "a redeploy.",
    ),
  ),
  const Chapter(
    id: 44,
    title: 'Canary Releases',
    avatar: '🐤',
    role: 'Narrator — sending a small bird in first',
    bodyIntro:
        "🐤 Named after miners sending a canary into a mine to detect "
        "danger before humans went in, a canary release ships a new "
        "version to a SMALL slice of real production traffic first, "
        "while the rest keeps running the old, proven version — then "
        "widens gradually as confidence grows.\n\n"
        "v2 → 1% of traffic → watch error rate & latency closely\n"
        "   → v2 → 25% of traffic → still healthy? → v2 → 100% of "
        "traffic\n\n"
        "Compared to blue-green (all-or-nothing traffic flip), canary "
        "is more gradual and catches problems that only show up under "
        "REAL production load and REAL traffic diversity — things "
        "staging environments often can't replicate.\n\n"
        "🧠 How does canary differ from blue-green fundamentally?",
    calloutHints: [
      "🔬 Pro nuance: canary analysis needs solid metrics and often "
          "statistical rigor — comparing the canary's error rate to the "
          "baseline requires enough traffic volume to be statistically "
          "meaningful, not just 'it looked fine for 30 seconds.'",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the fundamental difference between a canary release "
          "and a blue-green deployment?",
      options: [
        'There is no real difference between them',
        'Canary gradually shifts a growing percentage of traffic to '
            'the new version while watching metrics; blue-green flips '
            'ALL traffic at once between two complete environments',
        'Canary only works for mobile apps',
        'Blue-green is always safer than canary in every situation',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — canary is gradual and traffic-percentage-based; "
          "blue-green is an all-or-nothing flip between two full "
          "environments.",
      explainBad:
          "The core difference is granularity: canary shifts traffic "
          "gradually while watching metrics; blue-green flips "
          "everything at once.",
    ),
  ),
  const Chapter(
    id: 45,
    title: 'Technical Debt at Scale',
    avatar: '🏦',
    role: 'Narrator — the whole org paying interest',
    bodyIntro:
        "🏦 You met technical debt as a personal loan back in Level 5. "
        "At the scale of an entire organization with dozens of teams, "
        "debt compounds differently: a shaky shared library used by 30 "
        "services means EVERY team pays interest on the SAME debt, "
        "simultaneously, forever, until someone actually fixes the "
        "root cause.\n\nAt this scale, tracking debt informally in "
        "someone's head is a liability. Mature orgs treat debt like a "
        "real budget line:\n\n"
        "📊 Visible debt registries, not tribal knowledge\n\n"
        "⏳ Explicit \"interest\" estimates — how much slower does each "
        "new feature get?\n\n"
        "🎯 Dedicated time allocated to paying it down, not just \"if we "
        "ever get around to it\"\n\n"
        "🧠 What changes about tech debt once it's shared across many "
        "teams?",
    calloutHints: [
      "⚠️ Pro reality: the hardest debt to justify fixing is the kind "
          "that's invisible to leadership because it 'still works' — "
          "the argument for paying it down has to be made in terms of "
          "velocity lost and risk carried, not just 'this code is "
          "ugly.'",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What changes about technical debt once it lives in a shared "
          "library used by 30 teams, compared to debt in one team's own "
          "codebase?",
      options: [
        'Nothing changes — the debt is exactly as costly either way',
        'The interest is now paid by every team simultaneously, making '
            'informal tracking a serious organizational liability that '
            'needs visible, budgeted attention',
        'It automatically becomes cheaper because more people depend '
            'on it',
        'It is no longer technical debt once other teams use it',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — shared debt multiplies its cost across every "
          "dependent team, which is exactly why it needs visible, "
          "budgeted tracking, not tribal memory.",
      explainBad:
          "Shared debt compounds: every dependent team pays the SAME "
          "interest simultaneously — which is why it can't stay "
          "informal or invisible at that scale.",
    ),
  ),
  const Chapter(
    id: 46,
    title: 'The Strangler Fig Pattern',
    avatar: '🌱',
    role: 'Narrator — a vine slowly replacing a tree',
    bodyIntro:
        "🌱 Named after a real vine that grows around a host tree and "
        "gradually replaces it, the Strangler Fig pattern is the "
        "standard professional strategy for migrating off a legacy "
        "system SAFELY: don't do a risky \"big bang\" rewrite — instead, "
        "route traffic piece by piece to the new system, while the old "
        "system keeps running underneath, shrinking over time.\n\n"
        "Route login → new system   (legacy still handles everything "
        "else)\n"
        "Route search → new system  (legacy shrinks further)\n"
        "... repeat until legacy handles nothing → decommission it\n\n"
        "At every step, the blast radius of a mistake is limited to "
        "ONE piece of functionality, not the whole system — and you "
        "always have the option to route that one piece back to legacy "
        "if something's wrong.\n\n"
        "🧠 Why prefer the Strangler Fig approach over a full rewrite?",
    calloutHints: [
      "⚠️ Pro nuance: this usually requires a routing layer (proxy, "
          "feature flag, or facade) sitting in front of both systems, "
          "deciding per-request which one handles it — building that "
          "layer well is itself a real piece of engineering, not an "
          "afterthought.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why do professional teams generally prefer the Strangler "
          "Fig pattern over a full 'big bang' rewrite?",
      options: [
        'Big bang rewrites are always technically impossible',
        'Migrating piece by piece limits the blast radius of any '
            'single mistake and keeps a safe rollback path at each '
            'step, unlike an all-at-once cutover',
        'The Strangler Fig pattern is faster in every single case',
        'It requires no new code to be written at all',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — incremental migration limits risk per step and "
          "preserves a rollback path, which a single giant cutover "
          "cannot offer.",
      explainBad:
          "The key benefit is RISK CONTAINMENT — migrating one piece at "
          "a time limits how much can go wrong at once, and preserves a "
          "rollback path.",
    ),
  ),
  const Chapter(
    id: 47,
    title: 'Legacy Migration Strategy',
    avatar: '🗺️',
    role: 'Narrator — planning the long road',
    bodyIntro:
        "🗺️ A full legacy migration is a multi-month (sometimes "
        "multi-year) program, not a sprint task. The professional "
        "sequence typically looks like:\n\n"
        "1. Audit    — understand what the legacy system actually "
        "does, including undocumented behavior\n"
        "2. Shim     — build an adapter layer so new and old can "
        "coexist during transition\n"
        "3. Migrate  — move one slice of functionality at a time "
        "(Strangler Fig)\n"
        "4. Verify   — confirm the new slice produces IDENTICAL "
        "behavior to the old one\n"
        "5. Decommission — only remove legacy once nothing depends on "
        "it anymore\n\n"
        "The AUDIT step is often the most underestimated: legacy "
        "systems frequently have undocumented behavior that other "
        "systems secretly depend on (\"bug-compatible\" behavior). "
        "Skipping this step is how migrations silently break things "
        "that \"shouldn't\" have been affected.\n\n"
        "🔢 Order the legacy migration steps.",
    calloutHints: [
      "🕵️ Pro insight: 'verify identical behavior' often means running "
          "old and new systems in PARALLEL on real traffic and diffing "
          "their outputs — not just trusting that the new code 'looks "
          "correct' on inspection.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these steps in the order a professional legacy "
          "migration typically follows.",
      items: [
        OrderItem(
          'audit',
          "Audit the legacy system's real, including undocumented, "
              "behavior",
        ),
        OrderItem(
          'shim',
          'Build a shim/adapter layer so old and new can coexist',
        ),
        OrderItem('migrate', 'Migrate one slice of functionality at a time'),
        OrderItem(
          'verify',
          'Verify the new slice matches old behavior, ideally on real '
              'traffic',
        ),
        OrderItem(
          'decommission',
          'Decommission the legacy system once nothing depends on it',
        ),
      ],
      explainOk:
          "That's the professional sequence — you can't safely migrate "
          "what you haven't audited, and you never decommission before "
          "verifying.",
      explainBad:
          "Audit always comes first (know what you're replacing); "
          "decommissioning always comes last (only after verified "
          "migration).",
    ),
  ),
  const Chapter(
    id: 48,
    title: 'Migration Risk Management',
    avatar: '🛟',
    role: 'Narrator — keeping a lifeline ready',
    bodyIntro:
        "🛟 Even a well-planned migration carries real risk. "
        "Professional teams manage that risk deliberately, not by "
        "hoping nothing goes wrong:\n\n"
        "🔀 Run in parallel — old and new systems both process real "
        "traffic; compare outputs before fully cutting over\n\n"
        "🎯 Migrate lowest-risk slices first — build confidence and "
        "find surprises on low-stakes functionality before touching "
        "critical paths\n\n"
        "↩️ Always have a tested rollback path — \"we can always just "
        "cut back to legacy\" is only true if you've actually rehearsed "
        "it\n\n"
        "🚫 Don't let the migration itself become new debt — shims and "
        "adapters that outlive their purpose are exactly the kind of "
        "shortcut that compounds\n\n"
        "🧠 What's the risk of an untested rollback path?",
    calloutHints: [
      "⚠️ Pro failure mode: teams often skip rehearsing rollback because "
          "'we probably won't need it' — then discover during a real "
          "incident that the rollback path was never actually tested "
          "and doesn't work cleanly.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why is 'we can always roll back to legacy if something goes "
          "wrong' a dangerous assumption if the rollback has never "
          "actually been rehearsed?",
      options: [
        'It is not dangerous — rollback paths always work by definition',
        'An untested rollback path may not actually work cleanly when '
            'you need it most, precisely during a real incident under '
            'pressure',
        'Rollback is only a concept for database migrations, not '
            'application migrations',
        'Testing rollback paths is unnecessary busywork',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — an unrehearsed rollback is a false sense of "
          "security; the worst time to discover it's broken is during a "
          "real incident.",
      explainBad:
          "The risk is discovering, mid-incident, that the 'safety net' "
          "was never actually tested and doesn't work — rehearsal is "
          "what makes rollback real.",
    ),
  ),
  const Chapter(
    id: 49,
    title: 'Code Review Culture',
    avatar: '🏛️',
    role: 'Narrator — the norms behind the process',
    bodyIntro:
        "🏛️ You practiced the mechanics of deep code review in Level 9. "
        "At the organizational level, review CULTURE matters just as "
        "much as review checklist items.\n\n"
        "🚫 Toxic culture: \"this is obviously wrong,\" nitpicks that "
        "block merges over trivial preferences, reviews that feel like "
        "gatekeeping rather than collaboration. This culture quietly "
        "trains people to avoid ambitious changes and to dread "
        "submitting PRs at all.\n\n"
        "✅ Healthy culture: \"consider X because Y,\" reviewers who "
        "distinguish \"this must change\" from \"just a suggestion,\" and "
        "reviews that actively teach rather than just gate. Healthy "
        "review culture correlates strongly with how much a team is "
        "willing to attempt ambitious refactors and architectural "
        "changes.\n\n"
        "🎯 Sort each review comment by culture type.",
    calloutHints: [
      "⚠️ Pro leadership signal: review culture is set from the TOP — "
          "if senior engineers model harsh, gatekeeping reviews, junior "
          "engineers learn to do the same, and it compounds across the "
          "whole org.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each comment into the culture it reflects.",
      bucketALabel: '🚫 Toxic',
      bucketBLabel: '✅ Healthy',
      items: [
        Sort2Item(
          'obvious',
          '"This is obviously wrong, did you even test it?"',
          true,
        ),
        Sort2Item(
          'consider',
          '"Consider extracting this into its own function — it will '
              'be easier to test in isolation."',
          false,
        ),
        Sort2Item(
          'nitblock',
          'Blocking a merge for hours over a trivial spacing preference '
              'the linter should catch',
          true,
        ),
        Sort2Item(
          'distinguish',
          '"Nit: could rename this, but not blocking — your call."',
          false,
        ),
      ],
      explainOk:
          "Exactly — healthy review distinguishes real issues from "
          "suggestions and stays focused on the code, not the person.",
      explainBad:
          "Look for tone and focus: attacking the person or blocking on "
          "trivia is toxic; specific, respectful, clearly-prioritized "
          "feedback is healthy.",
    ),
  ),
  const Chapter(
    id: 50,
    title: 'Security-Focused Review',
    avatar: '🔐',
    role: "Narrator — reviewing with an attacker's eyes",
    bodyIntro:
        "🔐 A security-focused review asks a different set of questions "
        "than a normal correctness review — it thinks like an "
        "attacker, not just a user:\n\n"
        "🚪 Input validation — is user input validated/sanitized BEFORE "
        "it's trusted, especially before it reaches a database query or "
        "shell command?\n\n"
        "🤫 Secrets hygiene — are credentials kept out of code, logs, "
        "and error messages entirely?\n\n"
        "🪪 AuthZ vs AuthN — is the system checking not just \"who is "
        "this user\" (authentication) but \"is THIS user allowed to do "
        "THIS specific action\" (authorization)? A shockingly common "
        "bug class is checking the first and forgetting the second.\n\n"
        "🌐 Attack surface — does this change expose a new endpoint, "
        "permission, or capability that widens what an attacker could "
        "try?\n\n"
        "🧠 Spot the missing security check.",
    calloutHints: [
      "⚠️ Pro distinction: authentication answers 'who are you?' "
          "Authorization answers 'are you allowed to do THIS?' A "
          "logged-in user (authenticated) trying to access someone "
          "else's private data (unauthorized) is exactly the bug class "
          "that AuthZ checks exist to catch.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "function getInvoice(req) {\n"
          "    const user = authenticate(req);   // confirms WHO the "
          "user is\n"
          "    return db.getInvoice(req.params.invoiceId);  // fetches "
          "ANY invoice ID\n"
          "}\n\n"
          "What security check is missing here?",
      options: [
        'Nothing is missing — authentication alone is enough',
        'Authorization: nothing checks that THIS authenticated user '
            'actually owns or is allowed to view THIS specific invoice '
            'ID',
        'The function needs a faster database query',
        'It needs more logging, that is the only issue',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — this is a classic authorization bug: authenticated "
          "but unauthorized access, since any logged-in user could "
          "fetch any invoice by guessing IDs.",
      explainBad:
          "Authentication confirms WHO the user is; it says nothing "
          "about whether they're ALLOWED to see this specific invoice. "
          "That authorization check is what's missing.",
    ),
  ),
  const Chapter(
    id: 51,
    title: 'Static Analysis at Scale',
    avatar: '🔬',
    role: 'Narrator — a robot reading code without running it',
    bodyIntro:
        "🔬 Static analysis examines source code WITHOUT running it, "
        "looking for patterns known to cause bugs or vulnerabilities — "
        "unused variables, possible null dereferences, SQL injection "
        "patterns, insecure crypto usage.\n\n"
        "commit → static analyzer scans code → flags risky pattern → "
        "blocks merge until fixed\n\n"
        "At scale, static analysis becomes a mandatory CI gate, not an "
        "optional suggestion — because relying on every individual "
        "reviewer to spot every risky pattern by eye, across hundreds "
        "of PRs a day, simply doesn't scale. The analyzer catches the "
        "same category of mistake with perfect consistency, every "
        "single time.\n\n"
        "🧠 Why make static analysis a mandatory CI gate instead of a "
        "manual suggestion?",
    calloutHints: [
      "⚠️ Pro tradeoff: static analyzers produce false positives. Too "
          "many, and engineers start reflexively suppressing warnings "
          "instead of reading them — which defeats the whole point. "
          "Tuning the ruleset to a low false-positive rate is real, "
          "ongoing engineering work.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why do mature engineering orgs make static analysis a "
          "mandatory CI gate rather than an optional tool reviewers can "
          "choose to run?",
      options: [
        'Manual review by humans is always more consistent than '
            'automated tools',
        'Consistency at scale — an automated gate catches the same '
            'category of risky pattern every time, across every PR, '
            'without depending on individual reviewer attention',
        'Static analysis tools are required by international law',
        'It removes the need for any human code review at all',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the value is guaranteed, consistent coverage "
          "across every single PR, which no amount of individual "
          "reviewer diligence can match at scale.",
      explainBad:
          "The core reason is CONSISTENCY AT SCALE: an automated gate "
          "never gets tired or distracted, unlike relying on hundreds "
          "of individual manual reviews.",
    ),
  ),
  const Chapter(
    id: 52,
    title: 'Linting & Enforcement at Scale',
    avatar: '📏',
    role: 'Narrator — one ruler for the whole workshop',
    bodyIntro:
        "📏 A shared lint configuration, enforced in CI across every "
        "repo in an org, isn't about picking the objectively \"best\" "
        "style — it's about eliminating an entire category of "
        "bikeshedding and making every codebase feel familiar to "
        "anyone who moves between teams.\n\n"
        "one shared lint config → enforced in CI for every repo\n"
        "→ no PR merges with lint violations, no exceptions\n"
        "→ style debates happen ONCE, in the config, not per-PR forever\n\n"
        "The professional insight: consistency across the WHOLE "
        "organization beats any one engineer's individually \"better\" "
        "preference, because the cost of inconsistency (context-"
        "switching friction, onboarding confusion) compounds across "
        "every engineer who touches multiple codebases.\n\n"
        "🧠 What's the real organizational argument for one shared lint "
        "config?",
    calloutHints: [
      "⚠️ Pro nuance: lint rules should mostly be auto-fixable "
          "(formatters) rather than requiring manual fixes — a rule "
          "that just complains without offering an automatic fix "
          "creates friction without proportional benefit.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the real organizational argument for enforcing ONE "
          "shared lint config across every repo, instead of letting "
          "each team pick its own style?",
      options: [
        'One particular style is objectively, mathematically correct',
        'Consistency across the whole org reduces context-switching '
            'friction and onboarding confusion, which compounds in cost '
            'as engineers move between codebases',
        'It makes the compiler run faster',
        'It is required to write any tests',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the argument is about organizational friction and "
          "consistency, not about any one style being objectively "
          "superior.",
      explainBad:
          "It's not about picking the 'best' style — it's about "
          "eliminating friction and confusion when engineers move "
          "between differently-styled codebases.",
    ),
  ),
  const Chapter(
    id: 53,
    title: 'Architecture Decision Records',
    avatar: '📜',
    role: 'Narrator — writing down WHY, not just WHAT',
    bodyIntro:
        "📜 Six months from now, someone will ask \"why on earth did we "
        "choose Postgres over MongoDB for this service?\" — and nobody "
        "will remember unless it was written down. An Architecture "
        "Decision Record (ADR) is a short, permanent document capturing "
        "exactly that.\n\n"
        "ADR-014: Choose Postgres for the orders service\n\n"
        "Context:      why we needed to decide now, and what "
        "constraints applied\n"
        "Options:      Postgres, MongoDB, DynamoDB — considered and "
        "compared\n"
        "Decision:     Postgres, chosen because of X, Y, Z\n"
        "Consequences: tradeoffs we accepted knowingly (e.g. less "
        "flexible schema)\n\n"
        "The critical section is CONSEQUENCES — an honest ADR names "
        "the downsides accepted, not just the upsides chosen. This is "
        "what makes ADRs useful later: when a consequence becomes "
        "painful, the team can see it was a KNOWN tradeoff, not a "
        "surprise oversight, and can revisit the decision deliberately.\n\n"
        "🧠 Why is the \"Consequences\" section the most important part "
        "of an ADR?",
    calloutHints: [
      "⚠️ Pro discipline: ADRs are immutable historical records, not "
          "living documents you edit — if a decision changes, you write "
          "a NEW ADR that supersedes the old one, preserving the full "
          "history of reasoning over time.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why is the 'Consequences' section often considered the most "
          "valuable part of an ADR?",
      options: [
        "It is the shortest section, so it's quick to write",
        'It honestly names the tradeoffs accepted, so a later painful '
            'downside is recognized as a known tradeoff, not a '
            'surprise, letting the team revisit deliberately',
        'It lists which engineer is to blame if things go wrong',
        'It is purely decorative and rarely read',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — naming accepted downsides upfront turns future "
          "pain into an expected, revisitable tradeoff instead of a "
          "confusing surprise.",
      explainBad:
          "The value is honesty about tradeoffs: naming what you're "
          "accepting upfront means future pain is recognized as a "
          "KNOWN cost, not a shocking oversight.",
    ),
  ),
  const Chapter(
    id: 54,
    title: 'Evaluating Frameworks: Real Tradeoffs',
    avatar: '⚖️',
    role: 'Narrator — weighing two very different tools',
    bodyIntro:
        "⚖️ Choosing a framework is rarely \"which one is objectively "
        "best\" — it's \"which set of tradeoffs fits OUR context.\" A "
        "popular, mainstream framework and a newer, better-fit-on-paper "
        "framework pull in genuinely different directions:\n\n"
        "🌍 Popular framework — huge ecosystem, easy hiring, tons of "
        "Stack Overflow answers — but might not match your actual "
        "technical needs well\n\n"
        "🎯 Right-fit framework — matches your actual requirements more "
        "precisely — but a smaller community means you're more on your "
        "own when something breaks, and hiring/onboarding is harder\n\n"
        "A senior-level evaluation makes this tradeoff EXPLICIT and "
        "documented (often as an ADR) rather than pretending one option "
        "is a free lunch with no downside.\n\n"
        "🧠 What's the mature way to choose between a popular framework "
        "and a better-fit niche one?",
    calloutHints: [
      "⚠️ Pro trap: 'everyone uses X' is a real, legitimate factor "
          "(hiring, community support, long-term maintenance risk) — "
          "it's not automatically wrong to weigh popularity heavily. "
          "The mistake is treating it as the ONLY factor, or as an "
          "unstated assumption nobody examined.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the professionally mature way to decide between a "
          "popular mainstream framework and a smaller framework that "
          "fits your needs more precisely?",
      options: [
        'Always pick the most popular one automatically, no analysis '
            'needed',
        'Explicitly weigh and document the real tradeoffs — ecosystem '
            'size, hiring, and long-term risk vs actual technical fit — '
            'rather than assuming either option is free of downsides',
        'Always pick the newest one to seem innovative',
        'Flip a coin, since all frameworks are equivalent',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — an explicit, documented weighing of real tradeoffs "
          "beats defaulting to either 'always popular' or 'always "
          "novel.'",
      explainBad:
          "There's no universal right answer here — the mature "
          "approach is EXPLICITLY weighing and documenting the real "
          "tradeoffs for your specific context.",
    ),
  ),
  const Chapter(
    id: 55,
    title: 'Build vs Buy',
    avatar: '🛠️',
    role: 'Narrator — a very old, very real question',
    bodyIntro:
        "🛠️ Should you build your own authentication system, or "
        "buy/use an existing one (Auth0, Okta, an open-source library)? "
        "This is the classic build vs buy decision, and it recurs "
        "constantly across a career: payments, search, analytics, "
        "notifications — the pattern repeats everywhere.\n\n"
        "🔨 Build — full control, no vendor lock-in, but real ongoing "
        "cost: engineering time, maintenance burden, and the risk of "
        "getting a genuinely hard problem (like security-critical auth) "
        "subtly wrong\n\n"
        "🛒 Buy — faster to ship, leverages a vendor's specialized "
        "expertise, but less control, real ongoing cost (fees), and "
        "dependency risk if the vendor changes pricing, gets acquired, "
        "or shuts down\n\n"
        "A useful professional heuristic: build the things that are "
        "your actual competitive differentiator; buy the commodity "
        "infrastructure that every company needs but isn't what makes "
        "YOUR product special.\n\n"
        "🧠 What's a useful heuristic for deciding what to build vs "
        "buy?",
    calloutHints: [
      "⚠️ Pro nuance: 'buy' still has real engineering cost — "
          "integration work, handling vendor outages gracefully, and "
          "migration risk if you ever need to switch vendors later. "
          "'Buy' is not 'zero engineering effort,' it's 'different "
          "engineering effort.'",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's a useful professional heuristic for deciding what to "
          "build in-house versus buy/use an existing solution for?",
      options: [
        'Always build everything in-house for maximum control',
        'Build the things that are your actual competitive '
            'differentiator; buy the commodity infrastructure that is '
            'not what makes your product special',
        'Always buy everything to minimize all engineering work',
        'Flip a coin — build vs buy is unpredictable and not worth '
            'analyzing',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — focus engineering effort on what actually "
          "differentiates your product, and buy the commodity pieces "
          "everyone needs.",
      explainBad:
          "The useful heuristic is differentiation: build what makes "
          "YOUR product special, buy the commodity infrastructure that "
          "doesn't.",
    ),
  ),
  const Chapter(
    id: 56,
    title: 'The Tech Radar Mindset',
    avatar: '🎯',
    role: 'Narrator — four rings, one honest map',
    bodyIntro:
        "🎯 A tech radar is a structured way orgs track which "
        "technologies to embrace, and which to avoid — organized into "
        "four rings:\n\n"
        "✅ ADOPT — proven, safe to use widely, default choice\n\n"
        "🧪 TRIAL — promising, worth using on a real (but lower-risk) "
        "project to build confidence\n\n"
        "🔍 ASSESS — interesting, worth exploring, but not yet ready to "
        "bet real projects on\n\n"
        "🛑 HOLD — avoid for new work; often things being actively "
        "phased out, or that turned out to have hidden problems\n\n"
        "The mindset matters more than the specific tool "
        "categorization: continuously and HONESTLY evaluate your "
        "technology choices, rather than either rigidly sticking with "
        "what's familiar forever, or chasing every new trend without "
        "real evidence.\n\n"
        "🧠 What's the real value of maintaining a tech radar?",
    calloutHints: [
      "⚠️ Pro discipline: a tech radar is worthless if it's "
          "aspirational instead of honest — putting something in ADOPT "
          "because leadership likes it, rather than because it's "
          "actually proven in your context, defeats the entire purpose "
          "of the exercise.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the real value of an organization maintaining a tech "
          "radar?",
      options: [
        'It guarantees the org always uses the newest technology '
            'available',
        'It forces continuous, honest evaluation of technology '
            'choices, avoiding both rigid stagnation and uncritical '
            'trend-chasing',
        'It replaces the need for any architecture decisions at all',
        'It is purely a marketing document for recruiting',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the value is the disciplined habit of honest, "
          "ongoing evaluation, not any single ring's specific contents.",
      explainBad:
          "The real value is the ONGOING HONEST EVALUATION habit itself "
          "— avoiding both 'never change' and 'chase every trend' "
          "extremes.",
    ),
  ),
  const Chapter(
    id: 57,
    title: 'Blameless Postmortem Culture',
    avatar: '🕯️',
    role: 'Narrator — the principal-engineer gauntlet begins',
    bodyIntro:
        "🕯️ 🏆 Final level — the principal-engineer gauntlet. After a "
        "production incident, mature engineering orgs run a blameless "
        "postmortem: a structured write-up of what happened, WHY, and "
        "what changes will prevent recurrence — deliberately without "
        "assigning personal blame.\n\n"
        "incident timeline → root cause analysis → concrete action "
        "items → blameless review\n\n"
        "The professional insight: blame suppresses honest information. "
        "If an engineer fears punishment for admitting \"I didn't "
        "realize that config would affect production,\" they'll hide "
        "that detail — and the SAME root cause will bite the team again "
        "later, undetected. Blameless culture optimizes for surfacing "
        "the truth, which is what actually prevents repeat incidents.\n\n"
        "🧠 Why does blameless culture actually prevent MORE incidents, "
        "not fewer consequences?",
    calloutHints: [
      "⚠️ Pro distinction: 'blameless' does NOT mean 'no "
          "accountability.' It means the goal is fixing the SYSTEM that "
          "allowed the mistake (missing safeguard, unclear alert, "
          "absent review step) rather than punishing the individual who "
          "happened to trigger it.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why does a blameless postmortem culture actually reduce "
          "future incidents, rather than just being 'nicer' to "
          "engineers?",
      options: [
        "It doesn't reduce incidents — it's purely a morale exercise",
        'Removing fear of blame encourages honest disclosure of exactly '
            'what happened, surfacing the true root cause so the '
            'underlying system flaw can actually be fixed',
        'It guarantees incidents never happen again automatically',
        'Blameless simply means nobody has to write anything down',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — honesty enabled by removing blame is what surfaces "
          "the real, fixable root cause, which is what actually "
          "prevents recurrence.",
      explainBad:
          "The mechanism is honesty: without fear of blame, people "
          "disclose the true root cause, which is the only thing that "
          "lets you actually fix the underlying system flaw.",
    ),
  ),
  const Chapter(
    id: 58,
    title: 'Engineering Velocity vs Quality',
    avatar: '⚖️',
    role: 'Narrator — the eternal balancing act',
    bodyIntro:
        "⚖️ Ship faster, or ship more carefully? This tension never "
        "fully resolves — it's a constant balancing act, not a problem "
        "with a permanent fix. Senior engineering judgment is about "
        "calibrating the RIGHT balance for the CURRENT context, not "
        "maximizing one axis forever.\n\n"
        "🚀 Lean toward velocity when: validating a risky new idea with "
        "real users, low-stakes internal tooling, reversible changes\n\n"
        "🛡️ Lean toward quality when: payments, security-critical "
        "paths, anything hard to reverse once shipped, systems at "
        "massive scale where a small bug affects millions\n\n"
        "The mature framing isn't \"which is better\" — it's \"given "
        "THIS specific decision's reversibility and blast radius, which "
        "end of the dial makes sense right now?\" The same team should "
        "make different calls for a marketing landing page vs a "
        "billing system.\n\n"
        "🧠 What should actually drive where you land on the "
        "velocity-quality dial for a given decision?",
    calloutHints: [
      "⚠️ Pro trap: treating velocity-vs-quality as a fixed "
          "organizational personality ('we're a move-fast company') "
          "instead of a per-decision judgment call is how orgs end up "
          "either shipping careless payment bugs, or moving too slowly "
          "on genuinely low-risk experiments.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What should primarily determine how a team balances "
          "velocity vs quality for a SPECIFIC decision?",
      options: [
        'A fixed company-wide policy that applies identically to every '
            'decision, forever',
        "That decision's reversibility and blast radius — low-stakes, "
            'reversible work can lean toward velocity; high-stakes, '
            'hard-to-reverse work should lean toward quality',
        'Whichever the most senior person in the room personally '
            'prefers, unrelated to the decision',
        'Always maximize velocity, regardless of context, since speed '
            'is always correct',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — reversibility and blast radius are the right "
          "per-decision inputs, not a fixed company-wide slogan.",
      explainBad:
          "The right driver is per-decision: how reversible is this, "
          "and how big is the blast radius if it's wrong? That should "
          "set the dial, not a blanket policy.",
    ),
  ),
  const Chapter(
    id: 59,
    title: 'Capstone — The Midnight Rollback',
    avatar: '🌙',
    role: 'Narrator — a synthesis scenario, live at 2am',
    bodyIntro:
        "🌙 It's 2am. A deploy just went out. Alerts start firing: "
        "error rates climbing, latency spiking. This scenario "
        "synthesizes nearly everything you've learned in this subject "
        "— let's walk it, decision by decision, the way a principal "
        "engineer actually would.\n\n"
        "1. Alerts fire → is this bad enough to page someone right now? "
        "(blast radius check)\n"
        "2. Check: was this behind a feature flag? → if yes, flip it "
        "OFF first (fastest, safest mitigation)\n"
        "3. No flag available? → trigger the deployment's rollback "
        "path (hopefully tested — Level 12!)\n"
        "4. Once stable → write the blameless postmortem (Level 15, "
        "Ch 57): timeline, root cause, action items\n"
        "5. Action items feed back into: better CI checks, a missing "
        "feature flag, or an ADR update\n\n"
        "Notice the ORDER: the fastest, least risky mitigation (flag "
        "flip) is tried before the slower, riskier one (full rollback) "
        "— because acting fast with an already-tested lever beats "
        "scrambling to invent a new fix live, under pressure, at 2am.\n\n"
        "🔢 Put this incident response in the right order.",
    calloutHints: [
      "🎯 The synthesis: feature flags (L10) exist partly so THIS "
          "exact moment has a fast, safe lever. Tested rollback paths "
          "(L12) exist so the fallback actually works. Blameless "
          "postmortems (L15) exist so this doesn't happen the same way "
          "twice.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these incident-response steps in the order a "
          "well-prepared team would actually take them.",
      items: [
        OrderItem('assess', 'Assess severity and blast radius from the alerts'),
        OrderItem(
          'flagoff',
          'If behind a feature flag, flip it off first — fastest safe '
              'mitigation',
        ),
        OrderItem(
          'rollback',
          'If no flag exists, trigger the tested deployment rollback',
        ),
        OrderItem(
          'postmortem',
          'Once stable, write a blameless postmortem with action items',
        ),
      ],
      explainOk:
          "Exactly right — assess first, reach for the fastest safe "
          "lever (flag) before the slower one (full rollback), and "
          "always close the loop with a blameless postmortem.",
      explainBad:
          "Always try the fastest, already-tested mitigation (flag "
          "off) before a full rollback, and the postmortem only "
          "happens AFTER things are stable again.",
    ),
  ),
  const Chapter(
    id: 60,
    title: "The Principal Engineer's Final Gauntlet",
    avatar: '🏆',
    role: 'Narrator — the last test in Craft Cove',
    bodyIntro:
        "🏆 We've rolled a long way together, from \"what is a bug\" to "
        "production incident response. This final capstone asks you to "
        "reason across the WHOLE subject at once — the kind of "
        "synthesis a principal engineer does by instinct.\n\nConsider a "
        "real scenario: your team wants to migrate a critical legacy "
        "billing system to a new architecture, while continuing to ship "
        "features, without a single night of downtime, and without the "
        "team's velocity collapsing under the weight of the migration.\n\n"
        "The synthesis draws from nearly everything in this subject:\n\n"
        "🌱 Strangler Fig (L12) to migrate incrementally, not all at "
        "once\n\n"
        "🚩 Feature flags + trunk-based dev (L10) to keep shipping "
        "continuously during the migration, without long-lived "
        "branches\n\n"
        "🐤 Canary releases (L11) to validate each migrated slice on "
        "real traffic before fully committing to it\n\n"
        "📜 ADRs (L14) to record WHY each major migration decision was "
        "made, for the team six months from now\n\n"
        "🕯️ Blameless postmortems (L15) for anything that goes wrong "
        "along the way, so mistakes teach instead of just hurt\n\n"
        "🧠 Final check: which combination best fits this exact "
        "scenario?",
    calloutHints: [
      "🎓 This is the real shape of senior engineering judgment: not "
          "knowing one trick perfectly, but knowing WHICH combination "
          "of tools fits a specific, high-stakes, real-world situation "
          "— and being able to explain why to the rest of the team.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "For migrating a critical legacy billing system with zero "
          "downtime, continued feature delivery, and controlled risk, "
          "which combination of practices best fits?",
      options: [
        'A single big-bang rewrite deployed all at once over a '
            'weekend, with feature branches frozen for months',
        'Strangler Fig migration with feature flags and trunk-based '
            'development to keep shipping, canary releases to validate '
            'each migrated slice, ADRs to record decisions, and '
            'blameless postmortems for anything that goes wrong',
        'Skip testing entirely to move as fast as possible, and '
            'document nothing to save time',
        'Wait until there is a perfectly quiet week with zero other '
            'feature work, then rewrite everything by hand with no '
            'rollback plan',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — this combination lets the team migrate "
          "incrementally and safely, keep shipping continuously, "
          "validate each step on real traffic, and learn from anything "
          "that goes wrong. That's the whole subject, working together.",
      explainBad:
          "A big-bang rewrite, skipped testing, or waiting for a "
          "mythical 'quiet week' all reintroduce the exact risks this "
          "whole subject taught you to avoid. The synthesis is: "
          "incremental migration + flags/trunk-based dev + canaries + "
          "ADRs + blameless postmortems.",
    ),
  ),
];
