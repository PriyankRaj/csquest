import '../models/pq_models.dart';

/// Ported from process-quest/subjects/dbms.js — real content, all 60
/// chapters (Levels 1-15), narrative bodies flattened from HTML, callouts
/// pulled into calloutHints, puzzles mapped 1:1 onto the Flutter puzzle
/// model (mcq/order/sort2/match).
final dbmsChapters = <Chapter>[
  const Chapter(
    id: 1,
    title: "The Toy & Fruit Shelf",
    avatar: "🗂️",
    role: "Narrator — rolling into Database Bay",
    bodyIntro:
        "Welcome to Database Bay! Let's play shopkeeper. Here's my shelf right now: "
        "Apple → 5, Orange → 3, Cap → 2.\n\n"
        "That little list is already a tiny database — a place where information is "
        "stored neatly so it's easy to find. In database language, my whole shelf is "
        "a table called Shelf:\n\n"
        "🍎 Each row is ONE kind of item on the shelf — \"Apple, 5\" is one whole row.\n\n"
        "📊 Each column is ONE piece of info about every item — like item (the name) "
        "or count (how many).\n\n"
        "So the Shelf table has 3 rows (Apple, Orange, Cap) and 2 columns (item, "
        "count) — just like a shopping spreadsheet!",
    calloutHints: [
      "🧮 Kid tip: a database is just a REALLY well-organized set of lists — like "
          "your shelf, but able to hold millions of rows without ever getting messy.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a word on the left, then click the definition on the right that "
          "matches it.",
      pairs: [
        MatchPair('database', '🗄️ Database', 'The whole organized shelf of information'),
        MatchPair('table', '📋 Table', 'One list about one kind of thing, like Shelf'),
        MatchPair('row', '➡️ Row', "ONE item's whole entry, like 'Apple, 5'"),
        MatchPair('column', '⬇️ Column', 'ONE piece of info about every item, like count'),
      ],
      explainOk:
          "All matched! You've got the shelf vocabulary down: database → table → "
          "row → column, biggest to smallest. 🎉",
    ),
  ),
  const Chapter(
    id: 2,
    title: "Every Item Needs a Tag",
    avatar: "🏷️",
    role: "Narrator — handing out ID tags",
    bodyIntro:
        "My shelf is growing! Now I have TWO apple entries because a new apple crate "
        "arrived. Confusing — which \"Apple\" row do I mean?\n\n"
        "Databases fix this with a primary key — a special ID number that is "
        "different for every single row, like a price tag with a one-of-a-kind "
        "barcode: item_id 1 = Apple (5), item_id 2 = Orange (3), item_id 3 = Cap (2).\n\n"
        "Now every row has its own tag: item_id. No two rows ever share the same "
        "primary key!\n\n"
        "Primary keys get super useful when tables need to talk to each other. Say a "
        "kid named Mia buys 2 apples. I write that in a NEW table called Purchases — "
        "and instead of writing \"Apple\" again, it just keeps a copy of the apple's "
        "item_id (1). That copied ID is called a foreign key — a little pointer back "
        "to the Shelf table.",
    calloutHints: [
      "🏷️ Primary key = \"this row's own ID tag.\" 🔗 Foreign key = \"a sticky note "
          "pointing at someone else's ID tag.\"",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each description into the bucket for the right kind of key.",
      bucketALabel: '🏷️ Primary Key',
      bucketBLabel: '🔗 Foreign Key',
      items: [
        Sort2Item('own', "The Shelf table's own item_id for the apple row", true),
        Sort2Item('points', "The Purchases table's copy of that same item_id", false),
        Sort2Item('neverRepeat', "Every row's ID number, never repeated", true),
      ],
      explainOk:
          "Exactly right! Primary key = my own ID. Foreign key = pointing at "
          "someone else's ID.",
      explainBad:
          "Close! Remember: PRIMARY key is a row's own unique ID. FOREIGN key is a "
          "copy of another table's ID, used to link tables together.",
    ),
  ),
  const Chapter(
    id: 3,
    title: "Asking the Shelf a Question",
    avatar: "❓",
    role: "Narrator — learning to ask nicely",
    bodyIntro:
        "Databases love questions — but you have to ask in their special language, "
        "called SQL (say it like \"sequel\"). Don't worry, it reads almost like "
        "English! Here's my shelf again: Apple (5), Orange (3), Cap (2).\n\n"
        "To ask \"show me every item on the shelf,\" you'd write: SELECT item FROM "
        "Shelf;\n\n"
        "SELECT means \"show me,\" and FROM Shelf means \"look on the Shelf table.\" "
        "If you only want some rows, add WHERE — like a filter: SELECT item FROM "
        "Shelf WHERE count > 2;\n\n"
        "That means: \"show me every item where there are MORE than 2 in stock.\" "
        "That would answer with Apple and Orange — but NOT Cap, since there are "
        "only 2 caps!",
    calloutHints: [
      "🗣️ Reading SQL out loud usually just works: \"SELECT [what you want] FROM "
          "[which table] WHERE [only rows matching this rule].\"",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click an SQL keyword on the left, then click what it means on the right.",
      pairs: [
        MatchPair('select', 'SELECT', 'Show me...'),
        MatchPair('from', 'FROM', '...look on this shelf/table...'),
        MatchPair('where', 'WHERE', '...only rows matching this rule'),
      ],
      explainOk:
          "Perfect — SELECT item FROM Shelf WHERE count > 2 says exactly that, in "
          "database language! 🎉",
    ),
  ),
  const Chapter(
    id: 4,
    title: "Joining Two Tables Together",
    avatar: "🔗",
    role: "Narrator — connecting the dots",
    bodyIntro:
        "Here's the coolest trick in Database Bay: JOIN. It lets you combine two "
        "related tables into one answer.\n\n"
        "Say we want to know: \"What did Mia buy?\" Mia's purchase lives in the "
        "Purchases table, but it only stores an item_id number, not the item's name "
        "or emoji! The actual item info (Apple, its name, its count) lives in the "
        "Shelf table.\n\n"
        "A JOIN uses the foreign key (from Chapter II) to connect them, so you can "
        "ask one big question across both tables at once — and get back \"Mia bought "
        "Apple,\" not just \"Mia bought item #1.\"",
    calloutHints: [
      "🧵 Think of JOIN like tying a string between two tables: pull on Mia's row "
          "in Purchases, and the string is already tied to the matching Apple row on "
          "the Shelf.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps the database follows to answer \"What did Mia buy?\" using a JOIN.",
      items: [
        OrderItem('s1', "🔍 Find Mia's row in the Purchases table"),
        OrderItem('s2', '🔢 Read the item_id stored in that row (the foreign key)'),
        OrderItem('s3', '🗄️ Look through the Shelf table for the row with that same item_id'),
        OrderItem('s4', "🍎 Return that Shelf row's item name as the answer"),
      ],
      explainOk:
          "That's it! You just traced exactly how a JOIN links two tables using a "
          "shared ID. Database Bay complete! 🎉",
      explainBad:
          "Think about it step by step: first find Mia's purchase, then get its "
          "item_id, then go hunt for that id on the Shelf, then return the matching "
          "item.",
    ),
  ),
  const Chapter(
    id: 5,
    title: "When One Shelf Isn't Enough",
    avatar: "📦",
    role: "Narrator — spotting messy duplicate data",
    bodyIntro:
        "Database Bay is growing fast, and I made a rookie mistake. I tried to save "
        "time by stuffing the supplier's name AND phone number into every single row "
        "of my Shelf table — FreshFarms and 555-0101 typed for both Apple and Orange, "
        "and ToyWorks/555-0202 for Cap.\n\n"
        "See the problem? FreshFarms and its phone number are typed out TWICE. If "
        "FreshFarms changes their phone number, I have to remember to update EVERY "
        "row that mentions them — and if I miss one, my shelf now has two different "
        "\"true\" phone numbers for the same supplier. That's called a redundancy "
        "problem.\n\n"
        "This whole level is about normalization — a set of rules for organizing "
        "tables so every fact lives in exactly ONE place.",
    calloutHints: [
      "🧠 Big idea: whenever you're typing the same fact more than once, a database "
          "designer's brain should light up and ask \"should this live somewhere "
          "else?\"",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the biggest risk of storing supplier_phone in every single Shelf "
          "row instead of just once?",
      options: [
        'The table would use slightly more storage space',
        'Updating the phone number in only SOME rows leaves the table with conflicting answers for the same supplier',
        "SQL doesn't allow repeated text values in a column",
        'The Shelf table would stop working entirely',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the real danger is inconsistency: two rows quietly disagreeing "
          "about one supplier's real phone number.",
      explainBad:
          "Think about what happens the day FreshFarms changes their number and "
          "you only update one of the two rows — the table now tells two different "
          "'true' stories.",
    ),
  ),
  const Chapter(
    id: 6,
    title: "First Normal Form (1NF)",
    avatar: "🧹",
    role: "Narrator — tidying up messy cells",
    bodyIntro:
        "The first cleanup rule is called First Normal Form, or 1NF. It says: every "
        "cell must hold ONE single, simple (atomic) value — never a list crammed "
        "into one box.\n\n"
        "Here's a Shelf row that BREAKS 1NF: item_id 9, items_in_box = \"Apple, "
        "Orange, Cap\".\n\n"
        "That one cell is secretly hiding THREE items. Good luck writing WHERE item "
        "= 'Apple' against that — SQL has no clean way to peek inside a comma-packed "
        "string. The 1NF fix is simple: give each item its own row (item_id 9 → "
        "Apple, item_id 9 → Orange, item_id 9 → Cap).",
    calloutHints: [
      "📏 1NF in one sentence: \"one cell, one fact — never a hidden list.\"",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each table description into the correct bucket.",
      bucketALabel: '✅ Follows 1NF',
      bucketBLabel: '❌ Breaks 1NF',
      items: [
        Sort2Item('one-count', 'The count column holds exactly one number per row', true),
        Sort2Item('csv-cell', 'One cell holds "Apple, Orange, Cap" as a single packed string', false),
        Sort2Item('one-row-per-item', 'Each item gets its own separate row', true),
        Sort2Item('two-phones-one-cell', 'A cell holds two phone numbers separated by a slash', false),
      ],
      explainOk:
          "Right — 1NF just means each cell holds one clean, atomic fact. No "
          "hidden lists allowed!",
      explainBad:
          "Look for cells trying to hide MORE than one value at once (lists, "
          "comma-separated text) — those break 1NF.",
    ),
  ),
  const Chapter(
    id: 7,
    title: "Second Normal Form (2NF)",
    avatar: "🔍",
    role: "Narrator — investigating a composite key",
    bodyIntro:
        "Now imagine an OrderItems table with a composite key — a primary key made "
        "of TWO columns together, (order_id, item_id): order 101/item 1/qty 2/Apple, "
        "order 101/item 3/qty 1/Cap, order 102/item 1/qty 5/Apple.\n\n"
        "quantity genuinely depends on BOTH order_id and item_id together (it's "
        "specific to that particular order). But item_name only depends on item_id "
        "alone — \"Apple\" is called Apple no matter which order it's in! That's a "
        "partial dependency, and it's exactly what Second Normal Form (2NF) "
        "forbids.\n\n"
        "The fix: move item_name out into the Shelf table (keyed by item_id alone), "
        "and let OrderItems just keep the foreign key.",
    calloutHints: [
      "🧩 2NF in one sentence: \"every non-key column must depend on the WHOLE key, "
          "not just part of it.\"",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a term on the left, then its matching definition on the right.",
      pairs: [
        MatchPair('composite', 'Composite key', 'A primary key made of two or more columns together'),
        MatchPair('partial', 'Partial dependency', 'A column that only depends on PART of a composite key'),
        MatchPair('fix', 'The 2NF fix', 'Move the partially-dependent column into its own table'),
      ],
      explainOk: "Nailed it — that's exactly how 2NF cleans up composite-key tables. 🎉",
    ),
  ),
  const Chapter(
    id: 8,
    title: "Third Normal Form (3NF)",
    avatar: "🪄",
    role: "Narrator — chasing a dependency chain",
    bodyIntro:
        "Back to our messy Shelf table with supplier_phone baked in. Look at the "
        "dependency chain: item_id → supplier_id → supplier_phone.\n\n"
        "supplier_phone doesn't depend on item_id directly — it depends on "
        "supplier_id, which depends on item_id. That indirect chain is called a "
        "transitive dependency, and Third Normal Form (3NF) says: get rid of it. "
        "Every non-key column should depend ONLY on the primary key, directly — no "
        "middlemen.\n\n"
        "The fix is the same pattern as before: split off a new Suppliers table "
        "(supplier_id → supplier_name, supplier_phone), and have Shelf just keep a "
        "foreign key pointing to it.",
    calloutHints: [
      "🎯 3NF in one sentence: \"no column should depend on another non-key column, "
          "only on the key itself.\"",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps for fixing a table that has a transitive dependency.",
      items: [
        OrderItem('spot', 'Spot a column that depends on ANOTHER non-key column, not the key itself'),
        OrderItem('newtable', 'Create a new table for that dependent fact (e.g. Suppliers)'),
        OrderItem('move', 'Move the transitively-dependent columns into the new table'),
        OrderItem('fk', 'Leave a foreign key behind in the original table, pointing to the new one'),
      ],
      explainOk:
          "That's the full 3NF cleanup — find the chain, split it off, link it back "
          "with a foreign key. Normalization complete! 🎉",
      explainBad:
          "Think about order: you must FIND the transitive dependency before you "
          "can build a new table for it, move the data, and finally link it back.",
    ),
  ),
  const Chapter(
    id: 9,
    title: "Why Full Table Scans Are Slow",
    avatar: "🐢",
    role: "Narrator — checking every single row by hand",
    bodyIntro:
        "Say I ask: \"which item has count > 2?\" Without any help, the database "
        "does exactly what you'd imagine a very patient turtle doing — it checks row "
        "1, then row 2, then row 3... ALL the way to the last row, one at a time. "
        "This is called a full table scan.\n\n"
        "For 3 rows, that's instant. But real databases can have MILLIONS of rows. "
        "Checking every single one for every single question would make Database "
        "Bay grind to a halt.",
    calloutHints: [
      "⏱️ A full scan's cost grows with the table — twice the rows, roughly twice "
          "the work. That's why we need a shortcut for big tables.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Why do full table scans become a real problem as a table grows?",
      options: [
        'SQL only allows scanning up to 100 rows',
        'The time to check every row grows roughly along with the number of rows in the table',
        'Full scans corrupt the data they read',
        'Full scans only work on tables with a primary key',
      ],
      answerIndex: 1,
      explainOk:
          "Right — more rows means more rows to check, one by one, unless there's "
          "a smarter way to find them.",
      explainBad:
          "The issue isn't corruption or row limits — it's simply that 'check "
          "every row' takes longer and longer as the table grows.",
    ),
  ),
  const Chapter(
    id: 10,
    title: "Meet the B-Tree Index",
    avatar: "🌳",
    role: "Narrator — building a shortcut tree",
    bodyIntro:
        "Instead of checking every row, databases build a tiny sorted map called an "
        "index — usually shaped like a B-Tree: a tree of sorted keys that lets you "
        "jump straight toward the answer, splitting your search in half again and "
        "again, like a phone book.\n\n"
        "Looking up item_id = 3 with a B-Tree index looks like this:\n\n"
        "🌱 Start at the root node — it holds a few keys and points to smaller/"
        "larger branches.\n\n"
        "➡️ Compare 3 to the root's keys, follow the correct branch down.\n\n"
        "🍃 Keep branching down until you hit a leaf node holding the actual row.\n\n"
        "📦 Fetch that one row — done, no scanning needed!",
    calloutHints: [
      "🌳 A good index turns \"check a million rows\" into \"make about 20 quick "
          "comparisons\" — that's the power of a tree shape.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps of looking up item_id = 3 using a B-Tree index.",
      items: [
        OrderItem('root', 'Start at the root node of the index'),
        OrderItem('compare', "Compare the target key to the node's keys"),
        OrderItem('branch', 'Follow the correct branch down the tree'),
        OrderItem('leaf', 'Reach a leaf node that points to the actual row'),
        OrderItem('fetch', 'Fetch that exact row — no scanning required'),
      ],
      explainOk:
          "Exactly how a B-Tree index works — branch, compare, branch again, until "
          "you land right on the row. 🌳",
      explainBad:
          "Remember: you always start at the root, compare before branching, and "
          "only fetch the row once you've reached a leaf.",
    ),
  ),
  const Chapter(
    id: 11,
    title: "When an Index Helps... and When It Hurts",
    avatar: "⚖️",
    role: "Narrator — weighing a tradeoff",
    bodyIntro:
        "Indexes sound magical, so why not index EVERY column? Because indexes "
        "aren't free:\n\n"
        "✍️ Every time you INSERT, UPDATE, or DELETE a row, the database must also "
        "update every index on that table — more indexes means slower writes.\n\n"
        "📉 An index on a column with only a couple of possible values (like a yes/"
        "no flag) often doesn't help much — the database still ends up looking at "
        "roughly half the table either way.\n\n"
        "Indexes shine on columns with lots of different values that show up often "
        "in WHERE or JOIN conditions — like item_id.",
    calloutHints: [
      "⚖️ Every index is a tradeoff: faster reads on that column, slightly slower "
          "writes on the whole table. Choose wisely!",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each column into the right bucket.',
      bucketALabel: '👍 Good index candidate',
      bucketBLabel: '👎 Weak index candidate',
      items: [
        Sort2Item('itemid', 'item_id — used constantly in WHERE and JOIN', true),
        Sort2Item('flag', 'is_active — only ever true or false', false),
        Sort2Item('email', 'customer_email — unique per customer, searched often', true),
        Sort2Item('everysecond', 'live_counter — updated hundreds of times per second', false),
      ],
      explainOk:
          "Great instincts! High-variety, frequently-searched columns are index "
          "gold; low-variety or constantly-changing columns usually aren't worth it.",
      explainBad:
          "Ask two questions: does this column have MANY different values, and is "
          "it searched often? If either answer is 'not really,' skip the index.",
    ),
  ),
  const Chapter(
    id: 12,
    title: "Choosing What to Index",
    avatar: "🎯",
    role: "Narrator — writing the golden rule",
    bodyIntro:
        "Here's the practical rule real database engineers use every day: index the "
        "columns that show up in your WHERE, JOIN, and ORDER BY clauses — the ones "
        "the database needs to filter, match, or sort by often. Don't index columns "
        "just because they exist.",
    calloutHints: [
      "🧭 Golden rule: \"index for how the table is actually queried, not for how "
          "it's shaped.\"",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a query pattern on the left, then its verdict on the right.",
      pairs: [
        MatchPair('where-often', 'A column filtered in WHERE on almost every query', 'Strong candidate for an index'),
        MatchPair('join-key', 'A foreign key used to JOIN two tables constantly', 'Strong candidate for an index'),
        MatchPair('rare-report', 'A column only ever checked once a year in a rare report', 'Not worth indexing'),
      ],
      explainOk:
          "Perfect — you're thinking like a real database engineer now: index for "
          "actual usage patterns, not just because a column exists.",
    ),
  ),
  const Chapter(
    id: 13,
    title: "What Is a Transaction?",
    avatar: "💳",
    role: "Narrator — moving money between piggy banks",
    bodyIntro:
        "Imagine Mia wants to move 5 coins from her piggy bank to her brother's. "
        "That's really TWO steps: subtract 5 from Mia's balance, then add 5 to her "
        "brother's. A transaction is a group of steps that the database treats as "
        "ONE single, unbreakable unit — either every step happens, or none of them "
        "do.\n\n"
        "BEGIN TRANSACTION, subtract 5 from Mia, add 5 to Leo, COMMIT.\n\n"
        "If the power went out right after the first UPDATE, you'd NEVER want Mia "
        "to lose 5 coins that vanish into nowhere. Transactions exist to prevent "
        "exactly that.",
    calloutHints: [
      "💳 Think of a transaction like a seatbelt-clicked car ride: either the WHOLE "
          "trip happens safely, or you never left the driveway.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps of Mia's coin transfer transaction.",
      items: [
        OrderItem('begin', 'BEGIN the transaction'),
        OrderItem('sub', "Subtract 5 coins from Mia's balance"),
        OrderItem('add', "Add 5 coins to Leo's balance"),
        OrderItem('commit', 'COMMIT — make both changes permanent together'),
      ],
      explainOk:
          "Exactly — begin, do every step, then commit them together as one "
          "unbreakable unit. That's a transaction!",
      explainBad:
          "A transaction always starts with BEGIN and ends with COMMIT, and the "
          "money must leave one account before it can land in the other.",
    ),
  ),
  const Chapter(
    id: 14,
    title: "Atomicity & Durability",
    avatar: "🛡️",
    role: "Narrator — surviving a power outage",
    bodyIntro:
        "ACID is a checklist of four promises a database makes about transactions. "
        "Let's start with two of them:\n\n"
        "⚛️ Atomicity — \"all or nothing.\" If ANY step in the transaction fails, "
        "the database undoes every step that already happened, as if none of it "
        "occurred.\n\n"
        "🛡️ Durability — once a transaction says COMMIT, the change is permanent, "
        "even if the power goes out one millisecond later. It's already safely "
        "written to disk.",
    calloutHints: [
      "🔌 Durability is why you don't lose your saved game just because your "
          "console lost power right after you hit \"Save.\"",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a term on the left, then its promise on the right.",
      pairs: [
        MatchPair('atomicity', 'Atomicity', 'All steps happen, or none of them do'),
        MatchPair('durability', 'Durability', 'Once committed, it survives a crash or power loss'),
        MatchPair('crash-mid', 'Power fails mid-transaction (before COMMIT)', 'Atomicity undoes the partial work'),
      ],
      explainOk:
          "Perfect — atomicity protects you DURING a transaction, durability "
          "protects your data AFTER it's committed.",
    ),
  ),
  const Chapter(
    id: 15,
    title: "Consistency & Isolation",
    avatar: "🧯",
    role: "Narrator — catching a rule-breaking transaction",
    bodyIntro:
        "The other two ACID promises:\n\n"
        "✅ Consistency — a transaction can never leave the database breaking its "
        "own rules. If \"balance can never go negative\" is a rule, no transaction "
        "is allowed to finish with a negative balance.\n\n"
        "🙈 Isolation — transactions running at the same time shouldn't see each "
        "other's unfinished, half-done work. Each one behaves as if it's running "
        "alone.\n\n"
        "Imagine Transaction A is halfway through Mia's transfer (money already "
        "left her account, hasn't landed in Leo's yet) — Isolation means "
        "Transaction B, checking balances at that exact moment, should NOT see that "
        "\"missing\" 5 coins floating in limbo.",
    calloutHints: [
      "🙈 Isolation is like a library rule: no one gets to read a half-erased, "
          "half-rewritten page.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Transaction B reads Mia's balance in the exact middle of Transaction "
          "A's transfer, after the 5 coins left Mia's account but before they "
          "landed in Leo's. What just happened?",
      options: [
        'Nothing unusual — this is exactly how isolation should work',
        'An isolation violation — Transaction B saw a half-finished, in-between state it should never have seen',
        'An atomicity violation, because the money already vanished forever',
        "A durability violation, because the data wasn't saved yet",
      ],
      answerIndex: 1,
      explainOk:
          "Right! Good isolation would have hidden A's half-done work from B until "
          "A fully commits.",
      explainBad:
          "The money isn't gone forever and nothing failed to save — the real "
          "issue is that B glimpsed an in-between state it shouldn't have.",
    ),
  ),
  const Chapter(
    id: 16,
    title: "Commit or Rollback",
    avatar: "✅",
    role: "Narrator — deciding the ending",
    bodyIntro:
        "Every transaction ends one of two ways:\n\n"
        "✅ COMMIT — \"everything worked, save it all permanently.\"\n\n"
        "↩️ ROLLBACK — \"something went wrong, undo everything since BEGIN, as if "
        "this transaction never happened at all.\"\n\n"
        "Say Leo's account doesn't actually exist — the second UPDATE in Mia's "
        "transfer fails. A smart application catches that and calls ROLLBACK, which "
        "un-does the first UPDATE too, so Mia never actually loses her 5 coins.",
    calloutHints: [
      "↩️ ROLLBACK is the database's \"undo button\" — but it only works before "
          "COMMIT is called. After COMMIT, it's permanent.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each scenario into the right ending.',
      bucketALabel: '✅ Commit',
      bucketBLabel: '↩️ Rollback',
      items: [
        Sort2Item('both-ok', 'Both UPDATE steps succeeded', true),
        Sort2Item('one-fails', "The second UPDATE fails because Leo's account doesn't exist", false),
        Sort2Item('constraint', 'A rule check (balance ≥ 0) would be broken by finishing', false),
        Sort2Item('all-clear', 'Every step in the transaction ran with no errors', true),
      ],
      explainOk:
          "Exactly — commit only when every step is clean; rollback the moment "
          "anything would break the rules.",
      explainBad:
          "If every single step succeeded cleanly, commit. If even one step fails "
          "or breaks a rule, rollback the whole thing.",
    ),
  ),
  const Chapter(
    id: 17,
    title: "The Lost Update Problem",
    avatar: "🐛",
    role: "Narrator — watching two updates collide",
    bodyIntro:
        "Two customers try to buy the last apple AT THE SAME TIME. Without "
        "protection, here's the disaster that can happen:\n\n"
        "Transaction A reads count = 5. Transaction B ALSO reads count = 5 (before "
        "A finishes). Transaction A computes 5 − 1 = 4, writes count = 4. "
        "Transaction B computes 5 − 1 = 4 (using its own stale read!), writes count "
        "= 4.\n\n"
        "Two purchases happened, but the count only went down by 1 instead of 2! "
        "One update got silently lost because both transactions read the same "
        "\"old\" value before either one wrote back.",
    calloutHints: [
      "🐛 The lost update problem is why \"just read, then write\" is dangerous "
          "without any protection when things happen at the same time.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange the events in the order they happen.',
      items: [
        OrderItem('areads', 'Transaction A reads count = 5'),
        OrderItem('breads', 'Transaction B also reads count = 5'),
        OrderItem('awrites', 'Transaction A writes count = 4'),
        OrderItem('bwrites', "Transaction B writes count = 4 (overwriting A's update!)"),
      ],
      explainOk:
          "That's the lost update bug — both reads happen before either write, so "
          "one decrement silently disappears.",
      explainBad:
          "Both transactions must READ before either one WRITES for this bug to "
          "happen — that's the key timing to get right.",
    ),
  ),
  const Chapter(
    id: 18,
    title: "Locks: Shared vs Exclusive",
    avatar: "🔐",
    role: "Narrator — handing out permission slips",
    bodyIntro:
        "The classic fix for lost updates is locking. A lock is a permission slip a "
        "transaction grabs before touching a row:\n\n"
        "👀 Shared lock (read lock) — many transactions can hold this on the same "
        "row at once, since just reading doesn't hurt anyone.\n\n"
        "✍️ Exclusive lock (write lock) — only ONE transaction can hold this at a "
        "time, and it blocks everyone else (even readers, usually) until it's "
        "released.\n\n"
        "Now Transaction B can't even READ the row for updating until Transaction "
        "A's exclusive lock is released — which stops the lost update from ever "
        "happening.",
    calloutHints: [
      "🔐 Shared locks are like \"look, don't touch\" — plenty of people can look "
          "at once. Exclusive locks are \"hands off, I'm working\" — only one person "
          "at a time.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each action into the right bucket.',
      bucketALabel: '👀 Shared Lock',
      bucketBLabel: '✍️ Exclusive Lock',
      items: [
        Sort2Item('readonly', 'Just reading the current count to display it', true),
        Sort2Item('decrement', 'Decrementing count as part of a purchase', false),
        Sort2Item('manyreaders', 'Ten dashboards reading the same row at once', true),
        Sort2Item('onewriter', 'Only one transaction allowed to hold this at a time', false),
      ],
      explainOk: 'Exactly right! Reads can share; writes need exclusivity to stay safe.',
      explainBad:
          'Ask: does this action change the data? If yes, it needs an exclusive '
          'lock. If it only looks, a shared lock is enough.',
    ),
  ),
  const Chapter(
    id: 19,
    title: "Deadlock Between Transactions",
    avatar: "🔗",
    role: "Narrator — watching two transactions freeze",
    bodyIntro:
        "Locks fix lost updates, but they create a new danger: deadlock. Picture "
        "this:\n\n"
        "🔒 Transaction A locks the Shelf row, then tries to lock the Purchases "
        "row.\n\n"
        "🔒 Transaction B locks the Purchases row, then tries to lock the Shelf "
        "row.\n\n"
        "⏳ A is waiting for B to release Purchases. B is waiting for A to release "
        "Shelf. Neither will EVER let go — they're stuck forever in a circle.\n\n"
        "Real databases constantly watch for this exact circular-waiting pattern. "
        "When they find one, they pick a victim transaction, forcibly roll it back, "
        "and let the other one continue — breaking the frozen circle.",
    calloutHints: [
      "🔗 A deadlock is like two people in a narrow hallway, each waiting for the "
          "other to step aside first — forever.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange the events that lead to (and resolve) a deadlock.',
      items: [
        OrderItem('alocks', 'Transaction A locks the Shelf row'),
        OrderItem('blocks', 'Transaction B locks the Purchases row'),
        OrderItem('await', 'A tries to lock Purchases and waits for B'),
        OrderItem('bwait', 'B tries to lock Shelf and waits for A — now both are stuck'),
        OrderItem('detect', 'The database detects the circular wait'),
        OrderItem('kill', 'The database rolls back one transaction to break the deadlock'),
      ],
      explainOk:
          "That's a full deadlock cycle — two transactions locking in opposite "
          "order, waiting on each other, until the database intervenes.",
      explainBad:
          "The freeze only happens once BOTH transactions are each waiting on the "
          "other — detection and the rollback always come after that.",
    ),
  ),
  const Chapter(
    id: 20,
    title: "Isolation Levels",
    avatar: "🎚️",
    role: "Narrator — turning a safety dial",
    bodyIntro:
        "Isolation isn't all-or-nothing — databases offer a dial of isolation "
        "levels, trading safety for speed:\n\n"
        "⚡ Read Committed — you never see uncommitted (in-progress) changes from "
        "others, but you might see DIFFERENT committed values if you read the same "
        "row twice in one transaction. Fast, decent safety.\n\n"
        "🛡️ Serializable — the strictest level. Transactions behave as if they ran "
        "one at a time, in some order, with zero interference. Very safe, but can "
        "mean more waiting and blocking.",
    calloutHints: [
      "🎚️ Higher isolation = fewer surprises, but more transactions end up "
          "waiting on each other. Engineers pick the level that fits how risky the "
          "data is.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Which of these is the real tradeoff when choosing a stricter isolation "
          "level like Serializable over Read Committed?",
      options: [
        'Stricter isolation makes the database use less disk space',
        'Stricter isolation gives stronger correctness guarantees, but usually costs more waiting/blocking between transactions',
        'Stricter isolation removes the need for any locks at all',
        'Isolation level has no effect on performance, only on syntax',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — it's a real tradeoff: more safety from interference, at the "
          "cost of more transactions waiting on each other.",
      explainBad:
          "Isolation level is fundamentally a safety-vs-speed dial — stricter "
          "means safer but typically slower due to more blocking.",
    ),
  ),
  const Chapter(
    id: 21,
    title: "Anatomy of a Query Plan",
    avatar: "🗺️",
    role: "Narrator — unrolling a treasure map",
    bodyIntro:
        "When you run a query, the database doesn't just magically produce an "
        "answer — it builds a query plan: a pipeline of stages the data flows "
        "through.\n\n"
        "A typical plan for SELECT item FROM Shelf WHERE count > 2 might look like:\n\n"
        "📥 Scan — read rows (via full scan or an index).\n\n"
        "🧹 Filter — keep only rows matching WHERE count > 2.\n\n"
        "🔗 Join — combine with another table, if the query needs one.\n\n"
        "↕️ Sort — order the results, if ORDER BY was requested.\n\n"
        "📤 Return — hand the final rows back to you.",
    calloutHints: [
      "🗺️ Every query — no matter how fancy — breaks down into this same kind of "
          "assembly line of stages.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange the stages in the order data flows through a query plan.',
      items: [
        OrderItem('scan', 'Scan — read rows from the table (or an index)'),
        OrderItem('filter', 'Filter — keep only rows matching WHERE'),
        OrderItem('join', 'Join — combine with another table if needed'),
        OrderItem('sort', 'Sort — order results if ORDER BY was used'),
        OrderItem('return', 'Return — send the final rows back'),
      ],
      explainOk:
          "That's the pipeline! Scan, filter, join, sort, return — the assembly "
          "line every query travels through.",
      explainBad:
          "You must read rows before you can filter them, and you can't sort or "
          "return a result set until it's fully assembled.",
    ),
  ),
  const Chapter(
    id: 22,
    title: "Scan vs Seek",
    avatar: "🔎",
    role: "Narrator — comparing two search strategies",
    bodyIntro:
        "The optimizer's very first decision is HOW to read rows for the Scan "
        "stage:\n\n"
        "📖 Full scan — read every row, check each one against the filter. Fine "
        "for small tables, or when most rows will match anyway.\n\n"
        "🎯 Index seek — jump straight to matching rows using an index. Great when "
        "very FEW rows match, out of a huge table.\n\n"
        "Surprisingly, if a query would match 90% of a table's rows, a full scan "
        "can actually be FASTER than an index seek — hopping all over an index to "
        "fetch almost every row anyway is more work than just reading straight "
        "through.",
    calloutHints: [
      "🔎 The optimizer estimates how many rows will match BEFORE choosing — "
          "that's why the same query can pick different strategies on different "
          "data.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each scenario into the strategy it favors.',
      bucketALabel: '📖 Favors Full Scan',
      bucketBLabel: '🎯 Favors Index Seek',
      items: [
        Sort2Item('mostmatch', 'The WHERE clause matches 90% of all rows', true),
        Sort2Item('onematch', 'The WHERE clause matches exactly 1 row out of a million', false),
        Sort2Item('tinytable', 'The table only has 10 rows total', true),
        Sort2Item('uniquelookup', 'Looking up one row by its unique primary key', false),
      ],
      explainOk:
          "Exactly — seeks win when few rows match a huge table; scans win when "
          "most rows will be needed anyway.",
      explainBad:
          "Think about HOW MANY rows will actually match. Very few out of many "
          "favors a seek; most of the table favors a plain scan.",
    ),
  ),
  const Chapter(
    id: 23,
    title: "Join Order Matters",
    avatar: "🧩",
    role: "Narrator — packing puzzle pieces in the smart order",
    bodyIntro:
        "When a query joins several tables, the ORDER the database joins them in "
        "changes how much work it does — even though the final answer is "
        "identical.\n\n"
        "Say Shelf has 3 rows but Purchases has 10,000 rows. If the optimizer "
        "filters Shelf down to 1 matching row FIRST, then joins that tiny result "
        "against Purchases, it does far less work than joining ALL of Purchases "
        "against ALL of Shelf and filtering afterward.",
    calloutHints: [
      "🧩 Rule of thumb: filter down to the smallest possible set as EARLY as "
          "possible, then join — less data flowing through each later stage.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a strategy on the left, then its effect on the right.',
      pairs: [
        MatchPair('filter-first', 'Filter the small table down first, then join', 'Less data flows through the rest of the plan'),
        MatchPair('join-then-filter', 'Join everything first, then filter at the very end', 'Wastes work joining rows that get thrown away anyway'),
        MatchPair('same-answer', 'Either join order chosen', 'Produces the exact same final answer either way'),
      ],
      explainOk:
          "Exactly — the optimizer's job is picking the CHEAPEST path to the same "
          "correct answer.",
    ),
  ),
  const Chapter(
    id: 24,
    title: "Reading a Simplified EXPLAIN Plan",
    avatar: "📋",
    role: "Narrator — decoding the optimizer's notes",
    bodyIntro:
        "Real databases let you ask \"how would you run this?\" using EXPLAIN. A "
        "simplified plan for our shelf query might print: Filter (count > 2) → "
        "Index Seek on Shelf.item_id → Return 2 rows.\n\n"
        "Reading it takes practice: the INNERMOST step usually runs first (the seek "
        "happens before the filter is applied on top of it), and the plan tells you "
        "WHICH strategy the optimizer actually picked — scan or seek, and in what "
        "order.",
    calloutHints: [
      "📋 EXPLAIN is like asking a chef to describe their recipe before cooking — "
          "you get to double-check it's efficient before running a slow query for "
          "real.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Looking at the EXPLAIN output above, which statement is true?",
      options: [
        'The database did a full table scan, then filtered',
        'The database used an index seek on item_id, then applied the count > 2 filter',
        'The database sorted the results before returning them',
        'The plan shows this query joined two tables',
      ],
      answerIndex: 1,
      explainOk:
          "Right — the plan explicitly shows an Index Seek feeding into a Filter, "
          "with no scan, sort, or join mentioned anywhere.",
      explainBad:
          "Reread the plan text carefully — it names 'Index Seek,' not a scan, "
          "and there's no sort or join step listed at all.",
    ),
  ),
  const Chapter(
    id: 25,
    title: "Counting and Summing with Aggregates",
    avatar: "🧮",
    role: "Narrator — adding things up",
    bodyIntro:
        "So far we've asked \"which rows match.\" Now let's ask questions ABOUT "
        "groups of rows using aggregate functions:\n\n"
        "COUNT(*) — how many rows are there?\n\n"
        "SUM(count) — what's the total of every item's count added together?\n\n"
        "AVG(count) — what's the average count per item?\n\n"
        "SELECT COUNT(*) FROM Shelf; → 3. SELECT SUM(count) FROM Shelf; → 10 "
        "(5+3+2). SELECT AVG(count) FROM Shelf; → 3.33.",
    calloutHints: [
      "🧮 Aggregates turn a whole pile of rows into ONE summary number — perfect "
          "for reports and dashboards.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a function on the left, then what it computes on the right.',
      pairs: [
        MatchPair('count', 'COUNT(*)', 'How many rows matched'),
        MatchPair('sum', 'SUM(count)', 'The total of every value added together'),
        MatchPair('avg', 'AVG(count)', 'The average value across all rows'),
      ],
      explainOk:
          "Perfect — COUNT counts rows, SUM adds values, AVG averages them. The "
          "core aggregate trio!",
    ),
  ),
  const Chapter(
    id: 26,
    title: "Grouping Rows with GROUP BY",
    avatar: "📊",
    role: "Narrator — sorting into buckets before counting",
    bodyIntro:
        "What if I want the total count PER SUPPLIER instead of one grand total? "
        "GROUP BY buckets rows together before running the aggregate on each "
        "bucket separately.\n\n"
        "SELECT supplier, SUM(count) FROM Shelf GROUP BY supplier; → FreshFarms: 8, "
        "ToyWorks: 2.\n\n"
        "The database quietly does this in stages: first it groups every row by "
        "matching supplier value, THEN it runs SUM(count) separately inside each "
        "group, and finally returns one summary row per group.",
    calloutHints: [
      "📊 Whenever you see \"...per category,\" \"...per supplier,\" or \"...per "
          "day,\" that's GROUP BY thinking.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange how GROUP BY actually executes.',
      items: [
        OrderItem('bucket', 'Bucket all rows together by matching supplier value'),
        OrderItem('aggregate', 'Run SUM(count) separately inside each bucket'),
        OrderItem('onerow', 'Return exactly one summary row per bucket'),
      ],
      explainOk:
          "Exactly — group first, aggregate inside each group second, one summary "
          "row out per group.",
      explainBad:
          "You must have the groups formed before you can aggregate INSIDE each "
          "one, and the single summary row only comes out at the very end.",
    ),
  ),
  const Chapter(
    id: 27,
    title: "A Question Inside a Question: Subqueries",
    avatar: "🪆",
    role: "Narrator — nesting one question inside another",
    bodyIntro:
        "Sometimes a question needs an ANSWER to another question first. \"Which "
        "items have more than the average count?\" needs the average count "
        "computed before it can filter anything. That's a subquery — a nested "
        "SELECT living inside another query, like a Russian nesting doll.\n\n"
        "SELECT item FROM Shelf WHERE count > (SELECT AVG(count) FROM Shelf);\n\n"
        "The database runs the INNER query first (compute the average = 3.33), "
        "then plugs that single answer into the OUTER query's WHERE clause.",
    calloutHints: [
      "🪆 The inner query always resolves to a value (or set of values) BEFORE "
          "the outer query can use it.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Given the Shelf table (Apple 5, Orange 3, Cap 2), what does 'SELECT "
          "item FROM Shelf WHERE count > (SELECT AVG(count) FROM Shelf)' return?",
      options: [
        'Apple, Orange, and Cap (all three)',
        'Apple only, since 5 > 3.33 (the average) while 3 and 2 are not',
        "Nothing — subqueries aren't allowed inside WHERE",
        'Just the number 3.33',
      ],
      answerIndex: 1,
      explainOk:
          "Right! The average is 3.33, and only Apple's count (5) beats it — "
          "Orange (3) and Cap (2) don't.",
      explainBad:
          "First compute the average (5+3+2)/3 = 3.33, then check which counts "
          "actually beat that number.",
    ),
  ),
  const Chapter(
    id: 28,
    title: "Joining Three Tables at Once",
    avatar: "🔗",
    role: "Narrator — chaining links together",
    bodyIntro:
        "Real questions often span THREE or more tables. Say we add a Suppliers "
        "table, and want to know: \"which supplier does Mia's purchase come from?\" "
        "That needs a chain: Purchases → Shelf → Suppliers.\n\n"
        "SELECT Suppliers.supplier_name FROM Purchases JOIN Shelf ON "
        "Purchases.item_id = Shelf.item_id JOIN Suppliers ON Shelf.supplier_id = "
        "Suppliers.supplier_id WHERE Purchases.kid = 'Mia';\n\n"
        "Each JOIN adds one more link in the chain — the database walks foreign "
        "keys step by step, just like our very first single JOIN, just repeated.",
    calloutHints: [
      "🔗 A 3-table join is just two 2-table joins chained together — nothing new "
          "to learn, just more links!",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps to answer 'which supplier does Mia's purchase come from?'",
      items: [
        OrderItem('find-mia', "Find Mia's row in Purchases, read its item_id"),
        OrderItem('find-shelf', 'Use that item_id to find the matching Shelf row'),
        OrderItem('read-supplier', "Read that Shelf row's supplier_id"),
        OrderItem('find-supplier', 'Use supplier_id to find the matching Suppliers row'),
        OrderItem('return-name', "Return that supplier's name as the answer"),
      ],
      explainOk:
          "That's a 3-table join traced step by step — one foreign key hop at a "
          "time. 🎉",
      explainBad:
          "Follow the foreign keys one hop at a time: Purchases → Shelf first, "
          "THEN Shelf → Suppliers.",
    ),
  ),
  const Chapter(
    id: 29,
    title: "Beyond Tables: Document Stores",
    avatar: "📄",
    role: "Narrator — flipping through a stack of index cards",
    bodyIntro:
        "Not every database uses neat rows and columns. A document store (like "
        "MongoDB) saves each record as a flexible, self-contained document — often "
        "JSON, e.g. { item: \"Apple\", count: 5, tags: [\"fruit\", \"red\", "
        "\"fresh\"] }.\n\n"
        "Notice tags is a LIST right inside the document — something a strict 1NF "
        "relational table wouldn't allow in one cell! Documents can even have "
        "slightly different fields from each other, which is great when your "
        "data's shape changes often.",
    calloutHints: [
      "📄 Document stores trade some of SQL's strict structure for flexibility — "
          "perfect for data that doesn't fit neatly into fixed columns.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the main advantage a document store offers over a strict "
          "relational table?",
      options: [
        'It guarantees stronger ACID transactions than any SQL database',
        'It lets each record have a flexible, even slightly different shape, without redesigning a fixed schema',
        'It automatically normalizes your data into 3NF',
        "It's the only kind of database that can be indexed",
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — flexibility of shape is the core tradeoff document stores "
          "offer over rigid table schemas.",
      explainBad:
          "Think about what's DIFFERENT from a relational table — it's the "
          "freedom to skip a fixed, uniform column structure.",
    ),
  ),
  const Chapter(
    id: 30,
    title: "Key-Value Stores: The Simplest Database",
    avatar: "🔑",
    role: "Narrator — checking a coat-check ticket",
    bodyIntro:
        "Strip a database down to its bare essentials and you get a key-value "
        "store (like Redis): give it a key, get back a value. No columns, no "
        "joins, no query language — just a giant, blazing-fast dictionary.\n\n"
        "SET shelf:apple:count 5. GET shelf:apple:count → 5.\n\n"
        "They're wildly fast because they don't have to think about relationships "
        "or complex queries — just \"here's a ticket number, hand me my coat.\" "
        "That makes them perfect for caching, session storage, and counters.",
    calloutHints: [
      "🔑 Key-value stores give up query power for raw lookup speed — a "
          "deliberate, useful tradeoff.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a term on the left, then its role on the right.',
      pairs: [
        MatchPair('key', 'Key', "The unique lookup ticket, like 'shelf:apple:count'"),
        MatchPair('value', 'Value', 'The actual data stored under that key, like 5'),
        MatchPair('usecase', 'Best used for', 'Caching, sessions, counters — simple, super-fast lookups'),
      ],
      explainOk:
          "Right — a key-value store really is just that simple: a fast "
          "dictionary of tickets and their contents.",
    ),
  ),
  const Chapter(
    id: 31,
    title: "Graph Databases: Relationships First",
    avatar: "🕸️",
    role: "Narrator — following a web of friendships",
    bodyIntro:
        "Some data is ALL about relationships — who follows whom, what recommends "
        "what. A graph database (like Neo4j) stores nodes (things) and edges "
        "(relationships between them) directly, instead of forcing everything into "
        "rows and foreign keys.\n\n"
        "(Mia) -[FRIENDS_WITH]-> (Leo) -[FRIENDS_WITH]-> (Zoe)\n\n"
        "Questions like \"find all of Mia's friends-of-friends\" are lightning "
        "fast in a graph database — you just walk the edges. In a relational "
        "table, that same question needs a chain of expensive self-joins.",
    calloutHints: [
      "🕸️ If your app's main question is \"what's connected to what,\" a graph "
          "database is often the natural fit.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each scenario into the right bucket.',
      bucketALabel: '🕸️ Great fit for a graph DB',
      bucketBLabel: '📋 Better fit for a relational table',
      items: [
        Sort2Item('friends', 'Finding friends-of-friends in a social network', true),
        Sort2Item('recommend', 'Recommending products based on who bought what together', true),
        Sort2Item('invoice', 'Storing simple, fixed-shape monthly invoices', false),
        Sort2Item('inventory', "Tracking a shop's item counts, like our Shelf table", false),
      ],
      explainOk:
          "Exactly — relationship-heavy, connected questions favor a graph DB; "
          "simple fixed-shape records favor a relational table.",
      explainBad:
          "Ask: is the MAIN question about how things connect to each other? If "
          "yes, that's graph territory.",
    ),
  ),
  const Chapter(
    id: 32,
    title: "Choosing the Right Database",
    avatar: "🧭",
    role: "Narrator — reading the compass",
    bodyIntro:
        "None of these database types is \"the best\" — each is the best fit for "
        "a different shape of problem:\n\n"
        "📋 SQL / relational — structured data, strong consistency, lots of "
        "relationships that fit into tables (our Shelf & Purchases!).\n\n"
        "📄 Document — flexible, evolving record shapes.\n\n"
        "🔑 Key-value — simple, blazing-fast lookups (caching).\n\n"
        "🕸️ Graph — relationship-heavy, connected questions.",
    calloutHints: [
      "🧭 Real production systems often use MULTIPLE database types together — "
          "a relational DB for orders, a key-value cache for speed, and so on.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a need on the left, then the database type on the right.',
      pairs: [
        MatchPair('strong-rules', 'Needs strict rules, transactions, and structured joins', 'SQL / relational'),
        MatchPair('flexible-shape', 'Records whose shape changes often between entries', 'Document store'),
        MatchPair('ultra-fast', 'Needs the fastest possible simple lookups for caching', 'Key-value store'),
        MatchPair('connections', 'The main questions are all about connections between things', 'Graph database'),
      ],
      explainOk:
          "You've got the full map — SQL for structure, documents for "
          "flexibility, key-value for speed, graphs for connections. 🎉",
    ),
  ),
  const Chapter(
    id: 33,
    title: "Read Replicas",
    avatar: "🪞",
    role: "Narrator — making copies of the shelf",
    bodyIntro:
        "What if a million kids want to check the shelf at once? One database "
        "server can only handle so many reads. The fix: keep the ONE real, "
        "writable copy (the primary), and make several read-only replicas — "
        "mirrors that copy every change from the primary.\n\n"
        "✍️ All writes (INSERT/UPDATE/DELETE) go to the primary.\n\n"
        "👀 Reads get spread across many replicas, so no single server gets "
        "overwhelmed.\n\n"
        "🔄 Replicas constantly sync from the primary, usually just moments "
        "behind.",
    calloutHints: [
      "🪞 Read replicas scale READS beautifully, but they don't help with a "
          "flood of WRITES — those still all funnel through the one primary.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange the steps of how a write reaches all the replicas.',
      items: [
        OrderItem('write', 'An application writes a change to the primary'),
        OrderItem('apply', 'The primary applies and commits the change'),
        OrderItem('sync', 'The change streams out to every read replica'),
        OrderItem('readers', 'Readers querying any replica now see the update'),
      ],
      explainOk:
          "That's exactly how replication flows — write to the primary first, "
          "then it fans out to every replica.",
      explainBad:
          "The change must be committed on the primary BEFORE it can stream out "
          "anywhere else.",
    ),
  ),
  const Chapter(
    id: 34,
    title: "Sharding: Splitting the Shelf Across Many Warehouses",
    avatar: "🏭",
    role: "Narrator — splitting inventory across warehouses",
    bodyIntro:
        "Read replicas don't help if your WRITES outgrow one server too. The fix "
        "for that is sharding: split your data by some shard key across multiple "
        "independent database servers, so each one only holds a slice of the "
        "whole.\n\n"
        "Shard 1 (item_id 1-100): Apple, Cap, ... Shard 2 (item_id 101-200): "
        "Orange, ...\n\n"
        "Now writes AND reads for a given item only ever hit ONE shard, spreading "
        "the total load across many machines. The tradeoff: a query that needs "
        "data from MULTIPLE shards (like \"total count across everything\") gets "
        "harder to answer.",
    calloutHints: [
      "🏭 Sharding scales both reads AND writes, but makes cross-shard questions "
          "(\"give me everything\") more complicated to answer.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each item_id into the shard it belongs to (Shard 1 = 1-100, Shard 2 = 101-200).',
      bucketALabel: '🏭 Shard 1 (1–100)',
      bucketBLabel: '🏭 Shard 2 (101–200)',
      items: [
        Sort2Item('id1', 'item_id = 1 (Apple)', true),
        Sort2Item('id150', 'item_id = 150', false),
        Sort2Item('id99', 'item_id = 99', true),
        Sort2Item('id200', 'item_id = 200', false),
      ],
      explainOk:
          "Exactly — the shard key range decides which physical server holds "
          "(and answers for) each row.",
      explainBad:
          "Just compare each item_id to the two ranges: 1-100 goes to Shard 1, "
          "101-200 goes to Shard 2.",
    ),
  ),
  const Chapter(
    id: 35,
    title: "Eventual vs Strong Consistency",
    avatar: "⏳",
    role: "Narrator — waiting for the mirror to catch up",
    bodyIntro:
        "Replicas take a tiny bit of time to catch up after a write. What should "
        "a read from a replica see DURING that gap?\n\n"
        "🕰️ Eventual consistency — the replica might return slightly stale (old) "
        "data for a brief moment, but promises it WILL catch up soon. Fast, "
        "highly available.\n\n"
        "🛡️ Strong consistency — every read, from anywhere, always sees the very "
        "latest committed write — even if that means waiting for replicas to "
        "confirm first. Safer, but slower.",
    calloutHints: [
      "⏳ Most massive-scale systems (like social media feeds) happily accept "
          "eventual consistency — a like-count being a second late is no big deal. "
          "A bank balance usually is NOT okay with that.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Which scenario has the LEAST tolerance for stale, eventually-"
          "consistent reads?",
      options: [
        "A social media 'like' counter showing a slightly old number for a second",
        'Checking your bank balance right after transferring money, to avoid double-spending',
        "A video's view count updating a few seconds late",
        "A blog post's comment count lagging briefly behind reality",
      ],
      answerIndex: 1,
      explainOk:
          "Right — money needs strong consistency; the cost of being wrong "
          "(double-spending) is far too high to risk staleness.",
      explainBad:
          "Ask: what's the real-world COST of briefly seeing stale data here? "
          "Likes and view counts are harmless; bank balances are not.",
    ),
  ),
  const Chapter(
    id: 36,
    title: "The CAP Theorem",
    avatar: "⚖️",
    role: "Narrator — facing an impossible choice",
    bodyIntro:
        "The CAP theorem is a famous rule about distributed databases (ones "
        "spread across multiple machines). It says that during a network "
        "partition (some servers can't talk to others), a system can only keep "
        "TWO of these three promises fully:\n\n"
        "✅ Consistency — every node sees the same, latest data.\n\n"
        "🟢 Availability — every request gets SOME response, even during the "
        "partition.\n\n"
        "🔌 Partition tolerance — the system keeps working at all, despite the "
        "network split.\n\n"
        "Since real networks DO occasionally partition, partition tolerance "
        "isn't really optional — so in practice, the real choice during a "
        "partition is between Consistency and Availability.",
    calloutHints: [
      "⚖️ CAP isn't \"pick your favorite forever\" — it's \"when the network "
          "breaks, which do you sacrifice: an instant answer, or a "
          "guaranteed-fresh one?\"",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a letter on the left, then its meaning on the right.',
      pairs: [
        MatchPair('c', 'C — Consistency', 'Every node sees the same, latest data'),
        MatchPair('a', 'A — Availability', 'Every request gets some response, even during trouble'),
        MatchPair('p', 'P — Partition tolerance', 'The system survives the network splitting apart'),
      ],
      explainOk:
          "Perfect — and remember, during a real partition you can typically "
          "only fully keep one of C or A, not both.",
    ),
  ),
  const Chapter(
    id: 37,
    title: "Design the Schema",
    avatar: "🏗️",
    role: "Narrator — the first professional challenge",
    bodyIntro:
        "Database Bay's final trial begins. A real startup asks you to design the "
        "database for a mini online shop: customers place orders, and each order "
        "can contain multiple products.\n\n"
        "A production-grade design needs FOUR tables working together: one for "
        "customers, one for products, one for orders (linked to a customer), and "
        "one linking table for the many-to-many relationship between orders and "
        "products (since one order can hold many products, and one product can "
        "appear in many orders).",
    calloutHints: [
      "🏗️ This \"linking table in the middle\" pattern — sometimes called an "
          "associative or junction table — is how relational databases model "
          "many-to-many relationships, since a plain foreign key can only point to "
          "ONE row.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a table on the left, then its job on the right.',
      pairs: [
        MatchPair('customers', 'Customers', 'One row per customer, primary key customer_id'),
        MatchPair('products', 'Products', 'One row per product, primary key product_id'),
        MatchPair('orders', 'Orders', 'One row per order, with a foreign key to customer_id'),
        MatchPair('orderitems', 'OrderItems (junction table)', 'Links orders to products — foreign keys to BOTH order_id and product_id'),
      ],
      explainOk:
          "That's a real production e-commerce schema — you just designed it! A "
          "junction table is the key to any many-to-many relationship.",
    ),
  ),
  const Chapter(
    id: 38,
    title: "Spot the Mistake",
    avatar: "🕵️",
    role: "Narrator — auditing someone else's design",
    bodyIntro:
        "A junior developer shows you this table and asks why it feels \"off\": "
        "OrderItems, order_id 501, product_names \"Apple,Cap,Orange\", "
        "product_prices \"1.00,3.00,0.80\".\n\n"
        "Something here should set off every alarm bell you've learned in this "
        "level. Two comma-packed strings are hiding multiple facts inside single "
        "cells — you can't easily query \"all orders containing Apple,\" can't "
        "enforce a real foreign key to a Products table, and if the number of "
        "items ever doesn't match between the two lists, the data quietly becomes "
        "garbage.",
    calloutHints: [
      "🕵️ This is a real, common production bug pattern — and now you can name "
          "exactly why it's wrong.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's fundamentally wrong with storing product_names and "
          "product_prices as comma-separated strings in one row?",
      options: [
        "Nothing — it's a valid, normalized design",
        'It violates First Normal Form (1NF) by packing multiple values into single cells, breaking queryability and foreign key integrity',
        "It's a CAP theorem violation",
        "It's a deadlock waiting to happen",
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — this is a textbook 1NF violation, and it's exactly "
          "the kind of thing a junction table (from the last chapter) fixes.",
      explainBad:
          "This isn't about CAP or deadlocks — go back to the very first "
          "normalization rule: one cell, one atomic fact.",
    ),
  ),
  const Chapter(
    id: 39,
    title: "The CAP Trade-off Call",
    avatar: "🌐",
    role: "Narrator — the second professional challenge",
    bodyIntro:
        "You're the architect for a global live-chat app. The network between two "
        "data centers just partitioned — they temporarily can't talk to each "
        "other. You must choose, right now, for this app:\n\n"
        "Keep the app FULLY available on both sides, risking that a few messages "
        "arrive slightly out of order until the partition heals, OR block sending "
        "messages entirely on one side until the network heals, to guarantee "
        "perfect global ordering.\n\n"
        "For a chat app, most engineers choose availability — a chat that's "
        "briefly unable to send is a MUCH worse user experience than a rare, "
        "brief message-order hiccup that resolves itself in seconds.",
    calloutHints: [
      "🌐 There's no universally \"correct\" CAP choice — the right call depends "
          "entirely on what a WRONG answer costs your specific users.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "For a global live-chat app during a network partition, which "
          "reasoning best justifies choosing Availability over strict "
          "Consistency?",
      options: [
        'Availability is always the technically superior choice in every system',
        'A chat app briefly going unreachable is worse for users than a rare, self-healing message-ordering hiccup',
        'Consistency is impossible to implement in any distributed system',
        "This choice doesn't actually matter for a chat app",
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — good CAP reasoning is always about the real cost of being "
          "wrong for THIS specific app, not a universal rule.",
      explainBad:
          "There's no single 'always correct' side of CAP — the right answer "
          "here comes from comparing the actual user-facing cost of each option.",
    ),
  ),
  const Chapter(
    id: 40,
    title: "Database Bay — Final Review",
    avatar: "💠",
    role: "Narrator — the last trial of Database Bay",
    bodyIntro:
        "This is it — the final trial of Database Bay. Everything you've "
        "learned, from a shelf of apples to a global CAP trade-off, comes "
        "together into one professional workflow: how a real database gets "
        "built from scratch.",
    calloutHints: [
      "💠 Complete this final challenge to restore Database Bay's Shard and "
          "prove you can think like a real database engineer, start to finish.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange these stages in the order a real database engineer would tackle them.',
      items: [
        OrderItem('requirements', "Gather requirements: what data needs to be stored, and how it's used"),
        OrderItem('schema', 'Design a normalized schema: tables, columns, primary and foreign keys'),
        OrderItem('index', 'Add indexes for the columns real queries will filter and join on'),
        OrderItem('transactions', 'Wrap multi-step operations in ACID transactions'),
        OrderItem('scale', 'Plan replication and sharding for when load grows'),
        OrderItem('operate', 'Monitor, tune, and adjust the CAP trade-offs as the system runs'),
      ],
      explainOk:
          "That's the complete professional lifecycle — requirements, schema, "
          "indexing, transactions, scaling, and ongoing operation. Database Bay's "
          "Shard is restored! 💠",
      explainBad:
          "Think like an engineer building this for the first time: you can't "
          "index or scale a schema that doesn't exist yet, and scaling decisions "
          "come before day-to-day operation.",
    ),
  ),
  const Chapter(
    id: 41,
    title: "Replication Topologies Under Load",
    avatar: "🔁",
    role: "Narrator — entering the Deployment Frontier",
    bodyIntro:
        "Database Bay has a new frontier: real production operations. Level 9 "
        "taught you that replicas exist. Now you need to run them under real "
        "traffic.\n\n"
        "Replication comes in three flavors, and the flavor you pick decides "
        "what breaks during a failover:\n\n"
        "⚡ Asynchronous — the primary commits and confirms to the app "
        "immediately; replicas catch up moments later. Fast writes, but if the "
        "primary dies before a replica received the last few transactions, those "
        "transactions are GONE.\n\n"
        "🛡️ Synchronous — the primary waits for at least one replica to confirm "
        "it received the write before confirming to the app. Zero data loss on "
        "failover, but every write now pays the round-trip latency to that "
        "replica.\n\n"
        "⚖️ Semi-synchronous — the common production compromise: wait for ONE "
        "replica to acknowledge (not all of them), keeping most of the safety "
        "with much less latency than full sync.\n\n"
        "Then there's failover: when the primary dies, an orchestrator (like "
        "Patroni or Orchestrator) promotes a replica to be the new primary. A "
        "dangerous failure mode is split-brain — the old primary comes back "
        "online, still thinks it's the primary, and now TWO servers are both "
        "accepting writes independently.",
    calloutHints: [
      "🔁 Production rule: async replication is the default for throughput, "
          "semi-sync is the compromise payments teams reach for, and every "
          "failover plan needs a way to guarantee the old primary can never write "
          "again (\"fencing\").",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each fact into the replication mode it describes.',
      bucketALabel: '⚡ Asynchronous',
      bucketBLabel: '🛡️ Synchronous',
      items: [
        Sort2Item('confirmfast', 'Primary confirms the write to the app before any replica has it', true),
        Sort2Item('waitack', 'Primary waits for replica acknowledgment before confirming the write', false),
        Sort2Item('riskloss', 'Fastest writes, but risks losing the last few transactions on failover', true),
        Sort2Item('zeroloss', 'Zero data loss on failover, but adds round-trip latency to every write', false),
      ],
      explainOk:
          "Exactly — async trades a little durability for speed; sync trades a "
          "little speed for guaranteed durability on failover.",
      explainBad:
          "Ask: does the primary wait for a replica's confirmation before "
          "telling the app 'done'? If yes, that's synchronous.",
    ),
  ),
  const Chapter(
    id: 42,
    title: "Backups, RPO, and RTO",
    avatar: "💾",
    role: "Narrator — planning for disaster before it happens",
    bodyIntro:
        "Replication protects you from a server dying. It does NOT protect you "
        "from a bad DELETE FROM Shelf; with no WHERE clause — that mistake "
        "replicates everywhere instantly. For that, you need backups.\n\n"
        "Two numbers every production database team must agree on with the "
        "business, BEFORE an incident:\n\n"
        "⏱️ RPO (Recovery Point Objective) — how much data can we afford to "
        "lose? \"RPO = 15 minutes\" means backups/logs must let you restore to "
        "within 15 minutes of the failure.\n\n"
        "🕐 RTO (Recovery Time Objective) — how long can we afford to be down "
        "while we restore? \"RTO = 1 hour\" means the WHOLE recovery process, "
        "start to finish, must complete inside an hour.\n\n"
        "To hit a tight RPO, engineers combine a periodic full backup with "
        "continuously shipped transaction logs (WAL in Postgres, binlog in "
        "MySQL), enabling point-in-time recovery (PITR): restore the full "
        "backup, then replay logs up to one second before the bad DELETE ran.",
    calloutHints: [
      "💾 A backup you've never test-restored isn't a backup — it's a hope. "
          "Real teams run restore drills specifically to validate their RTO.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a term on the left, then its meaning on the right.',
      pairs: [
        MatchPair('rpo', 'RPO', 'The maximum data loss the business can tolerate, measured in time'),
        MatchPair('rto', 'RTO', 'The maximum downtime the business can tolerate during recovery'),
        MatchPair('pitr', 'Point-in-time recovery', 'Restore a full backup, then replay logs up to a chosen moment'),
        MatchPair('drill', 'Restore drill', "Practicing an actual restore, to prove your RTO is real, not theoretical"),
      ],
      explainOk:
          "Exactly — RPO is about data loss tolerance, RTO is about downtime "
          "tolerance, and PITR is the mechanism that hits a tight RPO.",
    ),
  ),
  const Chapter(
    id: 43,
    title: "Zero-Downtime Schema Migrations",
    avatar: "🛠️",
    role: "Narrator — changing the shelf while shoppers are still shopping",
    bodyIntro:
        "In production, you cannot take Database Bay offline to add a column — "
        "millions of shoppers are mid-checkout. The pattern real teams use is "
        "called expand-contract (or \"parallel change\"). Say you're renaming "
        "item to item_name on a huge Shelf table:\n\n"
        "1️⃣ Expand — add the new column item_name as NULLABLE, alongside the old "
        "one. A nullable add is a fast, near-zero-lock operation on most "
        "databases.\n\n"
        "2️⃣ Backfill — copy data from item into item_name in small batches (not "
        "one giant UPDATE, which would lock the whole table and blow up "
        "replication lag).\n\n"
        "3️⃣ Dual-write — deploy application code that writes to BOTH columns, so "
        "nothing falls out of sync while the backfill catches up.\n\n"
        "4️⃣ Migrate reads — once the backfill is verified complete, switch "
        "application reads over to item_name.\n\n"
        "5️⃣ Contract — once nothing reads or writes the old column anymore, drop "
        "it in a later release.",
    calloutHints: [
      "🛠️ Golden rule: never ship a schema change and the application code that "
          "depends on it in the SAME deploy. Split it into small, "
          "always-reversible steps.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange the expand-contract migration from first step to last.',
      items: [
        OrderItem('expand', 'Expand: add the new column as nullable'),
        OrderItem('backfill', 'Backfill: copy data into the new column in small batches'),
        OrderItem('dualwrite', 'Dual-write: deploy code that writes to both columns'),
        OrderItem('migratereads', 'Migrate reads: switch application reads to the new column'),
        OrderItem('contract', 'Contract: drop the old column once nothing uses it'),
      ],
      explainOk:
          "That's the full expand-contract pattern — always additive first, "
          "always subtractive last, never both at once.",
      explainBad:
          "You can't drop the old column until nothing reads it, and you can't "
          "dual-write to a column that doesn't exist yet.",
    ),
  ),
  const Chapter(
    id: 44,
    title: "Connection Pooling at Scale",
    avatar: "🔌",
    role: "Narrator — the shelf can only hold so many hands at once",
    bodyIntro:
        "Every database connection isn't free — it typically costs the server "
        "its own process or thread, plus memory, even while sitting idle. A "
        "popular app server might try to open THOUSANDS of connections under "
        "load. The database falls over from sheer connection overhead, long "
        "before it runs out of real query capacity.\n\n"
        "The fix: a connection pooler (like PgBouncer or ProxySQL) sits between "
        "your app and the database, holding a much smaller pool of real database "
        "connections and multiplexing many app requests onto them.\n\n"
        "👥 Session pooling — an app gets a real connection for its whole "
        "session; safest, but doesn't save many connections.\n\n"
        "⚡ Transaction pooling — a real connection is only borrowed for the "
        "duration of ONE transaction, then returned to the pool instantly for "
        "another app to use. Far higher connection reuse, but breaks any feature "
        "that depends on session state surviving between transactions.",
    calloutHints: [
      "🔌 Pool exhaustion is a classic incident pattern: every app instance "
          "holds a connection waiting on a slow query, the pool runs dry, and "
          "every OTHER request queues up behind it — one slow query cascades "
          "into a full outage.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why do production databases put a connection pooler like PgBouncer "
          "in front of them instead of letting every app instance connect "
          "directly?",
      options: [
        'Poolers make every individual query run faster',
        'Raw database connections are expensive to hold open at scale; a pooler multiplexes many app requests onto a much smaller set of real connections',
        'Poolers automatically add indexes to slow queries',
        'Connection pooling is only needed for NoSQL databases',
      ],
      answerIndex: 1,
      explainOk:
          "Right — pooling's whole point is protecting the database from "
          "connection overhead, not speeding up any single query.",
      explainBad:
          "A pooler doesn't touch indexes or query plans — it exists purely to "
          "control how many expensive real connections the database has to hold "
          "open.",
    ),
  ),
  const Chapter(
    id: 45,
    title: "Sharding Strategies: Hash, Range, and Directory",
    avatar: "🏭",
    role: "Narrator — choosing how to split the warehouse",
    bodyIntro:
        "Level 9 introduced range sharding (item_id 1–100 vs 101–200). "
        "Production systems actually choose between three sharding strategies, "
        "each with a different failure mode:\n\n"
        "🔢 Range sharding — split by a value range (like item_id or "
        "created_at). Easy to reason about and great for range scans, but new "
        "data (like today's orders) can pile onto ONE \"hot\" shard while old "
        "shards sit idle.\n\n"
        "🎲 Hash sharding — hash the shard key and mod it across shards. Spreads "
        "load evenly, but a query for \"everything between March and June\" now "
        "has to hit EVERY shard, since the hash scattered nearby values "
        "everywhere.\n\n"
        "📖 Directory-based sharding — a lookup table maps each key to its shard "
        "explicitly. Most flexible (you can rebalance one key at a time), but "
        "that lookup table itself becomes a critical, must-scale piece of "
        "infrastructure.",
    calloutHints: [
      "🏭 There's no free lunch: range gives you ordered scans but risks "
          "hotspots; hash gives you even load but kills range queries; directory "
          "gives you flexibility at the cost of one more system to keep alive.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a strategy on the left, then its tradeoff on the right.',
      pairs: [
        MatchPair('range', 'Range sharding', 'Great for range scans, but new writes can overload one hot shard'),
        MatchPair('hash', 'Hash sharding', 'Spreads load evenly, but breaks efficient range queries'),
        MatchPair('directory', 'Directory-based sharding', 'Most flexible rebalancing, but the lookup table becomes critical infrastructure'),
      ],
      explainOk:
          "Exactly — every sharding strategy trades away something; the right "
          "pick depends on your query patterns, not fashion.",
    ),
  ),
  const Chapter(
    id: 46,
    title: "Caching Layers: Cache-Aside and Its Traps",
    avatar: "⚡",
    role: "Narrator — building a faster mirror in front of the shelf",
    bodyIntro:
        "Read replicas (Level 9) scale reads by copying the WHOLE database. A "
        "cache scales reads by keeping only the HOT, frequently-read data in "
        "memory — often 100x faster than any disk-backed replica. The most "
        "common pattern is cache-aside: the app checks the cache first, and only "
        "falls back to the database on a miss.\n\n"
        "Two traps every senior engineer eventually gets bitten by:\n\n"
        "🧟 Stale cache — the database changes but the cache still serves the "
        "old value until its TTL expires (or someone explicitly invalidates it "
        "on write).\n\n"
        "🐘 Thundering herd — a popular key's TTL expires, and THOUSANDS of "
        "requests miss the cache at the exact same instant, all hammering the "
        "database to refill it simultaneously.",
    calloutHints: [
      "⚡ Fix for thundering herd: let only ONE request refill a hot key while "
          "everyone else briefly waits on (or gets served) the stale value — "
          "never let a whole crowd stampede the database at once.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange the steps of a cache-aside read for shelf:apple.',
      items: [
        OrderItem('check', 'App checks the cache for shelf:apple'),
        OrderItem('miss', "Cache reports a miss — the key isn't there"),
        OrderItem('readdb', 'App reads the real value from the database'),
        OrderItem('writecache', 'App stores that value into the cache with a TTL'),
        OrderItem('servenext', 'The next request for shelf:apple is served straight from the cache'),
      ],
      explainOk:
          "That's cache-aside — check first, only touch the database on a miss, "
          "then refill the cache for next time.",
      explainBad:
          "You can't refill the cache with a value you haven't read from the "
          "database yet, and the database is only ever consulted AFTER a miss.",
    ),
  ),
  const Chapter(
    id: 47,
    title: "Partitioning: Range, Hash, and List",
    avatar: "📚",
    role: "Narrator — splitting one giant filing cabinet into labeled drawers",
    bodyIntro:
        "Partitioning looks like sharding's cousin, but it happens INSIDE one "
        "database instance, not across separate servers. A giant table gets "
        "split into smaller physical partitions that the database still treats "
        "as one logical table.\n\n"
        "📅 Range partitioning — split by value ranges, most commonly by date "
        "(Orders_2024_01, Orders_2024_02, ...). A query filtered to one month "
        "can skip every other partition entirely — called partition pruning.\n\n"
        "🎲 Hash partitioning — hash a key to spread rows evenly across a fixed "
        "number of partitions, useful when there's no natural range to split "
        "on.\n\n"
        "🏷️ List partitioning — split by an explicit list of known values, like "
        "one partition per region ('US', 'EU', 'APAC').",
    calloutHints: [
      "📚 Partitioning's biggest production win is pruning: a 2-billion-row "
          "Orders table sliced by month means \"this quarter's report\" only ever "
          "touches 3 small partitions, not 2 billion rows.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a partitioning style on the left, then its best-fit scenario on the right.',
      pairs: [
        MatchPair('rangepart', 'Range partitioning', 'A time-series Orders table, mostly queried by recent date ranges'),
        MatchPair('hashpart', 'Hash partitioning', 'A table with no natural range, but you want rows spread evenly'),
        MatchPair('listpart', 'List partitioning', 'A table naturally split into a small, known set of categories like region'),
      ],
      explainOk:
          "Exactly — range for time-series pruning, hash for even spread with "
          "no natural order, list for known discrete categories.",
    ),
  ),
  const Chapter(
    id: 48,
    title: "Hot Keys and Hotspots",
    avatar: "🔥",
    role: "Narrator — when one shelf slot gets slammed",
    bodyIntro:
        "Sharding and partitioning both assume load spreads evenly. Reality "
        "disagrees: one viral post, one celebrity's account, one Black-Friday "
        "product gets FAR more traffic than every other key combined. That "
        "single key can overload its one shard even while every other shard "
        "sits idle — a hot key or hotspot.\n\n"
        "Production mitigations, roughly in order of effort:\n\n"
        "💾 Local/edge caching — cache the hot key's value close to the app, "
        "cutting most requests off before they ever reach the shard.\n\n"
        "🧵 Request coalescing — if 1,000 requests for the same hot key arrive "
        "at once, merge them into ONE database read and share the result, "
        "instead of hitting the database 1,000 times.\n\n"
        "✂️ Key splitting — split one hot logical key into several physical "
        "sub-keys (like counter:apple:0..9) written independently, then summed "
        "when read — spreading the write load across shards.",
    calloutHints: [
      "🔥 A sharding scheme that's \"even on average\" can still fail hard in "
          "production — hotspots are a reminder that average load and peak load "
          "on a single key are very different problems.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A single row (one celebrity account) is receiving so many reads "
          "that it's overwhelming its shard, while every other shard is idle. "
          "What's the most direct production fix?",
      options: [
        'Re-shard the entire cluster from scratch immediately',
        "Cache that hot key aggressively (and consider splitting its writes across sub-keys) so most traffic never reaches the shard at all",
        'Delete the row until traffic dies down',
        'Switch the whole database to a stricter isolation level',
      ],
      answerIndex: 1,
      explainOk:
          "Right — caching and key-splitting directly attack the hotspot "
          "without a disruptive full re-shard.",
      explainBad:
          "A full re-shard is slow and disruptive for one bad key, and "
          "isolation level has nothing to do with read hotspots.",
    ),
  ),
  const Chapter(
    id: 49,
    title: "Concurrency Anomalies: Dirty Reads, Phantoms, and Write Skew",
    avatar: "👻",
    role: "Narrator — naming the ghosts that haunt concurrent transactions",
    bodyIntro:
        "Level 5 introduced the lost update. Production engineers need to "
        "recognize three more classic anomalies by name, because bug reports "
        "and database docs assume you already know them:\n\n"
        "🙈 Dirty read — Transaction B reads a value Transaction A wrote but "
        "HASN'T committed yet. If A then rolls back, B just used data that never "
        "actually existed.\n\n"
        "👻 Phantom read — Transaction A runs the same WHERE count > 2 query "
        "twice inside one transaction, and gets a DIFFERENT set of rows the "
        "second time, because Transaction B inserted a new matching row in "
        "between.\n\n"
        "⚖️ Write skew — two transactions each read overlapping data, each "
        "independently decide their own change is safe based on what they read, "
        "and both commit — but the combination violates a rule neither one saw "
        "coming. Classic example: two doctors independently go off-call, each "
        "checking \"is at least one other doctor still on call?\" — both see "
        "\"yes,\" both go off-call, and now nobody is on call.",
    calloutHints: [
      "👻 Write skew is the sneakiest of the three: no single row was "
          "corrupted, no lock was violated — the invariant that broke lived "
          "ACROSS rows, and only Serializable isolation (or an explicit "
          "constraint) reliably catches it.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click an anomaly on the left, then its description on the right.',
      pairs: [
        MatchPair('dirty', 'Dirty read', "Reading another transaction's uncommitted, possibly-about-to-vanish change"),
        MatchPair('phantom', 'Phantom read', 'The same query returns a different set of rows the second time, within one transaction'),
        MatchPair('skew', 'Write skew', 'Two transactions each safely check a rule alone, but together they violate it'),
      ],
      explainOk:
          "Exactly — dirty reads see the future that might not happen, phantoms "
          "see a shifting set of rows, write skew breaks a rule across rows "
          "nobody individually broke.",
    ),
  ),
  const Chapter(
    id: 50,
    title: "Encryption at Rest and in Transit",
    avatar: "🔐",
    role: "Narrator — locking every door, not just the front gate",
    bodyIntro:
        "The Fortress of Trust has two very different attack surfaces, and each "
        "needs its own kind of encryption:\n\n"
        "💽 Encryption at rest — protects data sitting on disk. If someone "
        "steals a hard drive or an unencrypted backup file, Transparent Data "
        "Encryption (TDE) means the raw bytes are unreadable without the "
        "encryption key.\n\n"
        "📡 Encryption in transit — protects data while it travels over the "
        "network, using TLS between the app and the database. Without it, "
        "anyone who can sniff the network between your app server and your "
        "database can read every query and every row flowing past.\n\n"
        "🔑 Column-level / application-level encryption — for the most "
        "sensitive fields (SSNs, card numbers), encrypt the specific column "
        "itself, using a separate key management service (KMS), so even a "
        "database admin with full table access can't read the plaintext.",
    calloutHints: [
      "🔐 At-rest and in-transit encryption are both \"table stakes\" in any "
          "real production system — neither one substitutes for the other, since "
          "they protect against completely different attackers.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each protection into the right bucket.',
      bucketALabel: '💽 Encryption at Rest',
      bucketBLabel: '📡 Encryption in Transit',
      items: [
        Sort2Item('tde', "Transparent Data Encryption protecting the database's files on disk", true),
        Sort2Item('stolendisk', 'Protects data if someone physically steals a backup drive', true),
        Sort2Item('tls', 'TLS handshake between the application server and the database', false),
        Sort2Item('sniff', 'Protects against someone eavesdropping on the network between app and DB', false),
      ],
      explainOk:
          "Exactly — at-rest protects stored files, in-transit protects data on "
          "the wire. Real systems need both.",
      explainBad:
          "Ask: is the attacker holding a stolen disk (at rest), or sniffing a "
          "network cable (in transit)?",
    ),
  ),
  const Chapter(
    id: 51,
    title: "Row-Level Security and Least Privilege",
    avatar: "🛂",
    role: "Narrator — checking every visitor's badge at every row",
    bodyIntro:
        "A single shared database often serves MANY tenants (customers, teams, "
        "accounts) at once. A regular GRANT can say \"this app user may SELECT "
        "from Shelf\" — but it can't say \"this app user may only see Shelf rows "
        "belonging to Tenant 42.\" That finer-grained rule is Row-Level Security "
        "(RLS).\n\n"
        "CREATE POLICY tenant_isolation ON Shelf USING (tenant_id = "
        "current_setting('app.tenant_id')::int);\n\n"
        "Once that policy is active, EVERY query against Shelf — even a lazy "
        "SELECT * FROM Shelf written by a careless developer — automatically "
        "only sees rows for the current tenant. The database enforces the "
        "boundary, instead of trusting every application code path to remember "
        "a WHERE tenant_id = ... clause.",
    calloutHints: [
      "🛂 This is the principle of least privilege applied at the row level: "
          "never trust application code alone to enforce a security boundary "
          "that the database itself can guarantee.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange how a row-level security policy protects a careless query.',
      items: [
        OrderItem('policy', 'A database admin defines a row-level security policy on the table'),
        OrderItem('setting', 'The application sets the current tenant_id for its session'),
        OrderItem('query', 'A developer runs an ordinary SELECT * FROM Shelf with no WHERE clause'),
        OrderItem('filter', "The database silently filters the results to only that tenant's rows"),
      ],
      explainOk:
          "That's RLS working as designed — the policy must exist and the "
          "session tenant must be set BEFORE any query, careless or not, gets "
          "automatically filtered.",
      explainBad:
          "The policy has to be defined and the session's tenant_id set before "
          "any query runs — the filtering happens automatically, after that "
          "setup.",
    ),
  ),
  const Chapter(
    id: 52,
    title: "Audit Trails: Who Changed What, and When",
    avatar: "📜",
    role: "Narrator — keeping an unforgeable diary of every change",
    bodyIntro:
        "When something goes wrong in production — a suspicious balance change, "
        "a compliance auditor's question — \"who changed this row, and when?\" "
        "needs a real answer, not a guess. That's what an audit trail is for: "
        "an append-only record of every change to sensitive data.\n\n"
        "✍️ Trigger-based auditing — a database trigger fires on every "
        "INSERT/UPDATE/DELETE and writes a copy of the old/new row into an "
        "AuditLog table. Simple, but adds write overhead to every transaction.\n\n"
        "📡 CDC-based auditing (Change Data Capture) — a separate process reads "
        "the database's own replication log (the same stream replicas use) and "
        "streams every change out to an audit system, with almost no overhead "
        "on the primary.\n\n"
        "🔒 Tamper-evidence — the audit log itself must be append-only and "
        "ideally hash-chained (each entry includes a hash of the previous one), "
        "so nobody — not even an admin — can quietly edit history without it "
        "being detectable.",
    calloutHints: [
      "📜 An audit log that can itself be edited or deleted by the same admins "
          "it's supposed to be watching isn't really an audit log — it's a "
          "liability.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a concept on the left, then its role on the right.',
      pairs: [
        MatchPair('trigger', 'Trigger-based auditing', 'Fires on every write, copying old/new values into an AuditLog table'),
        MatchPair('cdc', 'CDC-based auditing', 'Reads the replication log stream to capture changes with minimal overhead'),
        MatchPair('tamperevident', 'Tamper-evidence', 'Hash-chained entries so editing past history is detectable'),
      ],
      explainOk:
          "Exactly — trigger-based is simplest but costs write overhead, CDC is "
          "near-free, and hash-chaining is what makes the log trustworthy.",
    ),
  ),
  const Chapter(
    id: 53,
    title: "SQL vs NoSQL: The Real Tradeoffs",
    avatar: "🧭",
    role: "Narrator — the architect's first fork in the road",
    bodyIntro:
        "Level 8 introduced NoSQL flavors. As an architect, the real decision "
        "is rarely \"SQL is old, NoSQL is new\" — it's a set of concrete "
        "tradeoffs for THIS workload:\n\n"
        "📐 Schema rigidity vs flexibility — SQL enforces a schema up front, "
        "catching bad data early; NoSQL lets each record's shape evolve, at the "
        "cost of pushing validation into application code.\n\n"
        "🔗 Joins — SQL joins are a first-class, optimizer-backed operation; "
        "most NoSQL stores either forbid joins outright or make you denormalize "
        "(duplicate data) to avoid needing them.\n\n"
        "📈 Horizontal scaling — many NoSQL systems were built sharding-first "
        "from day one; scaling a relational database horizontally (Level 12) is "
        "possible but requires deliberate sharding work most SQL databases "
        "don't do for you automatically.\n\n"
        "🔒 Transactional guarantees — SQL's ACID transactions across multiple "
        "rows/tables are mature and well understood; many NoSQL stores only "
        "guarantee atomicity within a SINGLE document or row.",
    calloutHints: [
      "🧭 The professional answer to \"SQL or NoSQL?\" is almost always \"it "
          "depends on your read/write pattern, your consistency needs, and your "
          "join complexity\" — never a blanket rule.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each requirement into the family it favors.',
      bucketALabel: '📋 Favors SQL / Relational',
      bucketBLabel: '📄 Favors NoSQL',
      items: [
        Sort2Item('multitable', 'Complex multi-table joins with strict referential integrity', true),
        Sort2Item('evolvingshape', 'Records whose shape evolves rapidly, iterated on weekly', false),
        Sort2Item('crossrowtxn', 'Transactions spanning multiple rows across multiple tables', true),
        Sort2Item('massivescale', 'Needs to scale horizontally to millions of writes/sec, denormalized data is acceptable', false),
      ],
      explainOk:
          "Exactly — structure and cross-row transactions favor SQL; flexible "
          "shape and sharding-first scale favor NoSQL.",
      explainBad:
          "Ask: does this need strict cross-row/table guarantees (SQL), or "
          "flexible shape and effortless horizontal scale (NoSQL)?",
    ),
  ),
  const Chapter(
    id: 54,
    title: "CAP Theorem, Applied to Real Databases",
    avatar: "🌍",
    role: "Narrator — mapping real systems onto the CAP triangle",
    bodyIntro:
        "Level 9 taught CAP in the abstract. Real production databases make a "
        "deliberate, documented choice about which side of CAP they lean toward "
        "during a partition:\n\n"
        "🟢 AP (Availability-favoring) — Cassandra and DynamoDB (in their "
        "default configurations) keep answering requests during a partition, "
        "accepting that different nodes may briefly disagree, resolved later "
        "via mechanisms like \"last write wins\" or vector clocks.\n\n"
        "🔵 CP (Consistency-favoring) — MongoDB and most consensus-based "
        "systems (built on Raft/Paxos, like etcd) will refuse to serve a "
        "request rather than risk returning stale or conflicting data during a "
        "partition.\n\n"
        "⚪ Single-node relational databases — a single-instance Postgres or "
        "MySQL isn't really \"CAP\" at all in the classical sense, since it has "
        "no partition to survive — CAP only becomes a real choice once you're "
        "distributed across multiple nodes.\n\n"
        "Crucially, most modern distributed databases let you TUNE this "
        "per-query — Cassandra, for instance, lets you request a stronger "
        "consistency level for a specific critical read, at the cost of that "
        "one query's latency, without changing the whole cluster's default.",
    calloutHints: [
      "🌍 CAP isn't a single permanent label stamped on a product — it's a "
          "dial many real systems let you adjust operation by operation.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a system on the left, then its typical CAP leaning on the right.',
      pairs: [
        MatchPair('cassandra', 'Cassandra / DynamoDB (default)', 'AP by default — favors staying available during a network partition'),
        MatchPair('mongo', 'MongoDB / Raft-based systems', 'CP by default — favors refusing stale/conflicting data over availability'),
        MatchPair('singlenode', 'A single-node Postgres/MySQL', 'Not really a CAP tradeoff at all — no partition exists on one node'),
      ],
      explainOk:
          "Exactly — CAP only becomes a real choice once you're distributed, "
          "and different real systems default to different sides of it.",
    ),
  ),
  const Chapter(
    id: 55,
    title: "Event Sourcing and CQRS",
    avatar: "🎞️",
    role: "Narrator — replaying the tape instead of trusting a snapshot",
    bodyIntro:
        "Every table so far has stored CURRENT state — Shelf's count column "
        "just holds \"5 right now,\" with no memory of how it got there. Event "
        "sourcing flips that: instead of storing current state, you store an "
        "append-only log of every EVENT that happened (ItemAdded, ItemSold, "
        "ItemReturned), and derive current state by replaying them.\n\n"
        "That pairs naturally with CQRS (Command Query Responsibility "
        "Segregation): split your write model (append events, validate "
        "business rules) from your read model (a separate, denormalized table "
        "optimized purely for fast queries, rebuilt from the event stream).",
    calloutHints: [
      "🎞️ The payoff: perfect audit history for free (Level 13's audit trail "
          "is basically automatic), and the ability to rebuild a read model in a "
          "completely NEW shape just by replaying old events. The cost: the read "
          "model is only EVENTUALLY consistent with the latest events — there's "
          "always a small lag between \"event happened\" and \"read model "
          "updated.\"",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange the steps from command to a fast read.',
      items: [
        OrderItem('command', "A command (e.g. 'sell 1 apple') arrives and is validated"),
        OrderItem('append', 'An ItemSold event is appended to the immutable event log'),
        OrderItem('project', 'A projector process consumes the new event'),
        OrderItem('update', 'The projector updates the separate, query-optimized read model'),
        OrderItem('query', 'Later reads are served fast from that read model, not by replaying events'),
      ],
      explainOk:
          "That's event sourcing + CQRS — validate, append the event, project "
          "it into a fast read model, then serve reads from that model.",
      explainBad:
          "The event must be appended before any projector can consume it, and "
          "the read model must be updated before a fast read can use it.",
    ),
  ),
  const Chapter(
    id: 56,
    title: "Multi-Region Database Design",
    avatar: "🌐",
    role: "Narrator — the architect's hardest map",
    bodyIntro:
        "Your users are now global. Do you run one database region and accept "
        "the speed-of-light latency for users on the other side of the planet, "
        "or run MULTIPLE regions? Two production patterns, with very different "
        "failure modes:\n\n"
        "🅰️ Active-passive — one region takes all writes; other regions hold "
        "read-only replicas and stand by for failover. Simple to reason about "
        "consistency-wise, but writes from far-away users always pay the "
        "latency to the single active region.\n\n"
        "🅱️ Active-active — multiple regions accept writes simultaneously, "
        "giving every user low local write latency. The hard part: what happens "
        "when the SAME row is written in two regions at nearly the same time? "
        "Systems resolve this with strategies like last-write-wins (simple, but "
        "can silently drop a concurrent update) or CRDTs (data structures "
        "specifically designed to merge concurrent updates without conflict).\n\n"
        "Multi-region design also has to respect data residency laws (like "
        "GDPR) — some data legally cannot leave certain regions at all, which "
        "can force a hybrid design where some tables are global and others are "
        "strictly regional.",
    calloutHints: [
      "🌐 Active-active buys low latency everywhere at the cost of genuinely "
          "hard conflict resolution; active-passive buys simplicity at the cost "
          "of latency for distant users. Neither is \"more correct\" — it "
          "depends on the product's tolerance for each cost.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A financial ledger system is deciding between active-active and "
          "active-passive multi-region replication. Which reasoning best "
          "supports choosing active-passive?",
      options: [
        'Active-passive is always faster for every user, everywhere',
        "A ledger needs a single unambiguous order of transactions; resolving concurrent conflicting writes across regions is riskier than accepting one region's write latency",
        "Active-active systems can't be encrypted",
        'Active-passive requires no replication at all',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — for money, an unambiguous transaction order beats low "
          "write latency almost every time.",
      explainBad:
          "Focus on what a LEDGER specifically can't tolerate: ambiguous "
          "concurrent writes to the same balance, which active-active makes "
          "possible.",
    ),
  ),
  const Chapter(
    id: 57,
    title: "Incident: The Deadlock Storm",
    avatar: "🚨",
    role: "Narrator — the Machine's Reckoning begins",
    bodyIntro:
        "3:14 AM. PagerDuty fires. Database Bay's Orders service is throwing a "
        "wave of deadlock detected errors, and checkout is failing for real "
        "customers. This is the capstone: synthesize everything from Levels "
        "11–14 to find the root cause.\n\n"
        "Path A (checkout): UPDATE Orders SET status = 'paid' WHERE order_id = "
        "501; UPDATE Payments SET status = 'captured' WHERE order_id = 501.\n\n"
        "Path B (refund worker): UPDATE Payments SET status = 'refunded' WHERE "
        "order_id = 501; UPDATE Orders SET status = 'refunded' WHERE order_id = "
        "501.\n\n"
        "Path A locks Orders, then Payments. Path B locks Payments, then "
        "Orders — the exact opposite order (Level 5's deadlock pattern, now in "
        "real production code). Under low traffic this almost never collides; "
        "under Black-Friday load, it happens constantly.\n\n"
        "The fix isn't \"add more retries\" — retries just paper over a "
        "structural bug. The real fix is enforcing a single, consistent lock "
        "ORDER across every code path that touches both tables (e.g., always "
        "lock Orders before Payments, everywhere in the codebase, with no "
        "exceptions).",
    calloutHints: [
      "🚨 Root-causing this needed Level 5's deadlock mechanics AND the "
          "production instinct that \"it only happens under load\" points at a "
          "resource-contention bug, not a logic bug.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange the incident response from the first alert to the verified fix.',
      items: [
        OrderItem('alert', 'PagerDuty fires on a spike in deadlock errors'),
        OrderItem('logs', 'On-call engineer pulls the deadlock logs to see which two queries collided'),
        OrderItem('tracepaths', 'Trace both code paths and find they lock Orders and Payments in opposite order'),
        OrderItem('fix', 'Standardize lock order across both code paths (always Orders, then Payments)'),
        OrderItem('verify', 'Deploy the fix and confirm the deadlock rate drops to zero under load'),
      ],
      explainOk:
          "That's a real incident lifecycle — detect, investigate, root-cause, "
          "fix the structural bug, then verify under real load. 🚨",
      explainBad:
          "You can't fix a lock-order bug before you've traced BOTH code "
          "paths, and you can't claim victory before verifying under real "
          "load.",
    ),
  ),
  const Chapter(
    id: 58,
    title: "Incident: The Slow-Query Regression",
    avatar: "🐌",
    role: "Narrator — the second reckoning",
    bodyIntro:
        "A different pager: p99 latency on SELECT * FROM Orders WHERE "
        "customer_id = ? AND status = 'active' jumped from 5ms to 4 seconds, "
        "right after yesterday's routine deploy — which didn't touch this query "
        "at all.\n\n"
        "EXPLAIN ANALYZE reveals the smoking gun: a sequential scan on Orders "
        "with an estimated 1,800,000 rows, filtering on customer_id = 4471 AND "
        "status = 'active'.\n\n"
        "The query planner switched from an index seek to a full sequential "
        "scan. Root cause, chased down using Level 6 and Level 11 knowledge "
        "together: yesterday's deploy included a large data migration (Level "
        "11's backfill!) that inserted millions of new rows in one batch "
        "WITHOUT the database's table statistics being refreshed afterward. "
        "The planner's row-count estimates went stale, and it wrongly decided a "
        "full scan would be cheaper than the index.\n\n"
        "The immediate fix: run ANALYZE Orders; to refresh statistics. The "
        "long-term fix: make statistics refresh an automatic, required step in "
        "the migration/backfill runbook, not an afterthought.",
    calloutHints: [
      "🐌 This is a genuinely common production bug class: a change with NO "
          "code diff on the slow query itself still broke it, because query "
          "plans depend on statistics that silently went stale after a large "
          "bulk write.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "p99 latency on an unrelated query spiked to 4 seconds right after a "
          "large data-migration deploy, and EXPLAIN shows a full sequential "
          "scan replaced a previously-used index seek. What's the most likely "
          "root cause?",
      options: [
        'The index on customer_id was silently deleted by the deploy',
        "The large bulk insert left the table's query-planner statistics stale, causing the optimizer to misjudge cardinality and pick a full scan",
        'The database ran out of disk space',
        'SELECT * always forces a sequential scan regardless of indexes',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — stale statistics after a huge bulk insert is a classic "
          "silent regression, invisible in any code diff.",
      explainBad:
          "Nothing here suggests a dropped index, full disk, or a SELECT * "
          "rule — the real clue is the timing right after a large, unrefreshed "
          "bulk insert.",
    ),
  ),
  const Chapter(
    id: 59,
    title: "Capstone: Design the Payments Ledger",
    avatar: "⚔️",
    role: "Narrator — the third reckoning, everything at once",
    bodyIntro:
        "The final design challenge: a payments ledger that must be correct, "
        "fast, global, and auditable, all at once. You have to combine every "
        "professional-tier lesson into one coherent design:\n\n"
        "💳 Transactions (Level 4): every balance change wraps in ACID "
        "transactions — no partial transfers.\n\n"
        "🔒 Isolation (Level 13): use Serializable isolation (or explicit "
        "constraints) specifically around balance transfers, since write skew "
        "here means real money problems.\n\n"
        "🏭 Scale (Level 12): shard by account_id so no single server becomes "
        "the bottleneck as customers grow.\n\n"
        "🌐 Region (Level 14): active-passive per shard, since a ledger cannot "
        "tolerate active-active's conflict-resolution risk.\n\n"
        "📜 Audit (Level 13): every balance mutation is also appended as an "
        "immutable event (Level 14's event sourcing), so \"what happened to "
        "this account, in order\" is always answerable.\n\n"
        "🛠️ Evolution (Level 11): any future schema change ships via "
        "expand-contract, never a blocking ALTER on the live ledger table.",
    calloutHints: [
      "⚔️ Nothing here is a new concept — this is the entire professional "
          "tier, applied together to one system that actually needs every one "
          "of these guarantees simultaneously.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a requirement on the left, then the concept that satisfies it on the right.',
      pairs: [
        MatchPair('nopartial', 'No transfer can ever leave money half-moved', 'ACID transactions'),
        MatchPair('wskew', "Two concurrent transfers can't silently violate a balance rule together", 'Serializable isolation'),
        MatchPair('growth', 'Must keep serving millions of accounts without one server melting down', 'Sharding by account_id'),
        MatchPair('history', 'Every balance change must be replayable as an audit history', 'Event sourcing'),
      ],
      explainOk:
          "That's the full picture — every professional-tier concept, matched "
          "to the exact production need it solves in a real ledger. ⚔️",
    ),
  ),
  const Chapter(
    id: 60,
    title: "The Machine's Reckoning — Database Bay's Final Trial",
    avatar: "💎",
    role: "Narrator — the last challenge of the professional tier",
    bodyIntro:
        "This is it — the hardest trial in Database Bay. A production payments "
        "system just failed a load test at 10x expected traffic. You are the "
        "principal engineer on call, and you must reason through the FULL "
        "response, drawing on every professional-tier level: replication, "
        "backups, migrations, pooling, sharding, caching, partitioning, "
        "hotspots, isolation anomalies, encryption, RLS, audits, SQL/NoSQL "
        "tradeoffs, CAP, event sourcing, and multi-region design.",
    calloutHints: [
      "💎 Complete this final challenge to prove you can think like a "
          "principal database engineer, end to end, under real pressure — no "
          "toy examples left, only production judgment.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Arrange these stages in the order a principal engineer would tackle them.',
      items: [
        OrderItem('detect', 'Detect the failure via alerts (latency, error rate, replication lag all spiking together)'),
        OrderItem('triage', 'Triage: is this a hot key, a connection pool exhaustion, a deadlock storm, or a stale query plan?'),
        OrderItem('mitigate', 'Apply the fastest safe mitigation (failover, scale the pool, add a cache, kill the offending query)'),
        OrderItem('rootcause', 'Root-cause the underlying design gap (missing shard key, no read replica, no RLS, etc.)'),
        OrderItem('harden', 'Ship the structural fix: reshard, add caching, tighten isolation, or redesign the migration path'),
        OrderItem('postmortem', 'Write the postmortem and update the runbook so the next on-call engineer inherits the lesson'),
      ],
      explainOk:
          "That's the complete principal-engineer incident lifecycle — detect, "
          "triage, mitigate fast, root-cause deeply, harden permanently, and "
          "document. Database Bay's Machine has been reckoned with! 💎",
      explainBad:
          "Think like the on-call engineer: you stop the bleeding (mitigate) "
          "before you fully root-cause, and you harden the system before "
          "writing it all down for next time.",
    ),
  ),
];
