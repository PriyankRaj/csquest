import '../models/pq_models.dart';

/// Ported from process-quest/subjects/os.js — all 60 chapters (levels 1-15),
/// real content, trimmed narrative prose, same puzzles/answers.
final osChapters = <Chapter>[
  const Chapter(
    id: 1,
    title: 'The Birth of a Process',
    avatar: '🥚',
    role: 'Narrator — moments after fork()',
    bodyIntro:
        "I didn't exist a millisecond ago. Then the kernel called fork(), and — "
        "snap — here I am: Process #4271.\n\nThe kernel gave me a home: a Process "
        "Control Block (PCB) 🪪 — like a new student getting handed a school ID "
        "card. It holds my PID, program counter, CPU registers, memory pointers, "
        "state, and open file descriptors.",
    calloutHints: [
      "🐧 Fun fact: on Linux, even threads are technically \"tasks\" created "
          "with clone() — fork() is just clone() with almost nothing shared.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which of these is NOT normally stored in a Process Control Block?",
      options: [
        'Program Counter (address of next instruction)',
        'Process state (ready / running / waiting)',
        'The actual compiled machine code of every other process on the system',
        'CPU register snapshot',
      ],
      answerIndex: 2,
      explainOk:
          "Right — a PCB describes this process only. It never stores other "
          "processes' code.",
      explainBad:
          "Not quite. A PCB is strictly per-process metadata: PID, program "
          "counter, registers, state, memory pointers, file descriptors — "
          "never another process's machine code.",
    ),
  ),
  const Chapter(
    id: 2,
    title: 'The Five Faces of Me',
    avatar: '🔁',
    role: 'Narrator — cycling through states',
    bodyIntro:
        "I flow through a well-defined state machine: New → Ready → Running → "
        "Terminated, with Waiting as a detour off Running.\n\nRunning → Ready "
        "happens when the scheduler simply preempts me (time slice ran out) — "
        "not because I was blocked on anything.",
    calloutHints: [
      "🚫 A process can NEVER go directly from Waiting to Running. It must "
          "always pass back through Ready first.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag to arrange these events in the order they'd happen to a "
          "process that does one disk read before finishing.",
      items: [
        OrderItem('new', 'Created by fork(), state = NEW'),
        OrderItem('ready1', 'Admitted to memory, state = READY'),
        OrderItem('run1', 'Scheduler dispatches it, state = RUNNING'),
        OrderItem('wait', 'Issues a disk read, state = WAITING'),
        OrderItem('ready2', 'Disk I/O completes, moved back to READY'),
        OrderItem('run2', 'Scheduled again, state = RUNNING'),
        OrderItem('term', 'Calls exit(), state = TERMINATED'),
      ],
      explainOk:
          "Exactly — note it must pass through READY again after WAITING; it "
          "can never jump straight back to RUNNING.",
      explainBad:
          "Close, but check the WAITING step — after I/O finishes, I go back "
          "to READY, not directly to RUNNING.",
    ),
  ),
  const Chapter(
    id: 3,
    title: 'My Threads: Lightweight Siblings',
    avatar: '🧵',
    role: 'Narrator — spawning a thread',
    bodyIntro:
        "Sometimes cloning my entire self is overkill. If I just want more "
        "hands doing work, I spawn threads instead of full child processes — "
        "like 3 kids sharing one kitchen (the heap), instead of each kid "
        "needing their own whole kitchen.\n\nA thread shares the code segment, "
        "heap, and open files with its siblings — but keeps its own stack, "
        "registers, program counter, and thread ID private.",
    calloutHints: [
      "🆚 Process vs Thread, one line: a process is an isolated address "
          "space; a thread is a separate flow of execution inside that same "
          "address space.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each item into the bucket that describes it, from the "
          "perspective of two threads belonging to the same process.",
      bucketALabel: '🤝 Shared',
      bucketBLabel: '🔒 Private',
      items: [
        Sort2Item('heap', 'Heap memory', true),
        Sort2Item('stack', 'Stack (local variables)', false),
        Sort2Item('code', 'Code / instructions segment', true),
        Sort2Item('pc', 'Program counter', false),
        Sort2Item('fds', 'Open file descriptors', true),
      ],
      explainOk:
          "That's the golden rule — code, heap, and files are shared; stack "
          "and registers/PC are private to each thread.",
      explainBad:
          "Some of these are off. Only the stack, registers, and program "
          "counter belong exclusively to a single thread.",
    ),
  ),
  const Chapter(
    id: 4,
    title: 'The Stack: My Call History',
    avatar: '🥞',
    role: 'Narrator — three functions deep',
    bodyIntro:
        "Every time I call a function, a new stack frame gets pushed onto my "
        "stack, holding that function's local variables, parameters, and "
        "return address — where to jump back to when it finishes.\n\n"
        "main() calls A() calls B() calls C(): C's frame sits on top, then "
        "B's, then A's, then main's frame at the very bottom.\n\nThis is why "
        "it's called a call stack — a literal LIFO stack data structure, "
        "just like nesting dolls: the last one placed inside is the first "
        "one popped back out. The most recently called function always "
        "returns first.\n\nIf I recurse too deep — call a function that "
        "calls itself without a base case — I keep pushing frames until I "
        "run out of stack space. That crash has a name: stack overflow 💥.",
    calloutHints: [
      "📏 The stack is fixed-size and grows/shrinks automatically as "
          "functions are called and return. Compare that to the heap, which "
          "you manage explicitly (next chapter).",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "main() calls A(), which calls B(), which is paused right now. "
          "Drag these frames into order from BOTTOM of the stack to TOP.",
      items: [
        OrderItem('main', 'main() — the very first frame'),
        OrderItem('a', 'A() — called by main'),
        OrderItem('b', 'B() — called by A, currently paused'),
      ],
      explainOk:
          "Correct — main called A, A called B, so B sits on top with A "
          "below it and main at the very bottom, still waiting for A to "
          "return.",
      explainBad:
          "Not quite. Whoever called last sits on top. main() called A(), "
          "which called B() — so bottom-to-top it's main, then A, then B.",
    ),
  ),
  const Chapter(
    id: 5,
    title: 'The Heap: My Junk Drawer',
    avatar: '📦',
    role: 'Narrator — allocating memory',
    bodyIntro:
        "The stack is neat and automatic, but it's rigid — frames come and go "
        "with function calls, and it can't hold data that needs to outlive "
        "the function that created it, or whose size isn't known until "
        "runtime.\n\nFor that, I use the heap — like renting a school locker "
        "🔒. I explicitly ask for one with malloc() (C) or new (C++/Java), "
        "and it's mine until I explicitly give it back with free()/delete — "
        "or until a garbage collector notices nobody's using it anymore and "
        "clears it out for me.\n\nTwo classic ways I can hurt myself here: a "
        "memory leak, where I rent a locker, lose the key, and never give it "
        "back, so it sits there forever; and a dangling pointer / "
        "use-after-free, where I give a locker back but keep using my old "
        "key on it anyway — it might now belong to someone else entirely.\n\n"
        "The OS also virtualizes memory for me through virtual memory and "
        "paging: my heap addresses are fake, translated by the MMU into "
        "real physical RAM addresses, page by page. That's how I can "
        "believe I own gigabytes of contiguous memory on a machine with far "
        "less physical RAM, and why one process can never accidentally "
        "read another's memory.",
    calloutHints: [
      "⚖️ Stack vs Heap in one line: the stack is automatic and fast but "
          "temporary; the heap is manual (or GC'd) and flexible but must be "
          "managed carefully — like a rented locker you have to remember to "
          "check back in.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "char* make_greeting() {\n"
          "  char buffer[64];\n"
          "  strcpy(buffer, \"hello\");\n"
          "  return buffer; // returning address of a STACK-local array\n"
          "}\n\nWhat's wrong with this C function?",
      options: [
        'Nothing — the caller can safely use the returned pointer',
        'It leaks heap memory because buffer was never freed',
        'It returns a pointer to a stack frame that is destroyed the instant the function returns — a dangling pointer',
        'It causes a deadlock between the caller and callee',
      ],
      answerIndex: 2,
      explainOk:
          "Exactly — buffer lived on make_greeting's stack frame. The moment "
          "the function returns, that frame is popped and the memory can be "
          "reused by the next call. The caller is left holding a dangling "
          "pointer.",
      explainBad:
          "Think about where buffer actually lives. It's a local array — "
          "it's on the STACK, not the heap, and stack frames are destroyed "
          "on return. That makes the returned pointer dangle.",
    ),
  ),
  const Chapter(
    id: 6,
    title: 'The Scheduler Decides My Fate',
    avatar: '⏱️',
    role: 'Narrator — waiting my turn',
    bodyIntro:
        "With dozens of processes and only a handful of CPU cores, someone "
        "has to decide who gets a turn and when — that's the scheduler's "
        "job.\n\nEvery time the CPU switches from running me to running "
        "someone else, the kernel performs a context switch: it saves my "
        "registers and program counter into my PCB, then loads another "
        "process's saved state from its PCB into the CPU. From my "
        "perspective, time simply skips forward — I have no idea I was ever "
        "paused.\n\nCommon scheduling strategies: First-Come, First-Served "
        "(FCFS) is simple, but one long process can make everyone else wait "
        "(the convoy effect). Round Robin gives everyone a fixed turn (a "
        "quantum), then sends them to the back of the line — fair, and the "
        "classic default for interactive systems. Priority Scheduling lets "
        "higher-priority processes jump the queue, risking starvation for "
        "low-priority ones unless you age their priority up over time. "
        "Shortest Job First (SJF) is provably optimal for average wait "
        "time, but requires knowing the future, which is rarely possible.",
    calloutHints: [
      "💸 Context switches aren't free — saving/restoring registers and "
          "flushing CPU caches costs real time. Too many context switches "
          "(thrashing 🌪️) can hurt throughput more than the scheduling "
          "problem it was trying to solve.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Three processes arrive at time 0 with these CPU burst needs: "
          "P1=4, P2=1, P3=2. Using Round Robin with a time quantum of 1 "
          "(order P1, P2, P3, repeat), drag these processes into the order "
          "they actually FINISH.",
      items: [
        OrderItem('p2', 'P2 (needs 1 total tick)'),
        OrderItem('p3', 'P3 (needs 2 total ticks)'),
        OrderItem('p1', 'P1 (needs 4 total ticks)'),
      ],
      explainOk:
          "Nice tracing! Timeline: P1(0-1) P2(1-2)[done] P3(2-3) P1(3-4) "
          "P3(4-5)[done] P1(5-6) P1(6-7)[done]. P2 finishes first, then P3, "
          "then P1.",
      explainBad:
          "Walk the timeline tick-by-tick with quantum=1, cycling P1,P2,P3: "
          "P1(0-1), P2(1-2) done, P3(2-3), P1(3-4), P3(4-5) done, P1(5-6), "
          "P1(6-7) done. So the finish order is P2, then P3, then P1.",
    ),
  ),
  const Chapter(
    id: 7,
    title: 'Sharing Without Colliding',
    avatar: '🔒',
    role: 'Narrator — two threads, one variable',
    bodyIntro:
        "Threads share the heap — convenient, until two of them touch the "
        "same variable at the same time. Say balance starts at 100, and two "
        "threads both run balance = balance + 10 concurrently.\n\nThat "
        "single line is actually three CPU steps: read balance, add 10, "
        "write it back. If both threads read before either writes, one "
        "update is silently lost. That's a race condition — the result "
        "depends on timing, which makes it maddeningly hard to reproduce "
        "and debug.\n\nThe fix is a mutex (mutual exclusion lock) — like a "
        "single bathroom key shared by a classroom. Whoever wants to touch "
        "balance must grab the key first, and hang it back up after. Only "
        "one thread can hold it at a time.\n\nBut locks introduce their own "
        "monster: deadlock. Classic recipe — Thread A locks mutex1 then "
        "wants mutex2; Thread B locks mutex2 then wants mutex1. Neither "
        "will ever let go of what it's holding, so both wait forever.",
    calloutHints: [
      "🔒 The standard prevention trick: always acquire locks in the same "
          "global order, everywhere in your codebase. If everyone locks "
          "mutex1 before mutex2, the circular-wait scenario above simply "
          "can't happen.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Thread A: lock(fileLock); lock(dbLock); ... unlock both\n"
          "Thread B: lock(dbLock); lock(fileLock); ... unlock both\n\n"
          "What's the safest fix?",
      options: [
        "Make Thread B also acquire fileLock first, then dbLock — matching Thread A's order",
        'Add more threads doing the same locking pattern so it averages out',
        'Have Thread A retry lock(dbLock) in a tight infinite loop with no backoff',
        'Remove the locks entirely to eliminate lock contention',
      ],
      answerIndex: 0,
      explainOk:
          "Exactly — enforcing a single global lock ordering removes the "
          "circular-wait condition, which is one of the four necessary "
          "conditions for deadlock. Break one condition, and deadlock "
          "becomes impossible.",
      explainBad:
          "The real fix is ordering: make every thread acquire fileLock and "
          "dbLock in the same order. That eliminates circular wait, one of "
          "deadlock's four required conditions.",
    ),
  ),
  const Chapter(
    id: 8,
    title: 'Final Boss — Full Circle',
    avatar: '🏁',
    role: 'Narrator — one last run',
    bodyIntro:
        "Let's replay my whole life in one scene. A shell runs ./sim &.\n\n"
        "The kernel fork()s the shell, creating me. I briefly share the "
        "shell's code, then exec() replaces it with sim's program image. A "
        "fresh PCB is born, state = NEW. I'm admitted into memory and "
        "marked READY, waiting my turn. Dispatched: RUNNING — my code "
        "executes, pushing stack frames, allocating heap blocks for its "
        "data structures.\n\nI spawn two threads to parallelize work. They "
        "share my heap and code, but each gets its own stack. One of them "
        "touches a shared counter — protected by a mutex so no race "
        "condition corrupts it.\n\nI request a file read and move to "
        "WAITING. A context switch hands the CPU to someone else while I "
        "wait. Data arrives, I'm moved back to READY, and later dispatched "
        "to RUNNING again.\n\nFinished. I call exit(). State becomes "
        "TERMINATED; my parent reaps my exit status, and my PCB is finally "
        "released.",
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange these milestones from process #4271's life in the "
          "correct chronological order.",
      items: [
        OrderItem('fork', 'fork() + exec() — PCB created, state NEW'),
        OrderItem('ready', 'Admitted to memory, state READY'),
        OrderItem('running', 'Dispatched by scheduler, state RUNNING'),
        OrderItem('threads', 'Spawns threads sharing the heap, protected by a mutex'),
        OrderItem('waiting', 'Blocks on file I/O, state WAITING'),
        OrderItem('ctxswitch', 'Context switch hands CPU to another process'),
        OrderItem('readyagain', 'I/O completes, back to READY'),
        OrderItem('runningagain', 'Rescheduled, state RUNNING again'),
        OrderItem('exit', 'exit() called, state TERMINATED, PCB released'),
      ],
      explainOk:
          "That's the full circle of life for a process. You've mastered "
          "the fundamentals: PCBs, states, threads, the stack, the heap, "
          "scheduling, and synchronization.",
      explainBad:
          "Almost — remember waiting is always followed by a context "
          "switch to someone else, and I/O completing sends me back to "
          "READY, never straight to RUNNING.",
    ),
  ),
  const Chapter(
    id: 9,
    title: 'First-Come, First-Served',
    avatar: '🚶',
    role: 'Narrator — standing in a very simple line',
    bodyIntro:
        "Welcome to Level 3. The simplest scheduling policy is FCFS "
        "(First-Come, First-Served): whoever arrives first runs first, "
        "start to finish, no interruptions.\n\nThree processes arrive at "
        "time 0: P1 needs 6 ticks, P2 needs 2, P3 needs 1. With FCFS in "
        "arrival order P1, P2, P3: P1 runs 0-6 (finishes at 6), P2 runs 6-8 "
        "(finishes at 8), P3 runs 8-9 (finishes at 9).\n\nNotice P3 only "
        "needed 1 tick but sat waiting for 8! That's the convoy effect — "
        "one long job at the front makes every short job behind it wait "
        "far longer than it should, like being stuck behind one slow "
        "cashier with a full cart.",
    calloutHints: [
      "📐 Average waiting time here = (0+6+8)/3 ≈ 4.67 ticks. FCFS is "
          "simple and fair in arrival order, but terrible for average wait "
          "time when job lengths vary a lot.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "P1 (needs 10 ticks) arrives just before P2 (needs 1 tick). "
          "Under FCFS, what happens to P2?",
      options: [
        "P2 runs immediately since it's shorter",
        'P2 waits the full 10 ticks for P1 to finish, even though it only needs 1 tick itself',
        'P2 and P1 run at the same time on the same core',
        'P2 is skipped entirely because it arrived second',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — FCFS never reorders by length. A short job stuck "
          "behind a long one just waits, which is the textbook convoy "
          "effect.",
      explainBad:
          "FCFS runs strictly in arrival order with no reordering — so P2 "
          "must wait out all 10 ticks of P1 first, even though P2 itself "
          "is nearly instant.",
    ),
  ),
  const Chapter(
    id: 10,
    title: 'Shortest Job First',
    avatar: '🏆',
    role: 'Narrator — reordering the line',
    bodyIntro:
        "If we know each job's length in advance, SJF (Shortest Job First) "
        "always runs the shortest remaining job next. This is provably "
        "optimal for minimizing average waiting time among non-preemptive "
        "policies.\n\nSame three jobs (P1=6, P2=2, P3=1), but scheduled by "
        "SJF instead of arrival order: P3 runs 0-1, P2 runs 1-3, P1 runs "
        "3-9. Average wait = (0+1+3)/3 ≈ 1.33 ticks — far better than "
        "FCFS's 4.67!",
    calloutHints: [
      "🔮 The catch: SJF needs to know the future — exactly how long each "
          "job will run. In practice, operating systems only ESTIMATE job "
          "length from past behavior, which is why pure SJF is mostly a "
          "theoretical benchmark, not a real-world default.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Four jobs arrive at time 0 with burst times: A=5, B=2, C=8, "
          "D=1. Drag them into the order SJF would run them.",
      items: [
        OrderItem('d', 'Job D — burst 1'),
        OrderItem('b', 'Job B — burst 2'),
        OrderItem('a', 'Job A — burst 5'),
        OrderItem('c', 'Job C — burst 8'),
      ],
      explainOk:
          "Right — SJF always picks the currently-shortest job: D(1), then "
          "B(2), then A(5), then C(8).",
      explainBad:
          "SJF sorts purely by burst length, shortest first: D=1, B=2, "
          "A=5, C=8 — so the run order is D, B, A, C.",
    ),
  ),
  const Chapter(
    id: 11,
    title: 'Round Robin — Choosing a Quantum',
    avatar: '⏱️',
    role: 'Narrator — tuning the swing timer',
    bodyIntro:
        "You've already traced Round Robin by hand. Now the professional "
        "question: how long should the time quantum be?\n\nToo large, and "
        "Round Robin starts to behave just like FCFS, losing the "
        "responsiveness RR is supposed to give. Too small, and the CPU "
        "spends more time doing context switches than actual work — if "
        "the quantum is 1ms but a context switch itself costs 0.1ms, "
        "you're burning 10% of your CPU just swapping processes in and "
        "out.\n\nRule of thumb taught in most OS courses: pick a quantum "
        "so that 80% of jobs finish within one quantum — big enough to be "
        "efficient, small enough to stay responsive.",
    calloutHints: [
      "⚖️ This is a real, recurring pattern in systems design: a knob "
          "that's too small wastes overhead, too large loses "
          "responsiveness — the sweet spot is empirical, not a magic "
          "constant.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each symptom into the bucket describing WHY it happens.",
      bucketALabel: '⏳ Quantum too LARGE',
      bucketBLabel: '⚡ Quantum too SMALL',
      items: [
        Sort2Item('fcfs', 'Round Robin starts behaving just like FCFS', true),
        Sort2Item('overhead', 'CPU spends most of its time context-switching, not computing', false),
        Sort2Item('sluggish', 'Interactive apps feel sluggish because turns take too long', true),
        Sort2Item('thrash', 'Throughput drops even though every process gets very frequent turns', false),
      ],
      explainOk:
          "Exactly — too large loses responsiveness (feels like FCFS), too "
          "small burns CPU on overhead instead of real work.",
      explainBad:
          "Think about the failure mode: a huge quantum removes the "
          "benefit of switching (FCFS-like); a tiny quantum makes "
          "switching overhead dominate.",
    ),
  ),
  const Chapter(
    id: 12,
    title: 'Priority Scheduling & Starvation',
    avatar: '👑',
    role: 'Narrator — watching the VIP line',
    bodyIntro:
        "Priority scheduling always runs the highest-priority ready "
        "process next. Great for letting urgent work (like a mouse-click "
        "handler) jump ahead of background work (like a file "
        "indexer).\n\nThe danger: starvation. If new high-priority "
        "processes keep arriving, a low-priority process can wait forever "
        "— never quite the highest priority in the queue at the right "
        "moment.\n\nThe standard fix is aging: gradually increase a "
        "waiting process's priority the longer it waits, so eventually "
        "even the lowest-priority job becomes the highest and gets its "
        "turn.",
    calloutHints: [
      "👑 Real OS schedulers (like Linux's CFS) don't use raw fixed "
          "priorities at all — they track how much CPU time each process "
          "has \"fairly earned\" and always favor whoever's furthest "
          "behind, which is aging taken to its logical extreme.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A low-priority background backup job has been ready to run "
          "for 10 minutes but keeps losing the CPU to a stream of new "
          "high-priority tasks. What's the standard fix?",
      options: [
        'Delete the backup job so it stops wasting resources',
        "Age its priority upward the longer it waits, until it eventually outranks new arrivals",
        'Force every process to run at the same fixed priority forever',
        'Let it run forever with no other process ever interrupting it',
      ],
      answerIndex: 1,
      explainOk:
          "Right — aging raises a waiting process's effective priority "
          "over time, guaranteeing it eventually gets scheduled, which "
          "directly prevents starvation.",
      explainBad:
          "The textbook fix for starvation is aging: slowly boost the "
          "priority of anyone who's been waiting a long time, so they "
          "eventually get their turn.",
    ),
  ),
  const Chapter(
    id: 13,
    title: 'Contiguous Allocation & Fragmentation',
    avatar: '🧱',
    role: 'Narrator — arranging boxes in a warehouse',
    bodyIntro:
        "The simplest way to give a process memory is contiguous "
        "allocation: one unbroken block of RAM, start to end. Simple — but "
        "as processes come and go, the free space gets chopped into "
        "scattered, unusable slivers. That's external fragmentation: "
        "plenty of free memory in total, but no single hole big enough "
        "for the next request.\n\nThere's a second kind too: internal "
        "fragmentation — when a process is given a fixed-size block "
        "bigger than it actually needs, and the leftover space inside "
        "that block is wasted.\n\nModern systems mostly dodge this with "
        "paging — fixed-size chunks everywhere.",
    calloutHints: [
      "🧩 Analogy: external fragmentation is like having five separate "
          "empty parking spots, none big enough for a bus. Internal "
          "fragmentation is like parking a motorcycle in a bus-sized spot "
          "— the space is \"used\" but mostly wasted.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Sort each scenario into the correct type of fragmentation.",
      bucketALabel: '🕳️ External',
      bucketBLabel: '📦 Internal',
      items: [
        Sort2Item('scattered', '500MB free total, but split into ten 50MB holes — no single request over 50MB fits', true),
        Sort2Item('oversized', 'A process needing 3KB is given a fixed 4KB block; 1KB sits wasted inside it', false),
        Sort2Item('gaps', 'Freed blocks between allocated ones leave unusable gaps as processes exit', true),
      ],
      explainOk:
          "Correct — external fragmentation is wasted space BETWEEN "
          "allocations; internal is wasted space INSIDE a block that's "
          "too big for its tenant.",
      explainBad:
          "Remember: external = scattered unusable gaps between blocks; "
          "internal = wasted space left over inside one oversized block.",
    ),
  ),
  const Chapter(
    id: 14,
    title: 'Paging & Address Translation',
    avatar: '🗺️',
    role: 'Narrator — reading a two-part map',
    bodyIntro:
        "Paging fixes fragmentation by chopping both virtual memory and "
        "physical RAM into fixed-size pages (virtual side) and frames "
        "(physical side) — commonly 4KB each. A process's pages don't "
        "need to sit next to each other in RAM at all.\n\nEvery memory "
        "address I use is a virtual address, split into a page number and "
        "an offset. The page table (one per process) maps each page "
        "number to the physical frame number that actually holds it. The "
        "MMU does this translation in hardware, on every single memory "
        "access: the page number is looked up in the page table to get a "
        "frame number, then combined with the SAME offset to form the "
        "physical address.",
    calloutHints: [
      "🔑 The offset never changes during translation — only the page "
          "number gets swapped for a frame number. That's why page/frame "
          "sizes must always match exactly.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Put the steps of translating a virtual address into a physical "
          "one in the correct order.",
      items: [
        OrderItem('split', 'CPU generates a virtual address; MMU splits it into page number + offset'),
        OrderItem('lookup', "MMU looks up that page number in the process's page table"),
        OrderItem('frame', 'Page table returns the matching physical frame number'),
        OrderItem('combine', 'MMU combines frame number + the SAME offset into a physical address'),
      ],
      explainOk:
          "That's exactly how the MMU does it, on every single memory "
          "access, transparently to your program.",
      explainBad:
          "Order matters: first split the address, then look up the page "
          "number, get back a frame number, then recombine with the "
          "untouched offset.",
    ),
  ),
  const Chapter(
    id: 15,
    title: 'Segmentation vs Paging',
    avatar: '📐',
    role: 'Narrator — comparing two floor plans',
    bodyIntro:
        "Segmentation is an older, different idea: instead of fixed-size "
        "pages, split memory into variable-size logical segments that "
        "match how programmers actually think — a code segment, a data "
        "segment, a stack segment — each can be a different size.\n\n"
        "Paging uses fixed-size chunks, has no external fragmentation, "
        "and is invisible to the programmer. Segmentation uses "
        "variable-size, meaningful chunks that match logical program "
        "structure, but can suffer external fragmentation.\n\nMost modern "
        "systems (like x86-64 in practice) use paging as the primary "
        "mechanism, sometimes layering a little bit of segmentation-like "
        "structure on top for protection.",
    calloutHints: [
      "🏗️ Real-world takeaway: fixed-size units (paging) are easier to "
          "manage efficiently at scale; variable-size units (segmentation) "
          "are easier to reason about logically. This exact tradeoff shows "
          "up again later in file systems and databases.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a property on the left, then click which scheme it "
          "describes on the right.",
      pairs: [
        MatchPair('fixed', 'Fixed-size chunks everywhere', 'Paging'),
        MatchPair('logical', 'Variable-size chunks matching program structure (code/data/stack)', 'Segmentation'),
        MatchPair('nofrag', 'Eliminates external fragmentation by design', 'Paging'),
      ],
      explainOk:
          "Correct — paging trades logical meaning for uniform, "
          "fragmentation-free chunks; segmentation trades uniformity for "
          "logical structure.",
    ),
  ),
  const Chapter(
    id: 16,
    title: 'Multilevel Page Tables',
    avatar: '🪜',
    role: 'Narrator — climbing a ladder of tables',
    bodyIntro:
        "A 64-bit address space is enormous. A single flat page table "
        "covering all of it would itself need to be gigabytes in size, "
        "per process — even for a process only using a tiny sliver of "
        "that space.\n\nThe fix: multilevel page tables — a tree of page "
        "tables. The top level only has entries for regions actually in "
        "use; unused branches simply don't exist, saving enormous amounts "
        "of memory.",
    calloutHints: [
      "💸 Tradeoff: multilevel lookups mean MORE memory accesses per "
          "translation (one per level) — which is exactly why CPUs cache "
          "recent translations in a small hardware cache called the TLB "
          "(Translation Lookaside Buffer), so most lookups skip the walk "
          "entirely.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why do real operating systems use multilevel (tree-structured) "
          "page tables instead of one giant flat table per process?",
      options: [
        'A flat table would be faster but multilevel looks more impressive in textbooks',
        'A flat table covering a huge address space would waste enormous memory on unused regions; multilevel only allocates tables for regions actually in use',
        'Multilevel tables are required to make context switching possible at all',
        'Flat tables cannot represent more than 256 pages',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — sparse address space usage means most of a flat "
          "table would be empty waste. Multilevel tables skip whole "
          "unused branches entirely.",
      explainBad:
          "The core motivation is memory efficiency: a flat table sized "
          "for a huge address space wastes memory on regions the process "
          "never touches; a tree structure can just omit those branches.",
    ),
  ),
  const Chapter(
    id: 17,
    title: 'Demand Paging & Page Faults',
    avatar: '📭',
    role: 'Narrator — opening an empty mailbox',
    bodyIntro:
        "Virtual memory lets me believe I own more memory than physically "
        "exists, using disk as overflow. With demand paging, a page isn't "
        "loaded into RAM until the moment it's actually accessed.\n\nIf I "
        "touch a page that isn't in RAM yet, the MMU raises a page fault "
        "— not an error, just a signal to the OS: go fetch this page from "
        "disk. The OS finds a free physical frame (or evicts something), "
        "loads the page's data from disk, updates the page table, and "
        "restarts the faulting instruction, which now succeeds.",
    calloutHints: [
      "⏱️ A page fault that hits disk can cost MILLIONS of times longer "
          "than a normal memory access — disk I/O is that much slower "
          "than RAM. This is why minimizing page faults matters so much "
          "for performance.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What is a page fault, precisely?",
      options: [
        'A hardware failure that crashes the process',
        "A signal that the accessed page isn't currently in physical RAM and must be fetched (typically from disk)",
        'An error meaning the process tried to access memory it never owned',
        'A special instruction used only during process termination',
      ],
      answerIndex: 1,
      explainOk:
          "Right — a page fault is a normal, expected control-flow event: "
          "'this page isn't in RAM yet, go get it,' not a crash.",
      explainBad:
          "A page fault isn't a crash — it's the MMU's way of telling the "
          "OS 'this valid page just isn't resident in RAM right now, "
          "please load it.'",
    ),
  ),
  const Chapter(
    id: 18,
    title: 'FIFO Page Replacement',
    avatar: '🚪',
    role: 'Narrator — first in, first out the door',
    bodyIntro:
        "When RAM is full and a new page must be loaded, something has to "
        "be evicted. FIFO evicts whichever page has been in memory the "
        "LONGEST, regardless of how recently it was used.\n\nWith 3 "
        "frames, trace A B C A D: A faults in, B faults in, C faults in, A "
        "is a hit (already there), then D faults and evicts A — the "
        "oldest, by FIFO order.",
    calloutHints: [
      "😬 FIFO has a famous quirk called Belady's Anomaly: sometimes "
          "adding MORE frames actually causes MORE page faults, not fewer "
          "— deeply counter-intuitive, and one of the reasons FIFO is "
          "rarely used in production.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "With only 2 frames, trace reference string A B C A. Drag these "
          "events into the order they happen.",
      items: [
        OrderItem('e1', 'A loaded — fault (frames: A)'),
        OrderItem('e2', 'B loaded — fault (frames: A, B)'),
        OrderItem('e3', 'C requested — fault, evict A, the OLDEST (frames: B, C)'),
        OrderItem('e4', 'A requested again — fault, evict B, now oldest (frames: C, A)'),
      ],
      explainOk:
          "Exactly — FIFO always evicts whoever arrived first among the "
          "currently-resident pages, regardless of recent use.",
      explainBad:
          "FIFO tracks arrival order only: with 2 frames, A and B fill "
          "both slots, then C evicts A (oldest), then A must fault back in "
          "and evicts B (now oldest).",
    ),
  ),
  const Chapter(
    id: 19,
    title: 'LRU Page Replacement',
    avatar: '🕰️',
    role: "Narrator — checking who hasn't been touched in a while",
    bodyIntro:
        "LRU (Least Recently Used) evicts the page that hasn't been "
        "touched for the longest time — a much better approximation of "
        "\"probably won't be needed again soon\" than FIFO's blind arrival "
        "order.\n\nWith 3 frames, trace A B C A D under LRU: A B C A load "
        "with no evictions needed yet (all fit). When D arrives, frames "
        "are full [A,B,C]; the least recently used is B (A was just "
        "re-used!), so B is evicted.\n\nCompare to FIFO, which evicted A "
        "here — LRU correctly noticed A was touched more recently and "
        "protected it instead.",
    calloutHints: [
      "💰 The catch: true LRU needs precise timestamps or a "
          "doubly-linked \"recency list\" maintained on every access — "
          "real hardware/OS combinations often approximate it (e.g. "
          "Linux's clock/\"second-chance\" algorithm) rather than "
          "implement it perfectly, trading a little accuracy for speed.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Frames hold [A, B, C] in that load order. Then A is accessed "
          "again (a hit), then D must be loaded, forcing an eviction. "
          "Which page does LRU evict, and why?",
      options: [
        'A — because it was the first one ever loaded',
        "B — because among the resident pages, it's the one that hasn't been touched most recently",
        "C — because it's alphabetically last",
        'D — because it was just requested',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — LRU only cares about RECENCY of use. Re-accessing A "
          "resets its recency, leaving B as the least-recently-used "
          "victim.",
      explainBad:
          "LRU evicts based on recency of USE, not load order. Since A "
          "was just re-accessed, B — untouched the longest — is the "
          "correct victim, not A.",
    ),
  ),
  const Chapter(
    id: 20,
    title: 'Thrashing & the Working Set',
    avatar: '🌪️',
    role: 'Narrator — spinning wheels, going nowhere',
    bodyIntro:
        "If too many processes compete for too little RAM, each one's "
        "pages keep getting evicted right before they're needed again — "
        "causing a constant storm of page faults. This is thrashing: the "
        "system spends almost all its time swapping pages in and out, and "
        "almost none actually computing.\n\nThe fix is the working set "
        "model: track the set of pages each process actually needs right "
        "now to make progress without faulting constantly. If total "
        "memory can't hold every active process's working set, the OS "
        "should reduce the NUMBER of processes running at once, not just "
        "shuffle pages faster.",
    calloutHints: [
      "📉 Thrashing produces a scary graph: as you add more processes, "
          "throughput first rises — then suddenly collapses toward zero, "
          "because CPU utilization drops as everyone waits on disk. Adding "
          "MORE load makes the system do LESS useful work — the opposite "
          "of what you'd expect.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A server's CPU usage is only 5%, disk I/O is pegged at 100%, "
          "and overall throughput has collapsed even though 40 processes "
          "are all technically 'running.' What's happening, and what's "
          "the fix?",
      options: [
        'The CPU is broken; replace the hardware',
        "This is thrashing — too many processes for available RAM. Reduce the number of concurrently running processes so each one's working set actually fits in memory",
        'This is a deadlock; kill all 40 processes',
        'This is normal, healthy, fully-utilized behavior',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — near-zero CPU use with maxed-out disk I/O is the "
          "signature of thrashing. The fix is admitting fewer processes, "
          "not scheduling harder.",
      explainBad:
          "Low CPU usage + maxed disk I/O + collapsed throughput is the "
          "classic thrashing signature — too many processes fighting over "
          "too little RAM. The fix is to run fewer processes at once, not "
          "tune the scheduler.",
    ),
  ),
  const Chapter(
    id: 21,
    title: 'Files, Inodes & Directories',
    avatar: '🗃️',
    role: 'Narrator — opening a filing cabinet',
    bodyIntro:
        "A file system organizes disk space into named files and "
        "directories. On Unix-like systems, every file has an inode — a "
        "small record holding its metadata (size, permissions, "
        "timestamps, and pointers to where its actual DATA blocks live on "
        "disk) — but notably, not the filename itself.\n\nA directory is "
        "just a special file: a list of (filename → inode number) pairs. "
        "That's why you can have hard links — two different filenames "
        "pointing at the exact same inode, the exact same underlying "
        "data.",
    calloutHints: [
      "🔗 This separation (name lives in the directory, data lives via "
          "the inode) is why renaming a huge file is instant — you're "
          "only rewriting a tiny directory entry, not moving any of the "
          "actual data blocks.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a term, then click its correct description.",
      pairs: [
        MatchPair('inode', 'Inode', "Metadata + pointers to a file's data blocks (no filename inside it)"),
        MatchPair('dir', 'Directory', 'A special file mapping filenames to inode numbers'),
        MatchPair('hardlink', 'Hard link', 'A second filename pointing at the SAME inode as an existing file'),
      ],
      explainOk:
          "Correct — separating names (in directories) from data (via "
          "inodes) is what makes renames instant and hard links possible.",
    ),
  ),
  const Chapter(
    id: 22,
    title: 'Disk Scheduling',
    avatar: '💽',
    role: "Narrator — planning the read/write head's route",
    bodyIntro:
        "On a spinning disk, the read/write head has to physically move "
        "across tracks — and that movement (seek time) is slow. Disk "
        "schedulers decide the ORDER to service pending read/write "
        "requests to minimize total head movement.\n\nHead starts at "
        "track 50. Pending requests: tracks 10, 90, 30, 70. FCFS services "
        "in arrival order: 50→10→90→30→70, with huge, backtracking "
        "movement. SSTF (Shortest Seek Time First) always jumps to the "
        "nearest pending request: 50→30→10→70→90, much less movement, but "
        "can starve far-away requests. SCAN sweeps in one direction like "
        "an elevator, servicing everything in its path, then reverses: "
        "50→30→10→(reverse)→70→90 — fair AND efficient, the standard "
        "real-world pick.",
    calloutHints: [
      "🛗 SCAN is literally called the \"elevator algorithm\" — it "
          "behaves exactly like a building elevator that keeps moving one "
          "direction, picking up everyone along the way, before "
          "reversing.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Head starts at track 40, moving upward (increasing track "
          "numbers). Pending requests: 60, 20, 80, 10. Drag into SCAN "
          "service order.",
      items: [
        OrderItem('t60', 'Track 60'),
        OrderItem('t80', 'Track 80'),
        OrderItem('t20', 'Track 20 (serviced after reversing direction)'),
        OrderItem('t10', 'Track 10 (serviced after reversing direction)'),
      ],
      explainOk:
          "Exactly — moving upward from 40, it hits 60 then 80 first, "
          "then reverses and sweeps down through 20 then 10.",
      explainBad:
          "SCAN keeps moving in its current direction (upward from 40) "
          "until it runs out of requests that way — 60, then 80 — then "
          "reverses and picks up 20, then 10.",
    ),
  ),
  const Chapter(
    id: 23,
    title: 'Buffering & Caching I/O',
    avatar: '🧊',
    role: 'Narrator — keeping a cold drink close by',
    bodyIntro:
        "Disk (or network) I/O is thousands of times slower than RAM. The "
        "OS hides much of that cost with a page cache: recently-read disk "
        "blocks are kept in RAM, so a second read of the same data can be "
        "served instantly, no disk trip needed.\n\nWrites get the same "
        "treatment via write-back caching: a write updates the in-RAM "
        "cache immediately and returns success to the program right away "
        "— the actual disk write happens later, in the background. Fast, "
        "but risky: if the system crashes before that background write "
        "completes, the data is lost.",
    calloutHints: [
      "⚠️ This exact tradeoff — \"fast now, but riskier if we crash\" — "
          "is why databases use a WRITE-AHEAD LOG: log the intent to disk "
          "FIRST, cheaply, before touching the real data.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A program reads the same 1MB file twice in a row. The second "
          "read returns almost instantly, far faster than the first. "
          "Why?",
      options: [
        'The disk itself gets physically faster after the first read',
        'The file shrank after being read once',
        "The OS's page cache already holds those disk blocks in RAM from the first read, so the second read is served from memory instead of disk",
        'The second read is actually reading a different, smaller file',
      ],
      answerIndex: 2,
      explainOk:
          "Right — the OS transparently caches recently-read disk blocks "
          "in RAM, so repeat reads skip the slow disk entirely.",
      explainBad:
          "The disk hasn't changed — the OS's page cache kept those "
          "blocks in RAM after the first read, so the second read is "
          "served from fast memory instead of slow disk.",
    ),
  ),
  const Chapter(
    id: 24,
    title: 'Journaling & Crash Recovery',
    avatar: '📔',
    role: 'Narrator — keeping a diary before acting',
    bodyIntro:
        "What happens if the power dies HALF-way through a multi-step "
        "file system update? Without protection, the file system could be "
        "left in an inconsistent, corrupted state.\n\nJournaling file "
        "systems fix this: before making a risky multi-step change, they "
        "first write a short summary of the INTENDED change to a special "
        "log (the journal). If the system crashes mid-update, on reboot "
        "it replays the journal to either finish or cleanly undo the "
        "incomplete change — never leaving things half-done.",
    calloutHints: [
      "🧠 This is the exact same idea as a database's write-ahead log, "
          "and the same idea behind \"atomic\" operations everywhere in "
          "computing: write down your intent durably FIRST, then act — so "
          "recovery is always possible.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why do journaling file systems write a log entry describing a "
          "change BEFORE actually performing that multi-step change on "
          "disk?",
      options: [
        'It makes writes slower on purpose, for no real benefit',
        "So that if the system crashes mid-change, the journal can be replayed on reboot to finish or cleanly undo the operation, avoiding a half-done, corrupted state",
        "The journal is just a backup copy in case the file is deleted later",
        "It's required by law for all modern operating systems",
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — logging intent first guarantees a crash can never "
          "leave a multi-step update stuck half-finished; recovery just "
          "replays the journal.",
      explainBad:
          "The journal exists purely for crash recovery: by recording "
          "intent before acting, a crash mid-operation can always be "
          "resolved cleanly by replaying (or discarding) the journal "
          "entry.",
    ),
  ),
  const Chapter(
    id: 25,
    title: 'Semaphores — Beyond the Simple Lock',
    avatar: '🚦',
    role: 'Narrator — counting available seats',
    bodyIntro:
        "A mutex is a binary lock: locked or unlocked, one holder at a "
        "time. A semaphore generalizes this with a counter: it allows up "
        "to N threads to hold it simultaneously, not just one.\n\nThink of "
        "a parking garage with 5 spots. Each arriving car calls wait() "
        "(decrementing the counter); if the counter is 0, new cars must "
        "wait. Each leaving car calls signal() (incrementing it back), "
        "waking up anyone queued. A mutex is just a semaphore with N=1.",
    calloutHints: [
      "🎯 Semaphores are perfect for limiting how many threads can use a "
          "LIMITED resource pool at once — like a fixed-size database "
          "connection pool or a fixed number of worker threads — not just "
          "\"one thread at a time.\"",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Match each term to its correct meaning.",
      pairs: [
        MatchPair('binary', 'Mutex (binary semaphore)', 'A semaphore with count = 1 — exactly one holder at a time'),
        MatchPair('counting', 'Counting semaphore', 'Allows up to N simultaneous holders, tracked by a counter'),
        MatchPair('wait', 'wait() / acquire()', 'Decrements the counter; blocks the caller if it would go below 0'),
      ],
      explainOk:
          "Correct — a mutex is just the N=1 special case of the more "
          "general counting semaphore.",
    ),
  ),
  const Chapter(
    id: 26,
    title: 'The Producer-Consumer Problem',
    avatar: '🏭',
    role: 'Narrator — running a tiny assembly line',
    bodyIntro:
        "Classic concurrency puzzle: a producer thread creates items and "
        "places them in a shared, fixed-size buffer; a consumer thread "
        "removes and processes them. Two failure modes to avoid: the "
        "producer must NOT add to a FULL buffer, and the consumer must "
        "NOT remove from an EMPTY buffer.\n\nThe standard solution uses "
        "two counting semaphores plus one mutex: emptySlots (starts at "
        "buffer size) — the producer waits on this before adding; "
        "fullSlots (starts at 0) — the consumer waits on this before "
        "removing; and mutex, which protects the buffer itself during "
        "add/remove.",
    calloutHints: [
      "🎬 This exact pattern is everywhere in real software: a web "
          "server's request queue, a logging pipeline, a video streaming "
          "buffer — anywhere something produces faster or slower than "
          "something else consumes.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Put the producer's steps for safely adding one item to the "
          "shared buffer in the correct order.",
      items: [
        OrderItem('waitempty', 'wait(emptySlots) — block if the buffer is currently full'),
        OrderItem('lock', 'lock(mutex) — get exclusive access to the buffer'),
        OrderItem('add', 'Add the item into the buffer'),
        OrderItem('unlock', 'unlock(mutex) — release exclusive access'),
        OrderItem('signalfull', 'signal(fullSlots) — wake up a waiting consumer'),
      ],
      explainOk:
          "That's the textbook safe ordering — check for space, lock, "
          "mutate, unlock, then signal that new data is ready.",
      explainBad:
          "The order matters: first make sure there's room (wait on "
          "emptySlots), THEN lock the buffer to mutate it safely, unlock, "
          "and finally signal fullSlots so a consumer wakes up.",
    ),
  ),
  const Chapter(
    id: 27,
    title: 'Readers-Writers Problem',
    avatar: '📖',
    role: 'Narrator — sharing one big library book',
    bodyIntro:
        "Shared data that's read often but written rarely deserves a "
        "smarter rule than \"only one thread at a time, period.\" The "
        "readers-writers pattern allows multiple readers simultaneously — "
        "reading doesn't change anything, so it's always safe for many "
        "readers to overlap — but only one writer, and only when NO "
        "readers or other writers are active.\n\nA naive implementation "
        "can starve writers forever if readers keep arriving "
        "continuously. Production implementations usually add a fairness "
        "rule: once a writer is waiting, no NEW readers may start until "
        "that writer has had its turn.",
    calloutHints: [
      "📚 This is exactly the concurrency model behind most real caches "
          "and config stores: cheap concurrent reads, exclusive rare "
          "writes, with fairness rules to prevent writer starvation.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Three threads want to READ a shared config object at the same "
          "moment, and no thread wants to write. What should happen under "
          "the readers-writers pattern?",
      options: [
        'Only one reader is allowed at a time; the other two must wait',
        "All three readers may proceed concurrently, since reading doesn't modify shared state",
        'The read must be blocked until a writer arrives first',
        'The config object must be locked exclusively for each reader in turn',
      ],
      answerIndex: 1,
      explainOk:
          "Right — concurrent reads are always safe to overlap since "
          "nothing is being mutated; the pattern's entire point is not "
          "serializing pure readers unnecessarily.",
      explainBad:
          "The whole benefit of readers-writers locking is that "
          "concurrent READS never conflict with each other — all three "
          "readers should be able to proceed simultaneously.",
    ),
  ),
  const Chapter(
    id: 28,
    title: 'Monitors & Condition Variables',
    avatar: '🖥️',
    role: 'Narrator — waiting politely, not endlessly checking',
    bodyIntro:
        "Raw semaphores are powerful but easy to misuse — forget one "
        "signal() and threads deadlock forever. Monitors package a lock "
        "together with the shared data AND the operations on it, so "
        "mutual exclusion is automatic and hard to forget.\n\nInside a "
        "monitor, a thread that finds a condition it needs isn't true yet "
        "calls wait() on a condition variable — this atomically releases "
        "the monitor's lock AND puts the thread to sleep, instead of "
        "wastefully spinning in a loop re-checking (busy-waiting, which "
        "burns CPU for nothing). Another thread later calls notify() to "
        "wake it up once the condition changes.",
    calloutHints: [
      "😴 Busy-waiting vs condition variables is a direct efficiency "
          "tradeoff: spinning in a loop wastes CPU cycles doing nothing "
          "useful; sleeping on a condition variable costs nothing while "
          "waiting and wakes up exactly when there's real work to do.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Match each term to its meaning.",
      pairs: [
        MatchPair('monitor', 'Monitor', 'A lock bundled together with shared data and its operations'),
        MatchPair('condvar', 'Condition variable wait()', 'Atomically releases the lock and sleeps until notified'),
        MatchPair('busywait', 'Busy-waiting', 'Repeatedly checking a condition in a loop, wasting CPU cycles'),
      ],
      explainOk:
          "Correct — monitors make locking hard to forget, and condition "
          "variables let threads sleep efficiently instead of "
          "busy-waiting.",
    ),
  ),
  const Chapter(
    id: 29,
    title: 'The Four Conditions for Deadlock',
    avatar: '🔗',
    role: 'Narrator — naming the trap precisely',
    bodyIntro:
        "Deadlock requires ALL FOUR of these conditions to hold "
        "simultaneously — break any ONE, and deadlock becomes impossible: "
        "mutual exclusion (resources can't be shared; only one holder at "
        "a time), hold and wait (a thread holds one resource while "
        "waiting for another), no preemption (a resource can't be "
        "forcibly taken back from its holder), and circular wait (a cycle "
        "of threads, each waiting on the next one's resource).",
    calloutHints: [
      "🎯 This is exactly why \"always acquire locks in the same global "
          "order\" works as a fix — it makes circular wait structurally "
          "impossible, breaking condition #4 without touching the other "
          "three.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Match each real scenario to the deadlock condition it "
          "demonstrates.",
      pairs: [
        MatchPair('hold', 'Thread A grabs lock1, then tries to also grab lock2 while still holding lock1', 'Hold and wait'),
        MatchPair('circ', "A waits on B's resource, B waits on C's resource, C waits on A's resource", 'Circular wait'),
        MatchPair('nopre', "The OS cannot forcibly strip a lock away from a thread that's holding it", 'No preemption'),
      ],
      explainOk:
          "Exactly right — recognizing which condition is present in "
          "real code is the first step toward picking the right fix.",
    ),
  ),
  const Chapter(
    id: 30,
    title: 'Deadlock Detection with a Resource Graph',
    avatar: '🕸️',
    role: 'Narrator — drawing arrows until a loop appears',
    bodyIntro:
        "Instead of preventing deadlock outright, some systems just "
        "DETECT it after the fact using a resource allocation graph: draw "
        "an arrow from a process to a resource it's waiting for, and from "
        "a resource to the process currently holding it.\n\nExample: P1 → "
        "R1 (waiting), R1 → P2 (held by), P2 → R2 (waiting), R2 → P1 (held "
        "by). Follow the arrows: P1 → R1 → P2 → R2 → P1 — that's a CYCLE, "
        "and a cycle in this graph means deadlock exists (for "
        "single-instance resources). If there's no cycle, the system is "
        "safe.",
    calloutHints: [
      "🔍 Real systems (like database engines) run deadlock detection "
          "periodically rather than preventing it upfront, because "
          "prevention is often too restrictive — then they simply pick "
          "one process in the cycle to kill/rollback, breaking the "
          "cycle.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A resource allocation graph shows: P1 waits for R1 (held by "
          "P2); P2 waits for R2 (held by P3); P3 holds R2 and needs "
          "nothing else. Is this a deadlock?",
      options: [
        'Yes — any waiting relationship at all is automatically a deadlock',
        "No — following the arrows, P3 needs nothing further, so the chain ends there; there's no CYCLE back to P1",
        'Yes, but only because there are exactly 3 processes involved',
        'It depends on which programming language wrote the code',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — deadlock requires a CYCLE. Since P3 isn't waiting "
          "on anything, the chain terminates and everyone can eventually "
          "proceed.",
      explainBad:
          "Deadlock specifically requires a CYCLE in the graph. Here P3 "
          "holds R2 but waits for nothing else, so the chain dead-ends "
          "rather than looping back — no cycle, no deadlock.",
    ),
  ),
  const Chapter(
    id: 31,
    title: 'Deadlock Prevention Strategies',
    avatar: '🛡️',
    role: 'Narrator — picking which rule to break',
    bodyIntro:
        "Since deadlock needs all four conditions, prevention just means "
        "permanently disabling one of them: attack mutual exclusion by "
        "using resources that support sharing where possible; attack "
        "hold and wait by requiring processes to request ALL needed "
        "resources upfront, atomically; attack no preemption by allowing "
        "the OS to forcibly take a resource back and roll back progress "
        "if needed; or attack circular wait by imposing a global "
        "ordering on resource acquisition.",
    calloutHints: [
      "⚖️ Every one of these has a real cost: requesting everything "
          "upfront hurts concurrency (you hold resources you're not using "
          "yet); preemption requires safe rollback logic. There's no free "
          "lunch — prevention always trades away some flexibility.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Sort each real prevention strategy by which deadlock "
          "condition it targets.",
      bucketALabel: '✋ Hold and Wait',
      bucketBLabel: '🔢 Circular Wait',
      items: [
        Sort2Item('upfront', 'Require a process to request ALL resources it will ever need at once, before starting', true),
        Sort2Item('ordering', 'Force every thread to acquire locks in the exact same numeric order, always', false),
        Sort2Item('allornothing', 'If any requested resource is unavailable, release everything already held and retry later', true),
      ],
      explainOk:
          "Correct — upfront/all-or-nothing requesting attacks "
          "hold-and-wait; global lock ordering attacks circular wait.",
      explainBad:
          "Requesting everything upfront (or releasing all on partial "
          "failure) attacks HOLD AND WAIT. A fixed global acquisition "
          "order attacks CIRCULAR WAIT.",
    ),
  ),
  const Chapter(
    id: 32,
    title: "The Banker's Algorithm",
    avatar: '🏦',
    role: 'Narrator — checking the vault before lending',
    bodyIntro:
        "The Banker's Algorithm avoids deadlock proactively: before "
        "granting a resource request, it simulates \"what if I say yes?\" "
        "and only approves the request if the system would still be left "
        "in a safe state — meaning there's SOME order in which every "
        "process could still finish, even in the worst case.\n\nLike a "
        "bank that won't approve a loan if doing so could leave it unable "
        "to cover ALL its other outstanding commitments, even in a "
        "worst-case scenario where everyone asks for their max at once.",
    calloutHints: [
      "🧮 The real cost: the Banker's Algorithm requires knowing every "
          "process's MAXIMUM possible future resource need in advance — "
          "information that's rarely available in general-purpose "
          "operating systems, which is why it's more of a foundational "
          "teaching algorithm than something you'll find running in, "
          "say, Linux's kernel scheduler.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "5 units of a resource are available. P1 might need up to 4 "
          "more; P2 might need up to 1 more. If the system grants P2's "
          "request for its 1 unit, is the resulting state SAFE?",
      options: [
        'No — granting any request always immediately causes deadlock',
        "Yes, as long as there's still some way for every process to eventually get enough to finish, even in the worst case — here, 4 units remain, enough to cover either process's worst case",
        'Only safe if P1 is destroyed first',
        "Unsafe, because P1's maximum need exceeds what's currently available",
      ],
      answerIndex: 1,
      explainOk:
          "Right — a state is safe if there EXISTS some completion "
          "order, even a worst-case one. With 4 units left after granting "
          "P2, both processes' worst-case needs are still coverable.",
      explainBad:
          "Safety only requires that SOME valid finishing order exists, "
          "not that every process could finish immediately. After "
          "granting P2's request, 4 units remain — still enough to "
          "eventually satisfy either process's worst-case need.",
    ),
  ),
  const Chapter(
    id: 33,
    title: 'Pipes & Message Queues',
    avatar: '🚰',
    role: 'Narrator — connecting two garden hoses',
    bodyIntro:
        "Threads share memory automatically, but separate PROCESSES "
        "don't — each has its own isolated address space. To communicate, "
        "they need explicit Inter-Process Communication (IPC) "
        "mechanisms.\n\nA pipe is the simplest: a one-way byte stream "
        "connecting one process's output to another's input — exactly "
        "what the shell's | operator creates. A message queue is more "
        "structured: discrete, labeled messages that can be read in any "
        "order, and can support many senders and receivers at once.",
    calloutHints: [
      "🐧 Fun fact: ls | grep foo in your shell creates TWO separate "
          "processes connected by exactly one pipe — a perfect real-world "
          "example of IPC you've probably used today without thinking "
          "about it.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Match each mechanism to its best description.",
      pairs: [
        MatchPair('pipe', 'Pipe', "One-way byte stream between two processes, like shell's | operator"),
        MatchPair('mq', 'Message queue', 'Discrete labeled messages, readable out of order, supports many senders/receivers'),
        MatchPair('isolation', 'Why IPC is needed at all', "Separate processes have isolated address spaces and can't share memory directly"),
      ],
      explainOk:
          "Correct — process isolation is exactly why explicit IPC "
          "mechanisms exist in the first place.",
    ),
  ),
  const Chapter(
    id: 34,
    title: 'Shared Memory IPC',
    avatar: '🏗️',
    role: 'Narrator — building a shared room between two houses',
    bodyIntro:
        "Shared memory is the fastest IPC mechanism: the OS maps the SAME "
        "physical memory region into both processes' virtual address "
        "spaces. After setup, reading and writing is just normal memory "
        "access — no system call overhead per operation, unlike pipes or "
        "message queues which require the kernel to copy data on every "
        "send/receive.\n\nThe tradeoff: since it's just raw shared memory, "
        "YOU are responsible for synchronization — usually with a "
        "semaphore or mutex ALSO placed in that shared region, to prevent "
        "race conditions.",
    calloutHints: [
      "🏎️ Rule of thumb: pipes/queues are safer and simpler (the kernel "
          "handles the synchronization implicitly via its internal "
          "buffering); shared memory is faster but pushes the "
          "synchronization burden entirely onto your own code.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why is shared memory the fastest IPC mechanism, but also the "
          "riskiest?",
      options: [
        "It's fastest because it uses a faster CPU core reserved for IPC, and risky because that core sometimes fails",
        "It's fastest because reads/writes are ordinary memory access with no per-operation kernel copy; it's risky because the processes themselves must handle synchronization to avoid race conditions",
        "It's neither fast nor risky compared to pipes",
        "It's fastest because it doesn't actually transfer any data",
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — skipping the kernel's copy-and-buffer overhead makes "
          "it fast, but that same lack of kernel mediation means YOU must "
          "add your own locking.",
      explainBad:
          "Shared memory is fast because normal memory instructions "
          "replace kernel-mediated copying; it's risky precisely because "
          "that kernel mediation (which used to provide implicit safety) "
          "is now gone — you must synchronize it yourself.",
    ),
  ),
  const Chapter(
    id: 35,
    title: 'System Calls & Mode Switching',
    avatar: '🚪',
    role: 'Narrator — crossing a heavily guarded door',
    bodyIntro:
        "Normal program code runs in user mode — restricted, sandboxed, "
        "unable to directly touch hardware or other processes' memory. To "
        "do anything privileged, a program must ask the kernel via a "
        "system call, which triggers a mode switch into kernel mode — "
        "full hardware access, but only trusted kernel code runs "
        "there.\n\nWhen user code calls read(fd, buf, n): the CPU traps "
        "into kernel mode, the kernel validates the request and performs "
        "the actual disk/device I/O, then the CPU switches back to user "
        "mode, returning the result.",
    calloutHints: [
      "💸 Mode switches aren't free (similar in spirit to context "
          "switches) — which is exactly why performance-sensitive code "
          "tries to minimize the NUMBER of system calls, batching work "
          "where possible instead of making one tiny syscall per byte.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Put the steps of a read() system call in the correct order.",
      items: [
        OrderItem('call', 'User-mode code calls read(fd, buf, n)'),
        OrderItem('trap', 'CPU traps into kernel mode'),
        OrderItem('validate', 'Kernel validates the request and performs the actual I/O'),
        OrderItem('return', 'CPU switches back to user mode with the result'),
      ],
      explainOk:
          "That's the full round trip — user mode requests, kernel mode "
          "executes privileged work, then control returns to user mode.",
      explainBad:
          "The call always originates in user mode, THEN traps into "
          "kernel mode for the privileged work, and only returns to user "
          "mode afterward with the result.",
    ),
  ),
  const Chapter(
    id: 36,
    title: 'The Real Cost of a Context Switch',
    avatar: '💸',
    role: 'Narrator — counting every hidden cost',
    bodyIntro:
        "Context switches are expensive for several itemized reasons: "
        "saving/restoring all CPU registers and the program counter "
        "into/from the PCB; flushing CPU caches (L1/L2) that were warm "
        "with the old process's data, so the new process starts with "
        "cold caches; flushing the TLB (the page-table lookup cache), "
        "since the new process needs fresh address translations; and the "
        "scheduler itself takes time to decide who runs next.",
    calloutHints: [
      "📊 This is exactly why threads (sharing an address space, so no "
          "TLB flush needed) are cheaper to switch between than full "
          "processes — one of the concrete, measurable reasons "
          "\"lightweight\" threading exists at all.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Sort each cost by whether it applies to BOTH process and "
          "thread switches, or ONLY to full process switches.",
      bucketALabel: '⚙️ Both',
      bucketBLabel: '🐢 Process-only (extra cost)',
      items: [
        Sort2Item('registers', 'Saving/restoring CPU registers and program counter', true),
        Sort2Item('tlb', 'Flushing the TLB because the address space changed', false),
        Sort2Item('sched', 'Scheduler deciding who runs next', true),
      ],
      explainOk:
          "Correct — register save/restore and scheduling happen for any "
          "switch; TLB flushing is the extra cost unique to switching "
          "address spaces (i.e. full processes).",
      explainBad:
          "Register save/restore and scheduler decision-making happen on "
          "ANY switch. TLB flushing is the EXTRA cost that only applies "
          "when the address space actually changes — i.e. a process "
          "switch, not a thread switch within the same process.",
    ),
  ),
  const Chapter(
    id: 37,
    title: 'Professional Check — Scheduling Tradeoffs',
    avatar: '🎓',
    role: 'Narrator — the interview begins',
    bodyIntro:
        "Level 10. No more training wheels — these are the kinds of "
        "questions asked in real systems-engineering interviews and "
        "design reviews.\n\nA production web server currently uses Round "
        "Robin scheduling for its worker threads. Latency-sensitive "
        "requests (health checks, tiny API calls) are getting stuck "
        "behind long-running batch report generation requests, even "
        "though RR is supposed to be \"fair.\"",
    calloutHints: [
      "💡 Fairness in TURNS isn't the same as fairness in LATENCY. "
          "Giving every request an equal-sized time slice still means a "
          "request behind N others waits for N slices worth of total "
          "delay before it's even seen once.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the most professionally correct fix for "
          "latency-sensitive requests getting stuck behind long batch "
          "jobs under Round Robin?",
      options: [
        'Increase the time quantum so batch jobs finish in fewer rounds',
        'Introduce priority classes (or separate queues) so latency-sensitive work preempts or is scheduled ahead of batch work, rather than treating all requests as equally urgent',
        'Switch to pure FCFS instead',
        'Remove the scheduler entirely and let requests run in random order',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — this is exactly why real systems use "
          "multi-level/priority scheduling: 'fair turns' and 'acceptable "
          "latency for urgent work' are different goals, and mixing all "
          "work into one RR queue serves neither well.",
      explainBad:
          "Increasing the quantum makes the problem worse (longer turns "
          "for everyone), and FCFS has zero fairness at all. The real fix "
          "is separating work by urgency — priority scheduling or "
          "separate queues — so latency-sensitive requests aren't waiting "
          "behind unrelated batch work.",
    ),
  ),
  const Chapter(
    id: 38,
    title: 'Professional Check — Spot the Race Condition',
    avatar: '🐛',
    role: 'Narrator — reading real production code',
    bodyIntro:
        "Review this real-looking snippet from a multi-threaded cache "
        "implementation:\n\nif (!cache.containsKey(key)) { value = "
        "computeExpensiveValue(key); cache.put(key, value); } return "
        "cache.get(key);\n\nThis pattern (check-then-act) looks safe "
        "reading top to bottom on a single thread — but under "
        "concurrency, TWO threads can both pass the containsKey check "
        "before either calls put, and both proceed to redundantly call "
        "computeExpensiveValue. Worse, if the map itself isn't "
        "thread-safe, this can corrupt its internal state entirely.",
    calloutHints: [
      "🎯 This exact bug class — \"check-then-act\" without atomicity — "
          "is one of the single most common concurrency bugs in real "
          "production code, precisely because it looks completely "
          "correct in isolation.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the correct, professional fix for this check-then-act "
          "race condition in the cache example?",
      options: [
        'Add a sleep() call before the check to reduce the chance of overlap',
        "Make the check-then-act sequence atomic — e.g. use a lock around the whole check+compute+put block, or use an atomic 'computeIfAbsent'-style operation provided by a thread-safe map",
        'Nothing needs fixing; redundant computation is always harmless',
        'Run the cache on a single CPU core to prevent races',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the fix is making the read-check-write sequence "
          "atomic, either via explicit locking or an atomic compound "
          "operation, not hoping timing works out.",
      explainBad:
          "sleep() only makes the race less likely, not impossible — "
          "never a real fix. The correct fix makes the check-then-act "
          "sequence atomic: a lock around the whole block, or a "
          "thread-safe map's atomic compute-if-absent operation.",
    ),
  ),
  const Chapter(
    id: 39,
    title: 'Professional Check — Memory Leak Diagnosis',
    avatar: '📈',
    role: 'Narrator — watching a graph creep upward',
    bodyIntro:
        "A long-running server's memory usage graph climbs steadily over "
        "days, never dropping, until the process eventually gets killed "
        "by the OS for using too much RAM. No single request uses much "
        "memory.\n\nCommon real-world causes: objects added to a "
        "long-lived cache or list that's never pruned; event "
        "listeners/callbacks registered but never unregistered, each "
        "holding a reference that prevents garbage collection; and "
        "threads spawned but never joined/cleaned up, each with its own "
        "retained stack and state.",
    calloutHints: [
      "🔍 The professional diagnostic approach: take a heap snapshot at "
          "two different times, diff them, and look for whichever object "
          "TYPE grew the most — that almost always points straight at "
          "the leaking data structure.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Heap snapshots taken an hour apart show the count of "
          "'CacheEntry' objects has grown from 10,000 to 4,000,000, while "
          "everything else stayed roughly flat. What's the most likely "
          "root cause?",
      options: [
        'Normal garbage collector behavior, no action needed',
        'A cache that keeps adding entries without ever evicting old/unused ones — an unbounded cache growth leak',
        'A CPU scheduling bug, unrelated to memory',
        'A disk I/O bottleneck',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — a specific object type ballooning in count, "
          "isolated from everything else, is the classic signature of an "
          "unbounded cache (or similarly unpruned collection) leak.",
      explainBad:
          "A dramatic, isolated growth in ONE object type's count "
          "between snapshots points directly at that type's source — "
          "here, a cache that's never evicting, growing without bound.",
    ),
  ),
  const Chapter(
    id: 40,
    title: 'Final Boss — Distributed Systems Primer',
    avatar: '🏆',
    role: 'Narrator — the last challenge before the Shard',
    bodyIntro:
        "One last idea, beyond a single machine: when a system spans "
        "MULTIPLE machines, new tradeoffs appear that don't exist on one "
        "box. The most famous is the CAP theorem: during a network "
        "partition, a distributed system must choose between consistency "
        "(every read sees the latest write, even if that means refusing "
        "some requests) and availability (every request gets SOME "
        "response, even if it might be slightly stale). Partition "
        "tolerance is assumed — real networks DO fail sometimes, so you "
        "can't simply opt out of that.",
    calloutHints: [
      "🎓 You've now walked the entire road: from a single process's "
          "birth, through memory, scheduling, concurrency, and deadlock, "
          "all the way to the tradeoffs that run the largest distributed "
          "systems on Earth. This is genuinely how far a real OS/systems "
          "curriculum goes. Well earned. 💠",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "During a network partition, a distributed database chooses "
          "to keep accepting writes on both sides of the split (so it "
          "stays fully available), even though the two sides will "
          "temporarily disagree on the data. Which CAP tradeoff did it "
          "choose?",
      options: [
        'Consistency over Availability — it refused requests to stay correct',
        'Availability over Consistency — it kept serving requests even at the cost of temporary disagreement between sides',
        'It avoided the tradeoff entirely by ignoring the partition',
        'This scenario is impossible under the CAP theorem',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — choosing to keep responding to requests "
          "during a partition, even with temporarily inconsistent data, "
          "is picking Availability over Consistency. You've completed "
          "the full Process Peninsula curriculum. 💠",
      explainBad:
          "Continuing to accept and answer requests on both sides of a "
          "partition — even though they'll disagree — is explicitly "
          "choosing Availability over Consistency, one of the two real "
          "options CAP forces during a partition.",
    ),
  ),
  const Chapter(
    id: 41,
    title: 'Containers Are Not Magic: Linux Namespaces',
    avatar: '📦',
    role: 'Narrator — peeking behind the container illusion',
    bodyIntro:
        "Welcome to the professional tier. Here's the uncomfortable truth "
        "senior engineers eventually learn: a container is just a "
        "regular Linux process — wrapped in a set of kernel namespaces "
        "that change what that process is allowed to see, not what "
        "hardware it runs on.\n\nPID namespace makes the container's "
        "process think it's PID 1, blind to every other process on the "
        "host. NET namespace gives it its own virtual network stack. MNT "
        "namespace gives it its own filesystem mount tree. UTS namespace "
        "gives it its own hostname. USER namespace lets UID 0 inside the "
        "container map to an unprivileged UID on the host.\n\nThere is no "
        "\"container\" data structure in the Linux kernel at all. "
        "Docker/containerd/runc just call clone() with a pile of "
        "CLONE_NEW* flags, then chroot/pivot_root into an image.",
    calloutHints: [
      "🐧 Everything you've learned about processes and PCBs from Level "
          "1 still applies underneath — it's the exact same kernel "
          "machinery. This is why a container \"escape\" is such a big "
          "deal: it means a process broke out of its namespace view back "
          "into the host's real, unfiltered one.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A teammate says 'containers are lightweight VMs.' What's the "
          "professionally accurate correction?",
      options: [
        "They're right — containers run their own separate kernel, just like a VM",
        'Containers share the host kernel; isolation comes from Linux namespaces (PID, NET, MNT, USER, etc.) changing what a normal process can see, plus cgroups limiting what it can use — there is no separate kernel or virtualized hardware',
        'Containers are actually slower than VMs because they emulate a CPU',
        'Containers only isolate network traffic; everything else is fully shared and visible',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — one shared host kernel, many isolated views of it "
          "via namespaces, with cgroups capping resource usage. No "
          "hypervisor, no separate kernel, no virtualized hardware — "
          "that's precisely why containers start in milliseconds instead "
          "of the seconds/minutes a VM boot takes.",
      explainBad:
          "Containers are NOT separate kernels or emulated hardware — "
          "that's a VM. A container is an ordinary host process whose "
          "view of PIDs, mounts, network, and users is filtered by Linux "
          "namespaces, with cgroups capping what it can consume.",
    ),
  ),
  const Chapter(
    id: 42,
    title: 'cgroups: Metering and Capping Resources',
    avatar: '📏',
    role: 'Narrator — reading the resource meter on the wall',
    bodyIntro:
        "Namespaces control what a process can see. cgroups (control "
        "groups) control what it can use — CPU time, memory, disk I/O "
        "bandwidth, even the number of processes it's allowed to "
        "fork.\n\ncpu.max caps CPU time as N microseconds per "
        "M-microsecond period; hit the cap and the kernel stops "
        "scheduling you until the next period, which shows up in "
        "monitoring as CPU throttling, not an error. memory.max is a hard "
        "ceiling — exceed it and the kernel's OOM killer terminates a "
        "process inside that cgroup, even if the host machine as a whole "
        "still has gigabytes of RAM free elsewhere. io.max caps "
        "read/write bytes-per-second or IOPS per block device. pids.max "
        "caps how many processes/threads the group may fork, stopping a "
        "runaway fork-bomb.",
    calloutHints: [
      "🚨 The single most common \"why did my container just die?!\" "
          "production surprise: docker stats shows the HOST has plenty of "
          "free memory, yet the container was still OOM-killed — because "
          "ITS cgroup's memory.max, not the host's total RAM, is the "
          "limit that matters.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each production symptom into the controller that "
          "actually governs it.",
      bucketALabel: '🧱 memory.max',
      bucketBLabel: '🧮 cpu.max',
      items: [
        Sort2Item('oom', 'A container is OOM-killed even though the host machine has 20GB free RAM', true),
        Sort2Item('throttle', "A container's CPU usage graph shows periodic flat plateaus at exactly 50% — it's being throttled, not idle", false),
        Sort2Item('leak', "A container's resident memory climbs until it hits its configured ceiling and gets killed", true),
        Sort2Item('quota', "A batch job set to '0.5 vCPU' never exceeds half a core's worth of scheduled time per period", false),
      ],
      explainOk:
          "Correct — memory.max governs hard OOM kills regardless of "
          "host capacity; cpu.max governs throttling regardless of how "
          "many idle cores the host has.",
      explainBad:
          "OOM kills and rising resident memory are memory.max's job. "
          "Periodic CPU throttling plateaus and vCPU quotas are "
          "cpu.max's job — both cap the CONTAINER, independent of what "
          "the host has free.",
    ),
  ),
  const Chapter(
    id: 43,
    title: 'systemd & Process Supervision',
    avatar: '⚙️',
    role: 'Narrator — watching the kernel hand off to PID 1',
    bodyIntro:
        "The kernel finishes booting and executes a single userspace "
        "program as PID 1 — on almost every modern Linux distro, that's "
        "systemd. Everything else on the machine, eventually, is a "
        "descendant of it.\n\nPID 1 has a job no other process has: when "
        "any orphaned process's parent dies before reaping it, PID 1 "
        "inherits it and is responsible for eventually reaping that "
        "zombie. A container's PID 1 that doesn't reap zombies is exactly "
        "why some container images ship a tiny init process like "
        "tini.\n\nsystemd's actual production responsibilities: "
        "dependency ordering (unit files declare After=/Requires=, so "
        "the database starts before the app that needs it); restart "
        "policies (Restart=on-failure automatically relaunches a crashed "
        "service, with backoff); and socket activation (systemd can own "
        "a listening socket and only spawn the actual service process "
        "the FIRST time a connection arrives).",
    calloutHints: [
      "🎯 Interview-grade insight: a service that keeps getting "
          "restarted by systemd isn't \"fixed\" by the restart — "
          "Restart=on-failure masks the symptom. Always check systemctl "
          "status / journalctl -u <service> for the underlying crash "
          "reason, or you're just automating the same failure on a "
          "loop.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Put these boot-time events into the correct order.",
      items: [
        OrderItem('kernel', 'Kernel finishes its own init, mounts root filesystem'),
        OrderItem('pid1', 'Kernel execs PID 1 (systemd) — the very first userspace process'),
        OrderItem('targets', 'systemd resolves unit dependency graph and reaches its default target'),
        OrderItem('services', 'Individual service units start, in dependency order (DB before app)'),
        OrderItem('reap', 'Any orphaned descendant process is reparented to PID 1 for eventual reaping'),
      ],
      explainOk:
          "Exactly right — the kernel hands off to PID 1 exactly once, "
          "then everything else is systemd resolving dependencies and, "
          "for the lifetime of the system, quietly reaping orphans.",
      explainBad:
          "The kernel only ever execs ONE PID 1 process directly. "
          "Dependency resolution and service starts happen after that, "
          "and zombie-reaping duty for orphans is an ongoing PID-1 "
          "responsibility, not a one-time boot step.",
    ),
  ),
  const Chapter(
    id: 44,
    title: 'The Real Cost of a Syscall, at Production Scale',
    avatar: '💸',
    role: "Narrator — manning the toll booth at the kernel's door",
    bodyIntro:
        "At small scale, one syscall's overhead is noise. At production "
        "scale — millions of requests per second — that overhead becomes "
        "a real, budgeted cost engineers explicitly optimize away.\n\nA "
        "single syscall costs more than a function call because the CPU "
        "must trap into kernel mode, the kernel validates every argument, "
        "and some syscalls also flush speculation state (post-Spectre/"
        "Meltdown mitigations), which is measurably more expensive than "
        "pre-2018 syscalls were.\n\nReal mitigations: vDSO maps small "
        "chunks of kernel code directly into userspace so calls like "
        "gettimeofday() never trap at all; batching/vectored I/O "
        "(readv()/writev()) submits MANY I/O operations in one syscall; "
        "and io_uring uses shared ring buffers between user and kernel "
        "space, letting high-throughput servers submit and reap "
        "thousands of I/O operations with drastically fewer mode "
        "switches.",
    calloutHints: [
      "📊 A concrete number worth internalizing: a \"cheap\" syscall can "
          "be roughly 100x more expensive than a plain function call once "
          "you count the mode switch and validation overhead — which is "
          "exactly why a hot loop doing one write() per log line, "
          "millions of times a second, is a classic profiler finding.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A profiler shows a logging library spends 40% of CPU time in "
          "the write() syscall, issuing one tiny write() per log line at "
          "extremely high volume. What's the professional fix?",
      options: [
        "Switch to a faster CPU — the syscall cost is fixed by hardware and can't be reduced",
        'Buffer log lines in userspace and flush with far fewer, larger write() calls (or use a batching/io_uring-based writer) — amortizing the fixed per-syscall overhead across many log lines',
        "Remove all logging entirely so there's no I/O",
        'Call write() from a different thread per log line to parallelize the syscall overhead',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the fixed overhead is PER SYSCALL, not per byte, so "
          "batching many log lines into fewer, larger writes amortizes "
          "that cost dramatically. This is the same principle as "
          "vectored I/O and io_uring.",
      explainBad:
          "The overhead is per syscall, not per CPU cycle available — "
          "more threads just means more syscalls, not fewer. The real "
          "fix is amortizing the fixed trap-and-validate cost across many "
          "log lines by buffering and batching writes.",
    ),
  ),
  const Chapter(
    id: 45,
    title: 'Multi-Core Scheduling & CPU Affinity',
    avatar: '🧭',
    role: 'Narrator — surveying a machine with dozens of cores',
    bodyIntro:
        "Real production hardware has dozens of cores, and the "
        "scheduler's job gets a new dimension: WHICH core runs WHICH "
        "process, not just when.\n\nModern schedulers (Linux's "
        "CFS/EEVDF) keep a per-core run queue and try to keep a process "
        "on the same core it last ran on, because that core's L1/L2 "
        "cache is still warm with that process's data. Migrating to a "
        "different core means starting with cold caches.\n\nCPU affinity "
        "(taskset, sched_setaffinity()) lets you pin a specific thread to "
        "specific cores, explicitly overriding the scheduler's free "
        "choice — useful for pinning a latency-critical thread to a "
        "dedicated core, or reserving entire cores exclusively for "
        "specific workloads with isolcpus.",
    calloutHints: [
      "⚖️ The tradeoff is real: pinning improves cache locality and "
          "reduces jitter for that one workload, but it also reduces the "
          "scheduler's flexibility to load-balance the REST of the "
          "system — over-pinning can leave some cores idle while others "
          "are overloaded.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A latency-sensitive service shows occasional multi-millisecond "
          "latency spikes that correlate exactly with a batch job "
          "scheduled on the same machine. Both are free to run on any of "
          "the 32 cores. What's the most targeted production fix?",
      options: [
        'Buy a machine with even more cores and hope the scheduler figures it out',
        "Pin the latency-sensitive service's threads to a reserved set of cores (or use isolcpus) so the batch job's scheduling and cache churn can never land on those cores",
        "Increase the batch job's priority so it finishes faster and stops interfering",
        'Disable the scheduler entirely on that machine',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — explicit CPU affinity/isolation directly removes "
          "the shared-core contention and cache-thrashing that's causing "
          "those spikes, without needing more total hardware.",
      explainBad:
          "Adding cores doesn't guarantee the scheduler keeps the two "
          "workloads apart. Raising the batch job's priority makes the "
          "spikes WORSE for the latency-sensitive service, not better. "
          "The targeted fix is pinning/isolating cores so the two "
          "workloads structurally can't collide.",
    ),
  ),
  const Chapter(
    id: 46,
    title: 'NUMA: Not All Memory Is Equal',
    avatar: '🗺️',
    role: 'Narrator — mapping distances between memory and cores',
    bodyIntro:
        "On a large multi-socket server, RAM isn't one uniform pool. "
        "It's physically attached in banks, each closest to a particular "
        "group of cores — a NUMA node. A core reading memory attached to "
        "its OWN node is fast; reading from a DIFFERENT node crosses an "
        "interconnect and is noticeably slower.\n\nNUMA-aware production "
        "software tries to keep a thread and the memory it touches most "
        "on the SAME node — allocate memory on first-touch by the thread "
        "that will use it, and pin that thread to that node's cores. "
        "Tools like numactl let operators inspect and control this "
        "explicitly.",
    calloutHints: [
      "😬 A classic NUMA production trap: a process is scheduled onto "
          "Node 1's cores, but its large in-memory dataset was allocated "
          "earlier while running on Node 0 — every single access to that "
          "dataset now silently crosses the interconnect. Nothing looks "
          "\"wrong\" in the code; the machine's topology is just working "
          "against it.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Sort each practice by whether it respects NUMA locality or "
          "ignores it.",
      bucketALabel: '✅ NUMA-aware',
      bucketBLabel: '🐢 NUMA-oblivious',
      items: [
        Sort2Item('pin', "Pin a worker thread to Node 0's cores AND allocate its big buffer with Node 0 affinity", true),
        Sort2Item('migrate', "Let the scheduler freely migrate a memory-heavy thread across nodes mid-run, leaving its allocated memory behind on the old node", false),
        Sort2Item('firsttouch', "Allocate memory lazily so it's placed on whichever node first actually touches (writes to) it", true),
        Sort2Item('ignore', 'Allocate one giant shared buffer on Node 0 and let threads on all 4 nodes hammer it equally', false),
      ],
      explainOk:
          "Correct — keeping a thread and 'its' memory co-located on one "
          "node is the whole point of NUMA awareness; letting threads and "
          "their data drift apart across nodes is the classic "
          "performance trap.",
      explainBad:
          "NUMA-aware practices keep compute and its memory on the SAME "
          "node (pinning, first-touch allocation). Letting threads "
          "migrate away from their data, or forcing many nodes to hammer "
          "one node's memory, both create expensive cross-interconnect "
          "traffic.",
    ),
  ),
  const Chapter(
    id: 47,
    title: 'Thread Pools & Work-Stealing',
    avatar: '🧵',
    role: "Narrator — watching workers grab tasks off each other's benches",
    bodyIntro:
        "A naive thread pool with ONE shared task queue and N worker "
        "threads has an obvious bottleneck: every worker contends on a "
        "lock around that single queue just to grab its next "
        "task.\n\nWork-stealing schedulers (used by Java's ForkJoinPool, "
        "Go's goroutine scheduler, Rust's Tokio) fix this: each worker "
        "has its OWN local queue it pushes/pops from with no contention. "
        "Only when a worker's local queue goes EMPTY does it steal a "
        "task from the BACK of some other busy worker's queue — a "
        "comparatively rare event.",
    calloutHints: [
      "🎯 Why steal from the BACK, not the front? The owning worker pops "
          "from the FRONT (good cache locality, LIFO-ish for recursive "
          "workloads). Stealing from the opposite end minimizes "
          "collisions between the owner and the thief touching the same "
          "end of the queue at the same time.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Worker A has 3 queued tasks; Worker B just went idle. Put "
          "these events in order.",
      items: [
        OrderItem('empty', "Worker B finishes its own last task; its local queue is now empty"),
        OrderItem('scan', "Worker B scans sibling workers' queues for available work"),
        OrderItem('steal', "Worker B steals a task from the BACK of Worker A's queue (not the front)"),
        OrderItem('runs', 'Worker B executes the stolen task independently, in parallel with Worker A'),
        OrderItem('aowns', "Worker A continues popping its remaining tasks from the FRONT of its own queue, uninterrupted"),
      ],
      explainOk:
          "Exactly — stealing only kicks in once a worker is genuinely "
          "idle, targets the opposite end of the victim's queue to "
          "minimize contention, and lets both workers proceed "
          "independently afterward.",
      explainBad:
          "Stealing is triggered by a worker going idle, not by a busy "
          "worker. It targets the BACK of the victim's queue (the owner "
          "uses the front), and both workers keep running independently "
          "— the owner is never blocked by the theft.",
    ),
  ),
  const Chapter(
    id: 48,
    title: 'Thrashing at Scale: Memory Pressure in Production Fleets',
    avatar: '📉',
    role: 'Narrator — watching a whole fleet, not just one box',
    bodyIntro:
        "At fleet scale, the same underlying phenomenon (too much demand "
        "for too little RAM) shows up wearing different clothes, and the "
        "fix is almost always \"shed load,\" not \"tune harder.\"\n\n"
        "Kubernetes memory pressure: the kubelet monitors node memory; if "
        "it drops too low, it starts EVICTING pods (even ones under "
        "their limit) to protect node stability. OOM-kill cascades: one "
        "pod's memory leak triggers the kernel OOM killer, killing a "
        "DIFFERENT innocent pod on the same node because the kernel's "
        "heuristic picked it, not the actual leaker. Swap thrashing under "
        "cgroup limits: a memory-pressured cgroup can start swapping "
        "instead of getting OOM-killed outright, which LOOKS like it's "
        "surviving but actually tanks latency by orders of magnitude.",
    calloutHints: [
      "🛠️ The production playbook mirrors Level 5's lesson exactly, "
          "just at fleet scale: don't try to schedule harder around "
          "insufficient memory — set correct requests/limits so the "
          "scheduler places the right NUMBER of pods per node in the "
          "first place, and let autoscaling add capacity instead of "
          "overpacking existing nodes.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Several nodes in a Kubernetes cluster show rising memory "
          "usage, then pods start getting OOM-killed seemingly at random "
          "— including pods that never leaked anything themselves. "
          "What's most likely happening, and what's the fix?",
      options: [
        'The cluster is under a DDoS attack; block traffic at the load balancer',
        "Memory-pressure eviction/OOM-kill is claiming victims by kernel heuristic rather than by who's actually responsible; the fix is tightening per-pod memory requests/limits so scheduling correctly reflects real usage, and letting the cluster autoscale rather than overpacking nodes",
        'This is expected, healthy behavior and needs no investigation',
        'Restart every pod in the cluster simultaneously',
      ],
      answerIndex: 1,
      explainOk:
          "Right — this is thrashing/memory-pressure at fleet scale. "
          "'Random' innocent victims getting OOM-killed is the signature "
          "of the kernel's OOM heuristic picking a victim on an "
          "overcommitted node, not of that specific pod misbehaving. Fix "
          "the packing, not the symptom.",
      explainBad:
          "Innocent pods dying isn't a DDoS signature — it's memory "
          "pressure claiming whichever process the kernel's OOM heuristic "
          "happens to pick on an overcommitted node. The real fix is "
          "correcting resource requests/limits and scaling out, exactly "
          "like fixing thrashing by reducing concurrent load, not "
          "restarting blindly.",
    ),
  ),
  const Chapter(
    id: 49,
    title: 'Privilege Separation & Sandboxing',
    avatar: '🛂',
    role: 'Narrator — guarding the door with more than one key',
    bodyIntro:
        "For decades, Unix privilege was all-or-nothing: root (UID 0, "
        "can do ANYTHING) or an unprivileged user. POSIX capabilities "
        "split root's powers into ~40 fine-grained bits, so a process can "
        "be granted EXACTLY what it needs — like CAP_NET_BIND_SERVICE to "
        "bind to privileged ports without full root. CAP_SYS_ADMIN is a "
        "notoriously broad catch-all capability; granting it is nearly "
        "as risky as granting full root.\n\nseccomp-bpf goes further: it "
        "filters WHICH syscalls a process may even attempt, at the "
        "kernel boundary, independent of capabilities or UID. A "
        "container runtime's default seccomp profile blocks dozens of "
        "rarely-needed, historically exploit-prone syscalls outright.",
    calloutHints: [
      "🎯 Principle of least privilege, stated precisely: grant the "
          "smallest set of capabilities AND the smallest set of allowed "
          "syscalls that still lets the process do its actual job. Every "
          "extra capability or syscall you allow is one more thing an "
          "attacker who compromises that process can abuse.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Sort each security control by which mechanism it actually "
          "is.",
      bucketALabel: '🔑 POSIX Capability',
      bucketBLabel: '🚧 seccomp-bpf filter',
      items: [
        Sort2Item('bindport', 'Grants permission to bind to port 443 without running as full root', true),
        Sort2Item('blocksyscall', 'Blocks the process from ever calling ptrace(), regardless of its permissions', false),
        Sort2Item('sysadmin', 'A single broad grant that lets a process do dozens of nearly-root-level operations', true),
        Sort2Item('allowlist', 'An allow-list of exactly which syscall numbers the process may invoke at all', false),
      ],
      explainOk:
          "Correct — capabilities grant fine-grained PERMISSIONS a "
          "privileged action would otherwise require; seccomp filters "
          "restrict which syscalls can be ATTEMPTED at all, a completely "
          "separate, complementary layer.",
      explainBad:
          "Capabilities (like CAP_NET_BIND_SERVICE or the overly broad "
          "CAP_SYS_ADMIN) are about WHAT a process is permitted to do. "
          "seccomp-bpf is about WHICH syscalls it's even allowed to call "
          "— an allow-list enforced at the kernel boundary, independent "
          "of permission.",
    ),
  ),
  const Chapter(
    id: 50,
    title: 'Race Conditions & TOCTOU Bugs',
    avatar: '⏳',
    role: 'Narrator — watching the gap between checking and acting',
    bodyIntro:
        "Check-then-act races have a name and a long, ugly exploit "
        "history in security contexts: TOCTOU — Time-Of-Check to "
        "Time-Of-Use.\n\nClassic TOCTOU vulnerability: a program checks "
        "access(path, W_OK), then separately opens the path for writing. "
        "Between the CHECK and the USE, an attacker with write access to "
        "the directory can swap that path to a SYMLINK pointing at "
        "something else entirely — the check passed against the original "
        "file, but the actual write happens against whatever the path "
        "resolves to NOW.\n\nThe professional-grade fix is always the "
        "same shape: collapse check-and-use into a SINGLE atomic kernel "
        "operation so there's no gap for anything to change in between — "
        "e.g. open(path, O_NOFOLLOW), or openat() with a directory file "
        "descriptor anchored to something that can't be swapped out from "
        "under it.",
    calloutHints: [
      "🎯 The general lesson generalizes past files: ANY \"check "
          "permission, then act\" pattern — file access, an auth token's "
          "validity, a bank balance — is a potential TOCTOU if the check "
          "and the act aren't the same atomic operation.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A privileged daemon does `if (access(path, W_OK) == 0) { fd = "
          "open(path, O_WRONLY); ... }`. A security review flags this as "
          "exploitable. What's the correct fix?",
      options: [
        'Call access() twice in a row to be extra sure',
        'Replace the check-then-open pattern with a single atomic operation that can\'t be tampered with in between — e.g. open() with O_NOFOLLOW (or drop privileges and let open() itself fail with the correct permission error) rather than checking access first',
        'Add a sleep() between the check and the open to give the filesystem time to settle',
        'Nothing is wrong; access() and open() always operate on the same file',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — the vulnerability is the GAP between check and use, "
          "during which the path can be swapped (e.g. via a symlink). The "
          "fix removes the gap entirely by making the permission check "
          "and the actual access one atomic, tamper-proof operation.",
      explainBad:
          "Calling access() twice, or adding a sleep, does nothing to "
          "close the gap — an attacker can still swap the path in that "
          "window. The real fix eliminates the separate check step, "
          "using an atomic open-time guarantee like O_NOFOLLOW instead.",
    ),
  ),
  const Chapter(
    id: 51,
    title: 'Kernel Exploit Defenses & Rootkits',
    avatar: '🛡️',
    role: 'Narrator — checking the fortress walls for hidden tunnels',
    bodyIntro:
        "If an attacker gains kernel-level code execution, they own the "
        "entire machine. Modern kernels ship layered defenses "
        "specifically to make that jump much harder: KASLR randomizes "
        "the kernel's code address each boot, so an exploit can't "
        "hardcode a jump address; stack canaries place a random value "
        "before the return address, detecting a buffer overflow before a "
        "corrupted return address is used; and SMEP/SMAP stop "
        "kernel-mode code from executing or even reading userspace "
        "memory directly.\n\nA rootkit is malware that achieves "
        "persistence by modifying the kernel itself, often via a "
        "malicious Loadable Kernel Module — e.g. hooking the syscall "
        "table so calls to open() silently hide certain files from every "
        "tool on the system, including ls and antivirus scanners.",
    calloutHints: [
      "🔏 Defense: signed kernel modules (the kernel refuses to load an "
          "unsigned/improperly-signed module) plus lockdown mode close "
          "off the most common rootkit installation path entirely — you "
          "can't hook what you can't load.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a term, then click its correct description.",
      pairs: [
        MatchPair('kaslr', 'KASLR', 'Randomizes kernel memory layout each boot so hardcoded exploit addresses fail'),
        MatchPair('canary', 'Stack canary', 'A sentinel value that detects a stack buffer overflow before a corrupted return address is used'),
        MatchPair('rootkit', 'Rootkit via syscall hooking', 'Malware that intercepts syscalls like open() to hide files from every tool that relies on them'),
      ],
      explainOk:
          "Correct — these layered defenses each target a different "
          "stage of a kernel exploit chain, and understanding what a "
          "rootkit actually modifies (the syscall path itself) is why "
          "signed-module enforcement is such an effective "
          "countermeasure.",
    ),
  ),
  const Chapter(
    id: 52,
    title: 'Secure IPC',
    avatar: '🔐',
    role: "Narrator — checking who's really on the other end of the pipe",
    bodyIntro:
        "IPC mechanically (pipes, message queues, shared memory) doesn't "
        "tell you WHO is really on the other end. Unix domain sockets "
        "with SO_PEERCRED let the kernel itself tell you the connecting "
        "process's real UID/GID/PID, which can't be spoofed by the "
        "client, unlike a self-reported field inside the message "
        "payload.\n\nFile-based IPC (dropping files in a shared "
        "directory) reintroduces every TOCTOU risk — a shared writable "
        "directory is exactly the kind of place symlink-swap attacks "
        "thrive. Shared memory is the fastest IPC but the least "
        "security-friendly by default: any process that can map the "
        "segment can read AND write it, so it needs its own access "
        "control layered on top.",
    calloutHints: [
      "🎯 Production takeaway: prefer IPC primitives where the KERNEL — "
          "not the payload — asserts identity (peer credentials on a "
          "Unix socket) over ones where a peer just self-reports who it "
          "is inside the message, which any local attacker can forge.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A local privileged daemon accepts commands over a Unix domain "
          "socket. It authorizes each request by trusting a "
          "\"caller\": \"admin-tool\" field inside the JSON message body. "
          "What's the security flaw, and the fix?",
      options: [
        'There\'s no flaw — Unix domain sockets are only reachable locally, so any local process can be trusted',
        'The caller field is self-reported and can be forged by ANY local process; the daemon should instead use SO_PEERCRED to get the kernel-verified UID/PID of the actual connecting process and authorize based on that',
        'The fix is to switch from a Unix domain socket to shared memory for better performance',
        'The fix is to encrypt the JSON payload with a password shared by all clients',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — a field the client controls inside its own message "
          "is not authentication, it's an unverified claim. SO_PEERCRED "
          "asks the KERNEL who's really on the other end, which a "
          "malicious local process cannot forge.",
      explainBad:
          "Being local doesn't make a caller trustworthy — any local "
          "process could open that same socket and claim to be "
          "'admin-tool' in the payload. The real fix uses kernel-verified "
          "peer credentials (SO_PEERCRED), not a self-reported field "
          "inside the message.",
    ),
  ),
  const Chapter(
    id: 53,
    title: 'Microkernel vs Monolithic Kernel',
    avatar: '🏛️',
    role: "Narrator — choosing where to draw the kernel's walls",
    bodyIntro:
        "Linux and Windows NT's core are monolithic: drivers, "
        "filesystems, the network stack, and the scheduler all run "
        "together in one enormous, highly privileged kernel address "
        "space. A bug in a random device driver can crash the ENTIRE "
        "machine, because it runs with full kernel privilege.\n\nA "
        "microkernel (seL4, QNX, and historically Mach) keeps the kernel "
        "itself tiny — scheduling, basic IPC, and memory protection "
        "only. Drivers, filesystems, and even network stacks run as "
        "separate, unprivileged USER-space processes that talk to the "
        "kernel and each other via message passing. Monolithic is fast "
        "with no IPC overhead between subsystems, but a driver crash can "
        "crash the whole OS. Microkernel is slower (every cross-"
        "component call is IPC), but a driver crash is contained to that "
        "one component and can often be restarted.",
    calloutHints: [
      "🚀 This is exactly why seL4 (a formally VERIFIED microkernel, "
          "mathematically proven free of certain bug classes) is chosen "
          "for safety-critical systems like avionics and medical "
          "devices, while Linux's monolithic design wins everywhere raw "
          "throughput and driver ecosystem breadth matter more than "
          "provable isolation.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a property, then click which design it matches.",
      pairs: [
        MatchPair('fast', 'Every subsystem call is a fast, direct in-kernel function call', 'Monolithic kernel'),
        MatchPair('isolated', 'A crashing driver is isolated to its own process and can be restarted', 'Microkernel'),
        MatchPair('verified', 'Small enough trusted core to be formally, mathematically verified (e.g. seL4)', 'Microkernel'),
      ],
      explainOk:
          "Correct — monolithic trades isolation for raw speed; "
          "microkernels trade some speed (IPC overhead) for containment "
          "and, in seL4's case, provable correctness.",
    ),
  ),
  const Chapter(
    id: 54,
    title: 'VMs vs Containers: Choosing Your Isolation Boundary',
    avatar: '🖥️',
    role: 'Narrator — comparing two very different fences',
    bodyIntro:
        "A VM is a fundamentally stronger isolation boundary than a "
        "container: a hypervisor (using hardware virtualization "
        "extensions like Intel VT-x/AMD-V) presents each guest with what "
        "LOOKS like real hardware, and each guest runs its OWN, "
        "completely separate kernel.\n\nThe architectural consequence: a "
        "kernel exploit inside a container can, in the worst case, reach "
        "the shared host kernel — because there IS only one kernel. A "
        "kernel exploit inside a VM is contained to that guest's OWN "
        "kernel; escaping to the host requires breaking the hypervisor "
        "itself, a much smaller and more heavily scrutinized attack "
        "surface.\n\nThe real-world answer is rarely \"VM OR container\" "
        "— it's often BOTH: a lightweight VM boundary around a fleet of "
        "fast-starting containers, getting VM-grade isolation with "
        "close-to-container-grade startup latency.",
    calloutHints: [
      "🏢 This is precisely why multi-tenant cloud providers run "
          "untrusted customer workloads inside VMs (or VM-like sandboxes "
          "such as Firecracker microVMs, which Lambda and Fargate use "
          "under the hood) rather than bare containers directly on "
          "shared hardware — the isolation boundary is the whole "
          "security model.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Sort each property by which isolation model it actually "
          "describes.",
      bucketALabel: '🖥️ Virtual Machine',
      bucketBLabel: '📦 Container',
      items: [
        Sort2Item('ownkernel', 'Runs its own separate guest kernel via a hypervisor', true),
        Sort2Item('sharedkernel', "Shares the host's single kernel; isolation is namespaces + cgroups", false),
        Sort2Item('startsms', "Typically starts in milliseconds because there's no guest kernel to boot", false),
        Sort2Item('strongboundary', 'A kernel exploit inside it must also break the hypervisor to reach the host', true),
      ],
      explainOk:
          "Correct — VMs get their strength from a genuinely separate "
          "guest kernel behind a hypervisor boundary; containers get "
          "their speed from sharing one kernel, at the cost of a shared "
          "kernel attack surface.",
      explainBad:
          "A VM's defining trait is its OWN guest kernel behind a "
          "hypervisor — that's what makes an escape require breaking the "
          "hypervisor too. A container shares the host kernel directly, "
          "which is exactly why it starts fast but has a shared attack "
          "surface.",
    ),
  ),
  const Chapter(
    id: 55,
    title: "Real-Time OS Constraints",
    avatar: '⏰',
    role: "Narrator — where \"usually fast\" isn't good enough",
    bodyIntro:
        "A Real-Time Operating System (RTOS) optimizes for guaranteeing "
        "a task finishes by a DEADLINE, every single time — a missed "
        "deadline in a pacemaker or a car's anti-lock brakes isn't "
        "\"degraded performance,\" it's a failure.\n\nHard real-time "
        "means missing a deadline is a system failure, full stop "
        "(avionics, medical devices). Soft real-time means missing "
        "occasionally degrades quality but isn't catastrophic (video "
        "streaming, audio playback). Real-time schedulers use "
        "deadline-aware algorithms: Rate Monotonic Scheduling (fixed "
        "priority: shorter period = higher priority) and Earliest "
        "Deadline First (dynamically always run whoever's deadline is "
        "soonest).\n\nThe famous real production failure mode is "
        "priority inversion: a HIGH-priority task blocks waiting on a "
        "lock held by a LOW-priority task, which itself gets preempted "
        "by a MEDIUM-priority task that has nothing to do with either — "
        "the high-priority task effectively waits behind a task that's "
        "supposed to be beneath it. This nearly doomed NASA's 1997 Mars "
        "Pathfinder mission mid-flight.",
    calloutHints: [
      "🛠️ The fix, priority inheritance: while a low-priority task "
          "holds a lock a high-priority task is waiting on, TEMPORARILY "
          "boost the lock-holder's priority to match, so it can't be "
          "starved out by an unrelated medium-priority task. Pathfinder's "
          "engineers fixed the actual bug remotely, on Mars, by enabling "
          "exactly this.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A high-priority task blocks on a mutex held by a low-priority "
          "task. A medium-priority task then preempts the low-priority "
          "holder and runs for a long time — indirectly starving the "
          "high-priority task, which is exactly what happened on Mars "
          "Pathfinder. What's the standard fix?",
      options: [
        'Give every task the same priority so nothing can be preempted',
        "Priority inheritance — temporarily boost the mutex-holder's priority to match the highest-priority task waiting on it, so a medium-priority task can no longer preempt it out from under the real bottleneck",
        'Remove all mutexes from the system entirely',
        'Kill the medium-priority task permanently',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — priority inheritance closes the loophole by making "
          "the lock-holder temporarily 'as important' as whoever's "
          "actually waiting on it, so an unrelated medium-priority task "
          "can't cut in line and stall the real dependency chain. This is "
          "literally how Pathfinder was saved.",
      explainBad:
          "Equal priorities would remove real-time guarantees entirely. "
          "Mutexes are still needed for correctness. The real, "
          "historically-proven fix is priority inheritance: temporarily "
          "elevate the lock-holder so it can't be preempted by unrelated, "
          "lower-urgency work.",
    ),
  ),
  const Chapter(
    id: 56,
    title: 'Distributed Consensus at the OS/Scheduling Level',
    avatar: '🕸️',
    role: 'Narrator — zooming out from one machine to a cluster of them',
    bodyIntro:
        "Every OS concept you've mastered has a distributed-systems "
        "cousin, because a cluster of machines faces the exact same "
        "problems with one brutal new constraint: no shared memory, no "
        "single clock, and messages can be delayed or lost.\n\nLeader "
        "election is \"who gets to run\" at cluster scale — instead of a "
        "scheduler picking one RUNNING process on one CPU, a consensus "
        "algorithm like Raft picks one leader node among many "
        "candidates. Distributed mutual exclusion is a mutex without "
        "shared memory — a distributed lock must survive the lock-holder "
        "crashing without releasing it. Quorum / safe-state checks echo "
        "the Banker's Algorithm's spirit: Raft only commits a change "
        "once a MAJORITY of nodes acknowledge it.",
    calloutHints: [
      "🎯 The single biggest conceptual leap: on ONE machine, a crashed "
          "process is unambiguously gone (the kernel knows). On a "
          "NETWORK, you often cannot tell the difference between \"that "
          "node is dead\" and \"that node is just slow to respond\" — and "
          "consensus algorithms exist specifically to make safe decisions "
          "despite that ambiguity.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Put these high-level Raft leader-election events in the "
          "correct order.",
      items: [
        OrderItem('timeout', 'A follower stops hearing from the current leader (election timeout expires)'),
        OrderItem('candidate', 'That node becomes a candidate and requests votes from every other node'),
        OrderItem('votes', 'A majority of nodes grant their vote to that candidate'),
        OrderItem('leader', 'The candidate becomes leader and starts sending heartbeats to the rest of the cluster'),
        OrderItem('commit', 'New writes are only committed once a majority of nodes acknowledge them'),
      ],
      explainOk:
          "Exactly right — election is triggered by silence (a timeout, "
          "since there's no shared clock to rely on), decided by majority "
          "vote, and ongoing safety is maintained by requiring majority "
          "acknowledgment before anything is considered durably "
          "committed.",
      explainBad:
          "Election starts only after a timeout (no heartbeat), not "
          "proactively. A candidate needs a MAJORITY of votes to become "
          "leader, and even after becoming leader, writes still require "
          "majority acknowledgment before being considered safely "
          "committed.",
    ),
  ),
  const Chapter(
    id: 57,
    title: 'Postmortem: The 3 A.M. Page',
    avatar: '🚨',
    role: 'Narrator — reading the incident timeline out loud',
    bodyIntro:
        "The final level. Real production incidents are almost never "
        "\"just\" a scheduling bug or \"just\" a memory bug — they're "
        "several failure modes colliding at the same unlucky "
        "moment.\n\nThe page: checkout-service p99 latency up 40x, error "
        "rate climbing. The postmortem timeline: a slow memory leak in a "
        "caching layer pushes the node into cgroup memory pressure, and "
        "the kernel starts reclaiming pages aggressively. Reclaim "
        "pressure causes a spike in page faults across EVERY pod on that "
        "node — classic thrashing, even for pods that never leaked "
        "anything themselves. Under that CPU/IO pressure, two services "
        "holding row-level database locks — normally released in "
        "microseconds — now take long enough that their acquisition "
        "order flips under load, and a genuine circular-wait deadlock "
        "forms between them. Both services' requests eventually hit "
        "their timeout and abort, which is WHY it looked like "
        "\"latency,\" not an obvious hang.",
    calloutHints: [
      "🎯 The real lesson of a senior postmortem: the ROOT cause is the "
          "leak, but the leak alone wasn't the outage — it needed the "
          "resulting memory pressure AND a pre-existing lock-ordering "
          "fragility to BOTH be true at the same time for the deadlock to "
          "actually manifest. Fixing only one of the two would still "
          "leave the system fragile.",
    ],
    puzzleType: PuzzleType.circuit,
    circuit: CircuitPuzzle(
      instructions:
          "This outage only happened because TWO conditions were true "
          "at once — flip switch A (memory pressure present) and switch "
          "B (lock-ordering violation present) to find the real trigger, "
          "then light the LED.",
      gate: CircuitGate.and,
      explainOk:
          "Exactly — this is why it's an AND, not an OR: memory pressure "
          "alone just causes thrashing (survivable, if painful); a "
          "latent lock-ordering flaw alone rarely manifests under normal, "
          "fast lock timing. It took BOTH simultaneously to produce the "
          "actual deadlock cascade — the true signature of a production "
          "incident born from compounding failures.",
      explainBad:
          "Think about WHY a single cause wasn't enough on its own. "
          "Memory pressure alone just slows things down; a lock-ordering "
          "flaw alone almost never triggers when locks are held for "
          "microseconds. It's the co-occurrence of BOTH — an AND, not an "
          "OR — that actually produced the deadlock.",
    ),
  ),
  const Chapter(
    id: 58,
    title: 'Capstone: The Kernel Panic Gauntlet',
    avatar: '💥',
    role: 'Narrator — reading a crash dump line by line',
    bodyIntro:
        "A production kernel driver dereferences a NULL pointer and the "
        "machine goes down hard — a kernel panic. Unlike a userspace "
        "segfault, which the kernel can just kill and clean up, a fault "
        "IN the kernel itself has nowhere safe to fall back to, so it "
        "halts everything rather than risk silently corrupting "
        "data.\n\nThe professional triage process: the kernel prints an "
        "\"oops\" — a partial crash report with a stack trace, register "
        "state, and the exact instruction pointer where it faulted — "
        "before panic() potentially halts everything. If kdump is "
        "configured, the ENTIRE kernel memory image is captured to disk "
        "via a secondary crash kernel before reboot. Post-reboot, an "
        "engineer loads the crash dump into a debugger, maps the "
        "faulting instruction pointer back to source, and checks what "
        "actually went wrong. The fix is deployed, but the postmortem "
        "ALSO asks whether this driver should have been running with "
        "reduced privilege in the first place.",
    calloutHints: [
      "🎯 This is the deepest, most professional insight of the whole "
          "course: a single NULL-pointer bug is trivial in userspace (one "
          "process dies) and catastrophic in kernel space (the whole "
          "machine dies) — precisely BECAUSE of the user/kernel boundary, "
          "and precisely WHY microkernel and capability-based designs "
          "exist to shrink how much code lives on the wrong side of that "
          "line.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Put these post-panic response steps into the correct "
          "professional order.",
      items: [
        OrderItem('oops', 'Kernel prints an oops with register state and faulting instruction pointer'),
        OrderItem('kdump', 'kdump captures the full kernel memory image via a secondary crash kernel'),
        OrderItem('reboot', 'Machine reboots into its normal kernel'),
        OrderItem('analyze', 'Engineer loads the crash dump and maps the fault back to the offending source line'),
        OrderItem('harden', 'Fix is deployed, and the design is reviewed for whether this code should have less privilege'),
      ],
      explainOk:
          "Exactly right — capture the evidence BEFORE rebooting (or "
          "it's gone), analyze after recovery, then close the loop by "
          "asking whether the privilege boundary itself should be "
          "tightened, not just the one bug.",
      explainBad:
          "The crash dump must be captured before reboot destroys the "
          "evidence, and analysis necessarily happens after the machine "
          "is back up. The final, most senior step is asking whether "
          "this code even belonged at full kernel privilege in the first "
          "place.",
    ),
  ),
  const Chapter(
    id: 59,
    title: 'Capstone: The Distributed Deadlock',
    avatar: '🔗',
    role: 'Narrator — watching a deadlock cross the network',
    bodyIntro:
        "The hardest combination: a deadlock that spans SEPARATE "
        "SERVICES, each individually deadlock-free, communicating over "
        "IPC/RPC.\n\nScenario: OrderService calls InventoryService and "
        "holds a distributed lock on order:4471 while waiting for the "
        "reply. Under heavy load, InventoryService, mid-request, calls "
        "BACK into OrderService to validate something, and that call "
        "needs a distributed lock on order:4471 too — which is still "
        "held by the FIRST call. Circular wait — across two machines, "
        "two locks, and a network round trip.\n\nWhy this is uniquely "
        "hard: there's no single resource allocation graph the kernel "
        "can inspect. No one process holds the full picture — you need "
        "DISTRIBUTED tracing just to reconstruct the cycle after the "
        "fact.",
    calloutHints: [
      "🛠️ Real fixes, layered: never allow synchronous callbacks back "
          "into a caller while holding a lock — break the cycle "
          "structurally; apply lock TIMEOUTS aggressively, since a "
          "distributed lock's holder can't be assumed alive the way an "
          "in-process mutex's holder can; and use a wound-wait or "
          "wait-die scheme instead of naive first-come-first-served "
          "locking across services.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Two services deadlock across the network because each ends "
          "up waiting on a distributed lock the other is holding, via a "
          "synchronous callback pattern. What's the most structurally "
          "sound fix, beyond just adding timeouts?",
      options: [
        "Increase every service's thread pool size so more requests can be in flight simultaneously",
        'Redesign the interaction so a service never makes a synchronous call back into whatever is calling it while still holding a lock — breaking the circular-wait structure itself, the same fix philosophy as single-process deadlock prevention',
        'Have both services retry forever with no backoff until one eventually gets through',
        "Merge both services into a single process so there's no network involved",
      ],
      answerIndex: 1,
      explainOk:
          "Correct — timeouts are a safety net, but they don't prevent "
          "the cycle from forming, they just eventually break it "
          "painfully. The structural fix is the same principle as "
          "single-process deadlock prevention: eliminate circular wait "
          "by redesigning the call pattern so it can't form a cycle in "
          "the first place.",
      explainBad:
          "More threads or blind retries don't address the CYCLE — they "
          "just make it more likely to recur or churn resources while "
          "stuck. Merging services eliminates the symptom by eliminating "
          "the architecture, which isn't always viable. The real fix is "
          "structural: never call back into a lock-holding caller, "
          "breaking circular wait by design.",
    ),
  ),
  const Chapter(
    id: 60,
    title: 'The Reckoning — Principal Engineer Finale',
    avatar: '👑',
    role: 'Narrator — the final review, before the badge is earned',
    bodyIntro:
        "One scenario left, deliberately mixing every layer of this "
        "entire subject: process lifecycle, memory, scheduling, "
        "containers, security, and distributed systems.\n\nYou're the "
        "principal engineer reviewing a proposed architecture for a new "
        "multi-tenant service: untrusted customer code will run "
        "arbitrary user-submitted functions, at high request volume, "
        "with strict per-tenant resource fairness and security isolation "
        "required. The junior team's first draft: run each tenant's "
        "function directly as a thread inside one big shared process, "
        "relying only on a seccomp filter for safety.",
    calloutHints: [
      "🎯 Walk the whole stack in your head before answering: threads "
          "inside one process share the ENTIRE address space — a "
          "seccomp filter restricts syscalls, but does nothing to stop "
          "one tenant's thread from directly reading another tenant's "
          "heap memory in the same process. That's not a "
          "syscall-boundary problem; it's an ADDRESS-SPACE boundary "
          "problem, and no syscall filter can fix a boundary it was "
          "never designed to enforce.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What is the single most important flaw in 'run each tenant "
          "as a thread in one shared process, protected by a seccomp "
          "filter,' and the professionally correct redesign?",
      options: [
        'seccomp filters are too slow for high request volume; the fix is to remove them entirely for performance',
        "Threads in the same process share one address space, so seccomp (a syscall boundary) cannot stop one tenant's thread from directly reading another tenant's memory; each tenant needs a real isolation boundary — at minimum separate processes with namespaces/cgroups (containers), or stronger, separate VMs/microVMs for genuinely untrusted code — not shared threads",
        'The fix is to add more CPU cores so threads never contend',
        'Nothing is wrong; seccomp is sufficient isolation for any use case',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — you've now connected every layer: process "
          "isolation is an address-space boundary, seccomp is a syscall "
          "boundary, and containers/VMs are the tools that actually "
          "provide tenant-grade isolation. Choosing the wrong boundary "
          "for the threat model is the single most common "
          "principal-engineer-level mistake in systems design. You've "
          "completed the professional tier of the Operating Systems "
          "curriculum. 💠",
      explainBad:
          "seccomp restricts WHICH syscalls a process can make — it "
          "does nothing to stop direct memory reads between threads "
          "sharing one address space, because that was never the "
          "boundary it enforces. True multi-tenant isolation for "
          "untrusted code needs a real address-space (or stronger, "
          "hypervisor-grade) boundary: separate processes with "
          "namespaces/cgroups at minimum, or VMs/microVMs for genuinely "
          "untrusted workloads.",
    ),
  ),
];
