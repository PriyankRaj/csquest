import '../models/pq_models.dart';

/// Ported from process-quest/subjects/cloud-distributed.js — real content,
/// HTML-stripped narrative, same puzzles/answers. 60 chapters across 15
/// levels (1-9 foundation tier, 10-15 professional tier).
final cloudDistributedChapters = <Chapter>[
  const Chapter(
    id: 1,
    title: "What Even Is 'The Cloud'?",
    avatar: '☁️',
    role: 'Narrator — rolling up to a giant warehouse',
    bodyIntro:
        "🐢 I rolled over a hill expecting fluffy white clouds — instead I found "
        "warehouses. Gigantic ones, full of humming computers stacked floor to "
        "ceiling. This is Cloud Cluster Isles, and here's the secret: \"the cloud\" "
        "isn't magic fog in the sky at all. It's just someone else's computers, "
        "that you rent over the Internet. ☁️💻\n\n"
        "🏫 Before the cloud, if a school wanted a website, it had to buy its own "
        "physical computer, plug it in, keep it cool, and fix it when it broke. "
        "That's like a school building its own power plant just to turn on the "
        "lights.\n\n"
        "Instead, cloud providers (like AWS, Google Cloud, or Azure) own gigantic "
        "warehouses full of computers, and let anyone rent tiny slices of them — "
        "by the hour, sometimes by the second!\n\n"
        "🏢 Data center — the actual warehouse full of computers\n\n"
        "🖥️ Server — one computer inside it, always on, always listening\n\n"
        "💳 Pay-as-you-go — you only pay for what you actually use, like renting "
        "a bike instead of buying one",
    calloutHints: [
      "🔌 Fun fact: some of these warehouses have their own power substations "
          "and cooling systems bigger than a shopping mall — a single data center "
          "can use as much electricity as a small city.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which best describes what people mean by 'the cloud'?",
      options: [
        'A special kind of software that only runs during rainy weather',
        'Computers owned by a provider, in data centers, that you rent over the Internet',
        'A single supercomputer that stores the entire Internet',
        'A wireless signal that replaces the Internet entirely',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — the cloud is just other companies' computers, in "
          "warehouses called data centers, that you rent instead of buying and "
          "maintaining your own.",
      explainBad:
          "Not quite — there's no fog involved! 'The cloud' means renting real "
          "physical computers, sitting in a data center somewhere, over the "
          "Internet.",
    ),
  ),
  const Chapter(
    id: 2,
    title: 'IaaS: Renting the Bare Computer',
    avatar: '🏗️',
    role: "Narrator — picking up an empty apartment's keys",
    bodyIntro:
        "🔑 The most basic thing you can rent in the cloud is a plain, empty "
        "computer — called IaaS, Infrastructure as a Service. You get the keys "
        "to a virtual machine with a blank hard drive, and YOU install "
        "everything: the operating system, the software, all of it.\n\n"
        "🏠 It's like renting an empty apartment — bare walls, no furniture. You "
        "get to decorate it exactly how you want, but you also have to do ALL "
        "the work: buy the couch, plug in the fridge, fix the leaky faucet "
        "yourself.\n\n"
        "✅ Full control — install any software, any configuration you like\n\n"
        "😓 Full responsibility — you patch the OS, secure it, keep it running\n\n"
        "🧱 Examples: AWS EC2, Google Compute Engine, Azure Virtual Machines",
    calloutHints: [
      '🧑‍🔧 IaaS is the "most work, most control" end of the cloud spectrum. '
          'Everything above the raw hardware is entirely on you.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'With Infrastructure as a Service (IaaS), what do you receive?',
      options: [
        'A finished website, ready to use immediately',
        'A blank virtual machine — you install and manage the OS and everything on top',
        'A pre-built app with no setup required at all',
        'Only a database, with no computer attached',
      ],
      answerIndex: 1,
      explainOk:
          'Right — IaaS is the bare-bones rental: a raw virtual machine. You '
          'do the rest yourself, from OS updates on up.',
      explainBad:
          'IaaS is deliberately minimal — you get a blank virtual computer, '
          'and everything installed and configured on it is your job.',
    ),
  ),
  const Chapter(
    id: 3,
    title: "PaaS: Someone Else Handles the Kitchen",
    avatar: '🍳',
    role: 'Narrator — ordering from a food-hall stall',
    bodyIntro:
        "🍳 Level up: PaaS, Platform as a Service. Instead of an empty "
        "apartment, PaaS is like renting a food-hall kitchen stall that already "
        "has the stove, oven, and sink installed. You just bring your recipe "
        "(your code) — the platform handles the OS, security patches, and "
        "servers underneath.\n\n"
        "✅ You upload your code; the platform runs it\n\n"
        "🛠️ No OS patching, no server setup — the provider handles that layer\n\n"
        "🍽️ Examples: Heroku, Google App Engine, AWS Elastic Beanstalk\n\n"
        "⚖️ You trade away some control (you usually can't tweak the OS "
        "directly) for a lot less babysitting. Perfect when you just want your "
        "app running, fast.",
    calloutHints: [
      '🧭 IaaS vs PaaS in one line: IaaS gives you an empty kitchen to build '
          'yourself; PaaS gives you a fully-installed kitchen — you just cook.',
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          'Click a description on the left, then the matching service model on the right.',
      pairs: [
        MatchPair('iaas', 'A blank virtual machine — you install the OS and everything else', 'IaaS'),
        MatchPair('paas', 'You upload your code; the platform manages the OS and servers', 'PaaS'),
        MatchPair('iaas2', 'You choose and patch the operating system yourself', 'IaaS'),
      ],
      explainOk:
          'Right — IaaS hands you raw hardware to manage; PaaS hands you a '
          'ready platform where you focus purely on code.',
    ),
  ),
  const Chapter(
    id: 4,
    title: 'SaaS: Just Use the App',
    avatar: '📱',
    role: 'Narrator — clicking a button in a browser tab',
    bodyIntro:
        "📱 The top of the stack: SaaS, Software as a Service. You don't "
        "manage servers, you don't manage a platform — you just open a website "
        "or app and use it. Gmail, Google Docs, Spotify, Zoom — all SaaS.\n\n"
        "🍽️ Back to the food analogy: SaaS is like ordering a finished meal "
        "delivered to your door. No kitchen, no stove, no recipe — just the "
        "food, ready to eat.",
    calloutHints: [
      '🪜 The IaaS → PaaS → SaaS ladder is really a "how much do YOU manage vs. '
          'the provider" scale — climbing up trades control for convenience, one '
          'rung at a time.',
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Drag these from MOST customer control/responsibility to LEAST.',
      items: [
        OrderItem('iaas', 'IaaS — you manage OS, runtime, and app'),
        OrderItem('paas', 'PaaS — you manage only your app code'),
        OrderItem('saas', 'SaaS — you manage nothing; you just use the app'),
      ],
      explainOk:
          'Exactly the ladder — IaaS (most control, most work), then PaaS, '
          'then SaaS (least control, zero setup).',
      explainBad:
          'Order by how much YOU have to manage: IaaS is the most hands-on, '
          'PaaS is middle ground, SaaS is fully hands-off.',
    ),
  ),
  const Chapter(
    id: 5,
    title: 'Bare Metal vs Virtual Machines',
    avatar: '🧱',
    role: 'Narrator — comparing one house to an apartment building',
    bodyIntro:
        "🧱 Bare metal means one physical computer dedicated entirely to you — "
        "no sharing, maximum performance, but if it's idle, that power is "
        "wasted. It's like owning a whole house just for yourself.\n\n"
        "🏢 A virtual machine (VM) slices ONE physical computer into several "
        "pretend computers, each believing it has its own CPU, memory, and disk "
        "— like an apartment building where many families share one structure, "
        "but each apartment feels private and self-contained.",
    calloutHints: [
      '🏗️ Cloud providers mostly rent VMs, not bare metal, because VMs let them '
          'pack MANY customers onto the same physical hardware — far more '
          'efficient than dedicating a whole machine per customer.',
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each scenario into the right bucket.',
      bucketALabel: '🧱 Bare metal',
      bucketBLabel: '🏢 Virtual machine',
      items: [
        Sort2Item('one', 'One whole physical server dedicated to a single high-performance database', true),
        Sort2Item('many', 'Ten customers each get a slice of the same physical server, isolated from each other', false),
        Sort2Item('waste', 'The hardware sits mostly idle because nobody else can use the leftover capacity', true),
        Sort2Item('pack', 'A cloud provider maximizes hardware usage by packing many tenants onto one machine', false),
      ],
      explainOk:
          'Correct — bare metal is one dedicated physical machine; VMs let '
          'one physical machine be sliced among many tenants.',
      explainBad:
          'Bare metal = one machine, one tenant, nothing shared. VM = one '
          "machine, sliced into several isolated pretend-computers for many "
          'tenants.',
    ),
  ),
  const Chapter(
    id: 6,
    title: 'The Hypervisor: Slicing One Computer into Many',
    avatar: '🎛️',
    role: 'Narrator — meeting the building superintendent',
    bodyIntro:
        "🎛️ Who actually does the slicing? A special piece of software called "
        "a hypervisor — think of it as the apartment building's "
        "superintendent. It sits between the real physical hardware and each "
        "virtual machine, handing out shares of CPU, memory, and disk to each "
        "\"apartment,\" and making sure none of them can peek into another's "
        "space.\n\n"
        "🧱 Type 1 hypervisor — runs directly on the bare hardware (most cloud "
        "providers use this)\n\n"
        "💻 Type 2 hypervisor — runs on top of a regular OS (like running "
        "VirtualBox on your laptop)",
    calloutHints: [
      "🔒 Isolation is the hypervisor's most important job: if one VM crashes "
          "or gets hacked, the others on the same physical machine should never "
          "even notice.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What is the hypervisor's main job?",
      options: [
        'It writes application code for you',
        'It sits between physical hardware and virtual machines, dividing resources and keeping VMs isolated from each other',
        'It only handles billing for cloud usage',
        'It replaces the need for an operating system inside each VM',
      ],
      answerIndex: 1,
      explainOk:
          "Right — the hypervisor divides one physical machine's resources "
          'among multiple VMs, and keeps them isolated from each other.',
      explainBad:
          "Think 'building superintendent': the hypervisor allocates shared "
          'hardware to each VM and keeps them from interfering with one '
          'another.',
    ),
  ),
  const Chapter(
    id: 7,
    title: 'Elasticity: Growing and Shrinking on Demand',
    avatar: '🎈',
    role: 'Narrator — watching a balloon inflate and deflate',
    bodyIntro:
        "🎈 One of the cloud's superpowers is elasticity: the ability to grow "
        "(add more servers) when traffic spikes, and shrink back down when it "
        "dies off — automatically, without a human rushing to buy more "
        "hardware.\n\n"
        "Imagine an ice cream shop 🍦 that can magically add ten extra counters "
        "on a hot Saturday, then fold them away Monday morning when it's quiet "
        "again. No wasted rent when it's slow, no long lines when it's busy.",
    calloutHints: [
      "💸 This is a HUGE shift from the old days: instead of buying enough "
          "servers for your busiest possible day (and having them sit mostly "
          "idle the rest of the time), you rent exactly what you need, minute "
          "by minute.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What does 'elasticity' mean in cloud computing?",
      options: [
        'Servers are made of a stretchy physical material',
        'The ability to automatically add or remove computing resources to match changing demand',
        'A discount you get for signing a long-term contract',
        'The speed of your Internet connection',
      ],
      answerIndex: 1,
      explainOk:
          'Exactly — elasticity means resources scale up and down '
          'automatically to match real demand, instead of being fixed in '
          'advance.',
      explainBad:
          'Elasticity is about capacity, not materials or speed: it\'s the '
          'ability to automatically scale computing resources up and down '
          'with demand.',
    ),
  ),
  const Chapter(
    id: 8,
    title: 'Autoscaling Basics: Watching the Crowd',
    avatar: '📈',
    role: 'Narrator — watching a line form outside',
    bodyIntro:
        "📈 Autoscaling is elasticity in action: a system watches a metric — "
        "often CPU usage, or how many requests are queued up — and "
        "automatically adds more servers when that metric climbs too high, "
        "then removes them when it drops back down.\n\n"
        "👀 Monitor a metric (CPU load, request queue length, memory usage)\n\n"
        "📏 Compare it to a target threshold\n\n"
        "➕ If too high: launch more instances\n\n"
        "➖ If too low: shut some instances down",
    calloutHints: [
      "🐌 Autoscaling isn't instant — new servers take real time to boot and "
          "register. If traffic spikes FASTER than servers can launch, users "
          "can still feel a slowdown right at the peak, even with autoscaling "
          "turned on.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Drag these steps into the order an autoscaler actually performs them.',
      items: [
        OrderItem('watch', 'Monitor CPU usage across current servers'),
        OrderItem('compare', 'Compare current usage to the target threshold'),
        OrderItem('decide', 'Decide: usage is above threshold, more capacity is needed'),
        OrderItem('launch', 'Launch new server instances and register them'),
        OrderItem('recheck', 'Keep monitoring; scale back down once usage drops'),
      ],
      explainOk:
          'That\'s the loop — watch, compare, decide, act, and keep watching. '
          'Autoscaling never really stops running this cycle.',
      explainBad:
          'The loop always starts with monitoring, then comparing to a '
          'threshold, THEN deciding and acting — and it never stops '
          're-checking afterward.',
    ),
  ),
  const Chapter(
    id: 9,
    title: "What's Actually IN a Container?",
    avatar: '📦',
    role: 'Narrator — peeking inside a shipping crate',
    bodyIntro:
        "📦 A container packages up an application AND everything it needs to "
        "run — its code, libraries, and settings — into one neat bundle that "
        "behaves the same no matter where you run it: your laptop, a "
        "teammate's laptop, or a cloud server.\n\n"
        "🚢 It's named after actual shipping containers: before standardized "
        "containers, loading a ship meant hand-stacking oddly-shaped crates and "
        "barrels. Standardized containers let ANY ship, crane, or truck handle "
        "ANY container the same way. Software containers do the same for code "
        "— \"works on my machine\" stops being a lottery.",
    calloutHints: [
      '🎯 The famous promise of containers: "it works the same everywhere," '
          'because the container carries its own tiny self-contained '
          'environment with it, instead of depending on whatever happens to be '
          'installed on the host.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What's the main problem containers solve?",
      options: [
        'They make computers physically smaller',
        'They bundle an app with everything it needs, so it runs consistently across different machines',
        'They replace the need for the Internet',
        "They automatically write your application's code for you",
      ],
      answerIndex: 1,
      explainOk:
          "Right — containers package an app plus its dependencies so it "
          "behaves identically everywhere, ending the 'works on my machine' "
          "problem.",
      explainBad:
          'Containers are about consistency, not hardware or code '
          'generation: they bundle an app with its dependencies so it runs '
          'the same anywhere.',
    ),
  ),
  const Chapter(
    id: 10,
    title: 'Images vs Containers: Recipe vs Meal',
    avatar: '📜',
    role: "Narrator — comparing a recipe card to dinner on the table",
    bodyIntro:
        "📜 A container image is the recipe: a read-only blueprint describing "
        "exactly what goes inside — the base OS layer, your app's code, its "
        "dependencies, and startup instructions. It doesn't DO anything by "
        "itself; it just describes what to build.\n\n"
        "🍽️ A running container is the meal: an actual live process created "
        "FROM that image, running right now, using CPU and memory. You can "
        "cook (run) the same recipe (image) many times, getting many "
        "identical meals (containers) — each one independent, even though "
        "they all started from the same recipe.",
    calloutHints: [
      '🔁 One image can spin up ZERO, ONE, or a HUNDRED running containers at '
          'once — the image never changes; only the number of "meals" cooked '
          'from it does.',
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a term on the left, then its correct description on the right.',
      pairs: [
        MatchPair('image', 'Container image', 'A read-only blueprint describing what to run — the recipe'),
        MatchPair('container', 'Running container', 'A live process created from an image — the cooked meal'),
        MatchPair('many', 'Ten identical containers running at once', 'Ten meals, all cooked from the same one recipe'),
      ],
      explainOk:
          'Exactly — the image is the static blueprint; a container is a '
          'live instance running from it, and you can run many at once.',
    ),
  ),
  const Chapter(
    id: 11,
    title: 'Containers vs VMs: Sharing the Kernel',
    avatar: '⚖️',
    role: 'Narrator — comparing two ways to slice a computer',
    bodyIntro:
        "⚖️ We met VMs back in Level 2 — each VM has its OWN full operating "
        "system kernel, made possible by the hypervisor. Containers are "
        "lighter: they all share the SAME host operating system's kernel, and "
        "are just isolated from each other using kernel features (namespaces "
        "and cgroups on Linux) — no separate OS inside each one.\n\n"
        "Virtual Machines: each has its own full OS kernel, heavier, slower "
        "to boot (minutes), stronger isolation boundary.\n\n"
        "Containers: share the host's OS kernel, lightweight, fast to start "
        "(seconds), slightly weaker isolation (shared kernel).",
    calloutHints: [
      "🐢 This is why I can spin up dozens of containers on my little shell in "
          "seconds, but booting that many full VMs would take ages — no "
          "separate operating systems to boot each time.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Sort each trait into the right bucket.',
      bucketALabel: '🏢 Virtual Machine',
      bucketBLabel: '📦 Container',
      items: [
        Sort2Item('ownkernel', 'Has its own separate operating system kernel', true),
        Sort2Item('sharekernel', "Shares the host machine's OS kernel", false),
        Sort2Item('slow', 'Takes minutes to boot, like starting a whole computer', true),
        Sort2Item('fast', 'Starts in a second or two, like launching a process', false),
      ],
      explainOk:
          'Correct — VMs carry a full separate OS and boot slowly; '
          'containers share the host kernel and start almost instantly.',
      explainBad:
          'VMs = own full kernel, slow boot. Containers = shared host '
          'kernel, fast start. That tradeoff is the whole point of '
          'containers.',
    ),
  ),
  const Chapter(
    id: 12,
    title: 'Layers: Why Container Images Build Fast',
    avatar: '🥞',
    role: 'Narrator — stacking transparent sheets',
    bodyIntro:
        "🥞 A container image isn't one giant blob — it's built from layers, "
        "stacked like transparent sheets. Each instruction in a build file "
        "(like a Dockerfile) adds one more layer: \"install this,\" \"copy that "
        "code in,\" and so on.\n\n"
        "Layer 1: base OS (e.g. a tiny Linux). Layer 2: install dependencies. "
        "Layer 3: copy in your app's code. Layer 4: set the startup command.\n\n"
        "🚀 The magic: if you only change your app's code (layer 3), the "
        "build system can REUSE layers 1 and 2 exactly as they were — no need "
        "to rebuild the whole image from scratch, since those layers are "
        "cached.",
    calloutHints: [
      "💡 Practical tip real engineers use: put things that rarely change "
          "(like installing dependencies) in EARLY layers, and things that "
          "change often (your actual code) in LATER layers — that way, most "
          "rebuilds are fast.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          'Why do engineers put rarely-changing steps (like installing dependencies) in EARLY layers, and frequently-changing code in LATER layers?',
      options: [
        'It makes the final image use less disk space overall',
        'Earlier layers can be cached and reused across builds, so only the changed later layers need rebuilding — much faster builds',
        'It\'s required by law for container security',
        'Layer order has no effect on build speed at all',
      ],
      answerIndex: 1,
      explainOk:
          'Right — layer caching means unchanged early layers are reused, '
          'so builds only redo the layers that actually changed, saving huge '
          'amounts of time.',
      explainBad:
          'The key mechanism is caching: unchanged layers get reused across '
          'builds, so ordering rarely-changing steps first keeps most '
          'rebuilds fast.',
    ),
  ),
  const Chapter(
    id: 13,
    title: "Why One Container Isn't Enough",
    avatar: '🐜',
    role: 'Narrator — watching one ant try to move a log',
    bodyIntro:
        "🐜 One container running your app is great — until real traffic "
        "arrives. One container can crash, run out of capacity, or need "
        "updating without downtime. At real scale you need MANY copies of "
        "your app running across MANY machines, and someone has to manage "
        "all of them.\n\n"
        "❓ Which machine should each container run on?\n\n"
        "❓ What happens when a container crashes — who restarts it?\n\n"
        "❓ How do you update all of them without taking the whole app down?\n\n"
        "❓ How do users find the RIGHT container among hundreds of moving "
        "copies?",
    calloutHints: [
      "🧩 Doing all of this by hand, across dozens or hundreds of machines, is "
          "exactly the kind of tedious, error-prone busywork computers are "
          "supposed to save us from. That's the gap orchestration fills.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'What core problem does container orchestration exist to solve?',
      options: [
        'Making individual containers start up faster',
        'Managing WHERE many containers run, restarting failed ones, and coordinating updates across many machines automatically',
        'Compressing container images to save disk space',
        'Replacing the need for any cloud provider',
      ],
      answerIndex: 1,
      explainOk:
          'Exactly — orchestration automates placement, healing, and '
          "updates across a fleet of containers and machines, at a scale "
          "humans can't manage by hand.",
      explainBad:
          "Orchestration isn't about single-container speed or disk space — "
          'it\'s about automatically managing placement, restarts, and '
          'updates across MANY containers and machines.',
    ),
  ),
  const Chapter(
    id: 14,
    title: 'When a Container Dies, Who Notices?',
    avatar: '💔',
    role: 'Narrator — noticing a light go out',
    bodyIntro:
        "💔 Without orchestration, if a container crashes at 3am, nobody "
        "notices until a human wakes up to angry alerts. An orchestration "
        "system continuously watches every container's health, and "
        "automatically restarts or replaces any that die — this is called "
        "self-healing.\n\n"
        "🔁 It doesn't just restart blindly — it constantly compares \"what "
        "SHOULD be running\" against \"what IS actually running,\" and takes "
        "action to close any gap. If you asked for 5 copies and only 3 are "
        "alive, it launches 2 more, automatically.",
    calloutHints: [
      '🎯 This "desired state vs actual state, always reconciling" idea is '
          'the beating heart of modern orchestration systems — you\'ll see it '
          'again and again at the professional tier.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "You've told the orchestrator you want 5 copies of your app running. One crashes, leaving 4. What happens?",
      options: [
        'Nothing — a human must manually restart it',
        'The orchestrator notices actual (4) doesn\'t match desired (5), and automatically launches a replacement',
        'The other 4 containers automatically shut down too, to match the failure',
        'The orchestrator deletes your app entirely as a safety measure',
      ],
      answerIndex: 1,
      explainOk:
          'Right — the orchestrator constantly reconciles actual state '
          'toward desired state, launching a replacement without any human '
          'intervention.',
      explainBad:
          'The core loop is reconciliation: desired state (5) vs actual '
          'state (4) triggers an automatic action to close the gap — no '
          'human needed.',
    ),
  ),
  const Chapter(
    id: 15,
    title: 'Orchestration: The Conductor of the Orchestra',
    avatar: '🎼',
    role: 'Narrator — watching a conductor wave a baton',
    bodyIntro:
        "🎼 A container orchestration system (like the Kubernetes-style "
        "systems you'll study at professional depth soon) acts like an "
        "orchestra conductor: it doesn't play any instrument itself, but it "
        "decides which musician (container) plays which part, on which stage "
        "(machine), and keeps everyone in sync.\n\n"
        "Core jobs an orchestrator handles:\n\n"
        "📍 Scheduling — deciding which machine each container runs on\n\n"
        "❤️ Health checking — noticing crashed containers and replacing them\n\n"
        "📈 Scaling — adding/removing copies based on load\n\n"
        "🔀 Networking — letting containers find and talk to each other "
        "reliably even as they move around\n\n"
        "🚀 Rolling updates — deploying new versions gradually, without "
        "downtime",
    calloutHints: [
      '🌍 Kubernetes is the most famous orchestration system, but the '
          'CONCEPTS — scheduling, healing, scaling, service discovery — apply '
          'broadly to any orchestration platform.',
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a job on the left, then its correct description on the right.',
      pairs: [
        MatchPair('sched', 'Scheduling', 'Deciding which machine each container runs on'),
        MatchPair('heal', 'Self-healing', 'Noticing crashed containers and replacing them'),
        MatchPair('scale', 'Scaling', 'Adding or removing copies based on load'),
        MatchPair('roll', 'Rolling update', 'Deploying a new version gradually without downtime'),
      ],
      explainOk:
          "Perfect — that's the conductor's whole job description: "
          'placement, healing, scaling, and safe rollout, all automated.',
    ),
  ),
  const Chapter(
    id: 16,
    title: 'Declarative vs Imperative: Telling vs Asking',
    avatar: '🗣️',
    role: 'Narrator — comparing two ways to give instructions',
    bodyIntro:
        "🗣️ There are two styles of telling a system what to do:\n\n"
        "👉 Imperative — a step-by-step list of commands: \"start container A "
        "on machine 1, then start container B on machine 2, then...\" You "
        "describe the exact ACTIONS to take.\n\n"
        "🎯 Declarative — you just describe the END STATE you want: \"I want 5 "
        "copies of this app running, always.\" The system figures out HOW to "
        "get there and keep it that way, even after failures.\n\n"
        "Modern orchestration systems are almost always declarative — you "
        "write down the goal, and the reconciliation loop from two chapters "
        "ago continuously works to make reality match it.",
    calloutHints: [
      '🧭 Declarative is like telling a taxi driver a destination address; '
          'imperative is like giving turn-by-turn directions yourself. '
          "Declarative adapts automatically if a road closes — imperative "
          "doesn't, unless you notice and re-plan.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Sort each instruction style into the right bucket.',
      bucketALabel: '🎯 Declarative',
      bucketBLabel: '👉 Imperative',
      items: [
        Sort2Item('d1', '"There should always be 5 running copies of this app."', true),
        Sort2Item('i1', '"Run this exact command on machine 1, then this one on machine 2."', false),
        Sort2Item('d2', 'The system automatically restarts a failed container to match the stated goal', true),
        Sort2Item('i2', 'A script that must be re-run manually if a step fails partway through', false),
      ],
      explainOk:
          'Exactly — declarative states the desired end goal and lets the '
          'system maintain it; imperative is a literal sequence of steps '
          'you must manage yourself.',
      explainBad:
          'Ask: does it describe WHAT you want (declarative) or exactly '
          'HOW/step-by-step to do it (imperative)?',
    ),
  ),
  const Chapter(
    id: 17,
    title: 'Serverless: No Server to Babysit (Sort Of)',
    avatar: '🫥',
    role: 'Narrator — looking for the server and not finding one',
    bodyIntro:
        "🫥 \"Serverless\" doesn't mean there are no servers — of course there "
        "are, somewhere! It means YOU never think about them. No choosing a "
        "VM size, no patching an OS, no capacity planning. You just hand over "
        "your code, and the cloud provider runs it only when it's actually "
        "needed.\n\n"
        "🐢 Compare this to me, the turtle: normally I have to be somewhere, "
        "rolling around, using energy even while waiting for something to do. "
        "Serverless code is more like a helper that only exists for the few "
        "seconds it's actually working, then vanishes completely until called "
        "again.",
    calloutHints: [
      "💤 Because the code doesn't run continuously, you also don't pay "
          "continuously — serverless billing is usually per actual execution, "
          "often down to fractions of a second.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What does 'serverless computing' really mean?",
      options: [
        'There are literally no physical servers involved anywhere',
        'Servers exist, but the developer never has to provision, patch, or manage them directly',
        'It only works without any Internet connection',
        'It means your code runs forever without ever stopping',
      ],
      answerIndex: 1,
      explainOk:
          "Right — servers absolutely still exist; 'serverless' just means "
          'the provider hides and manages them entirely, and your code runs '
          'on-demand.',
      explainBad:
          "There are always real servers running the code somewhere — "
          "'serverless' means YOU never manage them, not that they don't "
          "exist.",
    ),
  ),
  const Chapter(
    id: 18,
    title: 'Functions as a Service: Code That Wakes Up',
    avatar: '⚡',
    role: 'Narrator — flipping a light switch',
    bodyIntro:
        "⚡ FaaS (Functions as a Service) is the most common form of "
        "serverless: you write a single small function — a self-contained "
        "chunk of code that does one job — and the cloud provider handles "
        "running it, scaling it, and shutting it down when idle.\n\n"
        "😴 Your function sits completely dormant, using zero resources\n\n"
        "📩 Something triggers it (like an HTTP request)\n\n"
        "🚀 The provider spins up an environment and runs your function\n\n"
        "📤 The function returns a result\n\n"
        "😴 It goes back to sleep, ready to wake up again next time",
    calloutHints: [
      '🍔 Examples: AWS Lambda, Google Cloud Functions, Azure Functions — you '
          'upload a function, and never think about the machine underneath it.',
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these into the order a serverless function's life actually goes.",
      items: [
        OrderItem('sleep1', 'Function is dormant, using zero resources'),
        OrderItem('trigger', 'A trigger arrives (e.g. an HTTP request)'),
        OrderItem('spinup', 'Provider spins up an execution environment'),
        OrderItem('run', 'Function code runs and returns a result'),
        OrderItem('sleep2', 'Function goes back to sleep'),
      ],
      explainOk:
          'Exactly — dormant, triggered, spun up, run, then back to sleep. '
          "That's the whole FaaS lifecycle.",
      explainBad:
          'It always starts dormant, wakes only on a trigger, runs, and '
          'returns to sleep — nothing runs continuously in between calls.',
    ),
  ),
  const Chapter(
    id: 19,
    title: 'Event-Driven: What Wakes a Function Up',
    avatar: '🔔',
    role: 'Narrator — ringing a doorbell',
    bodyIntro:
        "🔔 Serverless functions are event-driven — they don't run on a "
        "schedule by default, they run because something specific HAPPENED. "
        "Common triggers (\"events\"):\n\n"
        "🌐 An HTTP request hits an API endpoint\n\n"
        "📁 A new file gets uploaded to storage\n\n"
        "📬 A message arrives in a queue\n\n"
        "⏰ A scheduled timer fires (like a cron job)\n\n"
        "🗄️ A row changes in a database\n\n"
        "🐢 It's like a doorbell instead of a receptionist who sits at a desk "
        "all day: nobody's \"on duty\" until someone actually rings the bell, "
        "at which point someone appears instantly to help.",
    calloutHints: [
      "🧩 This event-driven model is a natural fit for glue code — small "
          "reactions to specific things happening — rather than long-running, "
          "always-on services.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a trigger type on the left, then its example on the right.',
      pairs: [
        MatchPair('http', 'HTTP trigger', "A user's browser calls an API endpoint"),
        MatchPair('storage', 'Storage trigger', 'A new photo is uploaded to a bucket'),
        MatchPair('schedule', 'Scheduled trigger', 'A timer fires every night at 2am'),
        MatchPair('queue', 'Queue trigger', 'A new order message appears to be processed'),
      ],
      explainOk:
          'Right — event-driven functions react to specific happenings: '
          'requests, uploads, timers, or queue messages.',
    ),
  ),
  const Chapter(
    id: 20,
    title: 'Serverless Tradeoffs, Simply Put',
    avatar: '⚖️',
    role: 'Narrator — weighing two options on a scale',
    bodyIntro:
        "⚖️ Serverless isn't free lunch — it trades some things for others:\n\n"
        "✅ Pro: No server management, automatic scaling, pay only for actual "
        "use\n\n"
        "✅ Pro: Great for spiky, unpredictable, or infrequent workloads\n\n"
        "⚠️ Con: A dormant function takes a moment to \"wake up\" (we'll dig "
        "into this \"cold start\" at the professional tier)\n\n"
        "⚠️ Con: Less control over the exact runtime environment\n\n"
        "⚠️ Con: Can get expensive for CONSTANT, high-volume traffic compared "
        "to always-on servers",
    calloutHints: [
      '🎯 Rule of thumb: serverless shines for bursty, occasional work; '
          'steady, heavy, predictable traffic is often cheaper on traditional '
          'always-on servers or containers.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'Which workload is generally a WORSE fit for serverless (FaaS)?',
      options: [
        'A function that runs a few times a day in response to file uploads',
        'An API that occasionally gets a burst of traffic, then goes quiet for hours',
        'A service handling constant, massive, steady traffic 24/7 at a predictable high rate',
        'A nightly scheduled cleanup task',
      ],
      answerIndex: 2,
      explainOk:
          'Right — serverless shines for bursty or occasional work; a '
          'constant, massive steady load is often cheaper and more '
          'predictable on always-on infrastructure.',
      explainBad:
          'Serverless is great for spiky or occasional workloads; think '
          'about which option is the OPPOSITE of that — constant heavy '
          'traffic usually favors always-on servers.',
    ),
  ),
  const Chapter(
    id: 21,
    title: 'Object Storage: The Giant Filing Cabinet',
    avatar: '🗄️',
    role: 'Narrator — opening an enormous filing cabinet',
    bodyIntro:
        "🗄️ Object storage stores whole files (\"objects\" — photos, videos, "
        "backups) each with a unique key, in a flat structure without real "
        "folders (even though it LOOKS like folders in a web console). You "
        "don't edit part of a file in place — you replace the whole object.\n\n"
        "♾️ Scales to a practically unlimited number of objects\n\n"
        "🌍 Accessed over the network via simple APIs (usually HTTP)\n\n"
        "📦 Examples: Amazon S3, Google Cloud Storage\n\n"
        "🎯 Great for: images, videos, backups, static website files, logs",
    calloutHints: [
      "🔑 Every object is found by its key (like a filename), not by its "
          "physical location — object storage handles spreading your data "
          "across many machines for durability, completely behind the scenes.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'Object storage (like Amazon S3) is best suited for which kind of data?',
      options: [
        'A live database that needs constant small in-place row updates',
        'Whole files like images, videos, and backups, accessed as complete objects',
        'A single shared folder mounted like a local hard drive for one server',
        'Real-time in-memory caching for microsecond lookups',
      ],
      answerIndex: 1,
      explainOk:
          'Right — object storage is built for storing and retrieving whole '
          'files at massive scale, not for fine-grained in-place edits.',
      explainBad:
          "Object storage handles whole files (objects) at massive scale — "
          "it's not designed for constant in-place row edits or microsecond "
          "caching.",
    ),
  ),
  const Chapter(
    id: 22,
    title: 'Block Storage: The Hard Drive in the Cloud',
    avatar: '💾',
    role: 'Narrator — plugging in a virtual hard drive',
    bodyIntro:
        "💾 Block storage works like a raw hard drive attached to a single "
        "virtual machine: data is split into fixed-size \"blocks,\" and the "
        "VM's operating system organizes them into a familiar file system, "
        "just like a physical disk plugged into a real computer.\n\n"
        "🖥️ Usually attached to exactly ONE virtual machine at a time\n\n"
        "⚡ Fast, low-latency — great for databases and anything needing "
        "frequent small writes\n\n"
        "📦 Examples: AWS EBS, Google Persistent Disk",
    calloutHints: [
      '🆚 Object storage vs block storage in one line: object storage is a '
          'filing cabinet accessed over the network for whole files; block '
          'storage is a virtual hard drive attached to one machine for '
          'fine-grained reads and writes.',
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Sort each scenario into the storage type that fits best.',
      bucketALabel: '🗄️ Object storage',
      bucketBLabel: '💾 Block storage',
      items: [
        Sort2Item('photos', 'Storing millions of user-uploaded photos', true),
        Sort2Item('db', 'The disk backing a database that needs fast, frequent small writes', false),
        Sort2Item('backup', 'Long-term backups accessed occasionally over HTTP', true),
        Sort2Item('vm', 'The root drive attached to a single running virtual machine', false),
      ],
      explainOk:
          'Correct — object storage suits whole files at scale; block '
          'storage suits a fast disk dedicated to one machine.',
      explainBad:
          'Ask: is this a whole file accessed occasionally over the network '
          '(object), or a disk needing fast fine-grained reads/writes for '
          'one VM (block)?',
    ),
  ),
  const Chapter(
    id: 23,
    title: 'File Storage: A Shared Folder for Many Machines',
    avatar: '📁',
    role: 'Narrator — several turtles reaching into the same folder',
    bodyIntro:
        "📁 File storage is like block storage's more sociable cousin: "
        "instead of being tied to one VM, it's a shared folder-like file "
        "system that MULTIPLE machines can mount and read/write to at the "
        "same time — using familiar file system protocols (like NFS or SMB).",
    calloutHints: [
      '🎯 Great for: shared configuration files, home directories accessed '
          'by a fleet of servers, or content multiple app servers all need to '
          'read and write together — anywhere "one shared folder, many '
          'machines" is the actual need.',
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a storage type on the left, then its best-fit description on the right.',
      pairs: [
        MatchPair('obj', 'Object storage', 'Whole files at massive scale, one owner writes/reads a full object'),
        MatchPair('blk', 'Block storage', 'A fast disk attached to exactly one virtual machine'),
        MatchPair('file', 'File storage', 'One shared folder, mounted and used by MANY machines at once'),
      ],
      explainOk:
          'Right — object for scale, block for one fast dedicated disk, '
          'file for a shared multi-machine folder.',
    ),
  ),
  const Chapter(
    id: 24,
    title: 'CDNs: Copies Closer to You',
    avatar: '🌍',
    role: 'Narrator — noticing how much faster the nearby shop is',
    bodyIntro:
        "🌍 A CDN (Content Delivery Network) keeps CACHED COPIES of your "
        "content (images, videos, website files) on servers scattered all "
        "around the world, so users download from a server physically close "
        "to THEM, instead of one far-away origin server every single time.\n\n"
        "🚗 It's like a chain of bakeries instead of one central bakery "
        "mailing bread to every city — a bakery near you means fresher "
        "bread, faster, with way less travel distance.",
    calloutHints: [
      '⚡ CDNs cut two things at once: latency (physical distance = time) '
          'and load on your origin server (since most requests never even '
          'reach it — the CDN answers from its cache).',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'What is the main benefit a CDN provides?',
      options: [
        'It permanently stores your only copy of the data, replacing the origin server',
        'It serves cached copies of content from servers physically closer to users, reducing latency and origin load',
        "It encrypts all of your website's traffic automatically",
        'It replaces the need for DNS lookups entirely',
      ],
      answerIndex: 1,
      explainOk:
          "Right — a CDN's whole purpose is proximity: cached copies near "
          'the user mean faster delivery and far less load on the origin.',
      explainBad:
          "A CDN doesn't replace your origin data or handle "
          'encryption/DNS by itself — its core job is serving cached copies '
          'from nearby servers to cut latency and origin load.',
    ),
  ),
  const Chapter(
    id: 25,
    title: 'Fallacy #1: The Network Is Reliable',
    avatar: '📡',
    role: 'Narrator — a message vanishing into static',
    bodyIntro:
        "📡 Level 7! Once your app spans multiple machines, you're a "
        "distributed system — and distributed systems break in ways a single "
        "machine never does. The most famous trap is assuming \"the network "
        "is reliable.\" It absolutely is not.\n\n"
        "Cables get cut, Wi-Fi drops packets, routers get overloaded, cloud "
        "regions have outages. Any message you send between two machines can "
        "simply vanish — and worse, you often can't tell the difference "
        "between \"the message was lost\" and \"the message arrived but the "
        "REPLY was lost.\"",
    calloutHints: [
      "🐢 If I roll a message across the isles and it never arrives, I "
          "genuinely cannot always tell if my friend never got it, or got it "
          "and their reply to me got lost instead. That ambiguity is at the "
          "heart of distributed systems design.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'A server sends a request, then gets no response. What can it conclude for certain?',
      options: [
        'The request definitely never arrived at the other server',
        'Nothing for certain — the request may have been lost, OR it arrived and only the response was lost',
        'The other server has definitely crashed',
        'The network is definitely down entirely',
      ],
      answerIndex: 1,
      explainOk:
          'Exactly right — this ambiguity (request lost vs. response lost) '
          'is unavoidable over an unreliable network, and it\'s why '
          'distributed protocols must be designed to handle it (e.g. via '
          'retries and idempotency).',
      explainBad:
          "A missing response is ambiguous by nature — you can't tell "
          'whether the request was lost, or it succeeded and only the reply '
          'vanished. Design for that uncertainty.',
    ),
  ),
  const Chapter(
    id: 26,
    title: 'Fallacy #2: Latency Is Zero',
    avatar: '🐌',
    role: "Narrator — timing a message's trip across the world",
    bodyIntro:
        "🐌 Another dangerous assumption: latency is zero, i.e. things happen "
        "\"instantly.\" They never do. Even at the speed of light, a message "
        "from New York to Sydney takes real, measurable time — and real "
        "networks add far more delay than light-speed physics alone would "
        "suggest.\n\n"
        "If your code assumes a call to another machine returns \"basically "
        "instantly,\" it will behave badly the moment that call takes 200ms "
        "instead of 2ms — timeouts fire, queues back up, users wait.",
    calloutHints: [
      '📏 Rule of thumb many engineers memorize: calling a function in the '
          'SAME process costs nanoseconds; calling across a network, even a '
          'fast one, costs milliseconds — a difference of a MILLION times or '
          'more.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          'Roughly how much slower is a typical network call compared to calling a function within the same process?',
      options: [
        'About the same speed — negligible difference',
        'Around 2x slower',
        'Often a MILLION times slower or more (nanoseconds vs milliseconds)',
        'Network calls are actually faster',
      ],
      answerIndex: 2,
      explainOk:
          'Right — nanoseconds vs milliseconds is roughly a million-fold '
          'difference. Designs that ignore this gap tend to fall apart '
          'under real load.',
      explainBad:
          'The gap is enormous — local calls run in nanoseconds; network '
          "calls run in milliseconds. That's roughly a million-fold "
          'slowdown, not a small one.',
    ),
  ),
  const Chapter(
    id: 27,
    title: 'More Trusting Fallacies: Bandwidth and Topology',
    avatar: '🚧',
    role: 'Narrator — hitting a traffic jam on a wide-open-looking road',
    bodyIntro:
        "🚧 The famous \"Fallacies of Distributed Computing\" list keeps "
        "going. A few more:\n\n"
        "♾️ \"Bandwidth is infinite\" — networks have real capacity limits; "
        "enough traffic saturates any link.\n\n"
        "🔒 \"The network is secure\" — anything crossing a network can "
        "potentially be intercepted or tampered with unless you actively "
        "encrypt/verify it.\n\n"
        "🗺️ \"Topology doesn't change\" — machines get added, removed, "
        "replaced, moved between data centers — your system must tolerate "
        "the map shifting under it.\n\n"
        "👤 \"There is one administrator\" — real systems span teams and "
        "organizations, each with different priorities and change "
        "schedules.",
    calloutHints: [
      '🎯 These "fallacies" were written decades ago (by Peter Deutsch and '
          'others at Sun Microsystems) and remain just as true today — every '
          'one of them still bites engineers who assume otherwise.',
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each statement into the correct bucket.',
      bucketALabel: '❌ Fallacy (dangerous to assume)',
      bucketBLabel: '✅ Safe design principle',
      items: [
        Sort2Item('f1', '"Bandwidth is infinite, so I never need to worry about payload size."', true),
        Sort2Item('f2', '"The network can drop or delay any message, so I should design for retries."', false),
        Sort2Item('f3', '"The network topology never changes, so I can hardcode server addresses forever."', true),
        Sort2Item('f4', '"I should encrypt sensitive data in transit, since the network isn\'t inherently secure."', false),
      ],
      explainOk:
          'Exactly — the fallacies are the false comforting assumptions; '
          'the safe principles are designing AROUND the network\'s real, '
          'messy limitations.',
      explainBad:
          'Anything assuming the network is perfect (infinite bandwidth, '
          'fixed topology, inherently secure) is a fallacy. Designing '
          'around imperfection is the safe path.',
    ),
  ),
  const Chapter(
    id: 28,
    title: 'Why These Fallacies Matter: Designing for Failure',
    avatar: '🛡️',
    role: 'Narrator — building an umbrella before the rain',
    bodyIntro:
        "🛡️ The whole point of learning these fallacies isn't pessimism — "
        "it's preparation. Distributed systems that assume the network is "
        "perfect break in production, often unpredictably and at the worst "
        "possible time. Systems that assume the network WILL fail, at least "
        "sometimes, build in defenses upfront:\n\n"
        "🔁 Retries for messages that might have been lost\n\n"
        "⏱️ Timeouts so a slow/dead machine doesn't hang everything forever\n\n"
        "🎯 Idempotency — designing operations so doing them twice by "
        "accident causes no harm\n\n"
        "🧯 Circuit breakers — stop hammering a struggling service instead "
        "of piling on",
    calloutHints: [
      "🐢 A slow-to-start turtle who still keeps rolling until done is "
          "exactly the right instinct for distributed systems: expect delays "
          "and hiccups, but design so the system still finishes the job.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a defense on the left, then its purpose on the right.',
      pairs: [
        MatchPair('retry', 'Retry', 'Try again in case a message was lost'),
        MatchPair('timeout', 'Timeout', 'Stop waiting on a slow or dead machine instead of hanging forever'),
        MatchPair('idem', 'Idempotency', 'Make repeating an operation by accident harmless'),
        MatchPair('cb', 'Circuit breaker', 'Stop sending more requests to an already-struggling service'),
      ],
      explainOk:
          'Right — these four defenses are the practical toolkit for '
          "surviving an unreliable network, and you'll see them again at "
          'professional depth.',
    ),
  ),
  const Chapter(
    id: 29,
    title: 'Why Distributed Machines Need to Agree',
    avatar: '🤝',
    role: 'Narrator — several turtles arguing about which way to go',
    bodyIntro:
        "🤝 Imagine five turtles trying to decide, together, which direction "
        "to roll — with no single boss, and messages between them sometimes "
        "arriving late or not at all. Getting a group of independent "
        "machines to agree on ANYTHING (a value, a decision, an order of "
        "events) despite unreliable communication is one of the hardest, "
        "most fundamental problems in distributed systems: agreement (or "
        "\"consensus\").\n\n"
        "Why does it matter so much? Because so many real systems need it:\n\n"
        "🗳️ Which replica holds the \"true\" latest copy of the data?\n\n"
        "👑 Which machine is allowed to make the next decision?\n\n"
        "📝 In what ORDER did these events actually happen?",
    calloutHints: [
      "🎯 If machines can't agree reliably, you get split data, conflicting "
          "decisions, or worse — two machines both believing THEY'RE the one "
          "in charge (we'll meet this exact disaster soon).",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'Why is it fundamentally hard for distributed machines to agree on something?',
      options: [
        'Because computers are bad at math',
        'Because messages between machines can be delayed, lost, or arrive out of order, making it hard to know what everyone else currently believes',
        'Because agreement is only a problem for humans, not software',
        'Because agreement always requires a single physical server',
      ],
      answerIndex: 1,
      explainOk:
          'Right — unreliable, delayed, or lost communication is exactly '
          "what makes agreement hard; each machine only has an incomplete, "
          'possibly outdated view of the others.',
      explainBad:
          "The difficulty isn't math or a hardware requirement — it's that "
          "unreliable communication means no machine can be fully sure what "
          "every other machine currently believes.",
    ),
  ),
  const Chapter(
    id: 30,
    title: "Leader Election: Picking Who's In Charge",
    avatar: '👑',
    role: 'Narrator — turtles voting for a lead roller',
    bodyIntro:
        "👑 One common way to simplify agreement: instead of every machine "
        "negotiating everything constantly, the group elects ONE leader who "
        "makes decisions on everyone's behalf for a while. The others are "
        "followers who accept the leader's decisions.\n\n"
        "This isn't a permanent monarchy — if the leader ever seems to have "
        "failed, the group runs a new election to pick a replacement.",
    calloutHints: [
      '🎯 Why bother with a leader at all? It massively simplifies the "who '
          'decides" problem — instead of N machines all negotiating with each '
          'other constantly, followers just listen to one leader, until that '
          'leader is unavailable.',
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Drag these into the order a leader-based system typically goes through.',
      items: [
        OrderItem('elect', 'Machines elect a leader among themselves'),
        OrderItem('serve', 'Leader makes decisions; followers accept them'),
        OrderItem('fail', 'Leader stops responding (crash, network partition, etc.)'),
        OrderItem('detect', 'Followers detect the silence (e.g. missed heartbeats)'),
        OrderItem('reelect', 'A new election happens to pick a replacement leader'),
      ],
      explainOk:
          'That\'s the cycle — elect, serve, eventually fail, get detected, '
          "and re-elect. This loop repeats for the system's whole lifetime.",
      explainBad:
          'The leader must actually fail and be DETECTED as failed (via '
          'missed heartbeats) before a new election can happen — detection '
          'always comes before re-election.',
    ),
  ),
  const Chapter(
    id: 31,
    title: 'What Happens When the Leader Disappears',
    avatar: '🫠',
    role: "Narrator — waiting for a friend who's gone quiet",
    bodyIntro:
        "🫠 How does the group even know the leader is gone? Usually through "
        "heartbeats: the leader periodically sends \"I'm still here!\" "
        "signals. If followers don't hear a heartbeat within some timeout "
        "window, they assume the leader has failed and trigger a new "
        "election.\n\n"
        "⚠️ But here's the catch: a missing heartbeat doesn't ALWAYS mean the "
        "leader actually crashed. It might just be a slow network, or the "
        "leader is simply busy. This ambiguity is exactly the \"network is "
        "unreliable\" fallacy from Level 7, showing up again in a very "
        "concrete way.",
    calloutHints: [
      "⏱️ Pick the timeout carefully: too short, and you trigger needless "
          "elections over minor network blips. Too long, and the system is "
          "slow to recover from a genuinely dead leader.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What's the risk of setting a heartbeat timeout TOO SHORT?",
      options: [
        'The system will never detect a real leader failure',
        'Minor, harmless network delays get mistaken for leader failure, triggering unnecessary elections',
        'It has no downside at all — shorter is always better',
        'It makes the leader permanently unelectable',
      ],
      answerIndex: 1,
      explainOk:
          'Right — a too-short timeout confuses ordinary network jitter '
          'with a real failure, causing unnecessary, disruptive '
          're-elections.',
      explainBad:
          "A too-short timeout's real danger is false alarms: harmless "
          'network delays get misread as a dead leader, triggering needless '
          'elections.',
    ),
  ),
  const Chapter(
    id: 32,
    title: 'Split Brain: Two Leaders, One Disaster',
    avatar: '🧠',
    role: 'Narrator — watching two turtles both shout orders at once',
    bodyIntro:
        "🧠 Here's the nightmare scenario: a network glitch splits the "
        "cluster into two groups that can't talk to each other. Each group, "
        "unable to reach the \"old\" leader, elects its OWN new leader — and "
        "now there are TWO leaders active at once, both confidently making "
        "decisions, unaware of each other. This is split brain.\n\n"
        "💥 If both leaders accept writes independently, data can diverge "
        "and conflict — two \"truths\" that disagree, with no clean way to "
        "reconcile them later.",
    calloutHints: [
      '🗳️ The standard defense: require a leader to be elected (and to keep '
          'acting) only with support from a MAJORITY (quorum) of the cluster. '
          "A network split can give at most ONE side a majority — the other "
          "side can't elect anyone, preventing dual leadership.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What's the standard technique to prevent split brain (two leaders active at once)?",
      options: [
        'Let every node just guess who the real leader is',
        'Require leader election/actions to have support from a majority (quorum) of nodes — a network split can give a majority to at most one side',
        'Never allow more than one machine in the whole cluster',
        'Disable heartbeats entirely so no elections ever happen',
      ],
      answerIndex: 1,
      explainOk:
          'Exactly — requiring majority quorum guarantees at most one side '
          'of a split can ever have enough votes to elect/act as leader.',
      explainBad:
          'The quorum trick is key: since a majority can only exist on ONE '
          'side of any network split, requiring majority support prevents '
          'two leaders from both being legitimate.',
    ),
  ),
  const Chapter(
    id: 33,
    title: 'The CAP Theorem, Meet Process',
    avatar: '🎭',
    role: 'Narrator — being handed an impossible menu',
    bodyIntro:
        "🎭 Final chapter of the foundation tier! The CAP theorem is a "
        "famous rule about distributed data systems: when a network "
        "partition happens (some machines can't reach others), you can only "
        "guarantee TWO of these THREE properties at once, not all three:\n\n"
        "✅ Consistency (C) — every read sees the latest write, everywhere\n\n"
        "✅ Availability (A) — every request gets a response, even during a "
        "partition\n\n"
        "✅ Partition tolerance (P) — the system keeps working even when "
        "some machines can't talk to others\n\n"
        "🌐 Because real networks DO partition sometimes (Level 7's "
        "fallacies again!), partition tolerance is basically mandatory for "
        "any real distributed system — so the real-world choice becomes: "
        "during a partition, do you favor Consistency or Availability?",
    calloutHints: [
      '🎯 CAP is specifically about behavior DURING a partition — when the '
          'network is healthy, many systems happily give you all three at '
          'once.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'What does the CAP theorem actually say?',
      options: [
        'A distributed system can never have consistency, availability, or partition tolerance',
        'During a network partition, a system can guarantee at most two of Consistency, Availability, and Partition tolerance — not all three',
        'All three properties are always guaranteed simultaneously in any well-built system',
        'CAP only applies to single-machine databases',
      ],
      answerIndex: 1,
      explainOk:
          'Right — CAP is specifically about the moment of a partition: '
          'you must sacrifice either full consistency or full availability, '
          'since partition tolerance is generally required.',
      explainBad:
          "CAP isn't 'you can never have any of them' or 'always all "
          "three' — it's a specific tradeoff during a partition: pick at "
          'most two of the three.',
    ),
  ),
  const Chapter(
    id: 34,
    title: 'Picking Two: CP vs AP Systems',
    avatar: '🎛️',
    role: 'Narrator — flipping between two switches',
    bodyIntro:
        "🎛️ Since partition tolerance is nearly always required in "
        "practice, real systems mostly split into two camps:\n\n"
        "🔒 CP (Consistent + Partition-tolerant) — during a partition, the "
        "system may REFUSE some requests (become temporarily unavailable) "
        "rather than risk returning stale or conflicting data. Good for "
        "things like financial transactions, where wrong data is worse than "
        "no answer.\n\n"
        "⚡ AP (Available + Partition-tolerant) — during a partition, the "
        "system keeps answering requests, even if some answers might be "
        "slightly out of date. Good for things like a social media \"like\" "
        "counter, where a stale number briefly is way better than no "
        "response at all.",
    calloutHints: [
      "🏦 Analogy: a bank's core ledger usually leans CP (correctness over "
          'uptime); a "likes" counter or shopping cart usually leans AP '
          '(uptime over perfect freshness).',
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Drag each scenario into the design choice that fits it best.',
      bucketALabel: '🔒 CP — prefer refusing over wrong data',
      bucketBLabel: '⚡ AP — prefer answering, even if slightly stale',
      items: [
        Sort2Item('bank', 'Processing a bank transfer where double-spending must never happen', true),
        Sort2Item('likes', 'Showing a \'likes\' count on a social post', false),
        Sort2Item('inventory', 'Confirming a critical safety-stock check before shipping medicine', true),
        Sort2Item('cart', 'Letting users keep adding items to a shopping cart during a network blip', false),
      ],
      explainOk:
          'Correct — when being WRONG is dangerous, lean CP; when being '
          'briefly STALE is harmless but downtime isn\'t, lean AP.',
      explainBad:
          'Ask: is a wrong/stale answer dangerous (favor CP, refuse rather '
          'than risk it) or just a minor inconvenience (favor AP, keep '
          'answering)?',
    ),
  ),
  const Chapter(
    id: 35,
    title: 'Eventual Consistency in Plain Terms',
    avatar: '⏳',
    role: 'Narrator — watching gossip slowly spread through the isles',
    bodyIntro:
        "⏳ Eventual consistency is the promise many AP systems make: \"if "
        "you stop writing new updates, ALL replicas will eventually "
        "converge to the same value — just maybe not instantly.\" Right after "
        "a write, different machines might briefly disagree, but given "
        "enough time (usually milliseconds to seconds in practice), "
        "everyone catches up.\n\n"
        "🐢 Picture gossip spreading across Cloud Cluster Isles: I tell one "
        "turtle the news, they tell another, and so on. For a little while, "
        "some turtles know and others don't — but eventually everyone hears "
        "it. That temporary disagreement, followed by guaranteed "
        "convergence, is eventual consistency in a nutshell.",
    calloutHints: [
      '🆚 This is the opposite promise of "strong consistency," which '
          'insists every reader sees the latest write immediately, no matter '
          'what — at the cost of possibly refusing requests during a '
          'partition (that\'s the CP choice again).',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What exactly does 'eventual consistency' guarantee?",
      options: [
        'Every read always sees the very latest write, instantly, no exceptions',
        'If writes stop, all replicas will eventually converge to the same value — though reads in the meantime might be briefly stale',
        "Data is never replicated at all, so there's nothing to converge",
        'The system will crash until all data matches exactly',
      ],
      answerIndex: 1,
      explainOk:
          'Right — eventual consistency accepts temporary staleness in '
          'exchange for availability, promising convergence over time '
          'rather than instant agreement.',
      explainBad:
          'Eventual consistency explicitly allows brief staleness right '
          'after a write — the guarantee is about convergence OVER TIME, '
          'not instant agreement.',
    ),
  ),
  const Chapter(
    id: 36,
    title: 'Level 9 Capstone — CAP in the Wild',
    avatar: '🎓',
    role: 'Narrator — surveying the whole foundation tier from a hilltop',
    bodyIntro:
        "🎓 You've made it through the foundation tier! Let's connect "
        "everything: cloud service models (Level 1), elastic VMs and "
        "containers (Levels 2-4), serverless (Level 5), storage and CDNs "
        "(Level 6), the network fallacies that justify all of this caution "
        "(Level 7), leader election (Level 8), and now CAP and eventual "
        "consistency (Level 9) — all pieces of the same picture: real "
        "systems built from unreliable parts, engineered to stay useful "
        "anyway.\n\n"
        "One more real-world trace before the professional tier begins. A "
        "globally distributed shopping cart service experiences a brief "
        "network partition between two data centers.",
    calloutHints: [
      '🚀 From here on, the game shifts into the PROFESSIONAL TIER — '
          'production-grade depth. Every chapter from Level 10 onward assumes '
          "you've genuinely internalized everything up to here.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          'Drag these into the order events happen for an AP-style shopping cart service during a network partition.',
      items: [
        OrderItem('normal', 'Normally, all data centers sync writes and stay consistent'),
        OrderItem('partition', 'A network partition splits two data centers apart'),
        OrderItem('choice', 'System chooses Availability: both sides keep accepting cart updates independently'),
        OrderItem('diverge', "The two sides' cart data temporarily diverges"),
        OrderItem('heal', 'The partition heals; the sides reconcile and converge (eventual consistency)'),
      ],
      explainOk:
          "That's the full picture — this is CAP and eventual consistency, "
          'not as abstract theory, but as an actual sequence of events in '
          'production. Well done reaching the professional tier!',
      explainBad:
          'The sequence: normal syncing, then a partition hits, then the AP '
          'choice to keep serving both sides, causing divergence, and '
          'finally reconciliation once the partition heals.',
    ),
  ),
  const Chapter(
    id: 37,
    title: 'Pods: The Smallest Deployable Unit',
    avatar: '🫘',
    role: 'Narrator — professional-tier briefing begins',
    bodyIntro:
        "🏆 Professional tier. This is production knowledge-check depth — "
        "assume you're the engineer on call. In Kubernetes-style "
        "orchestration, the smallest deployable unit isn't a single "
        "container — it's a Pod. A Pod wraps one or more containers that "
        "must be scheduled together, on the same machine, sharing the same "
        "network namespace (same IP address, same localhost).\n\n"
        "🎯 Usually a Pod holds ONE main \"application\" container\n\n"
        "🧩 Sidecar containers can ride along in the same Pod (e.g. a "
        "logging agent, or a service-mesh proxy) — they share network and "
        "can share storage volumes with the main container\n\n"
        "🌐 All containers in a Pod share the SAME IP address and port "
        "space — they talk to each other over localhost",
    calloutHints: [
      "⚠️ Production nuance: Pods are meant to be ephemeral — they get "
          "created, rescheduled, and destroyed constantly. Never rely on a "
          "specific Pod's identity or IP surviving a restart; that's what "
          "Services (next chapter) exist to abstract away.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'In production Kubernetes-style orchestration, what fundamentally defines a Pod?',
      options: [
        'It is always exactly one container, with no exceptions',
        'It is a group of one or more containers scheduled together on the same machine, sharing network namespace and optionally storage',
        'It is a permanent, never-changing identity for an application',
        'It refers only to the physical server hardware',
      ],
      answerIndex: 1,
      explainOk:
          'Right — a Pod groups co-located containers sharing network (and '
          'optionally storage), most commonly a main app container plus '
          'optional sidecars.',
      explainBad:
          "A Pod isn't always single-container or permanent — it's a "
          'co-scheduled group sharing network namespace, often a main '
          "container plus sidecars, and it's inherently ephemeral.",
    ),
  ),
  const Chapter(
    id: 38,
    title: 'Services: Stable Addresses for Unstable Pods',
    avatar: '🎯',
    role: 'Narrator — a mail-forwarding address that never changes',
    bodyIntro:
        "🎯 Since Pods come and go, constantly getting new IPs, you need a "
        "stable way for other parts of your system to find them. That's "
        "what a Service provides: a fixed, stable virtual IP and DNS name "
        "that automatically load-balances traffic across whichever Pods "
        "currently match a given label — no matter how many times those "
        "Pods get replaced underneath it.\n\n"
        "🏷️ Services select Pods by labels (e.g. app: checkout), not by "
        "hardcoded identity\n\n"
        "🔄 As Pods are replaced, the Service's target list updates "
        "automatically\n\n"
        "⚖️ Traffic is load-balanced across all currently healthy matching "
        "Pods",
    calloutHints: [
      '🧠 Production insight: this label-based, indirect addressing is the '
          'SAME "stable interface over a changing set of workers" pattern '
          "you'll see again with load balancers, DNS-based service "
          'discovery, and even database connection pooling — it\'s a '
          "general distributed-systems idiom, not just a Kubernetes trick.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Why can't other parts of the system just hardcode a Pod's IP address directly?",
      options: [
        'Pods never have IP addresses at all',
        'Pods are frequently created and destroyed, so their IPs change constantly — Services provide a stable label-based address that survives Pod churn',
        'Hardcoding IPs is actually the recommended production practice',
        'Services are only used for external traffic, never internal',
      ],
      answerIndex: 1,
      explainOk:
          'Right — Pod IPs are transient by design; Services abstract that '
          'churn behind a stable, label-selected virtual address.',
      explainBad:
          'Pods DO have IPs, but they change constantly as Pods are '
          'replaced — that instability is exactly why Services exist, '
          'providing a stable label-based address instead.',
    ),
  ),
  const Chapter(
    id: 39,
    title: 'Deployments & Rolling Updates',
    avatar: '🚀',
    role: 'Narrator — swapping planks on a moving bridge',
    bodyIntro:
        "🚀 A Deployment declaratively describes \"I want N replicas of this "
        "Pod template running\" and manages rolling out new versions safely. "
        "A rolling update replaces old Pods with new ones gradually — a few "
        "at a time — instead of all at once, so the app stays available "
        "throughout.\n\n"
        "Rolling update, maxUnavailable=1, maxSurge=1, replicas=4: start "
        "[v1 v1 v1 v1], then one old replaced at a time until "
        "[v2 v2 v2 v2].\n\n"
        "⚠️ Production knowledge-check: if the new version (v2) has a bug "
        "that fails health checks, a well-configured rollout PAUSES "
        "automatically instead of continuing to replace healthy v1 Pods "
        "with broken ones — this is why readiness probes matter so much.",
    calloutHints: [
      '🔙 Real teams always keep a fast rollback path ready: if a rollout '
          'goes bad, reverting to the last known-good Deployment should be a '
          'single command, not a fire drill.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          'During a rolling update, the new version starts failing readiness/health checks. What should a properly configured rollout do?',
      options: [
        'Immediately replace ALL remaining old Pods with the broken new version anyway',
        "Pause the rollout, since unhealthy new Pods shouldn't be trusted to keep replacing healthy old ones",
        'Delete every Pod, old and new, immediately',
        'Ignore health checks entirely and always finish the rollout',
      ],
      answerIndex: 1,
      explainOk:
          'Right — a rollout that respects readiness probes halts on '
          'failing new Pods, preventing a bad version from fully replacing '
          'a healthy fleet.',
      explainBad:
          'Health checks exist to STOP a bad rollout partway — a properly '
          'configured deployment pauses rather than blindly replacing '
          'every remaining healthy Pod with a broken one.',
    ),
  ),
  const Chapter(
    id: 40,
    title: 'Horizontal Pod Autoscaling Policies in Production',
    avatar: '📊',
    role: 'Narrator — tuning dials on a live production dashboard',
    bodyIntro:
        "📊 A Horizontal Pod Autoscaler (HPA) automatically adjusts the "
        "NUMBER of Pod replicas based on observed metrics (commonly CPU or "
        "memory utilization, but production setups often use custom "
        "metrics like request queue depth).\n\n"
        "🎯 You set a target (e.g. \"keep average CPU at 60%\")\n\n"
        "📈 If observed usage exceeds target, more replicas are added\n\n"
        "📉 If usage drops well below target, replicas are removed\n\n"
        "⚠️ Production pitfalls senior engineers watch for:\n\n"
        "🌊 Thrashing — scaling up and down repeatedly if the metric hovers "
        "right at the threshold; production HPAs use stabilization "
        "windows/cooldowns to dampen this\n\n"
        "🐌 Slow scale-up vs. sudden traffic spikes — new Pods still need to "
        "be scheduled, pulled, and pass readiness checks before they help\n\n"
        "💰 Scaling on the wrong metric — CPU-based scaling can miss a "
        "service that's actually bottlenecked on I/O wait or downstream "
        "latency",
    calloutHints: [
      '🎯 Real production teams often combine HPA (more replicas) with '
          'cluster autoscaling (more underlying NODES) — scaling Pods is '
          "pointless if there's no physical machine capacity left to place "
          'them on.',
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Sort each scenario into the right bucket.',
      bucketALabel: '⚠️ Real production pitfall',
      bucketBLabel: '✅ Healthy autoscaling behavior',
      items: [
        Sort2Item('thrash', 'Replica count oscillates up and down every minute because usage hovers near the threshold', true),
        Sort2Item('stable', 'A stabilization window smooths out brief usage spikes before scaling reacts', false),
        Sort2Item('wrongmetric', 'Scaling only on CPU while the real bottleneck is downstream database latency', true),
        Sort2Item('nodeaware', "HPA adds Pods AND the cluster autoscaler adds nodes so there's room to schedule them", false),
      ],
      explainOk:
          'Right — thrashing and wrong-metric scaling are classic '
          'production traps; stabilization windows and node-aware scaling '
          'are the fixes senior engineers reach for.',
      explainBad:
          'Ask: does this behavior fight itself (thrashing, wrong signal) '
          'or does it correctly account for real constraints (smoothing, '
          'node capacity)?',
    ),
  ),
  const Chapter(
    id: 41,
    title: 'Cold Starts: The Price of Sleeping',
    avatar: '🥶',
    role: 'Narrator — waking up stiff after a long nap',
    bodyIntro:
        "🥶 We met dormant functions back at Level 5 — now the production "
        "reality: when a function hasn't run recently, the FIRST invocation "
        "must pay a cold start cost: spinning up a fresh execution "
        "environment, loading the runtime, initializing your code, THEN "
        "finally running your actual logic.\n\n"
        "This can add anywhere from tens of milliseconds to several seconds "
        "of extra latency — and it lands directly on whichever unlucky user "
        "triggers it.\n\n"
        "🐢 A slow-to-start turtle knows this feeling exactly\n\n"
        "🔥 Warm invocations (the environment is already running) skip "
        "almost all of that overhead\n\n"
        "🛠️ Production mitigation: provisioned concurrency — paying to "
        "keep a minimum number of environments always warm, trading some "
        "of serverless's cost savings for latency predictability",
    calloutHints: [
      '⚖️ Real tradeoff senior engineers weigh: provisioned concurrency '
          'removes cold starts but reintroduces a baseline cost even when '
          'idle — partially undoing the "pay only when running" promise of '
          'serverless.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What's the standard production technique to reduce cold-start latency, and what does it cost you?",
      options: [
        'Provisioned concurrency — keeping a minimum number of environments always warm, at the cost of paying for idle capacity',
        'Deleting the function entirely so it never needs to cold start',
        "Increasing the function's memory limit has no effect on cold starts at all",
        'Cold starts cannot be mitigated in any way',
      ],
      answerIndex: 0,
      explainOk:
          'Right — provisioned concurrency trades away some of '
          "serverless's pay-per-use savings in exchange for consistently "
          'warm, low-latency invocations.',
      explainBad:
          'The standard fix is provisioned concurrency: keep some '
          'environments pre-warmed, accepting a baseline idle cost in '
          'exchange for predictable latency.',
    ),
  ),
  const Chapter(
    id: 42,
    title: 'Execution-Time Limits and Timeout Design',
    avatar: '⏳',
    role: 'Narrator — watching a sandcastle-building timer run out',
    bodyIntro:
        "⏳ Serverless functions have hard execution-time limits — "
        "typically minutes, not hours. If your function runs longer than "
        "that, the platform forcibly terminates it, mid-work, no "
        "exceptions.\n\n"
        "Production implications senior engineers must design for:\n\n"
        "🧩 Long-running jobs must be BROKEN UP into smaller steps (e.g. "
        "using a workflow/orchestration service, or chaining functions via "
        "a queue) rather than run as one giant function call\n\n"
        "💾 Any function doing meaningful work should be able to "
        "checkpoint progress so a forced termination doesn't lose "
        "everything done so far\n\n"
        "🔁 Combined with idempotency (Level 7!) — since a timed-out "
        "invocation might have partially completed, retries must be safe",
    calloutHints: [
      "🎯 A common production anti-pattern: forcing a genuinely "
          "long-running batch job into a single serverless function "
          "invocation, only to have it repeatedly hit the time limit — the "
          "right fix is redesigning it as multiple smaller steps, not just "
          "raising the limit.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A batch job regularly exceeds a serverless function's execution-time limit. What's the correct production fix?",
      options: [
        'Just keep trying to raise the time limit indefinitely',
        'Break the job into smaller checkpointed steps, chained via a queue or workflow, each well within the time limit',
        'Ignore the failures — the platform will eventually finish it anyway',
        'Switch the entire application off serverless permanently with no other changes',
      ],
      answerIndex: 1,
      explainOk:
          'Right — the production-grade fix is decomposing the work into '
          'smaller, checkpointed, idempotent steps that each comfortably '
          'fit the time budget.',
      explainBad:
          "Raising limits or ignoring failures doesn't scale — the real "
          'fix is decomposing long work into smaller checkpointed, '
          'idempotent steps chained together.',
    ),
  ),
  const Chapter(
    id: 43,
    title: 'Serverless Cost Tradeoffs at Scale',
    avatar: '💰',
    role: 'Narrator — comparing two very different receipts',
    bodyIntro:
        "💰 Serverless pricing is usually a function of (execution time) × "
        "(memory allocated) × (number of invocations). At LOW, spiky "
        "volume this is often dramatically cheaper than running always-on "
        "servers. At HIGH, steady, predictable volume, the math often "
        "flips.\n\n"
        "Low, spiky traffic: serverless wins (pay only for actual bursts). "
        "High, steady traffic: always-on containers/VMs often win (fixed "
        "capacity amortized over constant use).\n\n"
        "Senior-level nuance: it's rarely all-or-nothing. Many production "
        "architectures mix both — serverless for bursty edge cases and glue "
        "logic, containers/VMs for the steady core workload — deliberately "
        "choosing the right tool per workload shape rather than picking one "
        "paradigm for everything.",
    calloutHints: [
      '📊 The professional habit: actually MEASURE real invocation volume '
          'and duration before committing to a cost model, rather than '
          'assuming serverless (or containers) is universally cheaper.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which workload's cost profile most favors serverless over always-on infrastructure?",
      options: [
        'A steady, predictable, 24/7 high-volume workload',
        "An occasional, spiky workload that's idle most of the time",
        'Both cost exactly the same in every scenario, always',
        'Serverless is always cheaper regardless of traffic shape',
      ],
      answerIndex: 1,
      explainOk:
          "Right — serverless's pay-per-use model shines for spiky, "
          'mostly-idle workloads; steady heavy traffic tends to favor '
          'amortized always-on capacity.',
      explainBad:
          'Cost favors serverless specifically for spiky, mostly-idle '
          'traffic — steady heavy volume usually favors always-on '
          'infrastructure instead.',
    ),
  ),
  const Chapter(
    id: 44,
    title: 'When NOT to Use Serverless',
    avatar: '🚫',
    role: 'Narrator — turning down a tempting shortcut',
    bodyIntro:
        "🚫 A senior engineer's judgment call: serverless isn't the right "
        "tool for everything. Situations where it commonly struggles in "
        "production:\n\n"
        "⏳ Long-running processes that exceed execution-time limits by "
        "nature (video encoding, large batch ETL)\n\n"
        "🔌 Workloads needing persistent connections (e.g. WebSockets held "
        "open for a long time, or stateful protocols)\n\n"
        "🐢 Latency-critical paths that can't tolerate cold-start variance, "
        "without paying for provisioned concurrency everywhere\n\n"
        "💰 Constant, massive, predictable traffic where always-on "
        "infrastructure is simply cheaper\n\n"
        "🧩 Complex local dev/debugging workflows that are much harder to "
        "replicate outside the cloud provider's actual runtime",
    calloutHints: [
      '🎯 Professional-tier takeaway: architecture decisions are always '
          'tradeoffs made against a SPECIFIC workload\'s shape — "serverless '
          'everywhere" and "never use serverless" are both red flags of '
          'shallow thinking.',
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Sort each workload.',
      bucketALabel: '✅ Good fit for serverless',
      bucketBLabel: '🚫 Poor fit for serverless',
      items: [
        Sort2Item('webhook', 'A small function reacting to occasional webhook events', true),
        Sort2Item('video', 'A multi-hour video transcoding pipeline', false),
        Sort2Item('ws', 'A chat service holding thousands of long-lived WebSocket connections open', false),
        Sort2Item('resize', 'Resizing an image immediately after it\'s uploaded', true),
      ],
      explainOk:
          'Correct — short, event-triggered bursts fit serverless well; '
          "long-running or persistent-connection workloads generally don't.",
      explainBad:
          'Ask: is the work short and event-triggered (good fit), or '
          'long-running / connection-persistent (poor fit, hits time '
          'limits or connection model mismatches)?',
    ),
  ),
  const Chapter(
    id: 45,
    title: 'Consensus: The Real Problem Raft/Paxos Solve',
    avatar: '🧮',
    role: 'Narrator — the gauntlet begins',
    bodyIntro:
        "🧮 Level 12 — locked until earned. Back at Level 8 we met leader "
        "election informally. Now, professional depth: consensus "
        "algorithms like Raft and Paxos exist to solve a precise problem: "
        "get a group of machines to agree on a SEQUENCE of values (usually "
        "a replicated log of operations), even when some machines crash or "
        "messages are delayed — while guaranteeing that once a value is "
        "agreed upon, it's agreed upon FOREVER (it can never be silently "
        "overwritten by a different value).\n\n"
        "This \"agree once, agree forever, survive crashes\" guarantee is "
        "what lets distributed databases replicate reliably: every healthy "
        "replica, given enough time, ends up with the exact same ordered "
        "log of operations.",
    calloutHints: [
      '🎯 A consensus algorithm only needs a MAJORITY of nodes alive and '
          "reachable to keep making progress — this is the same quorum idea "
          "from Level 8's split-brain defense, formalized rigorously.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'What is the core guarantee a consensus algorithm like Raft or Paxos provides?',
      options: [
        'That the network will never lose a message',
        'That once a value is agreed upon by the group, it is never silently overwritten, even as machines crash and recover — and the group can keep agreeing on new values as long as a majority is alive',
        'That every single machine in the cluster must always be online',
        'That all machines run the exact same physical hardware',
      ],
      answerIndex: 1,
      explainOk:
          'Right — the durability of agreed-upon decisions, plus the '
          'ability to keep progressing with only a majority alive, is the '
          'essential guarantee.',
      explainBad:
          "Consensus doesn't fix the network or require every machine "
          'online — its guarantee is that agreed values are permanent, and '
          'progress continues with just a majority alive.',
    ),
  ),
  const Chapter(
    id: 46,
    title: 'Raft: Leader Election with a Term Number',
    avatar: '🗳️',
    role: 'Narrator — watching a numbered ballot get cast',
    bodyIntro:
        "🗳️ Raft (designed to be more understandable than Paxos) organizes "
        "time into numbered terms. Each term has at most ONE leader. To "
        "become leader, a node increments the term number, votes for "
        "itself, and requests votes from others — winning requires a "
        "MAJORITY of votes in that term.\n\n"
        "🔢 Every message carries its term number; a node ALWAYS rejects "
        "messages from a stale (lower) term — this is exactly how Raft "
        "avoids the split-brain disaster from Level 8: an old leader from "
        "an earlier term is automatically ignored\n\n"
        "⏱️ If an election doesn't produce a majority winner (e.g. votes "
        "split), the term increments again and a new election starts — "
        "with randomized timeouts to reduce repeated ties",
    calloutHints: [
      '🎯 Production-relevant detail: the term number is the mechanism '
          'that makes "which leader is real" unambiguous — any node can '
          'instantly tell an old leader is stale just by comparing term '
          'numbers, no guessing required.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          'An old leader from term 5 keeps sending messages after a new leader was elected in term 6. What happens?',
      options: [
        'Both leaders remain valid and nodes must pick one arbitrarily',
        "Nodes reject the term-5 leader's messages because they've already seen the higher term 6 — the stale leader is automatically ignored",
        "The cluster crashes because two terms can't coexist",
        'Term numbers are ignored entirely during normal operation',
      ],
      answerIndex: 1,
      explainOk:
          'Right — any node that has seen a higher term automatically '
          'rejects messages tagged with a lower, stale term, cleanly '
          'resolving the old-leader problem.',
      explainBad:
          'Term numbers are the resolution mechanism: once a node has seen '
          'term 6, it automatically rejects anything tagged with the now-'
          'stale term 5.',
    ),
  ),
  const Chapter(
    id: 47,
    title: 'Log Replication and the Commit Point',
    avatar: '📜',
    role: 'Narrator — watching a ledger get copied to many hands',
    bodyIntro:
        "📜 Once a leader is elected, its main job is log replication: "
        "every new operation is appended to the leader's log, then sent to "
        "followers to append to THEIR logs too. An entry is only considered "
        "committed (safe, permanent, safe to apply and respond to the "
        "client) once a MAJORITY of nodes have it durably stored — not "
        "just the leader.\n\n"
        "Leader appends entry #42, sends to followers, majority (e.g. 3 of "
        "5) confirm they've stored it durably, entry #42 is now COMMITTED "
        "— guaranteed to survive any future leader change.\n\n"
        "⚠️ Production nuance: a client should NOT be told \"success\" until "
        "the entry is committed by majority — acknowledging early (after "
        "just the leader has it) risks losing that data if the leader "
        "crashes before replicating it anywhere else.",
    calloutHints: [
      "🎯 This majority-before-commit rule is precisely what makes "
          "committed data survive leader crashes: any future leader must "
          "itself have been elected by a majority, which guarantees overlap "
          "with the set that already has the committed entry.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Drag these into the correct order for safely committing a log entry.',
      items: [
        OrderItem('append', 'Leader appends the new entry to its own log'),
        OrderItem('send', 'Leader sends the entry to all followers'),
        OrderItem('ack', 'A majority of nodes durably store the entry and acknowledge'),
        OrderItem('commit', 'Entry is marked committed'),
        OrderItem('respond', 'Leader responds success to the client'),
      ],
      explainOk:
          "Exactly — and note the client is only told 'success' AFTER "
          'majority commit, never before, or a leader crash could silently '
          'lose acknowledged data.',
      explainBad:
          "The client must never hear 'success' before majority commit — "
          'that ordering is what prevents data loss on a leader crash.',
    ),
  ),
  const Chapter(
    id: 48,
    title: 'Paxos vs Raft: Same Goal, Different Roads',
    avatar: '🛣️',
    role: 'Narrator — comparing two maps to the same destination',
    bodyIntro:
        "🛣️ Paxos came first (1989-ish) and is famously correct but "
        "notoriously hard to understand and implement correctly — its "
        "original description handles single values, and building a "
        "practical replicated log on top (Multi-Paxos) requires extra "
        "engineering that isn't fully specified in the original papers.\n\n"
        "Raft (2014) was explicitly designed for understandability: it "
        "bakes in a strong, explicit leader and a clear term-based "
        "structure from the start, which maps directly onto \"replicate a "
        "log\" — the exact use case most real systems need.\n\n"
        "Paxos: leaderless in its base form; leader added via Multi-Paxos "
        "extensions; famously difficult to implement correctly. Raft: "
        "strong leader is a core, explicit part of the algorithm; designed "
        "from the start to be teachable and implementable. Both share the "
        "same fundamental safety guarantees.",
    calloutHints: [
      '🎯 Both provably solve the same consensus problem under the same '
          'failure assumptions (a majority of nodes must be alive and '
          'reachable) — the real-world difference is implementability and '
          'clarity, not correctness.',
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'Given that Paxos already provably solves consensus, why was Raft created?',
      options: [
        "Because Paxos doesn't actually guarantee correctness",
        'Because Paxos is notoriously hard to understand and implement correctly; Raft targets the same guarantees with a design built for understandability and direct log replication',
        'Because Raft solves a fundamentally different problem than Paxos',
        'Because Raft requires fewer machines to run',
      ],
      answerIndex: 1,
      explainOk:
          "Right — Raft doesn't out-power Paxos on correctness; it targets "
          'the same guarantees with a structure engineers find far easier '
          'to reason about and implement correctly.',
      explainBad:
          'Both solve the same consensus problem with the same safety '
          "guarantees — Raft's motivation was understandability and ease "
          'of correct implementation, not new capability.',
    ),
  ),
  const Chapter(
    id: 49,
    title: 'Multi-Region Architecture: Why and How',
    avatar: '🌎',
    role: 'Narrator — spreading turtles across continents',
    bodyIntro:
        "🌎 Multi-region architecture runs your system across multiple "
        "geographically separate cloud regions, for two main production "
        "reasons:\n\n"
        "⚡ Latency — serve users from the region physically closest to "
        "them\n\n"
        "🛡️ Blast-radius containment — an entire region can go down "
        "(power, networking, even a whole cloud provider outage); other "
        "regions keep serving traffic\n\n"
        "The hard part is DATA: do you replicate data across regions "
        "synchronously (strong consistency, but every write pays "
        "cross-region latency, and a region outage can block writes "
        "entirely — the CP choice from Level 9) or asynchronously (fast "
        "local writes, but a region failure can lose the most recent, "
        "not-yet-replicated writes — leaning AP)?",
    calloutHints: [
      "🎯 Senior-level judgment: most production multi-region systems "
          "don't pick one mode globally — critical data (payments, "
          "inventory counts) often goes synchronous/CP; less critical data "
          "(user preferences, view counts) often goes asynchronous/AP.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "What's the key tradeoff between synchronous and asynchronous cross-region replication?",
      options: [
        'There is no real tradeoff — synchronous is strictly better in every case',
        'Synchronous gives stronger consistency but adds latency and can block writes during a region outage; asynchronous is faster but risks losing recent writes on failure',
        'Asynchronous replication guarantees zero data loss under all conditions',
        'Synchronous replication only works within a single data center, never across regions',
      ],
      answerIndex: 1,
      explainOk:
          'Right — this is the CP/AP tradeoff from Level 9 playing out '
          'concretely across regions: consistency and safety vs. latency '
          'and availability during failures.',
      explainBad:
          'There IS a real tradeoff: synchronous replication costs latency '
          'and can block during an outage; asynchronous is faster but '
          'risks losing unreplicated writes on failure.',
    ),
  ),
  const Chapter(
    id: 50,
    title: "Multi-Cloud: Avoiding a Single Provider's Fate",
    avatar: '☁️☁️',
    role: 'Narrator — keeping eggs in more than one basket',
    bodyIntro:
        "☁️ Multi-cloud goes a step further than multi-region: running "
        "across DIFFERENT cloud providers entirely (e.g. AWS AND Google "
        "Cloud), so a single provider's outage, pricing changes, or policy "
        "shift can't take your whole system down or hold you hostage.\n\n"
        "Real production costs of multi-cloud, which is why it's often "
        "used selectively rather than universally:\n\n"
        "🧩 Each provider's services (their specific databases, queues, IAM "
        "systems) differ — using provider-specific features locks you INTO "
        "that provider, so true portability often means using only the "
        "lowest-common-denominator, less convenient primitives\n\n"
        "💸 Operating expertise, tooling, and monitoring must be duplicated "
        "across providers\n\n"
        "🔀 Cross-cloud networking adds real latency and complexity",
    calloutHints: [
      '🎯 Professional judgment call: many teams pursue multi-cloud '
          "selectively — e.g. one primary provider plus a genuinely "
          "critical piece (DNS, or disaster recovery cold storage) on a "
          "second provider — rather than fully duplicating an entire "
          "architecture, which is expensive and complex for most "
          "organizations to justify.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          'What\'s the main practical cost of running a fully duplicated architecture across two different cloud providers?',
      options: [
        "There is no extra cost; it's a free way to gain reliability",
        'You lose access to provider-specific convenient services (to stay portable), and must duplicate operational expertise and tooling across two ecosystems',
        'It automatically doubles your latency for every single request',
        'Cloud providers legally forbid using more than one at a time',
      ],
      answerIndex: 1,
      explainOk:
          "Right — true multi-cloud costs real engineering effort: staying "
          'portable means giving up convenient provider-specific features, '
          'plus duplicating operational tooling and expertise.',
      explainBad:
          "Multi-cloud isn't free or illegal — its real cost is giving up "
          'convenient provider-specific features to stay portable, plus '
          'duplicating operational expertise across ecosystems.',
    ),
  ),
  const Chapter(
    id: 51,
    title: 'Disaster Recovery Strategies: RPO and RTO',
    avatar: '🧯',
    role: 'Narrator — reading a fire-escape plan',
    bodyIntro:
        "🧯 Every serious production system needs a disaster recovery (DR) "
        "plan, measured by two numbers senior engineers must know cold:\n\n"
        "⏳ RPO (Recovery Point Objective) — how much data can you afford "
        "to LOSE, measured in time? (\"At most 5 minutes of writes.\")\n\n"
        "⏱️ RTO (Recovery Time Objective) — how long can you afford to be "
        "DOWN before service is restored? (\"At most 30 minutes of "
        "downtime.\")\n\n"
        "Common DR strategies, roughly cheapest-and-slowest to "
        "most-expensive-and-fastest:\n\n"
        "🥶 Backup & restore — cheapest, but slow RTO (hours) and worse "
        "RPO\n\n"
        "🌡️ Pilot light — minimal standby infrastructure always running, "
        "scaled up when needed\n\n"
        "🌤️ Warm standby — a smaller-scale but fully running copy, ready "
        "to take over and scale up fast\n\n"
        "🔥 Active-active (hot) — full duplicate running at full scale at "
        "all times; fastest RTO/RPO, most expensive",
    calloutHints: [
      '🎯 Professional habit: RPO/RTO targets should be set based on '
          'actual BUSINESS cost of downtime/data loss, then the DR strategy '
          'is chosen to meet those targets — not the other way around.',
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a term on the left, then its correct definition on the right.',
      pairs: [
        MatchPair('rpo', 'RPO', 'How much data loss (in time) is acceptable'),
        MatchPair('rto', 'RTO', 'How much downtime is acceptable before recovery'),
        MatchPair('pilot', 'Pilot light', 'Minimal standby infra, scaled up only when disaster strikes'),
        MatchPair('hot', 'Active-active', 'Full duplicate running at full scale at all times'),
      ],
      explainOk:
          'Right — RPO is about data loss tolerance, RTO is about downtime '
          'tolerance, and the strategies trade cost for how close to zero '
          'you can push both.',
    ),
  ),
  const Chapter(
    id: 52,
    title: 'Designing a Real DR Runbook',
    avatar: '📋',
    role: 'Narrator — rehearsing an emergency drill',
    bodyIntro:
        "📋 A DR strategy on paper means nothing without a tested runbook "
        "— the actual step-by-step procedure a human (or automation) "
        "follows during a real disaster, and a habit of REHEARSING it "
        "before disaster strikes.\n\n"
        "🚨 Detect the failure (monitoring/alerting triggers)\n\n"
        "📢 Declare a disaster and notify the incident team\n\n"
        "🔀 Fail over traffic to the standby region/provider (DNS or "
        "load-balancer switch)\n\n"
        "✅ Verify the standby is actually healthy and serving correctly\n\n"
        "📝 Communicate status to stakeholders\n\n"
        "🔙 Eventually fail back once the primary is restored, carefully, "
        "to avoid a second incident",
    calloutHints: [
      "🎯 The single most common production failure mode in DR isn't the "
          "disaster itself — it's discovering DURING a real disaster that "
          "the runbook was never actually tested, and the standby silently "
          "rotted out of sync. Regular \"game day\" DR drills exist "
          "specifically to catch this.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: 'Drag these into the correct order of a disaster recovery response.',
      items: [
        OrderItem('detect', 'Monitoring detects the failure'),
        OrderItem('declare', 'Team declares a disaster and is notified'),
        OrderItem('failover', 'Traffic is failed over to the standby region'),
        OrderItem('verify', 'Team verifies the standby is truly healthy'),
        OrderItem('communicate', 'Status is communicated to stakeholders'),
        OrderItem('failback', 'Once primary is restored, traffic is carefully failed back'),
      ],
      explainOk:
          'That\'s a real DR runbook — and note verification happens '
          'BEFORE declaring success, and failback is deliberate and '
          'careful, not rushed.',
      explainBad:
          'Verification must happen right after failover, before broad '
          'communication — and failback to the primary only happens '
          'later, carefully, once it\'s truly restored.',
    ),
  ),
  const Chapter(
    id: 53,
    title: 'FinOps Mindset: Cost as a First-Class Metric',
    avatar: '💵',
    role: 'Narrator — putting a price tag next to a performance graph',
    bodyIntro:
        "💵 FinOps treats cloud cost as a first-class engineering metric — "
        "tracked, owned, and optimized with the same rigor as latency or "
        "error rate, not left as a surprise on next month's bill.\n\n"
        "Core FinOps practices in production organizations:\n\n"
        "🏷️ Tagging/labeling resources so cost can be attributed to the "
        "right team or feature — you can't optimize what you can't "
        "attribute\n\n"
        "📊 Unit economics — cost PER request, per user, or per "
        "transaction, not just total spend, so cost scales sensibly with "
        "growth\n\n"
        "🔁 A continuous loop: Inform (visibility) → Optimize (act on "
        "findings) → Operate (make it an ongoing habit, not a one-time "
        "cleanup)",
    calloutHints: [
      '🎯 Senior-engineer mindset shift: "how fast can this run" and "how '
          'much does this cost to run" are the SAME conversation in a '
          "mature organization, not two separate ones handled by different "
          "teams.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'Why do FinOps-mature teams track cost PER request/user rather than just total monthly spend?',
      options: [
        'Total spend is always the more meaningful number',
        'Total spend naturally rises with growth; unit cost reveals whether the SYSTEM is becoming more or less efficient as it scales',
        'Per-request cost is impossible to measure in practice',
        'Unit economics only apply to non-technical businesses',
      ],
      answerIndex: 1,
      explainOk:
          'Right — rising total spend from growth is expected and often '
          'good; the real signal of efficiency (or waste) is whether cost '
          'PER UNIT of work is improving or worsening.',
      explainBad:
          "Total spend rising with growth isn't inherently bad or good — "
          'unit cost (per request/user) is what actually reveals whether '
          'the system is getting more or less efficient.',
    ),
  ),
  const Chapter(
    id: 54,
    title: 'Right-Sizing and Reserved Capacity',
    avatar: '📐',
    role: "Narrator — measuring a coat that's three sizes too big",
    bodyIntro:
        "📐 Right-sizing means matching provisioned capacity (VM size, "
        "memory, replica count) to ACTUAL observed usage, instead of "
        "guessing generously \"to be safe\" — a huge and common source of "
        "wasted cloud spend in real organizations is over-provisioned, "
        "oversized resources running at 5% utilization.\n\n"
        "For predictable, steady baseline load, reserved/committed-use "
        "pricing (committing to usage for 1-3 years) often costs "
        "dramatically less than on-demand pricing — while unpredictable "
        "BURSTS above that baseline stay on-demand or spot pricing.",
    calloutHints: [
      '🎯 Professional pattern: match pricing model to traffic shape — '
          'reserved capacity for the steady floor, on-demand/autoscaling '
          "for the variable peak above it. Reserving capacity for your PEAK "
          "traffic (rather than your baseline) wastes money on capacity "
          "that sits idle most of the time.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'For cost efficiency, what portion of your traffic should typically use reserved/committed-use pricing?',
      options: [
        'Your absolute peak traffic level, reserved at all times',
        'Your steady, predictable baseline load — with bursts above it handled by on-demand or autoscaled capacity',
        'None — reserved pricing is always a worse deal than on-demand',
        'Exactly half of your total infrastructure, regardless of usage patterns',
      ],
      answerIndex: 1,
      explainOk:
          'Right — reserving for the steady baseline captures the discount '
          "without wasting money on idle peak-sized capacity; bursts are "
          'handled flexibly on top.',
      explainBad:
          "Reserving for your PEAK wastes money on capacity that's idle "
          'most of the time — reserve the steady baseline, and let '
          'on-demand/autoscaling absorb bursts.',
    ),
  ),
  const Chapter(
    id: 55,
    title: 'Autoscaling Tradeoffs Under Real Traffic',
    avatar: '🌊',
    role: 'Narrator — surfing an unpredictable wave',
    bodyIntro:
        "🌊 We covered HPA mechanics at Level 10 — now the cost/reliability "
        "tradeoff under REAL, messy production traffic. Aggressive "
        "autoscaling (scale down fast, scale up fast) minimizes cost but "
        "risks under-provisioning during sudden spikes, since new capacity "
        "takes real time to come online (cold starts and Pod scheduling "
        "both apply here too).\n\n"
        "Conservative autoscaling (keep more buffer, scale down slowly) "
        "costs more but handles sudden spikes far more gracefully.",
    calloutHints: [
      '🎯 Senior-level answer to "how aggressive should autoscaling be?": '
          'it depends on how predictable your traffic actually is, and how '
          "expensive a brief under-provisioned period would be — a "
          "checkout service being briefly slow during a flash sale is a "
          "MUCH bigger cost than a little wasted buffer capacity would "
          "ever be.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: 'Sort each scenario into the autoscaling posture that fits it best.',
      bucketALabel: '⚡ Aggressive (minimize idle cost)',
      bucketBLabel: '🛡️ Conservative (keep buffer capacity)',
      items: [
        Sort2Item('internal', 'An internal analytics dashboard with smooth, predictable low traffic', true),
        Sort2Item('flashsale', 'A checkout service during an unpredictable flash sale', false),
        Sort2Item('batch', 'A nightly batch job with no user-facing latency requirement', true),
        Sort2Item('critical', 'A payment API where a brief under-capacity slowdown costs real revenue', false),
      ],
      explainOk:
          'Correct — predictable, low-stakes workloads can safely minimize '
          'idle cost; unpredictable or high-stakes ones justify keeping '
          'extra buffer.',
      explainBad:
          'Ask: is a brief under-provisioned moment cheap or expensive '
          'here? Cheap → be aggressive to save cost. Expensive → keep '
          'conservative buffer capacity.',
    ),
  ),
  const Chapter(
    id: 56,
    title: 'The Cost of Over-Engineering for Scale',
    avatar: '🏗️',
    role: 'Narrator — noticing a fortress built for a birdhouse',
    bodyIntro:
        "🏗️ The flip side of cost optimization: over-engineering for scale "
        "you don't actually have YET is itself a real, common cost — both "
        "in cloud spend AND in engineering time and complexity that slows "
        "the team down.\n\n"
        "Building a full multi-region, multi-cloud, auto-everything "
        "architecture for a product with a hundred users is like building "
        "a fortress to guard a birdhouse — the complexity itself becomes "
        "the liability: more to monitor, more to debug, more that can "
        "silently break.",
    calloutHints: [
      '🎯 The senior-engineer discipline: design for the scale you '
          'ACTUALLY have plus a reasonable, evidence-based margin — not for '
          "a hypothetical future that may never arrive, and re-evaluate "
          "architecture decisions as real usage data comes in, rather than "
          "guessing far ahead upfront.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'What\'s the main hidden cost of over-engineering a system for scale far beyond current actual needs?',
      options: [
        'There is no real cost — more scalability is always strictly better',
        'Unnecessary complexity: extra cloud spend, plus more surface area to monitor, debug, and maintain, which slows the team down',
        'It always makes the system measurably faster for current users',
        'It eliminates the need for any future architecture changes',
      ],
      answerIndex: 1,
      explainOk:
          'Right — premature scale engineering adds real, ongoing cost in '
          'both cloud spend and team velocity, without a matching current '
          'benefit.',
      explainBad:
          "Extra scalability isn't free — unused complexity still costs "
          'money and slows the team via more to monitor, debug, and '
          'maintain, often for no current benefit.',
    ),
  ),
  const Chapter(
    id: 57,
    title: 'Capstone I — Design a Globally Distributed System',
    avatar: '🌐',
    role: "Narrator — the gauntlet's first trial",
    bodyIntro:
        "🌐 The Machine's Reckoning — Level 15, the hardest tier. You're "
        "the principal engineer designing a globally distributed "
        "order-processing system for millions of users across continents. "
        "Synthesize everything: regions for latency and blast-radius "
        "(Level 13), consensus for replicated state (Level 12), "
        "Kubernetes-style orchestration for compute (Level 10), CAP-aware "
        "data choices (Level 9), and defenses against unreliable networks "
        "(Level 7) — all at once.\n\n"
        "Key design decision: orders MUST be processed exactly once, "
        "correctly ordered per customer, even though writes originate from "
        "many regions simultaneously and the network between regions is "
        "unreliable.",
    calloutHints: [
      '🎯 The professional answer isn\'t "use the fanciest technology" — '
          "it's making explicit, justified tradeoffs: which data needs "
          "strong consistency (payments — lean CP), which can be eventually "
          "consistent (order history display — lean AP), and where "
          "consensus-based replication is worth its latency cost (the "
          "authoritative order ledger).",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: 'Click a system component on the left, then the consistency approach that fits it best on the right.',
      pairs: [
        MatchPair('ledger', 'The authoritative order ledger (must never double-charge)', 'Strong consistency via consensus (CP)'),
        MatchPair('history', "A user's 'recent orders' display page", 'Eventual consistency (AP) is acceptable'),
        MatchPair('inventory', 'Real-time inventory count preventing overselling', 'Strong consistency via consensus (CP)'),
        MatchPair('recs', 'Product recommendation data shown alongside orders', 'Eventual consistency (AP) is acceptable'),
      ],
      explainOk:
          'Exactly the principal-engineer answer — match the consistency '
          'model to the actual cost of being wrong for THAT specific piece '
          'of data, not a blanket policy for the whole system.',
    ),
  ),
  const Chapter(
    id: 58,
    title: 'Chaos Engineering: Breaking Things on Purpose',
    avatar: '💥',
    role: 'Narrator — deliberately kicking over a tower to test it',
    bodyIntro:
        "💥 Chaos engineering is the discipline of deliberately injecting "
        "failure into a production (or production-like) system — killing "
        "random Pods, adding artificial network latency, simulating a "
        "whole region outage — to verify your system ACTUALLY survives the "
        "failures you've designed for, rather than just assuming it does "
        "on paper.\n\n"
        "🎯 Start small and controlled (a single instance failure) before "
        "graduating to larger blast radii (a whole availability zone)\n\n"
        "📊 Always have a hypothesis first: \"if we kill this leader, we "
        "expect a new one elected within N seconds and zero committed data "
        "loss\" — then verify it, don't just watch and hope\n\n"
        "🛑 Have a clear abort mechanism to stop the experiment "
        "immediately if it's causing real, unplanned customer harm",
    calloutHints: [
      "🎯 Principal-engineer insight: the goal of chaos engineering isn't "
          "to prove things break (they will) — it's to find out HOW they "
          "break, in a controlled way, BEFORE a real unplanned outage "
          "forces you to find out the hard way.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: 'What should come FIRST when designing a chaos engineering experiment?',
      options: [
        'Randomly kill production instances with no plan and see what happens',
        'Form a specific, testable hypothesis about expected behavior, then run a controlled experiment (with an abort mechanism) to verify it',
        'Only run chaos experiments after a real outage has already happened',
        'Chaos engineering should always target the entire production fleet at once, with no smaller-scale testing first',
      ],
      answerIndex: 1,
      explainOk:
          'Right — a stated hypothesis, a controlled blast radius, and a '
          'ready abort path are what separate disciplined chaos '
          'engineering from reckless production sabotage.',
      explainBad:
          'Chaos engineering is disciplined, not random: start with a '
          'specific hypothesis, use a controlled small blast radius, and '
          'always keep an abort mechanism ready.',
    ),
  ),
  const Chapter(
    id: 59,
    title: 'Capstone II — The Cascading Failure',
    avatar: '🌪️',
    role: 'Narrator — watching one domino tip into a hundred more',
    bodyIntro:
        "🌪️ A single database replica in one region becomes slow (not down "
        "— just slow). Requests pile up waiting on it. Threads/connections "
        "across the fleet get exhausted waiting for those slow requests. "
        "Healthy services elsewhere start timing out calling the now-"
        "overloaded service. Within minutes, the ENTIRE global system is "
        "degraded — even regions with a perfectly healthy database.\n\n"
        "This is a cascading failure: one small, contained problem "
        "propagating outward until it takes down far more than the "
        "original fault should have allowed.\n\n"
        "Principal-engineer diagnosis and fixes, synthesizing earlier "
        "chapters:\n\n"
        "⏱️ Aggressive, sane timeouts (Level 7) so slow calls don't hold "
        "resources forever\n\n"
        "🧯 Circuit breakers (Level 7) to stop hammering the already-"
        "struggling replica\n\n"
        "🚧 Bulkheads — isolate resource pools (e.g. separate connection "
        "pools per downstream dependency) so one slow dependency can't "
        "exhaust resources needed by unrelated calls\n\n"
        "📉 Load shedding — deliberately reject some requests under "
        "extreme load to protect the system's ability to serve the rest",
    calloutHints: [
      "🎯 The deepest lesson: a system's worst outages are rarely caused "
          "by one single big failure — they're caused by a SMALL failure "
          "that the system's own architecture allowed to spread unchecked.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          'Drag these into the order a cascading failure actually unfolds, ending with the class of fix that stops it.',
      items: [
        OrderItem('slow', 'One database replica becomes slow (not fully down)'),
        OrderItem('pileup', 'Requests pile up waiting on that slow replica'),
        OrderItem('exhaust', 'Connection/thread pools across the fleet get exhausted'),
        OrderItem('spread', 'Healthy services elsewhere start timing out and degrading too'),
        OrderItem('fix', 'Timeouts, circuit breakers, and bulkheads contain the blast radius'),
      ],
      explainOk:
          'That\'s the anatomy of a cascading failure — and the fix is '
          'always about CONTAINMENT: stopping a local slowdown from '
          'consuming shared resources everywhere else.',
      explainBad:
          'The chain is: slow dependency → requests pile up → shared '
          'resources exhaust → failure spreads to healthy services. The '
          'fix always focuses on containment (timeouts, circuit breakers, '
          'bulkheads).',
    ),
  ),
  const Chapter(
    id: 60,
    title: 'Capstone III — The Principal-Engineer Gauntlet',
    avatar: '🏆',
    role: 'Narrator — the final trial across Cloud Cluster Isles',
    bodyIntro:
        "🏆 The final trial. You're the principal engineer on-call when "
        "three things happen at once: (1) a network partition splits your "
        "primary region's cluster into two halves, (2) your consensus-"
        "based order ledger correctly refuses writes on the minority side "
        "(Level 12's majority-quorum safety working exactly as designed), "
        "and (3) a well-meaning autoscaler on the majority side, seeing a "
        "sudden spike in retried requests from the minority side's failed "
        "writes, scales up aggressively — but your FinOps budget alerts "
        "are now firing too.\n\n"
        "Nothing here is a bug. Every single behavior is a DIRECT, correct "
        "consequence of decisions made in earlier chapters: quorum-based "
        "consensus refusing minority writes (safety over availability, by "
        "design), clients retrying failed requests (a Level 7 defense), "
        "and autoscaling reacting to real increased load (working as "
        "intended). The \"incident\" is actually the SYSTEM behaving "
        "exactly as designed under a real partition — the job now is to "
        "confirm that, communicate it clearly, and let the design's own "
        "safety guarantees do their job until the partition heals.",
    calloutHints: [
      "🎓 🐢 You've rolled the entire distance, from \"what even is the "
          "cloud\" to reasoning calmly through a live multi-region "
          "incident, tracing every symptom back to a deliberate design "
          "decision instead of panicking. That's the real difference "
          "between knowing facts and having systems judgment. Welcome to "
          "the end of Cloud Cluster Isles — for now.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Given that quorum-refused minority writes, client retries, and autoscaler reaction are ALL working exactly as designed, what is the principal engineer's correct first move?",
      options: [
        'Immediately disable the consensus quorum requirement so the minority side can accept writes too',
        "Confirm this is the system's designed safety behavior under a real partition, communicate that clearly, and let it hold safely (refusing minority writes, absorbing retries) until the partition heals — rather than treating correct behavior as a bug to 'fix' under pressure",
        'Shut down the entire cluster, majority and minority side both, until further notice',
        'Ignore the FinOps budget alerts permanently since cost never matters during an incident',
      ],
      answerIndex: 1,
      explainOk:
          'Exactly right — disabling the quorum safeguard mid-partition is '
          'the single most dangerous move available (it reopens the door '
          'to split-brain data corruption from Level 8). The correct '
          "response is recognizing designed-safe behavior, communicating "
          "it, and letting the architecture's own guarantees hold until "
          "the network heals.",
      explainBad:
          'Disabling quorum protection mid-incident would reintroduce '
          'split-brain risk — the far more dangerous move. The right '
          'response is recognizing this as correct, designed behavior '
          'under partition, and holding steady until it heals, not '
          "panicking into a 'fix' that breaks a real safety guarantee.",
    ),
  ),
];
