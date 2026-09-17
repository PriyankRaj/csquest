import '../models/pq_models.dart';

/// Ported from process-quest/subjects/data-structures.js — all 60 chapters,
/// levels 1-15, "Structure Springs". Puzzle types used: mcq, order, sort2,
/// match (no fill/trace puzzles in this subject).
final dataStructuresChapters = <Chapter>[
  const Chapter(
    id: 1,
    title: 'Arrays: The Locker Row',
    avatar: '🔢',
    role: 'Narrator — rolling past the lockers',
    bodyIntro:
        "Welcome to Structure Springs! The first thing I see is a long row of "
        "lockers, all lined up in a row, all the exact same size. That's an "
        "array — a neat row of boxes for storing things. Right now, my 5 "
        "lockers hold: Apple, Banana, Grapes, Watermelon, and Cherries!\n\n"
        "Here's the fun (and tricky!) part: the very first locker isn't "
        "locker number 1. It's locker number 0! Computers love to start "
        "counting from zero. So if I have 5 lockers, they're numbered "
        "0, 1, 2, 3, 4.\n\n"
        "Each locker's number is called its index. The best part about an "
        "array? If I know the index, I can open that exact locker instantly "
        "— no need to check every locker before it!\n\n"
        "Fast to grab something if you know its index\n\n"
        "All boxes are the same size, lined up with no gaps\n\n"
        "Growing the row bigger can be slow — you may need a whole new row\n\n"
        "Let's practice counting locker indexes.",
    calloutHints: [
      "Kid tip: think of an array like a muffin tin. Every muffin cup is "
          "the same size, and they're numbered starting at 0, left to right.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a locker index on the left, then click the fruit it holds "
          "on the right.",
      pairs: [
        MatchPair('l0', 'Index 0', 'Apple'),
        MatchPair('l1', 'Index 1', 'Banana'),
        MatchPair('l2', 'Index 2', 'Grapes'),
        MatchPair('l3', 'Index 3', 'Watermelon'),
        MatchPair('l4', 'Index 4', 'Cherries'),
      ],
      explainOk:
          "Perfect! You've got it — the first locker is always index 0, and "
          "every locker after just counts up by one.",
    ),
  ),
  const Chapter(
    id: 2,
    title: 'Linked Lists: The Treasure Hunt',
    avatar: '🗺️',
    role: 'Narrator — following clues',
    bodyIntro:
        "A little further down the road, I find something different: boxes "
        "scattered all over the place, not lined up at all! But each box has "
        "a little note taped to it that says \"the next box is over there!\" "
        "That's a linked list.\n\n"
        "Picture a real scavenger hunt: Clue Card #1 says \"look under the "
        "mailbox\" — and under the mailbox is Clue Card #2, which points to "
        "the next hiding spot, and so on. You can NEVER skip straight to "
        "Clue Card #4. You have to follow every single clue in order, "
        "starting from #1! That's exactly how a linked list works.\n\n"
        "Instead of sitting in a numbered row, each piece — called a node — "
        "just holds two things: its own value, and a pointer (an arrow) to "
        "the next node. To find the 5th box, I can't jump straight to it "
        "like with lockers. I have to start at the first box and follow the "
        "arrows, one by one, like our treasure hunt!\n\n"
        "Slower to reach the middle — you must follow the arrows from the "
        "start\n\n"
        "Super easy to add or remove a box — just re-tape one arrow!\n\n"
        "Boxes don't need to sit next to each other in memory\n\n"
        "Let's compare arrays and linked lists.",
    calloutHints: [
      "Kid tip: an array is like assigned seats on a bus (seat 0, seat 1, "
          "seat 2...). A linked list is like a scavenger hunt where each "
          "clue tells you where the next clue is.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each card into the bucket it describes best.",
      bucketALabel: 'Array',
      bucketBLabel: 'Linked List',
      items: [
        Sort2Item('jump', 'Jump straight to any index instantly', true),
        Sort2Item(
          'follow',
          'Must follow arrows one by one from the start',
          false,
        ),
        Sort2Item(
          'retape',
          'Adding or removing is just re-taping one arrow',
          false,
        ),
        Sort2Item(
          'sameSize',
          'All boxes sit in a row, same size, numbered from 0',
          true,
        ),
      ],
      explainOk:
          "Sorted perfectly! Arrays are all about instant index-jumping; "
          "linked lists are all about following arrows.",
      explainBad:
          "Look again — arrows and treasure-hunt style belong to Linked "
          "Lists, instant index-jumping belongs to Arrays.",
    ),
  ),
  const Chapter(
    id: 3,
    title: 'Stacks & Queues: Pancakes and Ice Cream Lines',
    avatar: '🥞',
    role: 'Narrator — visiting the snack stand',
    bodyIntro:
        "Ooh, a snack stand! I see two fun ways things get organized here.\n\n"
        "First, a stack of pancakes. The last pancake the cook put on top is "
        "the first one you'll eat off the top. That's called LIFO: Last In, "
        "First Out. Adding a pancake is called push, and taking one off the "
        "top is called pop.\n\n"
        "Next to it, a line for ice cream. Whoever got in line FIRST gets "
        "served FIRST — no cutting! That's called FIFO: First In, First "
        "Out. That's a queue.\n\n"
        "Stack = LIFO = like a pile of plates, pancakes, or books\n\n"
        "Queue = FIFO = like a line at the ice cream truck\n\n"
        "Let's push some pancakes onto the stack, in order.",
    calloutHints: [
      "Kid tip: your browser's \"Back\" button acts like a stack — the LAST "
          "page you visited is the FIRST one you go back to!",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "You cook pancakes in this order: Blueberry, then Plain, then "
          "Chocolate Chip. Arrange them from BOTTOM of the stack (cooked "
          "first) to TOP (cooked last, on top).",
      items: [
        OrderItem('blueberry', 'Blueberry pancake'),
        OrderItem('plain', 'Plain pancake'),
        OrderItem('choc', 'Chocolate Chip pancake'),
      ],
      explainOk:
          "Yum, and correct! The first pancake cooked (Blueberry) sits at "
          "the bottom, and the last one cooked (Chocolate Chip) sits right "
          "on top — that's LIFO in action.",
      explainBad:
          "Remember, in a stack the first thing you put down stays at the "
          "BOTTOM, and each new thing goes right on TOP of it.",
    ),
  ),
  const Chapter(
    id: 4,
    title: 'Trees & the Guessing Game',
    avatar: '🌳',
    role: 'Narrator — climbing a tree',
    bodyIntro:
        "At the top of the springs stands a giant tree. Not the kind with "
        "leaves — a data structure tree! It starts at one box on top, called "
        "the root, and branches down into more boxes, called nodes.\n\n"
        "In a special kind called a binary search tree, every node follows "
        "one simple rule: smaller numbers go to the left branch, bigger "
        "numbers go to the right branch. That makes searching super quick — "
        "like a guessing game!\n\n"
        "Speaking of guessing games — here's binary search: I'm thinking of "
        "a number between 1 and 100. Instead of guessing 1, 2, 3... you "
        "guess 50 first (the middle!). If I say \"too high\", you now only "
        "need to search 1–49. Guess the middle of THAT. Each guess cuts the "
        "possibilities in half!\n\n"
        "Let's trace a guessing game together.",
    calloutHints: [
      "Kid tip: guessing the middle every time is way faster than guessing "
          "one-by-one. That's why binary search beats checking every locker "
          "in a row.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Secret number is 7. Range starts at 1-16. Guess the MIDDLE of "
          "the range each time:\n\n"
          "Guess 1: middle of 1-16 is 8 -> \"too high\" -> new range 1-7\n"
          "Guess 2: middle of 1-7 is 4 -> \"too low\" -> new range 5-7\n"
          "Guess 3: middle of 5-7 is 6 -> \"too low\" -> new range 7-7\n"
          "Guess 4: middle of 7-7 is 7 -> \"correct!\"\n\n"
          "How many total guesses did it take to find the secret number 7?",
      options: ['2', '3', '4', '7'],
      answerIndex: 2,
      explainOk:
          "Exactly right — 4 guesses! Each guess cuts the range roughly in "
          "half, so binary search finds things in way fewer tries than "
          "checking one by one.",
      explainBad:
          "Count each numbered guess line above, from Guess 1 all the way "
          "to the one that says \"correct!\". How many guess lines are "
          "there in total?",
    ),
  ),
  const Chapter(
    id: 5,
    title: 'The Call Stack',
    avatar: '📞',
    role: 'Narrator — watching functions call each other',
    bodyIntro:
        "Here's something wild: every program you run is secretly using a "
        "stack right now — called the call stack.\n\n"
        "When main() calls a function A(), the computer pushes a new "
        "\"frame\" onto the stack for A. If A calls B(), another frame goes "
        "on top for B. If B calls C(), yet another frame stacks on top for "
        "C. The stack now looks like: main (bottom), A, B, C (top).\n\n"
        "Here's the LIFO rule in action: whichever function was called LAST "
        "finishes and returns FIRST. C returns first (it's on top), then B, "
        "then A, then finally main. This is exactly why \"the call stack\" "
        "is a real stack, not just a nickname!\n\n"
        "Let's figure out the return order.",
    calloutHints: [
      "Kid tip: if functions keep calling functions forever with no end, "
          "the stack grows and grows until it's full — that's a real error "
          "called a \"stack overflow\"!",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "main() called A(), which called B(), which called C(). Arrange "
          "these three functions from the FIRST one to return to the LAST "
          "one to return.",
      items: [
        OrderItem('c', 'C() returns'),
        OrderItem('b', 'B() returns'),
        OrderItem('a', 'A() returns'),
      ],
      explainOk:
          "Exactly! C was called last, so it's on top of the stack and "
          "returns first — then B, then A. Last In, First Out.",
      explainBad:
          "Think LIFO: whichever function was called MOST RECENTLY (deepest "
          "on the stack) is the one that returns FIRST.",
    ),
  ),
  const Chapter(
    id: 6,
    title: 'Circular Queues',
    avatar: '🔄',
    role: 'Narrator — watching a queue wrap around',
    bodyIntro:
        "A regular queue is a line — but what if the line is drawn on a "
        "fixed-size circular buffer instead of an endless hallway? That's a "
        "circular queue, and it's how a lot of real software (like audio "
        "buffers and print spoolers) actually works.\n\n"
        "A circular queue tracks two pointers: front (where the next item "
        "will be removed from) and rear (where the next item will be "
        "added). When rear reaches the last slot, it wraps back around to "
        "slot 0 — as long as there's empty space that front has already "
        "freed up!\n\n"
        "Enqueue — add an item at the rear pointer, then move rear forward "
        "(wrapping if needed)\n\n"
        "Dequeue — remove the item at the front pointer, then move front "
        "forward\n\n"
        "Match the circular queue vocabulary.",
    calloutHints: [
      "Kid tip: think of a circular queue like a merry-go-round with "
          "numbered seats — when you reach the last seat, the next seat is "
          "seat 0 again, right next to it.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click its matching description "
          "on the right.",
      pairs: [
        MatchPair('front', 'Front', 'Pointer to the next item that will be removed'),
        MatchPair('rear', 'Rear', 'Pointer to where the next item will be added'),
        MatchPair('enqueue', 'Enqueue', 'Add an item at the rear, then move rear forward'),
        MatchPair(
          'wrap',
          'Wraparound',
          'Rear jumps back to slot 0 after the last slot, if there is room',
        ),
      ],
      explainOk:
          "All matched! Front removes, rear adds, and wraparound is what "
          "makes the queue 'circular' instead of running off the end.",
    ),
  ),
  const Chapter(
    id: 7,
    title: 'Stack vs Queue Showdown',
    avatar: '⚔️',
    role: 'Narrator — refereeing a friendly contest',
    bodyIntro:
        "Time for a showdown! Lots of real features you use every day are "
        "secretly either a stack (LIFO) or a queue (FIFO) under the hood. "
        "Let's spot which is which.\n\n"
        "Ask yourself: \"does the newest thing get handled first (stack), "
        "or does the oldest thing get handled first (queue)?\"\n\n"
        "Sort each real feature into the right bucket.",
    calloutHints: [
      "Kid tip: an office printer is a great real-world queue — the first "
          "document sent usually prints first, even if ten more get added "
          "while it's working.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each real feature into the bucket describing how it "
          "behaves.",
      bucketALabel: 'Stack (LIFO)',
      bucketBLabel: 'Queue (FIFO)',
      items: [
        Sort2Item(
          'undo',
          'The Undo button — undoes your MOST RECENT action first',
          true,
        ),
        Sort2Item(
          'back',
          'Browser Back button — goes to the LAST page you visited',
          true,
        ),
        Sort2Item(
          'print',
          'Office printer — prints the FIRST document sent, first',
          false,
        ),
        Sort2Item(
          'line',
          'People waiting in line at a ticket counter',
          false,
        ),
      ],
      explainOk:
          "Nailed it! Undo and Back are stacks (most recent first); "
          "printers and lines are queues (first come, first served).",
      explainBad:
          "Ask which thing gets handled first: the newest one (stack) or "
          "the oldest, longest-waiting one (queue)?",
    ),
  ),
  const Chapter(
    id: 8,
    title: 'Balanced Parentheses',
    avatar: '🧮',
    role: 'Narrator — checking brackets with a stack',
    bodyIntro:
        "Here's a classic real use for a stack: checking whether brackets "
        "are balanced — every opening bracket has a matching closing "
        "bracket, in the right order.\n\n"
        "The trick: scan left to right. Every time you see an opening "
        "bracket ( [ {, push it onto a stack. Every time you see a closing "
        "bracket, pop the stack — if it doesn't match, the string is "
        "broken. If the stack is empty at the very end, it's balanced!\n\n"
        "Trace it yourself on two strings.",
    calloutHints: [
      "Kid tip: this exact trick is how code editors know when you're "
          "missing a closing bracket — they're running this stack "
          "algorithm as you type!",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Using the push-open / pop-close stack trick, which of these two "
          "strings is properly balanced?\n\nString A: ( [ ) ]\nString B: "
          "( [ ] )",
      options: [
        'String A: ( [ ) ]',
        'String B: ( [ ] )',
        'Both strings are balanced',
        'Neither string is balanced',
      ],
      answerIndex: 1,
      explainOk:
          "Right! In String B, the [ closes before the ( — matching the "
          "LIFO order. In String A, the ) tries to close while [ is still "
          "on top, which breaks the rule.",
      explainBad:
          "Trace it with a stack: push ( then push [. The very next "
          "closing bracket must match whatever is on TOP of the stack. "
          "Which string respects that?",
    ),
  ),
  const Chapter(
    id: 9,
    title: 'Binary Tree Anatomy',
    avatar: '🌲',
    role: 'Narrator — labeling the tree',
    bodyIntro:
        "Let's properly label the parts of a tree before we go further.\n\n"
        "Root — the one node at the very top, with no parent\n\n"
        "Parent — a node that has at least one node below it\n\n"
        "Child — a node directly below another node\n\n"
        "Leaf — a node with NO children at all, at the bottom of a branch\n\n"
        "Depth — how many steps down from the root a node is (the root's "
        "depth is 0)\n\n"
        "In a binary tree specifically, every node has AT MOST two "
        "children — commonly called the left child and the right child.\n\n"
        "Match each tree term to its meaning.",
    calloutHints: [
      "Kid tip: think of a tree like a company org chart flipped upside "
          "down — the CEO (root) is on top, and the newest interns with "
          "nobody reporting to them (leaves) are at the bottom.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click its matching meaning on "
          "the right.",
      pairs: [
        MatchPair('root', 'Root', 'The one node at the top, with no parent'),
        MatchPair('leaf', 'Leaf', 'A node with no children'),
        MatchPair(
          'parent',
          'Parent',
          'A node with at least one child below it',
        ),
        MatchPair(
          'depth',
          'Depth',
          'How many steps down from the root a node sits',
        ),
      ],
      explainOk:
          "All matched! Root at the top, leaves at the bottom, parents "
          "connect them, and depth measures how far down you've gone.",
    ),
  ),
  const Chapter(
    id: 10,
    title: 'BST Insert',
    avatar: '➕',
    role: 'Narrator — planting a new node',
    bodyIntro:
        "In a binary search tree (BST), inserting a new value is like "
        "following a simple decision at every node: \"go left if smaller, "
        "go right if bigger.\"\n\n"
        "Here's our tree so far: root is 8, its left child is 3, and its "
        "right child is 10.\n\n"
        "Now let's insert 6. Start at the root: is 6 smaller than 8? Yes — "
        "go left, to node 3. Is 6 smaller than 3? No, 6 is bigger — go "
        "right from node 3. Node 3 has no right child yet, so 6 gets "
        "planted right there!\n\n"
        "Where does inserting 6 actually land?",
    calloutHints: [
      "Kid tip: a BST insert is just binary search's 'go left or go "
          "right' trick, except you're deciding where to PLANT a new node "
          "instead of where to FIND one.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In this BST (root = 8, left child = 3, right child = 10), where "
          "does inserting the value 6 end up?",
      options: [
        'As the left child of 8 (replacing 3)',
        'As the right child of node 3',
        'As the left child of node 10',
        'As the right child of node 10',
      ],
      answerIndex: 1,
      explainOk:
          "Correct! 6 < 8 sends you left to node 3, then 6 > 3 sends you "
          "right from node 3 — and since 3 has no right child yet, 6 is "
          "planted there.",
      explainBad:
          "Walk it step by step from the root: is 6 smaller or bigger than "
          "8? Then, at the node you land on, is 6 smaller or bigger than "
          "THAT node?",
    ),
  ),
  const Chapter(
    id: 11,
    title: 'BST Search Efficiency',
    avatar: '🔎',
    role: 'Narrator — timing a search',
    bodyIntro:
        "Why do programmers love balanced BSTs? Because searching one is "
        "dramatically faster than searching an unsorted list.\n\n"
        "In a balanced BST with height 3 (root at depth 0, then 3 more "
        "levels below it), the WORST case search only ever needs to check "
        "height + 1 = 4 nodes — because each step eliminates about half of "
        "the remaining nodes, just like binary search on a sorted array.\n\n"
        "Do the math on a slightly bigger tree.",
    calloutHints: [
      "Kid tip: a balanced BST with 15 nodes only needs about 4 "
          "comparisons to find anything — a plain unsorted list of 15 "
          "items could need to check all 15!",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A balanced BST has height 3 (the root is depth 0, and the "
          "deepest leaves are at depth 3). What is the maximum number of "
          "comparisons a search would ever need?",
      options: ['3', '4', '7', '15'],
      answerIndex: 1,
      explainOk:
          "Right — height 3 means at most 4 nodes on the path from root to "
          "the deepest leaf (depths 0,1,2,3), so at most 4 comparisons.",
      explainBad:
          "Count the levels from the root (depth 0) down to the deepest "
          "possible leaf (depth 3) — how many nodes total sit on that one "
          "path?",
    ),
  ),
  const Chapter(
    id: 12,
    title: 'Tree Traversals',
    avatar: '🚶',
    role: 'Narrator — walking the tree three ways',
    bodyIntro:
        "There are three classic ways to visit (\"traverse\") every node "
        "in a binary tree, and each one visits nodes in a different "
        "order:\n\n"
        "In-order (left, root, right) — visits values in SORTED order for "
        "a BST. This is the one people use most often.\n\n"
        "Pre-order (root, left, right) — visits the root first, useful for "
        "copying a tree's exact shape.\n\n"
        "Post-order (left, right, root) — visits the root LAST, useful for "
        "safely deleting a tree from the bottom up.\n\n"
        "Match each traversal to its visiting order.",
    calloutHints: [
      "Kid tip: \"in-order\" is named that way because for a BST, it "
          "happens to print every value IN sorted ORDER — smallest to "
          "largest, automatically!",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a traversal name on the left, then click its visiting "
          "order on the right.",
      pairs: [
        MatchPair('inorder', 'In-order', 'Left, then Root, then Right'),
        MatchPair('preorder', 'Pre-order', 'Root, then Left, then Right'),
        MatchPair('postorder', 'Post-order', 'Left, then Right, then Root'),
      ],
      explainOk:
          "All matched! In-order sorts a BST's values; pre-order visits "
          "the root first; post-order visits the root last.",
    ),
  ),
  const Chapter(
    id: 13,
    title: "What's a Heap?",
    avatar: '⛰️',
    role: 'Narrator — climbing a heap',
    bodyIntro:
        "A heap is a special tree shape with one strict rule about parents "
        "and children — but unlike a BST, it does NOT care about "
        "left-vs-right ordering.\n\n"
        "In a min-heap, every parent must be smaller than or equal to both "
        "of its children. That means the SMALLEST value in the whole tree "
        "is always sitting right at the root — no searching needed!\n\n"
        "A max-heap is the mirror image: every parent is bigger than or "
        "equal to its children, so the biggest value sits at the root.\n\n"
        "Quick check on the min-heap rule.",
    calloutHints: [
      "Kid tip: think of a min-heap like a family photo where every "
          "parent is shorter than their kids — the shortest person in the "
          "whole family always ends up at the very top.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In a MIN-heap, what must always be true about any parent node "
          "and its two children?",
      options: [
        'The parent must be smaller than or equal to both children',
        'The parent must be bigger than or equal to both children',
        'The left child must always be smaller than the right child',
        'There is no rule — any arrangement works',
      ],
      answerIndex: 0,
      explainOk:
          "Exactly! Parent \u2264 both children, everywhere in the tree, "
          "which guarantees the smallest value is always at the root.",
      explainBad:
          "Think about what 'min' in min-heap guarantees at the root — the "
          "smallest value has to bubble to the top, which means every "
          "parent must be \u2264 its children.",
    ),
  ),
  const Chapter(
    id: 14,
    title: 'The Heap Array Trick',
    avatar: '🧮',
    role: 'Narrator — storing a tree in a plain array',
    bodyIntro:
        "Here's a neat trick: heaps are almost always stored as a plain "
        "array, not as a tree with pointers! Because a heap is always "
        "\"full\" level by level, you can compute parent/child "
        "relationships with pure math on the index i:\n\n"
        "parent(i) = (i - 1) / 2\n"
        "left(i) = 2 * i + 1\n"
        "right(i) = 2 * i + 2\n\n"
        "No pointers, no wasted memory — just arithmetic! This is one "
        "reason heaps (used to build priority queues) are so fast and "
        "memory-efficient.\n\n"
        "Match each formula to what it finds.",
    calloutHints: [
      "Kid tip: index 0 is the root. Its children live at index 1 and 2. "
          "Node at index 1's children live at 3 and 4. The pattern always "
          "doubles!",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a formula on the left, then click what it finds on the "
          "right.",
      pairs: [
        MatchPair('parent', '(i - 1) / 2', "Index of node i's parent"),
        MatchPair('left', '2 * i + 1', "Index of node i's LEFT child"),
        MatchPair('right', '2 * i + 2', "Index of node i's RIGHT child"),
      ],
      explainOk:
          "All matched! These three formulas are all you need to navigate "
          "a heap stored as a plain array — no pointers required.",
    ),
  ),
  const Chapter(
    id: 15,
    title: 'Heapify Up (Insert)',
    avatar: '🫧',
    role: 'Narrator — bubbling a new value into place',
    bodyIntro:
        "Inserting into a heap always follows the same two-part dance:\n\n"
        "Drop the new value into the very next open slot at the end of the "
        "array.\n\n"
        "\"Bubble it up\": compare it to its parent, and if it breaks the "
        "heap rule, swap them. Keep bubbling up until it doesn't break the "
        "rule anymore (or it reaches the root).\n\n"
        "This bubbling process is called heapify-up, and in the worst case "
        "it only takes about log(n) swaps — because the heap's height "
        "grows so slowly as it fills up!\n\n"
        "Put the insert steps in the right order.",
    calloutHints: [
      "Kid tip: it's like a new kid joining a height-sorted line at the "
          "back, then politely swapping forward past anyone taller than "
          "them (min-heap) until they're in the right spot.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the steps of inserting a new value into a min-heap, in "
          "the order they actually happen.",
      items: [
        OrderItem('place', 'Place the new value in the next open slot at the end'),
        OrderItem('compare', 'Compare the new value to its parent'),
        OrderItem('swap', 'Swap with the parent if the new value is smaller'),
        OrderItem(
          'repeat',
          'Keep bubbling up until the rule holds or you reach the root',
        ),
      ],
      explainOk:
          "That's heapify-up! Place at the end, then keep "
          "comparing-and-swapping upward until the heap rule is satisfied.",
      explainBad:
          "The new value always starts at the END of the array first — "
          "only after that do the compare/swap/repeat steps begin.",
    ),
  ),
  const Chapter(
    id: 16,
    title: 'Priority Queue in Action',
    avatar: '🚑',
    role: 'Narrator — visiting the ER',
    bodyIntro:
        "A priority queue is a queue where the \"next\" item isn't the "
        "oldest one — it's the most URGENT one. Heaps are the classic way "
        "to build one, because the root is always the top-priority item!\n\n"
        "Picture a hospital ER using priority number 1 = most critical:\n\n"
        "Patient A — priority 1 (critical)\n\n"
        "Patient B — priority 3 (can wait a bit)\n\n"
        "Patient C — priority 2 (moderate)\n\n"
        "Even though B arrived before C, the ER treats patients by "
        "priority number, not arrival order — that's the whole point of a "
        "priority queue over a plain FIFO queue.\n\n"
        "Order the patients by treatment order.",
    calloutHints: [
      "Kid tip: a priority queue is why the most badly hurt patient gets "
          "seen first at a real ER, even if calmer patients have been "
          "waiting longer.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these three patients in the order the ER's priority "
          "queue would actually treat them (priority 1 = most urgent, "
          "treated first).",
      items: [
        OrderItem('a', 'Patient A — priority 1'),
        OrderItem('c', 'Patient C — priority 2'),
        OrderItem('b', 'Patient B — priority 3'),
      ],
      explainOk:
          "Right! Priority queues always serve the top-priority item next, "
          "no matter what order things arrived in — priority 1 beats "
          "priority 3, always.",
      explainBad:
          "Ignore arrival order completely — sort purely by priority "
          "NUMBER, smallest number (most urgent) first.",
    ),
  ),
  const Chapter(
    id: 17,
    title: 'Hash Functions',
    avatar: '🎲',
    role: 'Narrator — turning names into numbers',
    bodyIntro:
        "A hash table is a structure built for near-instant lookups by key "
        "— like looking up someone's phone number by their name instead of "
        "scanning a list.\n\n"
        "The magic ingredient is a hash function: a formula that takes a "
        "key (like the string \"Sam\") and turns it into a number — an "
        "array index called a bucket or slot. The same key always produces "
        "the same index, so you can jump straight there instead of "
        "searching!\n\n"
        "Match the hashing vocabulary.",
    calloutHints: [
      "Kid tip: think of a hash function like a rule that tells you "
          "exactly which drawer to look in for a name, instead of checking "
          "every drawer one by one.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click its matching meaning on "
          "the right.",
      pairs: [
        MatchPair(
          'hashfn',
          'Hash function',
          'A formula that turns a key into an array index',
        ),
        MatchPair('key', 'Key', 'The original piece of data, like a name or ID'),
        MatchPair(
          'bucket',
          'Bucket / slot',
          "The array position where a key's data ends up",
        ),
      ],
      explainOk:
          "All matched! A hash function maps a key to a bucket index, "
          "giving near-instant lookups.",
    ),
  ),
  const Chapter(
    id: 18,
    title: 'Collisions',
    avatar: '💥',
    role: 'Narrator — two keys, one slot',
    bodyIntro:
        "Hash tables have a fixed number of buckets, but there are usually "
        "WAY more possible keys than buckets. So sometimes, two different "
        "keys hash to the SAME index. That's called a collision.\n\n"
        "Say both \"Sam\" and \"Max\" hash to index 3. A well-built hash "
        "table doesn't lose either one — it has a plan (like keeping a "
        "small list at that index) so both can still be found later.\n\n"
        "What actually happens on a collision?",
    calloutHints: [
      "Kid tip: a collision is like two different letters both getting "
          "sorted into mailbox slot 3 — the mail carrier just keeps both "
          "letters together in that slot.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Both \"Sam\" and \"Max\" hash to index 3 in a hash table. What "
          "should a well-built hash table do?",
      options: [
        'Throw away whichever key arrived second',
        'Store both keys at index 3, e.g. by chaining them together in a small list',
        'Immediately crash the program',
        'Ignore the hash function and store both at index 0 instead',
      ],
      answerIndex: 1,
      explainOk:
          "Right! This is called a collision, and the standard fix is to "
          "keep BOTH items at that bucket, commonly using a small linked "
          "list (this is called 'chaining').",
      explainBad:
          "A good hash table never just throws data away — it keeps every "
          "colliding key at the same bucket, usually as a small list.",
    ),
  ),
  const Chapter(
    id: 19,
    title: 'Chaining vs Open Addressing',
    avatar: '🔗',
    role: 'Narrator — two ways to fix collisions',
    bodyIntro:
        "There are two classic strategies for handling collisions:\n\n"
        "Separate chaining — each bucket holds a small linked list. "
        "Colliding keys just get appended to that bucket's list.\n\n"
        "Open addressing (probing) — if a bucket is full, the table looks "
        "for the NEXT empty bucket nearby and puts the key there instead.\n\n"
        "Sort each description into the right strategy.",
    calloutHints: [
      "Kid tip: chaining is like a hotel room that can hold extra cots "
          "when it's \"full.\" Open addressing is like being told \"room 5 "
          "is full, try room 6\" at the front desk.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each description into the bucket for the collision "
          "strategy it describes.",
      bucketALabel: 'Separate Chaining',
      bucketBLabel: 'Open Addressing',
      items: [
        Sort2Item(
          'list',
          "Each bucket holds its own small linked list of items",
          true,
        ),
        Sort2Item(
          'probe',
          'A full bucket makes the table search for the next empty slot',
          false,
        ),
        Sort2Item(
          'append',
          "Colliding keys are simply appended to the same bucket's list",
          true,
        ),
        Sort2Item(
          'nextslot',
          'Data can end up stored in a DIFFERENT slot than its hash gave it',
          false,
        ),
      ],
      explainOk:
          "Sorted correctly! Chaining keeps a list per bucket; open "
          "addressing relocates the key to another slot entirely.",
      explainBad:
          "Chaining = extra items pile up IN the same bucket (as a list). "
          "Open addressing = the item MOVES to a different, empty bucket.",
    ),
  ),
  const Chapter(
    id: 20,
    title: 'Load Factor',
    avatar: '📊',
    role: 'Narrator — deciding when to grow',
    bodyIntro:
        "A hash table's load factor is how full it is:\n\n"
        "load factor = (number of items stored) / (number of buckets)\n\n"
        "The higher the load factor, the more collisions pile up, and the "
        "slower lookups get. Most hash tables automatically resize (grow "
        "bigger and re-hash everything) once the load factor crosses a "
        "threshold — commonly around 0.7.\n\n"
        "Do the math on this hash table.",
    calloutHints: [
      "Kid tip: a load factor near 1.0 is like a parking lot that's "
          "almost full — every new car takes longer to find a spot. A "
          "resize is like building a bigger lot.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A hash table has 15 items stored across 20 buckets. Its load "
          "factor is 15/20 = 0.75, above the common 0.7 resize threshold. "
          "What should happen next?",
      options: [
        'Nothing — 0.75 is perfectly fine forever',
        'The table should resize (grow) and re-hash all its items into more buckets',
        'The table should delete random items to make room',
        'The table should stop accepting any new items permanently',
      ],
      answerIndex: 1,
      explainOk:
          "Correct! Crossing the resize threshold triggers a grow-and-"
          "rehash, keeping lookups fast as the table keeps filling up.",
      explainBad:
          "A hash table doesn't delete data or freeze — once load factor "
          "crosses the threshold, it grows its bucket count and re-hashes "
          "everything.",
    ),
  ),
  const Chapter(
    id: 21,
    title: 'Graph Basics',
    avatar: '🕸️',
    role: 'Narrator — mapping connections',
    bodyIntro:
        "A graph is the most flexible structure yet: a bunch of vertices "
        "(dots, also called nodes) connected by edges (lines) — with no "
        "rule about parents, children, or order. Think city maps, friend "
        "networks, or flight routes.\n\n"
        "Computers usually store a graph one of two ways:\n\n"
        "Adjacency list — each vertex keeps a list of its direct "
        "neighbors. Efficient when most vertices only connect to a few "
        "others.\n\n"
        "Adjacency matrix — a big grid of 0s and 1s, where a 1 at row A, "
        "column B means \"A connects to B.\" Simple, but wastes memory on "
        "sparse graphs.\n\n"
        "Match the graph vocabulary.",
    calloutHints: [
      "Kid tip: think of a graph like an airline route map — cities are "
          "vertices, direct flights are edges, and there's no \"root\" "
          "city in charge.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click its matching meaning on "
          "the right.",
      pairs: [
        MatchPair('vertex', 'Vertex', 'A single node/dot in the graph'),
        MatchPair('edge', 'Edge', 'A connection between two vertices'),
        MatchPair(
          'adjlist',
          'Adjacency list',
          'Each vertex stores a list of its direct neighbors',
        ),
        MatchPair(
          'adjmatrix',
          'Adjacency matrix',
          'A grid of 0s/1s showing every possible connection',
        ),
      ],
      explainOk:
          "All matched! Vertices and edges are the building blocks; "
          "adjacency lists and matrices are just two ways to store them.",
    ),
  ),
  const Chapter(
    id: 22,
    title: 'Breadth-First Search (BFS)',
    avatar: '🌊',
    role: 'Narrator — spreading out in rings',
    bodyIntro:
        "BFS explores a graph one \"ring\" at a time — visiting everything "
        "1 step away before moving on to anything 2 steps away. This makes "
        "BFS the go-to algorithm for finding the shortest path in an "
        "unweighted graph!\n\n"
        "BFS is powered by a queue (FIFO): you enqueue the start node, "
        "then repeatedly dequeue a node, visit it, and enqueue all of its "
        "not-yet-visited neighbors.\n\n"
        "Put the BFS steps in the right order.",
    calloutHints: [
      "Kid tip: BFS spreads out exactly like ripples in a pond — the "
          "whole first ring finishes before the second ring even starts.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps of BFS in the order they actually happen.",
      items: [
        OrderItem('enqueueStart', 'Enqueue the starting node'),
        OrderItem('dequeueVisit', 'Dequeue a node and visit it'),
        OrderItem('enqueueNeighbors', 'Enqueue all of its unvisited neighbors'),
        OrderItem('repeat', 'Repeat until the queue is empty'),
      ],
      explainOk:
          "That's BFS! Start in the queue, dequeue-and-visit, enqueue "
          "fresh neighbors, repeat — always exploring ring by ring.",
      explainBad:
          "The queue always starts with just the start node — visiting "
          "and discovering neighbors only happens after that.",
    ),
  ),
  const Chapter(
    id: 23,
    title: 'Depth-First Search (DFS)',
    avatar: '🕳️',
    role: 'Narrator — diving down one path',
    bodyIntro:
        "DFS takes the opposite approach from BFS: it dives as deep as "
        "possible down ONE path before backtracking to try another. DFS "
        "is powered by a stack (or plain recursion, which secretly uses "
        "the call stack!).\n\n"
        "DFS is great for maze-solving, detecting cycles, and exploring "
        "every possible path — but it doesn't guarantee the SHORTEST path "
        "like BFS does.\n\n"
        "Put the DFS steps in the right order.",
    calloutHints: [
      "Kid tip: DFS is exactly like a maze-mouse — go as deep as you can, "
          "and only back up when you truly hit a dead end.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps of DFS in the order they actually happen.",
      items: [
        OrderItem('visitStart', 'Visit the starting node'),
        OrderItem('goDeeper', 'Move to an unvisited neighbor and go deeper'),
        OrderItem('deadEnd', 'Hit a node with no unvisited neighbors'),
        OrderItem(
          'backtrack',
          'Backtrack to the last node that still has unexplored options',
        ),
      ],
      explainOk:
          "That's DFS! Dive deep first, and only backtrack once you truly "
          "run out of new places to go.",
      explainBad:
          "DFS always goes as DEEP as it can first — backtracking only "
          "happens after hitting a genuine dead end.",
    ),
  ),
  const Chapter(
    id: 24,
    title: 'BFS vs DFS: Choosing the Right One',
    avatar: '🧭',
    role: 'Narrator — picking the right tool',
    bodyIntro:
        "BFS and DFS visit the same graph, but they're good at different "
        "jobs. Use the ring-vs-dive intuition to decide which one fits a "
        "task.\n\n"
        "Sort each scenario into the right bucket.",
    calloutHints: [
      "Kid tip: if the question has the word \"SHORTEST\" in it, think "
          "BFS. If it's about exploring everything or backtracking "
          "through choices, think DFS.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each scenario into the algorithm that fits it best.",
      bucketALabel: 'BFS',
      bucketBLabel: 'DFS',
      items: [
        Sort2Item(
          'shortestUnweighted',
          'Find the shortest route through an unweighted subway map',
          true,
        ),
        Sort2Item(
          'mazeExplore',
          'Explore a maze by going deep down one corridor before backtracking',
          false,
        ),
        Sort2Item(
          'levelByLevel',
          'Find everyone exactly 2 friends away from you in a social network',
          true,
        ),
        Sort2Item(
          'sudoku',
          'Try one possible Sudoku digit, and backtrack if it leads to a dead end',
          false,
        ),
      ],
      explainOk:
          "Exactly right! BFS shines at shortest-path and ring-by-ring "
          "problems; DFS shines at deep exploration and backtracking "
          "search.",
      explainBad:
          "Look for the word 'shortest' or 'levels away' (BFS) versus "
          "'explore deeply' or 'backtrack' (DFS).",
    ),
  ),
  const Chapter(
    id: 25,
    title: 'Why Balance Matters',
    avatar: '⚖️',
    role: 'Narrator — watching a tree tip over',
    bodyIntro:
        "Remember: a BST is only fast — O(log n) — if it stays roughly "
        "balanced (both sides about the same height). But what if you "
        "insert already-sorted values like 1, 2, 3, 4, 5 into a plain "
        "BST?\n\n"
        "Every new value is bigger than the last, so every one becomes the "
        "right child of the previous one. The \"tree\" becomes a straight "
        "line — secretly just a linked list! Now searching is back to "
        "O(n), no better than checking every item one by one.\n\n"
        "What actually happens to search time?",
    calloutHints: [
      "Kid tip: an unbalanced BST is like a game of guess-the-number "
          "where every answer is \"too low\" — you never get to skip half "
          "the range, you just crawl forward one at a time.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "If you insert 1, 2, 3, 4, 5 in that order into a plain BST, "
          "what happens to its search performance?",
      options: [
        'It stays a fast, balanced tree — O(log n) as always',
        'It becomes a straight line (basically a linked list), and search degrades to O(n)',
        'The BST automatically rejects sorted input',
        'Search becomes instant, O(1)',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly! Every new value only ever goes right, producing a "
          "lopsided line-shaped tree — search time falls all the way back "
          "to O(n).",
      explainBad:
          "Trace it: each new bigger value always goes to the right of "
          "the last one. What SHAPE does that make the tree?",
    ),
  ),
  const Chapter(
    id: 26,
    title: 'AVL Rotations (Concept)',
    avatar: '🔄',
    role: 'Narrator — fixing a lean',
    bodyIntro:
        "An AVL tree is a BST that automatically fixes itself whenever it "
        "starts leaning too far to one side, using its balance factor: the "
        "height of the left subtree minus the height of the right "
        "subtree. If that number ever becomes \u00b12, the tree performs a "
        "rotation to rebalance.\n\n"
        "Left rotation — fixes a tree that's leaning too heavily to the "
        "RIGHT\n\n"
        "Right rotation — fixes a tree that's leaning too heavily to the "
        "LEFT\n\n"
        "Match the AVL vocabulary.",
    calloutHints: [
      "Kid tip: rotations don't change WHICH values are in the tree — "
          "they just reshuffle the shape, like rearranging boxes on a "
          "shelf without removing any of them.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click its matching meaning on "
          "the right.",
      pairs: [
        MatchPair(
          'bf',
          'Balance factor',
          'Left subtree height minus right subtree height',
        ),
        MatchPair('leftrot', 'Left rotation', 'Fixes a tree leaning too heavily right'),
        MatchPair('rightrot', 'Right rotation', 'Fixes a tree leaning too heavily left'),
      ],
      explainOk:
          "All matched! Balance factor detects the lean, and the "
          "opposite-direction rotation fixes it.",
    ),
  ),
  const Chapter(
    id: 27,
    title: 'Red-Black Trees (Concept)',
    avatar: '🔴',
    role: 'Narrator — painting nodes',
    bodyIntro:
        "A red-black tree is another self-balancing BST — used inside "
        "many real programming language libraries (like C++'s map and "
        "Java's TreeMap). Instead of exact heights, it colors every node "
        "red or black and enforces simple coloring rules, such as:\n\n"
        "The root is always black\n\n"
        "A red node can never have a red child (no two reds in a row)\n\n"
        "Every path from root to an empty spot passes the same number of "
        "black nodes\n\n"
        "These rules guarantee the tree can never get more than about "
        "twice as tall as a perfectly balanced tree — keeping operations "
        "at O(log n).\n\n"
        "Spot the real rule.",
    calloutHints: [
      "Kid tip: think of the color rules like a traffic law: \"no two red "
          "lights in a row\" keeps the whole road (tree) from getting too "
          "chaotic (unbalanced).",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which of these is an actual red-black tree rule?",
      options: [
        'A red node can never have a red child',
        'Every node must have exactly two children',
        'The tree must always be a perfect triangle shape',
        'Black nodes are only allowed at the leaves',
      ],
      answerIndex: 0,
      explainOk:
          "Correct! 'No red node has a red child' is one of the real "
          "rules that keeps the tree from becoming too unbalanced.",
      explainBad:
          "Red-black rules are about COLOR patterns (like 'no two reds in "
          "a row'), not about forcing every node to have exactly two "
          "children.",
    ),
  ),
  const Chapter(
    id: 28,
    title: 'Tries for Prefix Search',
    avatar: '🔡',
    role: 'Narrator — building an autocomplete tree',
    bodyIntro:
        "A trie (pronounced \"try\") is a tree built specifically for "
        "storing words letter by letter — perfect for autocomplete and "
        "spell-check.\n\n"
        "Each node represents ONE character. Words that share the same "
        "starting letters literally share the same path down the trie. "
        "For example, \"CAT\" and \"CAR\" share the path C -> A, then split "
        "into T and R.\n\n"
        "To autocomplete a prefix like \"CA\", you just walk down the trie "
        "following C then A, and collect every word reachable from "
        "there.\n\n"
        "Match the trie vocabulary.",
    calloutHints: [
      "Kid tip: a trie is like a dictionary where every shared prefix "
          "(\"CA...\") only gets written ONCE, and all the different "
          "endings branch off from that single spot.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click its matching meaning on "
          "the right.",
      pairs: [
        MatchPair('trienode', 'Trie node', 'Represents one character position'),
        MatchPair(
          'sharedprefix',
          'Prefix sharing',
          'Words starting the same way share the same path',
        ),
        MatchPair(
          'autocomplete',
          'Autocomplete',
          'Walk down from a prefix and collect every reachable word',
        ),
      ],
      explainOk:
          "All matched! That prefix-sharing is exactly what makes tries "
          "so fast for autocomplete and spell-check.",
    ),
  ),
  const Chapter(
    id: 29,
    title: 'Insertion Sort',
    avatar: '🃏',
    role: 'Narrator — sorting a hand of cards',
    bodyIntro:
        "Insertion sort works exactly like sorting playing cards in your "
        "hand: take the next unsorted card, and slide it backward into "
        "its correct spot among the already-sorted cards.\n\n"
        "Trace it on [5, 2, 4]:\n\n"
        "Start: [5, 2, 4]\n"
        "Insert 2: [2, 5, 4] (2 slides left past 5)\n"
        "Insert 4: [2, 4, 5] (4 slides left past 5, stops before 2)\n\n"
        "Order the states of the array as it sorts.",
    calloutHints: [
      "Kid tip: insertion sort is great for small or nearly-sorted lists "
          "— it's literally how most people sort a hand of cards in real "
          "life.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these array states in the order insertion sort "
          "produces them while sorting [5, 2, 4].",
      items: [
        OrderItem('start', '[5, 2, 4]  (starting array)'),
        OrderItem('after2', '[2, 5, 4]  (after inserting 2)'),
        OrderItem('after4', '[2, 4, 5]  (after inserting 4 — fully sorted)'),
      ],
      explainOk:
          "That's insertion sort! Each new element slides backward into "
          "its correct sorted position, one at a time.",
      explainBad:
          "Insertion sort processes elements left to right — the starting "
          "array comes first, then each element gets slid into place in "
          "turn.",
    ),
  ),
  const Chapter(
    id: 30,
    title: 'Merge Sort',
    avatar: '✂️',
    role: 'Narrator — splitting and stitching',
    bodyIntro:
        "Merge sort uses a \"divide and conquer\" strategy — it keeps "
        "splitting the array in half until each piece has just 1 element "
        "(which is already \"sorted\" by definition), then carefully "
        "merges pairs of sorted pieces back together in order.\n\n"
        "This gives merge sort a reliable O(n log n) runtime, even in the "
        "worst case — much better than insertion sort's O(n\u00b2) on big "
        "lists.\n\n"
        "Order the conceptual steps of merge sort.",
    calloutHints: [
      "Kid tip: think of merge sort like tearing a deck of cards into "
          "single cards, then re-merging pairs together in sorted order, "
          "over and over, until it's one full sorted deck.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the high-level steps of merge sort in the order they "
          "happen.",
      items: [
        OrderItem('split', 'Split the array in half'),
        OrderItem(
          'recurse',
          'Keep splitting each half, recursively, down to single elements',
        ),
        OrderItem(
          'mergePairs',
          'Merge pairs of sorted pieces back together, in order',
        ),
        OrderItem(
          'done',
          'Keep merging bigger and bigger pieces until one sorted array remains',
        ),
      ],
      explainOk:
          "That's divide and conquer! Split all the way down, then merge "
          "all the way back up in sorted order.",
      explainBad:
          "You have to finish splitting ALL the way down to single "
          "elements before any merging can begin.",
    ),
  ),
  const Chapter(
    id: 31,
    title: 'Quicksort & the Pivot',
    avatar: '🎯',
    role: 'Narrator — picking a pivot',
    bodyIntro:
        "Quicksort picks one element as the pivot, then rearranges "
        "(partitions) the array so everything smaller than the pivot ends "
        "up on its left, and everything bigger ends up on its right. Then "
        "it recursively quicksorts each side.\n\n"
        "Trace a partition on [6, 2, 8, 1] using the LAST element, 1, as "
        "the pivot: everything must be compared to 1. Since 6, 2, and 8 "
        "are all bigger than 1, they ALL end up on the right of the "
        "pivot.\n\n"
        "What does this partition step produce?",
    calloutHints: [
      "Kid tip: quicksort's speed depends heavily on picking a good pivot "
          "— a bad pivot (like always picking the smallest value) can "
          "make it slow, closer to O(n\u00b2).",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Partitioning [6, 2, 8, 1] using 1 (the last element) as the "
          "pivot — where does everything end up?",
      options: [
        '1 ends up first, with 6, 2, 8 all after it (in some order) since they are all bigger',
        '1 ends up last, since it is the smallest',
        'The array does not change at all',
        'Everything gets sorted immediately in one step',
      ],
      answerIndex: 0,
      explainOk:
          "Right! Since every other value is bigger than the pivot (1), "
          "they all land on its right — the pivot itself lands first.",
      explainBad:
          "Compare every other value to the pivot (1). Since 6, 2, and 8 "
          "are ALL bigger than 1, where must they all end up relative to "
          "the pivot?",
    ),
  ),
  const Chapter(
    id: 32,
    title: 'Big-O Showdown',
    avatar: '🏁',
    role: 'Narrator — racing the algorithms',
    bodyIntro:
        "Let's line up everything we've learned by its Big-O complexity — "
        "the language programmers use to describe how an algorithm's "
        "runtime grows as the input gets bigger.\n\n"
        "Match each operation to its typical Big-O complexity.",
    calloutHints: [
      "Kid tip: O(n\u00b2) algorithms (like bubble/insertion sort on big "
          "lists) get MUCH slower as input grows; O(log n) algorithms "
          "(like binary search) barely slow down at all.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click an operation on the left, then click its typical Big-O "
          "complexity on the right.",
      pairs: [
        MatchPair('insertionWorst', 'Insertion sort on a big list', 'O(n\u00b2)'),
        MatchPair('mergeSort', 'Merge sort', 'O(n log n)'),
        MatchPair('binarySearch', 'Binary search on a sorted array', 'O(log n)'),
        MatchPair(
          'checkAll',
          'Checking every element once (like a linear scan)',
          'O(n)',
        ),
      ],
      explainOk:
          "All matched! O(log n) is fastest for large inputs, then O(n), "
          "then O(n log n), then O(n\u00b2) is slowest of these.",
    ),
  ),
  const Chapter(
    id: 33,
    title: 'Weighted Graphs',
    avatar: '⚖️',
    role: 'Narrator — adding costs to edges',
    bodyIntro:
        "So far our graph edges just meant \"connected.\" A weighted graph "
        "attaches a number (cost, distance, time) to every edge — like "
        "real road distances between cities on a map.\n\n"
        "The famous Dijkstra's algorithm finds the shortest TOTAL distance "
        "from one starting node to every other node in a weighted graph "
        "(as long as no weights are negative).\n\n"
        "Its key move is called relaxation: whenever you find a shorter "
        "path to a node than what you'd previously recorded, you update "
        "(\"relax\") its distance to the shorter value.\n\n"
        "Match the weighted-graph vocabulary.",
    calloutHints: [
      "Kid tip: Dijkstra's algorithm is basically a GPS app's "
          "shortest-route finder — roads are weighted edges, and it keeps "
          "updating \"fastest known route\" as it explores.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a term on the left, then click its matching meaning on "
          "the right.",
      pairs: [
        MatchPair(
          'weightededge',
          'Weighted edge',
          'A connection with a cost or distance attached',
        ),
        MatchPair(
          'dijkstragoal',
          "Dijkstra's goal",
          'Find the shortest distance from start to every other node',
        ),
        MatchPair(
          'relax',
          'Relaxation',
          "Updating a node's distance when a shorter path is found",
        ),
      ],
      explainOk:
          "All matched! Weighted edges carry cost, and Dijkstra "
          "repeatedly relaxes distances until every shortest path is "
          "found.",
    ),
  ),
  const Chapter(
    id: 34,
    title: "Dijkstra's Algorithm Trace",
    avatar: '🧮',
    role: 'Narrator — walking through the algorithm',
    bodyIntro:
        "Let's trace Dijkstra's algorithm's actual loop, step by step, so "
        "you could run it by hand on a small map.\n\n"
        "Order the steps of the algorithm's main loop.",
    calloutHints: [
      "Kid tip: Dijkstra always greedily locks in the CLOSEST unvisited "
          "node next — it never has to \"undo\" a decision once a node is "
          "marked visited.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these steps of Dijkstra's algorithm in the order they "
          "happen.",
      items: [
        OrderItem(
          'init',
          "Set start node's distance to 0, and every other node's distance to infinity",
        ),
        OrderItem('pick', 'Pick the unvisited node with the smallest known distance'),
        OrderItem('relaxStep', 'Relax (possibly update) the distances of its neighbors'),
        OrderItem(
          'markVisited',
          'Mark that node visited, then repeat until all nodes are visited',
        ),
      ],
      explainOk:
          "That's the loop! Initialize distances, always expand the "
          "closest unvisited node, relax its neighbors, mark it done, "
          "repeat.",
      explainBad:
          "Every node needs a starting distance BEFORE any picking or "
          "relaxing can happen — start there.",
    ),
  ),
  const Chapter(
    id: 35,
    title: 'Minimum Spanning Tree',
    avatar: '🌉',
    role: 'Narrator — connecting everything cheaply',
    bodyIntro:
        "A Minimum Spanning Tree (MST) solves a different problem than "
        "Dijkstra: instead of shortest paths FROM one node, it finds the "
        "cheapest way to connect every node to every other node, using "
        "the least total edge weight possible, with absolutely no "
        "cycles.\n\n"
        "Think of it like designing the cheapest possible road network "
        "that still lets you drive from any town to any other town — no "
        "unnecessary extra roads.\n\n"
        "What is the MST's actual goal?",
    calloutHints: [
      "Kid tip: an MST is exactly the problem an electric company solves "
          "when wiring up a new neighborhood as cheaply as possible while "
          "still reaching every house.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What does a Minimum Spanning Tree algorithm actually try to "
          "achieve?",
      options: [
        'Find the shortest path between two specific nodes',
        'Connect every node together using the minimum total edge weight, with no cycles',
        'Visit every node exactly once and return to the start',
        'Find the single most expensive edge in the graph',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly! MST connects the whole graph as cheaply as possible "
          "while staying cycle-free — a totally different goal from "
          "shortest-path.",
      explainBad:
          "MST isn't about two specific nodes — it's about connecting ALL "
          "of them together for the lowest possible total cost.",
    ),
  ),
  const Chapter(
    id: 36,
    title: "Kruskal's Algorithm Trace",
    avatar: '📏',
    role: 'Narrator — grabbing the cheapest edges first',
    bodyIntro:
        "Kruskal's algorithm builds an MST with a beautifully simple "
        "greedy strategy: always consider the cheapest remaining edge "
        "first.\n\n"
        "Order Kruskal's steps.",
    calloutHints: [
      "Kid tip: Kruskal's only rule for skipping an edge is \"would this "
          "create a cycle?\" — if yes, skip it and move to the next "
          "cheapest edge instead.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these steps of Kruskal's algorithm in the order they "
          "happen.",
      items: [
        OrderItem('sortEdges', 'Sort all edges by weight, smallest to largest'),
        OrderItem('pickSmallest', 'Consider the smallest remaining edge'),
        OrderItem(
          'checkCycle',
          'Add it if it does not create a cycle; skip it if it does',
        ),
        OrderItem('repeatUntilDone', 'Repeat until every node is connected'),
      ],
      explainOk:
          "That's Kruskal's! Sort by weight first, then greedily add the "
          "cheapest edge that doesn't form a cycle, over and over.",
      explainBad:
          "Nothing can be picked before the edges are sorted by weight "
          "first — sorting always comes first.",
    ),
  ),
  const Chapter(
    id: 37,
    title: 'Choose the Right Structure',
    avatar: '🧑‍💼',
    role: 'Narrator — a real engineering decision',
    bodyIntro:
        "Professional Knowledge Check time. In real systems, picking the "
        "wrong data structure can make software thousands of times "
        "slower. Let's practice the decision-making, not just the "
        "vocabulary.\n\n"
        "Make the call on this scenario.",
    calloutHints: [
      "Real interview framing: always ask \"what operation happens most "
          "often, and what's its Big-O cost in each candidate structure?\" "
          "before choosing.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "You need to look up a user's profile by their exact unique "
          "username, millions of times per second, with no need to keep "
          "any particular order. Which structure gives the best average "
          "lookup performance?",
      options: [
        'An unsorted array, scanned from the start every time',
        'A hash table, keyed by username',
        'A linked list, searched from the head every time',
        'A binary search tree sorted by signup date',
      ],
      answerIndex: 1,
      explainOk:
          "Correct! Exact-match lookups with no ordering requirement are "
          "the textbook case for a hash table — O(1) average lookup by "
          "key.",
      explainBad:
          "You don't need any ORDER here, just exact-match lookups — that "
          "points straight at a hash table's O(1) average case.",
    ),
  ),
  const Chapter(
    id: 38,
    title: 'Complexity Tradeoff Audit',
    avatar: '📋',
    role: 'Narrator — auditing real tradeoffs',
    bodyIntro:
        "Every structure trades speed in one operation for slowness in "
        "another. A professional needs to know these tradeoffs cold.\n\n"
        "Match each operation to its typical average-case complexity in "
        "the structure named.",
    calloutHints: [
      "Real interview tip: \"it depends on the operation\" is often the "
          "right answer — the same data might live in a different "
          "structure depending on what you do with it most.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click an operation on the left, then click its typical "
          "average-case Big-O on the right.",
      pairs: [
        MatchPair('arrayIndex', 'Get element by index — Array', 'O(1)'),
        MatchPair('frontInsertArray', 'Insert at the FRONT of a big array', 'O(n)'),
        MatchPair(
          'bstSearch',
          'Search — balanced Binary Search Tree',
          'O(log n)',
        ),
        MatchPair(
          'hashSearch',
          'Search — Hash Table (few collisions)',
          'O(1)',
        ),
      ],
      explainOk:
          "All matched! This is exactly the kind of tradeoff table a "
          "professional keeps in their head when choosing a structure.",
    ),
  ),
  const Chapter(
    id: 39,
    title: 'Spot the Bug',
    avatar: '🐛',
    role: 'Narrator — debugging like a professional',
    bodyIntro:
        "A junior engineer wrote this binary search and it sometimes "
        "loops forever. Read it carefully:\n\n"
        "low = 0, high = length - 1\n"
        "while low <= high:\n"
        "    mid = (low + high) / 2\n"
        "    if array[mid] == target: return mid\n"
        "    if array[mid] < target: low = mid       // bug is here\n"
        "    else: high = mid - 1\n\n"
        "Notice the line marked with the bug: when the target is bigger "
        "than array[mid], the code sets low = mid instead of low = mid + "
        "1. If mid ever equals low again on the next loop, the range "
        "never shrinks — infinite loop!\n\n"
        "What's the correct fix?",
    calloutHints: [
      "Real interview tip: off-by-one bugs in binary search almost "
          "always hide in exactly this spot — forgetting to move a "
          "boundary PAST the midpoint you just ruled out.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What is the correct fix for the buggy line \"low = mid\" (when "
          "array[mid] < target)?",
      options: [
        'Change it to low = mid + 1, so the range always shrinks',
        'Change it to low = mid - 1',
        'Delete the whole while loop',
        'Change high = mid - 1 to high = mid instead',
      ],
      answerIndex: 0,
      explainOk:
          "Correct! Once array[mid] is ruled out as too small, the new "
          "low must move PAST it — low = mid + 1 — or the search range "
          "can stop shrinking forever.",
      explainBad:
          "The problem is the range not shrinking. Since array[mid] has "
          "already been ruled out as too small, the new low boundary must "
          "move to mid + 1, not stay at mid.",
    ),
  ),
  const Chapter(
    id: 40,
    title: 'Professional Certification: Data Structures',
    avatar: '🏆',
    role: 'Narrator — the final challenge of Structure Springs',
    bodyIntro:
        "Final challenge! Let's combine everything into one real system "
        "design idea used constantly in production software: the LRU "
        "(Least Recently Used) cache — used in browsers, databases, and "
        "operating systems to keep the most useful data close at hand and "
        "evict the rest.\n\n"
        "An LRU cache is a clever COMBINATION of two structures you "
        "already know:\n\n"
        "A hash map — gives O(1) lookup: \"does this key exist, and "
        "where's its node?\"\n\n"
        "A doubly linked list — keeps items ordered from "
        "most-recently-used (front) to least-recently-used (back), "
        "allowing O(1) move-to-front on access and O(1) eviction from the "
        "back when the cache is full\n\n"
        "Match each LRU cache piece to the job it does.",
    calloutHints: [
      "This is the whole point of Structure Springs: real, professional "
          "systems are usually built by COMBINING simple structures, each "
          "covering the other's weakness.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a component on the left, then click the job it does on "
          "the right.",
      pairs: [
        MatchPair('hashmap', 'Hash map', "O(1) lookup of a key's node location"),
        MatchPair(
          'dll',
          'Doubly linked list',
          'Keeps most-to-least recently used order, O(1) move-to-front',
        ),
        MatchPair(
          'evict',
          'Eviction on a full cache',
          'Remove the node at the BACK of the linked list',
        ),
        MatchPair(
          'onaccess',
          'On every cache hit',
          'Move that node to the FRONT of the linked list',
        ),
      ],
      explainOk:
          "You've built an LRU cache! Hash map for instant lookup, "
          "doubly linked list for instant reordering — Structure Springs' "
          "Shard is yours.",
    ),
  ),
  const Chapter(
    id: 41,
    title: 'LSM-Trees vs B-Trees: Choosing a Storage Engine',
    avatar: '🗄️',
    role: 'Narrator — touring a database engine room',
    bodyIntro:
        "Past the certification gate, the ground shakes — I've rolled "
        "into the Deployment Frontier, where every structure has to "
        "survive real production traffic, real disks, and real 3am "
        "pages. First stop: the engine room of a database, where two "
        "storage-engine designs quietly decide how fast your writes and "
        "reads really are.\n\n"
        "A B-tree storage engine (classic Postgres/MySQL InnoDB) keeps "
        "data sorted in place on disk, in fixed-size pages. Updating a "
        "row means finding its exact page and mutating it — great for "
        "reads (one predictable tree walk), but every write can trigger "
        "random-access disk I/O and page splits.\n\n"
        "An LSM-tree (Log-Structured Merge-tree — Cassandra, RocksDB, "
        "LevelDB) never mutates data in place. Writes go into an "
        "in-memory memtable, then get flushed as immutable, sorted "
        "SSTables on disk. Old SSTables are later merged (\"compacted\") "
        "in the background. Writes become pure sequential appends — fast "
        "— but reads may have to check the memtable AND several SSTables, "
        "and background compaction costs extra disk I/O later.\n\n"
        "Write amplification — how many extra bytes get written to disk "
        "per logical write (B-trees: page rewrites; LSM-trees: compaction "
        "rewrites)\n\n"
        "Read amplification — how many places must be checked to answer "
        "one read (B-trees: one path; LSM-trees: memtable + N SSTables, "
        "mitigated with Bloom filters)\n\n"
        "Sort each trait into the storage engine it actually describes.",
    calloutHints: [
      "Real production framing: write-heavy workloads (metrics, logs, "
          "time-series) tend to favor LSM-trees; read-heavy workloads with "
          "lots of updates in place tend to favor B-trees. Postgres and "
          "Cassandra made genuinely different bets here on purpose.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each trait into the storage engine design it describes.",
      bucketALabel: 'B-Tree',
      bucketBLabel: 'LSM-Tree',
      items: [
        Sort2Item(
          'inplace',
          'Updates mutate the exact on-disk page in place',
          true,
        ),
        Sort2Item(
          'memtable',
          'Writes land first in an in-memory memtable, then flush to disk',
          false,
        ),
        Sort2Item(
          'sstable',
          'Disk data lives in immutable, sorted SSTables merged by compaction',
          false,
        ),
        Sort2Item(
          'onepath',
          'A read typically walks one predictable path from root to leaf',
          true,
        ),
      ],
      explainOk:
          "Exactly right! B-trees optimize for in-place, predictable "
          "reads; LSM-trees optimize for sequential, append-only writes "
          "and pay for it later with compaction.",
      explainBad:
          "In-place page mutation and single-path reads are B-tree "
          "behavior. Memtables, immutable SSTables, and background "
          "compaction are LSM-tree behavior.",
    ),
  ),
  const Chapter(
    id: 42,
    title: 'Persistent Data Structures: Immutability for Safe Concurrency',
    avatar: '🪞',
    role: 'Narrator — watching a tree that never changes',
    bodyIntro:
        "Next up: a strange tree that never seems to change, no matter "
        "how many times I \"edit\" it. That's a persistent data structure "
        "— every \"update\" produces a brand-new version while the old "
        "version stays completely intact and valid.\n\n"
        "The trick that makes this affordable is structural sharing (also "
        "called path copying). To \"change\" one leaf in a tree, you don't "
        "copy the WHOLE tree — you copy only the nodes on the path from "
        "that leaf up to the root, and every other subtree is simply "
        "shared (by reference) between the old and new versions.\n\n"
        "Because old versions are never mutated, multiple threads can "
        "read old versions forever without locks — there's nothing to "
        "race on. This is exactly how Clojure's persistent vectors, "
        "Git's commit trees, and much of React/Redux's state model stay "
        "safe under concurrency.\n\n"
        "What actually happens when you \"update\" a persistent tree?",
    calloutHints: [
      "Kid-simple but production-real: if nothing is ever mutated, "
          "there's no \"two threads changed it at the same time\" bug to "
          "even have. That's why persistent structures are a go-to tool "
          "for lock-free concurrent reads.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "You 'update' one leaf in a persistent (immutable) tree with "
          "1,000 nodes. What actually happens under the hood?",
      options: [
        'The entire 1,000-node tree is deep-copied',
        'The old tree is destroyed and mutated in place',
        'Only the nodes on the path from that leaf to the root are copied; everything else is shared with the old version',
        'Nothing is copied — the change is invisible to old readers',
      ],
      answerIndex: 2,
      explainOk:
          "Right! Structural sharing means only the path to the root "
          "gets new nodes — old readers keep seeing the untouched "
          "original tree, cheaply.",
      explainBad:
          "Persistent structures don't deep-copy everything, and they "
          "never mutate the old version either — only the path from the "
          "changed leaf up to the root gets copied; the rest is shared.",
    ),
  ),
  const Chapter(
    id: 43,
    title: 'Memory Layout: Arrays-of-Structs vs Structs-of-Arrays',
    avatar: '🧊',
    role: "Narrator — inspecting the CPU's cache lines",
    bodyIntro:
        "Zooming in close, I can see the CPU pulling memory in small "
        "fixed-size chunks called cache lines (commonly 64 bytes). If the "
        "data you need next is already sitting in the same cache line as "
        "data you just touched, it's basically free. If it isn't, you "
        "pay a real latency cost. That's spatial locality, and it's why "
        "HOW you lay out data in memory can matter as much as which "
        "structure you pick.\n\n"
        "Say you have a million particles, each with position, velocity, "
        "and color. Two layouts: Array-of-Structs (AoS) packs one record "
        "per particle together; Struct-of-Arrays (SoA) keeps a separate "
        "array per field.\n\n"
        "AoS is great when you usually need the WHOLE record at once "
        "(read pos+vel+color for one particle together — one cache line, "
        "one trip). SoA is great when you usually scan just ONE field "
        "across MANY records (update every particle's position only) — a "
        "tight, cache-friendly, SIMD-friendly scan with zero wasted bytes "
        "from unrelated fields. This is exactly why columnar databases "
        "(like Snowflake, Parquet) store tables column-by-column instead "
        "of row-by-row.\n\n"
        "Sort each access pattern into the layout that fits it best.",
    calloutHints: [
      "Real production framing: the \"right\" structure isn't just about "
          "Big-O — for hot loops, memory layout can be the difference "
          "between a function that's fast and one that's 5-10x slower, "
          "with the exact same algorithm.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each access pattern into the memory layout that serves it best.",
      bucketALabel: 'Array-of-Structs (AoS)',
      bucketBLabel: 'Struct-of-Arrays (SoA)',
      items: [
        Sort2Item(
          'wholeRecord',
          'Loading one full user profile (all its fields) at a time',
          true,
        ),
        Sort2Item(
          'onlyPositions',
          'Updating only the position field for a million particles',
          false,
        ),
        Sort2Item(
          'columnarDb',
          'A columnar analytics database scanning just one column',
          false,
        ),
        Sort2Item(
          'gameEntity',
          "Fetching one game entity's full state to render it",
          true,
        ),
      ],
      explainOk:
          "Exactly! Whole-record access favors AoS; single-field scans "
          "across many records favor SoA — the same data, laid out for "
          "the access pattern that actually happens.",
      explainBad:
          "Ask: does this operation need ALL the fields of ONE record "
          "(AoS), or just ONE field across MANY records (SoA)?",
    ),
  ),
  const Chapter(
    id: 44,
    title: 'The Write-Ahead Log: Durability Before Speed',
    avatar: '📜',
    role: "Narrator — watching a scroll that's written before anything else",
    bodyIntro:
        "Before any database touches its real data files, it writes to a "
        "humble structure first: the write-ahead log (WAL) — a strictly "
        "append-only sequence of \"I'm about to do this\" records, flushed "
        "to disk (fsync) before the actual change is considered durable.\n\n"
        "Why bother? Because a crash mid-write to the real data files "
        "could leave them corrupted or half-updated. But a crash "
        "mid-append to a simple, sequential log is easy to recover from: "
        "on restart, the database just replays the log from the last "
        "known-good point forward.\n\n"
        "1. Client asks to update row X\n"
        "2. Append \"update row X\" to the WAL, fsync to disk — durable "
        "now\n"
        "3. Apply the update to the actual data pages in memory/disk\n"
        "4. Acknowledge success to the client\n\n"
        "This same append-only-log idea shows up everywhere: Postgres's "
        "WAL, MySQL's redo log, and — at a much bigger scale — Kafka's "
        "entire storage model is basically a giant, partitioned "
        "write-ahead log that other services read from.\n\n"
        "Put the WAL commit steps in the actual order they happen.",
    calloutHints: [
      "Kid-simple but production-real: a WAL trades a LITTLE extra work "
          "(write twice: once to the log, once to the real data) for a "
          "guarantee that a crash can never silently lose or corrupt a "
          "committed change — the log always tells the truth about what "
          "happened.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these steps of a durable write using a write-ahead "
          "log, in the order they actually happen.",
      items: [
        OrderItem('receive', 'Receive a request to change some data'),
        OrderItem(
          'appendWal',
          'Append the intended change to the write-ahead log and fsync it to disk',
        ),
        OrderItem('applyData', 'Apply the change to the actual data structures/pages'),
        OrderItem('ack', 'Acknowledge success to the client'),
      ],
      explainOk:
          "That's the WAL protocol! The log is written and fsynced "
          "BEFORE the real data is touched, so a crash can always be "
          "recovered by replaying it.",
      explainBad:
          "The log entry must be durably written BEFORE the real data "
          "pages are touched — that's the entire point of "
          "'write-ahead'.",
    ),
  ),
  const Chapter(
    id: 45,
    title: 'Skip Lists: Probabilistic Balance for Scaling Ordered Sets',
    avatar: '🪜',
    role: 'Narrator — crossing a ladder of shortcuts',
    bodyIntro:
        "The ground turns to sand — I've entered the Scaling Wastes, "
        "where the question is never \"does it work?\" but \"does it "
        "still work at 100 million items?\" First up: skip lists, the "
        "structure behind Redis's sorted sets (ZSET).\n\n"
        "A skip list is a linked list with EXTRA \"express lane\" links "
        "layered on top. Level 0 has every element; level 1 has roughly "
        "every 2nd element as a shortcut; level 2 has roughly every 4th; "
        "and so on, decided randomly at insert time (a coin flip per "
        "level).\n\n"
        "Searching starts at the top level and only drops down a level "
        "when the next express-lane node would overshoot the target — "
        "skipping huge chunks of the list for free. This gives skip "
        "lists expected O(log n) search, insert, and delete — matching a "
        "balanced BST — but with NO rotations and a much simpler, highly "
        "concurrent-friendly implementation.\n\n"
        "Why does a skip list avoid needing rotations?",
    calloutHints: [
      "Real production framing: skip lists trade a guaranteed worst case "
          "(like AVL/red-black trees have) for a probabilistic one that's "
          "almost always just as good AND far easier to make lock-free — "
          "exactly why Redis picked them for ZSET instead of a balanced "
          "tree.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Balanced BSTs (AVL, red-black) need rotations to stay balanced "
          "after every insert. Why doesn't a skip list need anything like "
          "that?",
      options: [
        'Skip lists never allow inserts after creation',
        'Skip list levels are assigned randomly per node, so no rebalancing step is needed — the express lanes just average out to be useful',
        'Skip lists are always kept in a single level, so there is nothing to balance',
        'Skip lists secretly convert to an array after every insert',
      ],
      answerIndex: 1,
      explainOk:
          "Right! Randomized level assignment means the structure "
          "self-balances on average — no explicit rebalancing/rotation "
          "step is ever needed.",
      explainBad:
          "The key idea is randomness: each node's number of 'express "
          "lane' levels is picked randomly, so the whole structure stays "
          "roughly balanced on average without any explicit fix-up step.",
    ),
  ),
  const Chapter(
    id: 46,
    title: 'Sharding & Consistent Hashing',
    avatar: '🌐',
    role: 'Narrator — splitting one big table into many',
    bodyIntro:
        "A single machine's hash table eventually runs out of RAM. The "
        "fix: sharding — split your data across many machines, each "
        "holding a slice (\"shard\"). But how do you decide WHICH machine "
        "owns which key, in a way that survives machines being added or "
        "removed?\n\n"
        "The naive approach, hash(key) % N, is a trap: if N (the number "
        "of machines) changes, almost EVERY key's target machine changes "
        "too — a full, painful data reshuffle.\n\n"
        "Consistent hashing fixes this: imagine a circular number line (a "
        "\"hash ring\") from 0 to some max value. Both keys AND machines "
        "get hashed onto this same ring. Each key belongs to the first "
        "machine found walking clockwise from the key's position. Adding "
        "or removing ONE machine only reshuffles the keys between that "
        "machine and its one neighbor — not the whole ring.\n\n"
        "Put these consistent-hashing events in the order their "
        "consequences unfold.",
    calloutHints: [
      "Real production framing: real systems (Cassandra, DynamoDB, many "
          "CDNs) add virtual nodes — each physical machine gets many "
          "points on the ring — to spread load evenly and avoid one "
          "unlucky machine owning a giant arc of the ring.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these events in the order they'd happen when a "
          "cluster grows.",
      items: [
        OrderItem(
          'ringSetup',
          'Keys and machines are both hashed onto positions on a shared ring',
        ),
        OrderItem(
          'ownership',
          'Each key is owned by the first machine found walking clockwise from it',
        ),
        OrderItem('addMachine', 'A new machine is added, taking a new position on the ring'),
        OrderItem(
          'localReshuffle',
          'Only the keys between the new machine and its one neighbor move — everything else stays put',
        ),
      ],
      explainOk:
          "That's consistent hashing! Ring placement first, ownership by "
          "clockwise-nearest-neighbor, and adding a machine only "
          "disturbs its local neighborhood — not the whole ring.",
      explainBad:
          "The ring and ownership rule have to already exist before a "
          "new machine can be added — and even then, only ONE local "
          "neighborhood of keys ever needs to move.",
    ),
  ),
  const Chapter(
    id: 47,
    title: 'External Merge Sort: Sorting Data Bigger Than RAM',
    avatar: '💾',
    role: 'Narrator — sorting a dataset too big to hold at once',
    bodyIntro:
        "What do you do when you need to sort 500GB of data but only "
        "have 16GB of RAM? You can't load it all at once — so external "
        "merge sort adapts the merge sort we already know to work mostly "
        "on disk.\n\n"
        "1. Split the data into chunks small enough to fit in RAM.\n"
        "2. Sort each chunk fully in memory, then write it back to disk "
        "as a sorted \"run.\"\n"
        "3. Repeatedly k-way merge the sorted runs together — reading "
        "just a small buffer from the front of each run at a time — "
        "until one single, fully sorted file remains.\n\n"
        "The k-way merge step never needs to hold more than one small "
        "buffer per run in memory at once, no matter how huge the total "
        "dataset is — it always just compares the current fronts of each "
        "run and writes out the smallest. This is exactly how "
        "large-scale ETL pipelines, MapReduce shuffle-and-sort phases, "
        "and database ORDER BY spill-to-disk sorts work.\n\n"
        "Put the external merge sort phases in order.",
    calloutHints: [
      "Real production framing: this is the same divide-and-conquer idea "
          "as in-memory merge sort — the only new trick is treating disk "
          "chunks as the \"pieces\" instead of array slices, since RAM "
          "simply isn't big enough to hold everything at once.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the phases of external merge sort in the order they "
          "happen.",
      items: [
        OrderItem('chunk', 'Split the huge dataset into RAM-sized chunks'),
        OrderItem('sortChunk', 'Sort each chunk fully in memory'),
        OrderItem(
          'writeRun',
          "Write each sorted chunk back to disk as a sorted 'run'",
        ),
        OrderItem(
          'kwayMerge',
          'K-way merge the sorted runs, reading only small buffers at a time, into one final sorted file',
        ),
      ],
      explainOk:
          "That's external merge sort! Chunk it, sort each chunk in "
          "memory, persist as sorted runs, then merge the runs with only "
          "tiny buffers held in RAM at once.",
      explainBad:
          "Nothing can be merged until sorted runs already exist on disk "
          "— chunking and in-memory sorting always come first.",
    ),
  ),
  const Chapter(
    id: 48,
    title: 'Probabilistic Structures: Bloom Filters & HyperLogLog',
    avatar: '🎲',
    role: 'Narrator — trading perfect accuracy for tiny memory',
    bodyIntro:
        "Sometimes the honest, exact answer costs too much memory — and "
        "a structure that's occasionally, predictably WRONG in one safe "
        "direction is a great trade.\n\n"
        "A Bloom filter answers \"have I possibly seen this key before?\" "
        "using just a bit array and several hash functions — no actual "
        "keys stored. Adding a key sets several bits; checking a key "
        "sees if all those bits are set. It can produce a false positive "
        "(\"yes, probably seen\" when it wasn't) but NEVER a false "
        "negative — if it says \"definitely not seen,\" that's always "
        "true. This is exactly why LSM-tree storage engines keep a Bloom "
        "filter per SSTable: skip disk reads for keys that definitely "
        "aren't there.\n\n"
        "HyperLogLog solves a different problem: \"roughly how many "
        "DISTINCT items have I seen,\" across billions of items, using "
        "only a few kilobytes — instead of a hash set that could need "
        "gigabytes. It sacrifices exactness for a small, well-understood "
        "error rate (~1-2%).\n\n"
        "Match each probabilistic structure to what it's actually for.",
    calloutHints: [
      "Real production framing: analytics dashboards that show \"~14.2M "
          "unique visitors\" are very likely reading a HyperLogLog, not "
          "counting a literal set of 14.2 million user IDs in memory.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a structure or fact on the left, then click its "
          "matching description on the right.",
      pairs: [
        MatchPair(
          'bloom',
          'Bloom filter',
          "Answers 'might this key exist?' with no false negatives, using a bit array",
        ),
        MatchPair(
          'hll',
          'HyperLogLog',
          'Estimates the count of DISTINCT items using tiny fixed memory',
        ),
        MatchPair(
          'falsepos',
          'False positive risk',
          "A Bloom filter can wrongly say 'maybe seen' — but never wrongly say 'never seen'",
        ),
        MatchPair(
          'sstableuse',
          'LSM-tree read path',
          'Checks a Bloom filter per SSTable first, to skip disk reads that would be wasted',
        ),
      ],
      explainOk:
          "All matched! Bloom filters guard against wasted lookups with "
          "one-directional error; HyperLogLog trades exactness for tiny, "
          "constant memory when counting distinct items.",
    ),
  ),
  const Chapter(
    id: 49,
    title: 'Merkle Trees: Tamper-Evident Hashing',
    avatar: '🔗',
    role: 'Narrator — entering a vault of hashes',
    bodyIntro:
        "Heavy doors seal behind me — this is the Fortress of Trust, "
        "where structures have to prove data hasn't been secretly "
        "changed, not just store it fast. First: the Merkle tree.\n\n"
        "Every leaf holds the hash of one piece of data. Every parent "
        "node holds hash(left child's hash + right child's hash), all "
        "the way up to one single root hash that summarizes the ENTIRE "
        "dataset.\n\n"
        "Change even ONE bit of data D, and its leaf hash changes, which "
        "changes its parent hash, which changes the root hash. Two "
        "systems can compare just their tiny root hashes to instantly "
        "know \"identical\" or \"different\" — and if different, walk "
        "down the tree to find EXACTLY which leaf disagrees, without "
        "re-transferring the whole dataset. This is how git detects any "
        "changed file instantly, how blockchains prove block contents "
        "weren't altered, and how DynamoDB/Cassandra efficiently find "
        "out-of-sync replicas during anti-entropy repair.\n\n"
        "What actually happens to the root hash if one leaf's data "
        "changes?",
    calloutHints: [
      "Real production framing: Merkle trees turn \"did anything change "
          "anywhere in this huge dataset?\" from an O(n) full comparison "
          "into an O(1) root-hash check, plus O(log n) to locate exactly "
          "what changed.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In a Merkle tree, one byte of the data behind leaf D changes. "
          "What happens to the tree's root hash?",
      options: [
        "Nothing — only leaf D's own hash changes",
        'The root hash changes too, because every ancestor hash on the path from D up to the root gets recomputed',
        'The whole tree must be thrown away and rebuilt from scratch with a different shape',
        'Only leaves change; parent and root hashes are fixed once written',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly! Every hash on the path from the changed leaf up to "
          "the root depends on it, so the root hash always changes — "
          "that's what makes tampering detectable with just one "
          "comparison.",
      explainBad:
          "Follow the dependency chain: the root's hash is built FROM "
          "its children's hashes, all the way down to the leaves — so a "
          "changed leaf ripples all the way up to the root.",
    ),
  ),
  const Chapter(
    id: 50,
    title: 'Lock-Free Queues: Concurrency Without Mutexes',
    avatar: '⚙️',
    role: 'Narrator — watching threads race without crashing',
    bodyIntro:
        "Multiple threads need to push and pop from the SAME queue, at "
        "the same time, without a traditional mutex slowing everyone "
        "down to \"one thread at a time.\" That's a lock-free queue.\n\n"
        "The core tool is a CPU instruction called CAS — "
        "compare-and-swap: \"if this memory location still holds the "
        "value I expect, atomically replace it with my new value; "
        "otherwise, tell me it failed and let me retry.\" Threads race to "
        "CAS the queue's tail pointer forward; exactly one wins per "
        "attempt, and losers simply retry — no thread ever BLOCKS "
        "waiting for a lock to be released.\n\n"
        "This introduces the infamous ABA problem: a thread reads value "
        "A, gets paused, another thread changes it to B and back to A, "
        "and the first thread's CAS wrongly succeeds because the value "
        "\"looks unchanged\" — even though the world underneath it "
        "changed. Real lock-free queues (like the classic Michael-Scott "
        "queue) guard against this with tagged pointers or versioned "
        "references.\n\n"
        "What's the actual benefit of CAS over a traditional lock?",
    calloutHints: [
      "Real production framing: lock-free structures trade simplicity "
          "for throughput under heavy contention — a badly-contended "
          "mutex can bottleneck an entire multi-core system, while a "
          "well-built lock-free queue lets cores keep making progress "
          "independently.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A traditional mutex-based queue blocks every other thread "
          "while one thread holds the lock. What does compare-and-swap "
          "(CAS) offer instead?",
      options: [
        'It guarantees only one thread can ever touch the queue, permanently',
        'It lets threads attempt an atomic update and simply retry on failure, without ever blocking other threads from making progress',
        'It removes the need for the queue to be thread-safe at all',
        'It makes every operation slower but simpler to reason about',
      ],
      answerIndex: 1,
      explainOk:
          "Right! CAS lets a thread attempt its update optimistically "
          "and retry on failure — no thread is ever forced to sleep "
          "waiting for a lock, which is exactly what 'lock-free' means.",
      explainBad:
          "Lock-free doesn't mean 'no coordination' — it means "
          "coordination happens via retry-on-failure atomic operations "
          "(CAS) instead of blocking other threads with a mutex.",
    ),
  ),
  const Chapter(
    id: 51,
    title: 'Append-Only Logs: The Structure Behind Audit Trails',
    avatar: '🧾',
    role: "Narrator — reading a ledger that's never erased",
    bodyIntro:
        "A financial ledger, a security audit trail, and Kafka's storage "
        "engine all share the exact same underlying structure: an "
        "append-only log. New records are always added at the end, each "
        "getting a strictly increasing offset. Nothing already written "
        "is ever edited or deleted in place.\n\n"
        "Need to \"change\" a value? You don't rewrite history — you "
        "APPEND a new event describing the change (this is the core idea "
        "of event sourcing). The current state is just whatever you get "
        "by replaying every event from the start (or from the last "
        "snapshot).\n\n"
        "offset 0: AccountCreated, balance 0\n"
        "offset 1: Deposited, amount 100\n"
        "offset 2: Withdrew, amount 30\n"
        "-> current balance = replay all events = 70\n\n"
        "This makes append-only logs naturally tamper-evident (any edit "
        "to old history is detectable, especially combined with hash "
        "chains) and gives you a complete, ordered history for free — "
        "exactly what an auditor or a \"how did we get into this state\" "
        "debugging session needs.\n\n"
        "Sort each behavior into the structure it actually belongs to.",
    calloutHints: [
      "Real production framing: \"just delete the bad row\" is often the "
          "WRONG production fix for audit-critical systems — the correct "
          "fix is usually to append a corrective event and let the log "
          "tell the true, complete story of what happened.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each behavior into the structure it describes.",
      bucketALabel: 'Append-Only Log',
      bucketBLabel: 'Mutable Table',
      items: [
        Sort2Item(
          'newOffset',
          'Every write gets a new, strictly increasing offset at the end',
          true,
        ),
        Sort2Item(
          'editRow',
          'Updating a value overwrites the existing row in place',
          false,
        ),
        Sort2Item(
          'correctiveEvent',
          'A mistake is fixed by appending a new corrective event, not editing old ones',
          true,
        ),
        Sort2Item(
          'currentOnly',
          "Only the current value is stored — history isn't kept automatically",
          false,
        ),
      ],
      explainOk:
          "Sorted correctly! Append-only logs never rewrite history — "
          "they add corrective events; mutable tables just overwrite in "
          "place and lose the 'how did we get here' story.",
      explainBad:
          "Append-only means literally nothing already written ever "
          "changes — fixes are new events at the end, not edits to old "
          "entries.",
    ),
  ),
  const Chapter(
    id: 52,
    title: 'Hash Chains & Checksums: Proving Nothing Was Tampered',
    avatar: '🧬',
    role: 'Narrator — verifying every link in the chain',
    bodyIntro:
        "Append-only logs are tamper-RESISTANT, but how do you actually "
        "PROVE nothing was silently rewritten? By linking every record's "
        "hash into the next one — a hash chain.\n\n"
        "record 1: data1, hash1 = H(data1)\n"
        "record 2: data2, hash2 = H(data2 + hash1)\n"
        "record 3: data3, hash3 = H(data3 + hash2)\n\n"
        "Each record's hash depends on its own data AND the previous "
        "record's hash. Tamper with record 1's data, and hash1 changes — "
        "which breaks hash2, which breaks hash3, all the way to the end "
        "of the chain. Anyone re-verifying the whole chain will "
        "immediately spot exactly where it diverges. This is literally "
        "the core idea behind blockchain block-linking, and it's used in "
        "plenty of non-blockchain audit-log systems too.\n\n"
        "Note the difference from a plain checksum (like CRC32): a "
        "checksum only catches ACCIDENTAL corruption (bit flips from a "
        "bad disk sector) — it uses a fast, non-cryptographic function "
        "and is trivial for an attacker to recompute and forge after "
        "tampering. A cryptographic hash chain is designed so an "
        "attacker CAN'T cheaply produce a fake chain that still matches, "
        "because finding a different input with the same hash is "
        "computationally infeasible.\n\n"
        "Why does tampering with an early record break the whole chain?",
    calloutHints: [
      "Real interview framing: \"checksum\" answers \"did a bit "
          "accidentally flip?\" — \"cryptographic hash chain\" answers "
          "\"did anyone, even a motivated attacker, secretly rewrite "
          "history?\" They solve different threat models.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Someone secretly edits record 1's data in a hash chain. Why "
          "does this get detected all the way at record 100?",
      options: [
        'It does not — only record 1 itself would look wrong',
        "Because each record's hash depends on the previous record's hash, so the change ripples forward and every later hash stops matching",
        'Because hash chains automatically alert an administrator by email',
        "Because record 100 stores an independent, unrelated copy of record 1's data",
      ],
      answerIndex: 1,
      explainOk:
          "Exactly! Every record's hash is computed FROM the previous "
          "record's hash, so one early change invalidates every hash "
          "that comes after it — the tampering is unmissable on "
          "re-verification.",
      explainBad:
          "Trace the dependency: record 2's hash includes record 1's "
          "hash, record 3's hash includes record 2's hash, and so on — a "
          "change at the start ripples all the way to the end.",
    ),
  ),
  const Chapter(
    id: 53,
    title: 'The System-Design Interview: Picking Structures Under Pressure',
    avatar: '🧑‍🏛️',
    role: 'Narrator — entering a maze of design decisions',
    bodyIntro:
        "The walls close in — this is the Architect's Labyrinth, where "
        "every turn is a real system-design decision, and picking the "
        "wrong structure sends you down a dead end. There's a repeatable "
        "framework professionals use here:\n\n"
        "1. What's the dominant operation? (lookups? range scans? "
        "ordered iteration? prefix search? membership checks?)\n"
        "2. What's its required Big-O, given realistic scale (thousands "
        "vs billions of items)?\n"
        "3. What's the acceptable tradeoff — memory for speed? exactness "
        "for scale (Bloom/HyperLogLog)? write cost for read cost (LSM vs "
        "B-tree)?\n\n"
        "Interviewers are almost never looking for ONE \"correct\" "
        "structure — they're listening for whether you can name the "
        "tradeoffs and justify the pick given the actual constraints "
        "stated in the problem.\n\n"
        "Make the call on this scenario.",
    calloutHints: [
      "Real interview tip: always say the requirement OUT LOUD before "
          "naming a structure — \"since we need ordered range queries AND "
          "fast point lookups, a balanced tree or skip list beats a plain "
          "hash map here\" reads far stronger than just blurting \"hash "
          "map.\"",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "You need to support both 'get user X's exact rank' AND 'get "
          "the top 10 users right now' AND 'get everyone ranked between "
          "position 50 and 60' — with millions of frequently-changing "
          "scores. Which structure family fits best?",
      options: [
        'A plain hash map keyed by user ID only',
        'An unsorted array, re-scanned on every query',
        'An ordered structure like a skip list or balanced tree, keeping scores sorted with O(log n) update and range queries',
        'A single integer counter',
      ],
      answerIndex: 2,
      explainOk:
          "Correct! Rank and range queries need an ORDERED structure, "
          "not just fast lookup by key — a skip list or balanced tree "
          "keeps scores sorted while still updating quickly.",
      explainBad:
          "A plain hash map gives fast lookup by key but has NO ordering "
          "— and this problem explicitly needs rank and range queries, "
          "which require an ordered structure.",
    ),
  ),
  const Chapter(
    id: 54,
    title: 'LRU Cache at Scale: Sharding and Thread-Safety',
    avatar: '🧱',
    role: 'Narrator — pushing the LRU cache past a single thread',
    bodyIntro:
        "We built a single-threaded LRU cache back at the certification: "
        "hash map + doubly linked list, O(1) get/put/evict. Now put it "
        "under REAL load — thousands of threads hitting it per second. "
        "One global lock around the whole structure becomes the "
        "bottleneck.\n\n"
        "The standard fix: shard the cache. Instead of one hash map + "
        "one linked list guarded by one lock, build N independent LRU "
        "caches, each with its OWN lock. Route each key to a shard using "
        "hash(key) % N (or, at bigger scale, consistent hashing). Now N "
        "threads can be inside N different shards simultaneously, each "
        "only contending with the small slice of traffic that happens to "
        "hash to the same shard.\n\n"
        "The tradeoff: each shard's \"least recently used\" is only "
        "accurate WITHIN that shard, not globally — a slightly imperfect "
        "eviction order in exchange for dramatically less lock "
        "contention. This exact pattern (Caffeine, Guava's cache, many "
        "real production caches) is used precisely because perfect "
        "global LRU ordering matters far less than throughput at scale.\n\n"
        "Match each sharded-LRU concept to what it actually does.",
    calloutHints: [
      "Real interview tip: naming \"just shard it and accept approximate "
          "global ordering\" is a strong senior-level answer — it shows "
          "you understand that perfect correctness and real-world "
          "throughput are often in direct tension.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a concept on the left, then click its matching "
          "description on the right.",
      pairs: [
        MatchPair(
          'shardRoute',
          'hash(key) % N',
          'Routes a key to exactly one shard, deterministically',
        ),
        MatchPair(
          'perShardLock',
          'Per-shard lock',
          'Lets N threads work in N different shards concurrently, without blocking each other',
        ),
        MatchPair(
          'approxGlobal',
          'Global LRU accuracy tradeoff',
          'Eviction order is only exact within a shard, not across the whole cache',
        ),
        MatchPair(
          'onelock',
          'A single global lock (the problem being solved)',
          'Forces every thread to wait its turn, even for unrelated keys',
        ),
      ],
      explainOk:
          "All matched! Sharding trades a little global-ordering "
          "precision for massively reduced lock contention — the "
          "classic scale-vs-correctness tradeoff in real caches.",
    ),
  ),
  const Chapter(
    id: 55,
    title: 'Tries at Scale: Autocomplete for Millions of Queries',
    avatar: '🔡',
    role: 'Narrator — compressing a trie under real load',
    bodyIntro:
        "A plain trie works beautifully for a small dictionary — but "
        "autocomplete over millions of real search queries has a memory "
        "problem: a long, rarely-branching chain of single-character "
        "nodes wastes a huge amount of memory on pointers alone.\n\n"
        "The production fix is a compressed trie (a.k.a. radix tree / "
        "Patricia trie): any chain of nodes with no branching gets "
        "collapsed into ONE node holding the whole shared substring, "
        "instead of one node per character.\n\n"
        "Plain trie for \"romania\" and \"romantic\" branches character by "
        "character; a compressed trie collapses the shared \"roman\" "
        "prefix into one node, branching only at \"ia\" vs \"tic\".\n\n"
        "Real autocomplete systems go further: each node also caches "
        "its precomputed top-K completions (by popularity/frequency), so "
        "serving \"what are the top 5 autocompletions for this prefix?\" "
        "is an O(1) lookup at the matching node, instead of re-walking "
        "and re-ranking the whole subtree on every keystroke.\n\n"
        "Order the steps of building a production-grade autocomplete "
        "trie.",
    calloutHints: [
      "Real production framing: this precompute-at-index-time, "
          "O(1)-at-query-time pattern shows up everywhere at scale — "
          "search autocomplete, typeahead, even DNS — because query-time "
          "latency budgets are usually far tighter than index-build-time "
          "budgets.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these steps for building a production autocomplete "
          "system in the order they happen.",
      items: [
        OrderItem('insertWords', 'Insert every known query as a path through the trie'),
        OrderItem(
          'compress',
          'Compress non-branching chains into single nodes (radix/Patricia style)',
        ),
        OrderItem('rankSubtrees', "Rank each subtree's queries by popularity"),
        OrderItem(
          'cacheTopK',
          'Cache the top-K completions at each node for O(1) query-time lookup',
        ),
      ],
      explainOk:
          "That's the pipeline! Build the trie, compress it for memory, "
          "rank subtrees by popularity, then cache top-K per node so "
          "serving is instant at query time.",
      explainBad:
          "You can't compress or rank anything before the words are "
          "actually in the trie — and caching top-K depends on ranking "
          "already being done.",
    ),
  ),
  const Chapter(
    id: 56,
    title: 'Union-Find: Disjoint Sets for Huge Graphs',
    avatar: '🕸️',
    role: 'Narrator — merging groups at massive scale',
    bodyIntro:
        "Kruskal's algorithm needed a fast way to answer \"would adding "
        "this edge create a cycle?\" The structure that makes that "
        "nearly free, even on graphs with billions of nodes, is "
        "union-find (disjoint set union).\n\n"
        "Each node starts in its own set, tracked via a \"parent\" "
        "pointer to itself. Two operations:\n\n"
        "find(x) — follow parent pointers up to the set's representative "
        "(\"root\")\n\n"
        "union(x, y) — merge two sets by pointing one root at the other\n\n"
        "Two optimizations turn this from \"fine\" into \"nearly O(1) "
        "amortized\":\n\n"
        "Union by rank/size — always attach the SMALLER tree under the "
        "BIGGER tree's root, keeping trees shallow\n\n"
        "Path compression — while doing find(x), point every node "
        "visited directly at the root, so future finds are instant\n\n"
        "Combined, these two tricks give union-find operations an "
        "amortized time complexity so close to constant that it's used "
        "at massive scale: network connectivity checks, image "
        "segmentation (grouping connected pixels), and social-network "
        "\"same friend group?\" queries on graphs with billions of "
        "edges.\n\n"
        "Order the steps of a find(x) call that uses path compression.",
    calloutHints: [
      "Real production framing: path compression is a beautiful example "
          "of \"pay a little now, save a LOT later\" — every find() call "
          "makes every FUTURE find() call on those same nodes faster.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the steps of a find(x) call with path compression, in "
          "the order they happen.",
      items: [
        OrderItem(
          'walkUp',
          'Follow parent pointers upward from x until reaching the root',
        ),
        OrderItem(
          'identifyRoot',
          "Identify that node (with itself as parent) as the set's root",
        ),
        OrderItem(
          'repointAll',
          'Re-point every node visited along the way directly at that root',
        ),
        OrderItem('returnRoot', 'Return the root as the answer'),
      ],
      explainOk:
          "That's path-compressed find()! Walk to the root, recognize "
          "it, flatten every visited node to point straight at it, then "
          "return it — future lookups are now instant.",
      explainBad:
          "You have to actually reach the root before you know what to "
          "compress everything to point at — walking up always comes "
          "first.",
    ),
  ),
  const Chapter(
    id: 57,
    title: 'Capstone: Designing a Rate Limiter',
    avatar: '🚦',
    role: 'Narrator — the gauntlet begins',
    bodyIntro:
        "The floor drops away into darkness — this is The Machine's "
        "Reckoning, the hardest tier in all of Structure Springs. No more "
        "single-structure questions: every challenge from here combines "
        "everything you've learned. First: design a rate limiter — "
        "\"allow at most N requests per user per minute.\"\n\n"
        "Three real structural approaches, each with a real tradeoff:\n\n"
        "Token bucket — each user has a counter (\"bucket\") that refills "
        "by a fixed rate over time and is drained per request; smooth, "
        "allows small bursts, O(1) memory per user.\n\n"
        "Fixed window counter — one integer counter per user per time "
        "window (e.g. \"3:00-3:01\"); dead simple, O(1), but allows a "
        "burst right at the window boundary (2x the limit across two "
        "adjacent windows).\n\n"
        "Sliding window log — store the actual TIMESTAMP of every "
        "request in a queue/circular buffer per user, and count only "
        "entries within the trailing window; perfectly precise, but "
        "O(requests) memory per user instead of O(1).\n\n"
        "A production-grade hybrid — the sliding window counter — "
        "approximates the precise version using just TWO fixed-window "
        "counters (current + previous) and a weighted average, getting "
        "near-sliding-window accuracy at fixed-window memory cost.\n\n"
        "Sort each rate-limiter trait into the design it actually "
        "describes.",
    calloutHints: [
      "Real production framing: this is exactly the kind of question "
          "where naming \"it depends on precision vs memory\" and then "
          "picking one WITH a reason is what separates a strong answer "
          "from a memorized one.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each trait into the rate-limiting design it describes.",
      bucketALabel: 'Fixed Window Counter',
      bucketBLabel: 'Sliding Window Log',
      items: [
        Sort2Item(
          'oneInt',
          'Stores just one integer counter per time window',
          true,
        ),
        Sort2Item(
          'boundaryBurst',
          'Can allow up to 2x the limit right at a window boundary',
          true,
        ),
        Sort2Item(
          'storesTimestamps',
          'Stores the exact timestamp of every recent request',
          false,
        ),
        Sort2Item(
          'exactPrecision',
          'Gives perfectly precise limiting at the cost of O(requests) memory',
          false,
        ),
      ],
      explainOk:
          "Sorted correctly! Fixed window counters are cheap but can "
          "burst at boundaries; sliding window logs are precise but cost "
          "memory proportional to request volume.",
      explainBad:
          "A single counter per window = fixed window (cheap, "
          "boundary-burst risk). Storing every timestamp = sliding "
          "window log (precise, more memory).",
    ),
  ),
  const Chapter(
    id: 58,
    title: 'Capstone: A Real-Time Leaderboard',
    avatar: '🏆',
    role: 'Narrator — ranking millions, live',
    bodyIntro:
        "Design a real-time leaderboard for a game with 50 million "
        "players: support \"update my score\" and \"what's my exact "
        "rank?\" and \"show me the top 100\" — all with sub-millisecond "
        "latency, constantly.\n\n"
        "This is the textbook use case for a sorted set — exactly like "
        "Redis's ZSET — built by COMBINING two structures you already "
        "know:\n\n"
        "A skip list, keeping every player's score in sorted order with "
        "O(log n) insert, update, rank-by-position, and range queries "
        "(\"show me ranks 50-60\")\n\n"
        "A hash map from player ID directly to their node in the skip "
        "list, so \"update my score\" doesn't need a search first — O(1) "
        "to locate, then O(log n) to reposition\n\n"
        "Just like the LRU cache combined a hash map with a doubly "
        "linked list to cover each other's weakness, this leaderboard "
        "combines a hash map (fast lookup by key) with a skip list (fast "
        "ordered operations) — the SAME architectural pattern, a "
        "different pair of structures.\n\n"
        "Match each leaderboard component to the job it does.",
    calloutHints: [
      "Real production framing: recognizing \"I need O(1) lookup by key "
          "AND fast ordered range queries -> combine a hash map with an "
          "ordered structure\" is one of the single most reusable "
          "patterns in real system design.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a component on the left, then click the job it does on "
          "the right.",
      pairs: [
        MatchPair(
          'skiplistjob',
          'Skip list of scores',
          'Keeps all scores sorted with O(log n) update and range/rank queries',
        ),
        MatchPair(
          'hashmapjob',
          'Hash map (player ID -> skip list node)',
          'O(1) lookup of where a specific player currently sits',
        ),
        MatchPair(
          'updateFlow',
          'On a score update',
          "O(1) locate the player's node, then O(log n) reposition it in sorted order",
        ),
        MatchPair(
          'top100',
          'Get the top 100 players',
          "Walk the skip list's top express lane from the highest score downward",
        ),
      ],
      explainOk:
          "You've built a real-time leaderboard! Hash map for instant "
          "lookup, skip list for instant ordering — the exact same "
          "combining pattern as the LRU cache, applied to a new problem.",
    ),
  ),
  const Chapter(
    id: 59,
    title: 'Capstone: Eviction Policy for a Distributed Cache',
    avatar: '🌍',
    role: 'Narrator — evicting wisely across a whole fleet',
    bodyIntro:
        "Design the eviction policy for a distributed cache spread "
        "across 200 machines, holding way more hot data than fits in "
        "RAM. Every idea from this entire tier gets used at once here.\n\n"
        "Consistent hashing decides WHICH machine owns which key, so "
        "adding/removing machines doesn't reshuffle everything.\n\n"
        "Each machine runs its own sharded LRU internally, so no single "
        "global lock bottlenecks that machine's traffic.\n\n"
        "Choosing between LRU (evict least-RECENTLY used — cheap, but "
        "easily fooled by one-off bulk scans polluting the cache) and "
        "LFU (evict least-FREQUENTLY used — resists scan pollution, but "
        "needs to track access counts and slowly \"forget\" stale "
        "popularity) is itself a real tradeoff. Many production caches "
        "(like Redis's actual eviction policies) offer BOTH and let "
        "operators pick.\n\n"
        "More advanced policies like ARC (Adaptive Replacement Cache) "
        "dynamically balance between LRU-like and LFU-like behavior "
        "based on observed access patterns, rather than committing to "
        "one forever.\n\n"
        "Sort each eviction-policy trait into the policy it actually "
        "describes.",
    calloutHints: [
      "Real production framing: \"LRU is cheap but scan-vulnerable; LFU "
          "resists that but costs more bookkeeping; ARC adapts between "
          "them\" is a genuinely senior-level answer — most candidates "
          "only know LRU.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each trait into the eviction policy it describes.",
      bucketALabel: 'LRU (least recently used)',
      bucketBLabel: 'LFU (least frequently used)',
      items: [
        Sort2Item(
          'recency',
          'Evicts based on how long ago an item was last touched',
          true,
        ),
        Sort2Item(
          'scanVulnerable',
          'A one-off bulk scan can wipe out genuinely popular cached items',
          true,
        ),
        Sort2Item(
          'frequencyCount',
          'Tracks an access-count per item to decide what to evict',
          false,
        ),
        Sort2Item(
          'scanResistant',
          'Resists pollution from a single one-off bulk scan',
          false,
        ),
      ],
      explainOk:
          "Sorted correctly! LRU is cheap and recency-based but "
          "scan-vulnerable; LFU tracks frequency and resists that exact "
          "failure mode at the cost of extra bookkeeping.",
      explainBad:
          "Recency-based and scan-vulnerable = LRU. Frequency-counting "
          "and scan-resistant = LFU.",
    ),
  ),
  const Chapter(
    id: 60,
    title: 'Capstone: The Full Search-Autocomplete Pipeline',
    avatar: '🧠',
    role: 'Narrator — the final reckoning',
    bodyIntro:
        "The final challenge of Structure Springs: design the FULL "
        "autocomplete pipeline behind a real search box handling "
        "millions of keystrokes per second — combining nearly every "
        "structure from this entire professional tier into one working "
        "system.\n\n"
        "A compressed trie with precomputed top-K completions per node "
        "handles the core \"given this prefix, what are the best "
        "completions?\" query in O(1) at the matching node.\n\n"
        "A Bloom filter in front of it lets the service instantly say "
        "\"definitely no completions exist for this prefix\" for "
        "garbage/typo input, skipping the trie walk entirely.\n\n"
        "A sharded LRU cache sits in front of the trie for the hottest "
        "prefixes (like \"how\", \"what is\"), serving the most common "
        "queries without touching the trie at all.\n\n"
        "Behind the scenes, an LSM-tree-backed store durably persists "
        "the raw query-frequency data used to rebuild and re-rank the "
        "trie periodically, favoring the LSM-tree's fast-write profile "
        "since raw query logs are an append-heavy, write-dominant "
        "stream.\n\n"
        "Notice the shape of the whole design: EVERY piece exists to "
        "protect a slower piece behind it from unnecessary work — cache "
        "protects trie, Bloom filter protects trie, trie protects the "
        "underlying analytics store, and the write-optimized store "
        "protects the whole pipeline's ability to keep up with real-time "
        "query volume.\n\n"
        "Match each pipeline layer to the job it does, and claim your "
        "final certification.",
    calloutHints: [
      "This is the whole point of the professional tier: real systems "
          "are rarely \"pick one structure\" — they're layered defenses, "
          "each covering the next layer's weakness, exactly like the LRU "
          "cache and leaderboard you built earlier, just composed at a "
          "bigger scale.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a layer on the left, then click the job it does on the "
          "right.",
      pairs: [
        MatchPair(
          'bloomLayer',
          'Bloom filter (front line)',
          'Instantly rules out prefixes with zero possible completions',
        ),
        MatchPair(
          'cacheLayer',
          'Sharded LRU cache',
          'Serves the hottest prefixes without ever touching the trie',
        ),
        MatchPair(
          'trieLayer',
          'Compressed trie with cached top-K',
          'Answers most real prefix queries in O(1) at the matching node',
        ),
        MatchPair(
          'lsmLayer',
          'LSM-tree-backed analytics store',
          'Durably persists write-heavy raw query logs used to rebuild the trie',
        ),
      ],
      explainOk:
          "Certification complete! You just designed a real, "
          "production-shaped system by layering exactly the structures "
          "this whole professional tier taught — each one protecting "
          "the next from unnecessary work. Structure Springs bows to "
          "you.",
    ),
  ),
];
