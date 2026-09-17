import '../models/pq_models.dart';

/// Ported from process-quest/subjects/webtech.js, chapters 1-60 (Levels 1-15) —
/// real content, trimmed narrative prose, same puzzles/answers.
final webtechChapters = <Chapter>[
  const Chapter(
    id: 1,
    title: 'How the Web Works',
    avatar: '📬',
    role: 'Narrator — sending a message to a faraway computer',
    bodyIntro:
        "Hi, it's Process again! I rolled into Web Woods, and it's buzzing with tiny "
        "messages flying everywhere. Every website lives on a server — a computer far "
        "away that stores pages and hands them out. Your computer or phone is the "
        "client. When you type a website address, your browser sends a request asking "
        "\"please send me that page!\" The server writes back with three kinds of "
        "building blocks, all wrapped up together.\n\n"
        "HTML — the bones of the page (what's on it)\n"
        "CSS — the outfit and makeup (how it looks)\n"
        "JavaScript — the muscles (how it moves and reacts)\n\n"
        "Let's put the steps of loading a page in the right order.",
    calloutHints: [
      "Fun fact: this whole trip — asking, waiting, and getting the page back — "
          "usually happens in less than one second, even if the server is on the "
          "other side of the world!",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these steps into the order they really happen when you open a website.",
      items: [
        OrderItem('type', 'You type a website address in your browser'),
        OrderItem('ask', 'Your browser (the client) asks the server for the page'),
        OrderItem('send', 'The server sends back HTML, CSS, and JavaScript'),
        OrderItem('show', 'Your browser builds the skeleton, paints it, and adds behavior'),
      ],
      explainOk:
          "Yes! You ask, the server answers, and your browser builds the page piece "
          "by piece — skeleton first, then paint, then movement.",
      explainBad:
          "Almost — remember, YOU ask first, THEN the server replies, and only after "
          "that does your browser build and show the page.",
    ),
  ),
  const Chapter(
    id: 2,
    title: 'HTML — the Skeleton',
    avatar: '🦴',
    role: 'Narrator — poking at page bones',
    bodyIntro:
        "HTML stands for HyperText Markup Language — a fancy name for \"labels that "
        "tell the browser what each piece of the page is.\" Think of HTML like a "
        "skeleton: it doesn't look pretty by itself, but it holds everything in the "
        "right place. Each label is called a tag, written inside angle brackets, like "
        "<h1>Big Title</h1>, <p>A little paragraph of text.</p>, <img src=\"turtle.png\">, "
        "and <a href=\"https://example.com\">Click me!</a>.\n\n"
        "<h1> — a big heading, like a title\n"
        "<p> — a paragraph of normal text\n"
        "<img> — shows a picture\n"
        "<a> — a clickable link to another page\n\n"
        "Match each tag to the job it does.",
    calloutHints: [
      "Most tags come in pairs, like <p> ... </p> — the second one has a slash and "
          "means \"okay, this part is done now.\"",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a tag on the left, then click the job it does on the right.",
      pairs: [
        MatchPair('h1', '<h1>', 'Shows a big title'),
        MatchPair('img', '<img>', 'Shows a picture'),
        MatchPair('p', '<p>', 'Shows a normal paragraph of text'),
        MatchPair('a', '<a>', 'Makes clickable text that goes to another page'),
      ],
      explainOk:
          "Perfect! h1 for titles, p for paragraphs, img for pictures, and a for "
          "links — you've got the skeleton down.",
    ),
  ),
  const Chapter(
    id: 3,
    title: 'CSS — the Look',
    avatar: '🎨',
    role: 'Narrator — trying on outfits',
    bodyIntro:
        "A skeleton alone looks a bit spooky! That's where CSS comes in — Cascading "
        "Style Sheets, or in kid words: the paintbrush and outfit designer for your "
        "page. CSS decides colors, sizes, spacing, and fonts. You write little style "
        "rules like \"h1 { color: hotpink; font-size: 40px; }\" — this says \"find "
        "every <h1> on the page, make its text hot pink, and make it nice and big.\" "
        "You can style borders, backgrounds, spacing between things, even make boxes "
        "round instead of square!\n\n"
        "Time for a quick check on what CSS actually controls.",
    calloutHints: [
      "Without CSS, every website would look like plain black text on a white page "
          "— CSS is what gives the internet its colors, fun fonts, and cool layouts.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which of these is something CSS is in charge of?",
      options: [
        'Making a button show a popup message when clicked',
        'Deciding that a heading should be blue and bold',
        'Asking the server to send the page',
        'Storing a list of usernames in a database',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly! CSS handles look and style — colors, fonts, sizes, spacing. "
          "Clicks and popups are JavaScript's job, coming up next!",
      explainBad:
          "Think about what CSS means: style. Colors, fonts, and sizes are CSS's "
          "job. Clicking and popups belong to JavaScript instead.",
    ),
  ),
  const Chapter(
    id: 4,
    title: 'JavaScript — the Behavior',
    avatar: '⚡',
    role: 'Narrator — pressing a button to see what happens',
    bodyIntro:
        "HTML gives a page bones, CSS gives it a nice outfit — but the page is still "
        "standing still, like a statue. JavaScript (JS for short) is the magic that "
        "makes it move, react, and play! JavaScript can listen for things you do — "
        "like clicking a button — and then change the page: \"button.onclick = "
        "function() { message.text = 'You clicked me!'; };\" This says: \"when someone "
        "clicks the button, change the message.\" Games, quizzes, and popups are all "
        "built with JavaScript.\n\n"
        "Let's trace through a tiny bit of JavaScript logic: a counter starts at 0, "
        "and each click adds 1 and shows \"Clicks: \" plus the count. The button gets "
        "clicked THREE times in a row.",
    calloutHints: [
      "HTML, CSS, and JavaScript are best friends: HTML is the \"what,\" CSS is the "
          "\"how it looks,\" and JavaScript is the \"what happens next.\"",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "After three clicks, what does the message show?",
      options: ['Clicks: 1', 'Clicks: 2', 'Clicks: 3', 'Clicks: 0'],
      answerIndex: 2,
      explainOk:
          "Yes! Each click adds 1 to clicks, so after three clicks it becomes 3, "
          "and the message shows \"Clicks: 3\".",
      explainBad:
          "Walk through it click by click: it starts at 0. Click 1 → 1. Click 2 → "
          "2. Click 3 → 3. So the message should show \"Clicks: 3\".",
    ),
  ),
  const Chapter(
    id: 5,
    title: 'The Box Model',
    avatar: '📦',
    role: 'Narrator — unwrapping nested boxes',
    bodyIntro:
        "Every single element on a page — every button, image, paragraph — is "
        "secretly a rectangle. CSS calls this the box model, and it's built from four "
        "nested layers, from the inside out: margin → border → padding → content.\n\n"
        "Content — the actual text or image\n"
        "Padding — breathing room INSIDE the border\n"
        "Border — the box's outline\n"
        "Margin — empty space OUTSIDE the border, pushing other boxes away\n\n"
        "Match each layer to what it actually does.",
    calloutHints: [
      "Mnemonic: from the middle out it's Content, Padding, Border, Margin — "
          "\"Can Pandas Be Messy?\"",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a layer on the left, then click what it does on the right.",
      pairs: [
        MatchPair('content', 'Content', 'The text or image itself'),
        MatchPair('padding', 'Padding', 'Space INSIDE the border, around the content'),
        MatchPair('border', 'Border', 'The visible outline of the box'),
        MatchPair('margin', 'Margin', 'Space OUTSIDE the border, between this box and others'),
      ],
      explainOk: "Nailed it — content, padding, border, margin, from the inside out.",
    ),
  ),
  const Chapter(
    id: 6,
    title: 'Flexbox — One Direction at a Time',
    avatar: '↔️',
    role: 'Narrator — lining up boxes in a row',
    bodyIntro:
        "Flexbox is a CSS layout tool built for arranging items along ONE direction "
        "— a row or a column — and automatically sharing the space between them: "
        "\".container { display: flex; justify-content: space-between; align-items: "
        "center; }\"\n\n"
        "display: flex — turns on flexbox for this container\n"
        "justify-content — spacing along the main direction (e.g. left-to-right)\n"
        "align-items — alignment across the OTHER direction (e.g. top-to-bottom)\n\n"
        "Order the steps of building a simple flex navbar.",
    calloutHints: [
      "Think of flexbox like kids lining up for recess: you can spread them evenly, "
          "bunch them at one end, or center the whole line.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these CSS decisions into the order you'd naturally make them.",
      items: [
        OrderItem('pick', 'Pick the container that holds the nav links'),
        OrderItem('flex', 'Set display: flex on that container'),
        OrderItem('direction', 'Decide the direction: row (side by side) or column (stacked)'),
        OrderItem('space', 'Use justify-content to spread the links apart'),
      ],
      explainOk:
          "Exactly the natural flow: pick the box, turn on flex, choose a "
          "direction, then control the spacing.",
      explainBad:
          "You need a container FIRST, then turn on flex, THEN pick a direction, "
          "and only then adjust spacing.",
    ),
  ),
  const Chapter(
    id: 7,
    title: 'CSS Grid — Rows and Columns',
    avatar: '▦',
    role: 'Narrator — drawing a checkerboard',
    bodyIntro:
        "While flexbox is great for ONE direction, CSS Grid is built for TWO "
        "directions at once — rows AND columns — like a checkerboard you design "
        "yourself: \".gallery { display: grid; grid-template-columns: 1fr 1fr 1fr; "
        "gap: 12px; }\" This creates 3 equal columns (1fr means \"one fair share\") "
        "with 12px of gap between every cell. Add more rows automatically just by "
        "adding more items!\n\n"
        "Sort these layout jobs into Flexbox vs. Grid.",
    calloutHints: [
      "Rule of thumb: reach for Flexbox when arranging things in a line, reach for "
          "Grid when arranging things in a full 2D layout, like a photo gallery.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each layout job into the tool that fits it best.",
      bucketALabel: '↔️ Flexbox (one direction)',
      bucketBLabel: '▦ Grid (rows AND columns)',
      items: [
        Sort2Item('navbar', 'A row of navigation links spaced evenly', true),
        Sort2Item('gallery', 'A photo gallery with 4 columns and many rows', false),
        Sort2Item('toolbar', 'A toolbar with icons in a single line', true),
        Sort2Item('dashboard', 'A dashboard with cards arranged in a grid', false),
      ],
      explainOk:
          "Right — single-line arrangements fit Flexbox, full 2D layouts fit Grid.",
      explainBad:
          "Ask: is this ONE line of items (Flexbox) or a true rows-and-columns "
          "layout (Grid)?",
    ),
  ),
  const Chapter(
    id: 8,
    title: 'Position & Stacking',
    avatar: '🗂️',
    role: 'Narrator — stacking transparent sheets',
    bodyIntro:
        "Sometimes you need a box to break out of the normal flow — like a popup "
        "floating over everything else. CSS's position property controls that.\n\n"
        "static — the normal, default flow (top to bottom, left to right)\n"
        "relative — normal flow, but you can nudge it slightly with offsets\n"
        "absolute — removed from the flow, placed exactly relative to its nearest "
        "positioned ancestor\n"
        "fixed — stuck to the browser window itself, even while scrolling\n\n"
        "When boxes overlap, z-index decides which one sits on top — like a stack of "
        "transparent sheets, higher numbers on top.\n\n"
        "Which position value fits a popup that stays glued to the screen while "
        "scrolling?",
    calloutHints: [
      "A \"sticky header\" that stays visible while you scroll is usually built "
          "with position: fixed or position: sticky.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "You want a 'Back to top' button that stays in the same screen corner no "
          "matter how far the user scrolls. Which position value is right?",
      options: ['static', 'relative', 'fixed', 'inherit'],
      answerIndex: 2,
      explainOk:
          "Yes! fixed positions an element relative to the browser window, so it "
          "stays put during scrolling.",
      explainBad:
          "static and relative both scroll away with the page. fixed is the one "
          "that locks to the window itself.",
    ),
  ),
  const Chapter(
    id: 9,
    title: 'The DOM Tree',
    avatar: '🌳',
    role: 'Narrator — climbing a tree made of tags',
    bodyIntro:
        "When your browser reads HTML, it doesn't just show it — it builds a "
        "living, in-memory tree of objects called the DOM (Document Object Model). "
        "Every tag becomes a \"node\" in that tree, nested inside its parent. In "
        "<body><h1>Title</h1><ul><li>Item 1</li><li>Item 2</li></ul></body>, <body> "
        "is the parent of <h1> and <ul>, and the two <li> tags are children of <ul>. "
        "JavaScript can walk this tree and change ANY part of it live.\n\n"
        "Match each DOM relationship to its example.",
    calloutHints: [
      "This is why JavaScript can change a page after it loads — it's not editing "
          "text, it's editing a living tree of objects in memory.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a relationship on the left, then click its matching example on "
          "the right.",
      pairs: [
        MatchPair('parent', 'Parent of <li> and <li>', '<ul>'),
        MatchPair('child', 'A child of <body>', '<h1>'),
        MatchPair('siblings', 'Two elements at the same level', 'The two <li> tags'),
      ],
      explainOk:
          "Exactly — <ul> is the parent, <h1> is a child of <body>, and the two "
          "<li>s are siblings.",
    ),
  ),
  const Chapter(
    id: 10,
    title: 'Selecting Elements',
    avatar: '🔍',
    role: 'Narrator — pointing at exactly the right tag',
    bodyIntro:
        "Before JavaScript can change anything, it has to first FIND the element "
        "in the DOM tree. That's called selecting: document.getElementById(\"title\"), "
        "document.querySelector(\".card\"), document.querySelectorAll(\"li\").\n\n"
        "getElementById — finds the ONE element with that unique id\n"
        "querySelector — finds the FIRST element matching a CSS selector\n"
        "querySelectorAll — finds ALL matching elements, as a list\n\n"
        "Match each method to what it actually returns.",
    calloutHints: [
      "An id (like #title) should only ever appear once per page — that's what "
          "makes getElementById safe to grab exactly one element.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a method on the left, then click what it returns on the right.",
      pairs: [
        MatchPair('gid', "getElementById('title')", "The one element with id='title'"),
        MatchPair('qs', "querySelector('.card')", "The FIRST element with class 'card'"),
        MatchPair('qsa', "querySelectorAll('li')", "A list of EVERY <li> on the page"),
      ],
      explainOk:
          "Right! One-by-id, first-by-selector, all-by-selector.",
    ),
  ),
  const Chapter(
    id: 11,
    title: 'Events & Listeners',
    avatar: '👂',
    role: 'Narrator — waiting for something to happen',
    bodyIntro:
        "JavaScript reacts to things using events — clicks, key presses, page "
        "loads, form submits — by attaching an event listener: "
        "\"button.addEventListener('click', function() { console.log('Button was "
        "clicked!'); });\" This says: \"listen for a 'click' event on this button, "
        "and when it happens, run this function.\" The browser handles the waiting "
        "— your code doesn't have to check in a loop.\n\n"
        "Order the steps of wiring up a button click.",
    calloutHints: [
      "This pattern is everywhere: hovering, scrolling, typing in a box, and "
          "submitting a form are all just different event names.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these steps into the order they happen when you set up and use a "
          "button listener.",
      items: [
        OrderItem('select', 'Select the button element from the DOM'),
        OrderItem('attach', "Attach an event listener for the 'click' event"),
        OrderItem('wait', 'The browser waits — nothing runs yet'),
        OrderItem('fire', "The user clicks — the listener's function runs"),
      ],
      explainOk:
          "Exactly — find it, listen to it, wait, then react when the event "
          "actually fires.",
      explainBad:
          "You must SELECT the element before attaching a listener, and the "
          "function only runs once the real click happens.",
    ),
  ),
  const Chapter(
    id: 12,
    title: 'Changing the Page Live',
    avatar: '✏️',
    role: 'Narrator — editing the tree while it\'s alive',
    bodyIntro:
        "Once you've selected an element, JavaScript can change it directly — no "
        "page reload needed: title.textContent = \"New Title!\"; title.style.color = "
        "\"hotpink\"; and you can even build a brand new <li> with "
        "document.createElement and drop it in with list.appendChild(item). This is "
        "how a \"like\" button updates its count instantly.\n\n"
        "Match each line of code to what it actually does.",
    calloutHints: [
      "Every one of these changes updates the SAME living DOM tree from Chapter "
          "IX — that's why the page updates instantly without a reload.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a line on the left, then click its effect on the right.",
      pairs: [
        MatchPair('text', "title.textContent = 'New Title!'", 'Changes the visible text'),
        MatchPair('style', "title.style.color = 'hotpink'", 'Changes a CSS style directly'),
        MatchPair('create', "document.createElement('li')", 'Builds a brand-new element (not yet on the page)'),
        MatchPair('append', 'list.appendChild(item)', 'Actually inserts that new element into the page'),
      ],
      explainOk:
          "Perfect — you can change text, change style, create new nodes, and "
          "insert them, all live.",
    ),
  ),
  const Chapter(
    id: 13,
    title: 'Fetch — Asking for Data',
    avatar: '📡',
    role: 'Narrator — sending a request mid-page',
    bodyIntro:
        "Chapter I showed the browser asking a server for a WHOLE page. But "
        "JavaScript can also ask for just a little bit of DATA, without reloading "
        "anything, using fetch: \"fetch('/api/weather').then(response => "
        "response.json()).then(data => console.log(data.temperature));\" This "
        "sends a request in the background, waits for the server's response, turns "
        "it into usable data, and then does something with it — all while the rest "
        "of the page keeps working normally.\n\n"
        "Order the steps of a fetch request.",
    calloutHints: [
      "This background-request trick is called AJAX (Asynchronous JavaScript And "
          "XML, even though today it's almost always JSON, not XML).",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these steps into the order they happen during a fetch call.",
      items: [
        OrderItem('call', "JavaScript calls fetch('/api/weather')"),
        OrderItem('travel', 'The request travels to the server'),
        OrderItem('respond', 'The server sends back a response'),
        OrderItem('use', 'JavaScript reads the data and updates the page'),
      ],
      explainOk:
          "Exactly the fetch lifecycle: call it, it travels, the server answers, "
          "then you use the data.",
      explainBad:
          "The request has to travel to the server and get a response BEFORE your "
          "code can use any data.",
    ),
  ),
  const Chapter(
    id: 14,
    title: "JSON — Data's Common Language",
    avatar: '🗂️',
    role: 'Narrator — reading a very tidy note',
    bodyIntro:
        "Servers usually send data back as JSON (JavaScript Object Notation) — a "
        "simple text format for describing structured data that almost every "
        "programming language can read: { \"name\": \"Mia\", \"age\": 10, \"pets\": "
        "[\"turtle\", \"cat\"] }. JSON has just a few building blocks: objects ({ } "
        "with key/value pairs), arrays ([ ] lists), strings, numbers, booleans, and "
        "null. That's it — and it's enough to describe almost anything.\n\n"
        "Match each JSON piece to what it represents.",
    calloutHints: [
      "JSON looks a lot like a JavaScript object because that's exactly where it "
          "got its name — but it's really just plain, language-neutral text.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a piece on the left, then click what it represents on the right.",
      pairs: [
        MatchPair('obj', '{ "name": "Mia" }', 'An object — key/value pairs'),
        MatchPair('arr', '["turtle", "cat"]', 'An array — an ordered list'),
        MatchPair('num', '"age": 10', 'A key paired with a number value'),
      ],
      explainOk:
          "Right — objects hold named fields, arrays hold ordered lists, and "
          "values can be numbers, strings, or more nested structures.",
    ),
  ),
  const Chapter(
    id: 15,
    title: 'REST APIs — Verbs & Endpoints',
    avatar: '🧭',
    role: "Narrator — reading the server's menu",
    bodyIntro:
        "A REST API is a server's \"menu\" of URLs (called endpoints) plus a small "
        "set of action words (HTTP verbs) that say what to do with them: GET "
        "/users/7 reads user 7's data, POST /users creates a brand-new user, PUT "
        "/users/7 replaces user 7's data, DELETE /users/7 deletes user 7. The "
        "endpoint (/users/7) says WHAT you're working with; the verb (GET, POST...) "
        "says WHAT KIND of action to do to it.\n\n"
        "Match each verb to the action it performs.",
    calloutHints: [
      "This is exactly how the DBMS's SELECT/INSERT/UPDATE/DELETE map onto the "
          "web: GET reads, POST creates, PUT replaces, DELETE removes.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a verb on the left, then click the action it performs on the right.",
      pairs: [
        MatchPair('get', 'GET', 'Read existing data'),
        MatchPair('post', 'POST', 'Create something new'),
        MatchPair('put', 'PUT', 'Replace existing data'),
        MatchPair('delete', 'DELETE', 'Remove existing data'),
      ],
      explainOk: "Exactly — GET reads, POST creates, PUT replaces, DELETE removes.",
    ),
  ),
  const Chapter(
    id: 16,
    title: 'Async Code & the Event Loop',
    avatar: '🔁',
    role: 'Narrator — juggling many waiting tasks',
    bodyIntro:
        "JavaScript normally runs one line at a time. But a fetch call might take "
        "a whole second to come back — should the WHOLE page freeze while waiting? "
        "No! JavaScript hands slow tasks off and keeps running everything else, "
        "using the event loop. Given: console.log(\"1: start\"); fetch(\"/data\")."
        "then(() => console.log(\"3: data arrived\")); console.log(\"2: end of "
        "script\"); — this logs \"1\", then \"2\" — because fetch is slow and gets "
        "queued — and only once the response actually arrives does \"3\" run.\n\n"
        "What order do those three console.log lines actually print in?",
    calloutHints: [
      "This is why a slow network request never freezes your whole page: "
          "JavaScript keeps handling clicks and scrolling while it waits.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these log lines into the order they will actually print.",
      items: [
        OrderItem('l1', '1: start'),
        OrderItem('l2', '2: end of script'),
        OrderItem('l3', '3: data arrived'),
      ],
      explainOk:
          "Right — synchronous lines run immediately in order, and the fetch "
          "callback only runs once its slow response actually arrives, always "
          "last here.",
      explainBad:
          "The two plain console.log lines run immediately, top to bottom. The "
          "fetch callback has to wait for the network, so it always finishes last.",
    ),
  ),
  const Chapter(
    id: 17,
    title: 'The Viewport',
    avatar: '📱',
    role: 'Narrator — shrinking down to phone size',
    bodyIntro:
        "Phones have tiny screens, but old phone browsers used to zoom OUT to fit "
        "a whole desktop-sized page — tiny, unreadable text. The fix is one line "
        "in the page's head: <meta name=\"viewport\" content=\"width=device-width, "
        "initial-scale=1\">. This tells the browser: \"use the ACTUAL screen width "
        "as the page width, and don't zoom out.\" Without it, responsive CSS won't "
        "even get a chance to work properly on mobile.\n\n"
        "What's the job of the viewport meta tag?",
    calloutHints: [
      "The viewport meta tag is so foundational that almost every real website "
          "includes it — it's the first ingredient of \"mobile-friendly.\"",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What is the main job of <meta name=\"viewport\" content=\"width=device-"
          "width, initial-scale=1\">?",
      options: [
        'It makes the page load faster',
        'It tells the browser to use the real device width instead of zooming out a desktop layout',
        "It changes the page's colors automatically",
        "It stores the user's login information",
      ],
      answerIndex: 1,
      explainOk:
          "Exactly — it sets the page's width to match the real screen, which is "
          "the foundation of mobile-friendly design.",
      explainBad:
          "The viewport tag is about SIZE and ZOOM, not speed, color, or storage "
          "— it makes the page use the phone's actual width.",
    ),
  ),
  const Chapter(
    id: 18,
    title: 'Media Queries',
    avatar: '📐',
    role: 'Narrator — measuring the screen',
    bodyIntro:
        "Media queries let CSS ask a question about the screen and only apply "
        "certain rules if the answer is true: \".card { width: 300px; } @media "
        "(max-width: 600px) { .card { width: 100%; } }\" This says: \"normally cards "
        "are 300px wide, BUT if the screen is 600px or narrower, make cards fill "
        "the full width instead.\" That's how the same site looks great on a laptop "
        "AND a phone.\n\n"
        "Order the layout logic for a responsive card grid.",
    calloutHints: [
      "A \"breakpoint\" is just the screen width where a media query switches the "
          "layout — like a card going from 3-across to 1-across.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these into the order a browser actually applies them.",
      items: [
        OrderItem('base', 'Apply the normal (base) CSS rules first'),
        OrderItem('check', 'Check the current screen width against the media query'),
        OrderItem('match', 'If the screen matches (e.g. narrower than 600px)...'),
        OrderItem('override', "...apply the media query's rules on top, overriding the base ones"),
      ],
      explainOk:
          "Right — base styles apply first, then media queries layer on top only "
          "when the screen matches.",
      explainBad:
          "Base CSS always applies first; media query rules only kick in AFTER "
          "the browser checks the screen size.",
    ),
  ),
  const Chapter(
    id: 19,
    title: 'Mobile-First Thinking',
    avatar: '🐢',
    role: 'Narrator — designing small, then growing up',
    bodyIntro:
        "There are two ways to write responsive CSS: design for desktop first and "
        "shrink down, or design for the smallest phone first and grow up. Most "
        "professional teams choose mobile-first: base rules are the phone layout "
        "(.nav { flex-direction: column; }), then @media (min-width: 768px) { .nav "
        "{ flex-direction: row; } } grows up to tablet/desktop. Notice min-width "
        "instead of max-width — mobile-first queries say \"once the screen is AT "
        "LEAST this wide, upgrade the layout.\"\n\n"
        "Which media query direction matches mobile-first design?",
    calloutHints: [
      "Mobile-first usually means simpler CSS overall, since most people's very "
          "first visit today is on a phone, not a desktop.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which media query style is typical of mobile-first design?",
      options: [
        '@media (max-width: 1200px) { ... } as the very first rule',
        '@media (min-width: 768px) { ... } added on top of simple base (phone) styles',
        'Writing the desktop layout first, then overriding it for phones',
        'Never using any media queries at all',
      ],
      answerIndex: 1,
      explainOk:
          "Yes — start with simple phone-friendly base styles, then use min-width "
          "queries to upgrade the layout as the screen grows.",
      explainBad:
          "Mobile-first starts SIMPLE (for phones) and uses min-width to ADD "
          "complexity as the screen gets bigger — not the other way around.",
    ),
  ),
  const Chapter(
    id: 20,
    title: 'Responsive Units & Images',
    avatar: '📏',
    role: 'Narrator — measuring in relative terms',
    bodyIntro:
        "Fixed pixel sizes don't always scale nicely. Responsive CSS often uses "
        "relative units instead.\n\n"
        "% — relative to the parent's size\n"
        "em — relative to the current font size\n"
        "rem — relative to the ROOT font size (consistent everywhere)\n"
        "vw / vh — relative to the viewport's width/height\n\n"
        "Images can also adapt: srcset lets the browser pick a smaller image file "
        "for a small screen, saving data.\n\n"
        "Sort these units by what they're relative to.",
    calloutHints: [
      "Fixed px never scales with anything; relative units like rem and % are "
          "what make truly flexible layouts possible.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each unit into the bucket for what it's measured relative to.",
      bucketALabel: '📦 Relative to an element/font',
      bucketBLabel: '🖥️ Relative to the viewport/screen',
      items: [
        Sort2Item('percent', '% (parent element size)', true),
        Sort2Item('rem', 'rem (root font size)', true),
        Sort2Item('vw', 'vw (viewport width)', false),
        Sort2Item('vh', 'vh (viewport height)', false),
      ],
      explainOk:
          "Right — % and rem scale with elements/fonts, while vw/vh scale "
          "directly with the actual screen.",
      explainBad:
          "% and rem depend on an element or the root font; vw/vh depend "
          "directly on the browser window's size.",
    ),
  ),
  const Chapter(
    id: 21,
    title: 'HTTPS & the TLS Handshake',
    avatar: '🔒',
    role: 'Narrator — sealing an envelope',
    bodyIntro:
        "Plain HTTP sends data as readable text — anyone snooping on the network "
        "could read your password! HTTPS fixes this by wrapping every request in "
        "encryption using TLS (Transport Layer Security). Before any real data is "
        "sent, the browser and server perform a quick handshake: they agree on an "
        "encryption method and exchange keys that only the two of them can use — "
        "then the actual page data travels locked inside that encrypted tunnel.\n\n"
        "Order the steps of an HTTPS connection.",
    calloutHints: [
      "The padlock icon in your browser's address bar means the TLS handshake "
          "succeeded and your connection to that exact site is encrypted.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these steps into the order they happen when your browser connects "
          "over HTTPS.",
      items: [
        OrderItem('connect', 'Browser connects to the server'),
        OrderItem('handshake', 'Browser and server perform the TLS handshake, agreeing on encryption keys'),
        OrderItem('encrypted', 'All further data travels through the encrypted tunnel'),
        OrderItem('padlock', 'The browser shows the padlock icon'),
      ],
      explainOk:
          "Exactly — connect first, handshake to agree on encryption, THEN data "
          "flows encrypted, and the padlock confirms it.",
      explainBad:
          "The handshake (agreeing on encryption) must finish BEFORE any real "
          "data is sent, and the padlock only appears once that's done.",
    ),
  ),
  const Chapter(
    id: 22,
    title: 'The Same-Origin Policy',
    avatar: '🛂',
    role: 'Narrator — checking IDs at a border',
    bodyIntro:
        "Your browser has a built-in security rule called the same-origin policy: "
        "by default, JavaScript running on one website cannot read data from a "
        "DIFFERENT website's pages or cookies. An \"origin\" is the combination of "
        "protocol + domain + port — https://bank.com and https://evil.com are "
        "different origins, so a script on evil.com can't just reach into your "
        "open bank.com tab.\n\n"
        "Which pair counts as the SAME origin?",
    calloutHints: [
      "Servers can deliberately relax this with a header called CORS (Cross-"
          "Origin Resource Sharing) when they WANT to allow it — it's an opt-in "
          "exception, not the default.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Which pair of URLs share the SAME origin (same protocol + domain + port)?",
      options: [
        'https://shop.com and http://shop.com',
        'https://shop.com and https://shop.com/cart',
        'https://shop.com and https://shop.com:8080',
        'https://shop.com and https://evilshop.com',
      ],
      answerIndex: 1,
      explainOk:
          "Right — different PATHS on the same protocol/domain/port are still "
          "the same origin. The others differ in protocol, port, or domain.",
      explainBad:
          "Origin only cares about protocol, domain, and port — NOT the path. "
          "Look for the pair that only differs by path.",
    ),
  ),
  const Chapter(
    id: 23,
    title: 'XSS — Cross-Site Scripting',
    avatar: '🕷️',
    role: 'Narrator — spotting a sneaky script',
    bodyIntro:
        "XSS happens when an attacker sneaks their OWN JavaScript into a page "
        "that other people trust and visit — for example, by submitting a comment "
        "that contains a hidden <script> tag, if the site displays comments "
        "without cleaning them first: \"Nice post! <script>stealCookies()</script>\". "
        "If the site just inserts that text directly into the page, the browser "
        "will actually RUN that script for every visitor who reads the comment.\n\n"
        "Order the steps of an XSS attack.",
    calloutHints: [
      "The fix is called \"escaping\" or \"sanitizing\" user input — turning < "
          "and > into harmless text instead of letting them become real tags.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these into the order an XSS attack actually unfolds.",
      items: [
        OrderItem('submit', 'Attacker submits a comment containing a hidden <script> tag'),
        OrderItem('store', 'The website stores that comment without cleaning it'),
        OrderItem('render', 'A victim visits the page and the comment is inserted into the HTML'),
        OrderItem('run', "The victim's browser runs the attacker's script"),
      ],
      explainOk:
          "Exactly — the malicious script has to be submitted, stored, rendered, "
          "and only THEN does it actually run in a victim's browser.",
      explainBad:
          "The script only runs once it's inserted into a page a real visitor "
          "loads — that happens after submission and storage, not before.",
    ),
  ),
  const Chapter(
    id: 24,
    title: 'CSRF — Cross-Site Request Forgery',
    avatar: '🎭',
    role: 'Narrator — a forged signature',
    bodyIntro:
        "CSRF tricks a victim's browser into sending a request to a site the "
        "victim is ALREADY logged into, without the victim meaning to. If bank.com "
        "trusts any request carrying the victim's login cookie, and evil.com "
        "secretly auto-submits a \"transfer money\" form to bank.com, the browser "
        "happily attaches those cookies. The fix: servers require a special, "
        "unpredictable CSRF token with important requests — a token that a hidden "
        "cross-site form couldn't possibly know.\n\n"
        "Match each attack to what it actually abuses.",
    calloutHints: [
      "CSRF abuses trust the SERVER has in the browser's cookies; XSS (Chapter "
          "XXIII) abuses trust the BROWSER has in the page's own code. Different "
          "bugs, similar damage.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click an attack on the left, then click what it abuses on the right.",
      pairs: [
        MatchPair('xss', 'XSS', 'Runs attacker script inside a trusted page'),
        MatchPair('csrf', 'CSRF', 'Tricks the browser into sending a request using saved login cookies'),
        MatchPair('fix', 'CSRF token', "A secret value a forged cross-site form can't guess"),
      ],
      explainOk:
          "Right — XSS injects code into the page itself; CSRF forges a request "
          "that rides on your existing login.",
    ),
  ),
  const Chapter(
    id: 25,
    title: 'The Critical Rendering Path',
    avatar: '🎬',
    role: 'Narrator — watching a page come alive frame by frame',
    bodyIntro:
        "Getting HTML/CSS/JS to the browser is only half the story. The browser "
        "then has to actually turn it into pixels, in a pipeline called the "
        "critical rendering path: HTML → DOM tree, CSS → CSSOM (style tree), DOM + "
        "CSSOM → Render Tree, Render Tree → Layout (compute positions/sizes), "
        "Layout → Paint (fill in pixels). Anything that blocks this pipeline — "
        "like a big unoptimized CSS file loading before anything can be styled — "
        "delays the very first thing the user sees.\n\n"
        "Order the rendering pipeline.",
    calloutHints: [
      "\"First Contentful Paint\" is a real performance metric that measures "
          "exactly how long this whole pipeline takes for the FIRST visible pixel.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Drag these stages into the order the browser performs them.",
      items: [
        OrderItem('dom', 'Parse HTML into the DOM tree'),
        OrderItem('cssom', 'Parse CSS into the CSSOM (style tree)'),
        OrderItem('rendertree', 'Combine DOM + CSSOM into the Render Tree'),
        OrderItem('layout', 'Layout: compute exact size and position of every box'),
        OrderItem('paint', 'Paint: fill in actual pixels on screen'),
      ],
      explainOk:
          "Exactly right — parse both trees, merge them, compute layout, then "
          "paint pixels.",
      explainBad:
          "You need BOTH the DOM and CSSOM before you can build a Render Tree, "
          "and layout must happen before paint.",
    ),
  ),
  const Chapter(
    id: 26,
    title: 'Caching Strategies',
    avatar: '🗃️',
    role: 'Narrator — keeping a copy nearby',
    bodyIntro:
        "Re-downloading the same unchanged files on every visit is wasteful. "
        "Browsers cache (save a local copy of) files using headers the server "
        "sends: \"Cache-Control: max-age=86400\". This says \"reuse this file for up "
        "to 86,400 seconds (1 day) without asking the server again.\" When a file "
        "DOES change, developers often rename it with a hash in the filename (like "
        "app.3f8a1.js) so the browser knows it's genuinely new.\n\n"
        "Which scenario is the caching header actually helping with?",
    calloutHints: [
      "A Content Delivery Network (CDN) takes caching further — it stores copies "
          "of your files on servers physically close to each visitor.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A returning visitor loads your site instantly because their browser "
          "already has yesterday's unchanged CSS file saved locally. What made "
          "this possible?",
      options: [
        'The server ran the CSS through a compiler',
        'A Cache-Control header told the browser it could reuse the saved file instead of re-downloading it',
        'The visitor has a faster internet connection than before',
        'The CSS file was deleted from the server',
      ],
      answerIndex: 1,
      explainOk:
          "Right — caching headers let the browser skip a re-download entirely "
          "when it already has a valid, unexpired copy.",
      explainBad:
          "This is about avoiding a repeat DOWNLOAD, not connection speed or "
          "compiling — that's exactly what Cache-Control headers control.",
    ),
  ),
  const Chapter(
    id: 27,
    title: 'Lazy Loading',
    avatar: '😴',
    role: "Narrator — only waking up what's needed",
    bodyIntro:
        "A page with 50 images doesn't need to load all 50 the instant it opens — "
        "most are below the fold, out of view. Lazy loading delays loading "
        "offscreen content until it's actually about to be seen: <img src=\"photo."
        "jpg\" loading=\"lazy\">. This one attribute tells the browser: \"don't fetch "
        "this image yet — wait until the user scrolls close to it.\" The same idea "
        "applies to code: some JavaScript \"chunks\" only load when a user visits a "
        "feature that actually needs them.\n\n"
        "Sort these resources by when they should load.",
    calloutHints: [
      "Lazy loading directly improves the \"First Contentful Paint\" metric from "
          "Chapter XXV, since the browser has far less to fetch up front.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each resource into when it should realistically load.",
      bucketALabel: '⚡ Load immediately',
      bucketBLabel: '😴 Lazy load (only when needed)',
      items: [
        Sort2Item('logo', 'The site logo at the very top of the page', true),
        Sort2Item('footer-img', 'An image far down in the footer', false),
        Sort2Item('hero', 'The main hero banner image visible on load', true),
        Sort2Item('modal-code', 'JavaScript for a rarely-used settings modal', false),
      ],
      explainOk:
          "Right — anything visible immediately should load eagerly; anything "
          "offscreen or rarely used can wait.",
      explainBad:
          "Ask: will the user see or need this THE INSTANT the page opens? If "
          "not, it's a good lazy-load candidate.",
    ),
  ),
  const Chapter(
    id: 28,
    title: 'Reflow & Repaint Costs',
    avatar: '💸',
    role: 'Narrator — counting the cost of every change',
    bodyIntro:
        "Changing a page after it's rendered isn't free. Some changes only need a "
        "cheap repaint (pixels change color, layout stays the same); others force "
        "an expensive reflow (the browser must recompute layout for potentially "
        "the WHOLE page): el.style.color = \"red\" is repaint-only and cheap, while "
        "el.style.width = \"500px\" triggers a reflow, and even reading "
        "el.offsetWidth can force a reflow! Changing something that affects size "
        "or position (width, height, margin) is much more expensive than changing "
        "something purely visual (color, opacity).\n\n"
        "Sort these changes by their real cost.",
    calloutHints: [
      "A common performance trick: batch all your style reads, THEN all your "
          "style writes, instead of interleaving them — reading after writing can "
          "force the browser to recompute layout over and over.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each style change into the right cost bucket.",
      bucketALabel: '🎨 Cheap: repaint only',
      bucketBLabel: '💸 Expensive: triggers reflow',
      items: [
        Sort2Item('color', 'Changing text color', true),
        Sort2Item('opacity', 'Changing opacity', true),
        Sort2Item('width', "Changing an element's width", false),
        Sort2Item('margin', 'Changing margin (affects surrounding layout)', false),
      ],
      explainOk:
          "Right — purely visual changes repaint cheaply; anything affecting "
          "size/position forces a costlier reflow.",
      explainBad:
          "Ask: does this change move or resize anything? If yes, it likely "
          "forces a reflow, not just a repaint.",
    ),
  ),
  const Chapter(
    id: 29,
    title: 'Components — Building Blocks',
    avatar: '🧱',
    role: 'Narrator — snapping together LEGO bricks',
    bodyIntro:
        "Modern frameworks (React, Vue, Svelte, and friends) all share one core "
        "idea: break the UI into small, reusable components — each one owning its "
        "own markup, style, and behavior, like a LikeButton component that returns "
        "a <button>❤️ Like</button>. A whole page is really just components nested "
        "inside other components — a Page made of a Header, a list of Post "
        "components, each containing a LikeButton.\n\n"
        "Match each idea to the component concept it describes.",
    calloutHints: [
      "This mirrors the DOM tree from Chapter IX — components are just a more "
          "organized, reusable way to describe the same nested tree structure.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a description on the left, then click the term it matches on "
          "the right.",
      pairs: [
        MatchPair('component', 'A small, reusable, self-contained piece of UI', 'Component'),
        MatchPair('nesting', 'A Page made of a Header and many Post components', 'Composition (nesting components)'),
        MatchPair('reuse', 'Using the same LikeButton on 100 different posts', 'Reusability'),
      ],
      explainOk:
          "Exactly — components are reusable building blocks, composed together "
          "to build bigger UIs.",
    ),
  ),
  const Chapter(
    id: 30,
    title: 'State & Props',
    avatar: '🎛️',
    role: 'Narrator — reading dials and passing notes',
    bodyIntro:
        "Components need two kinds of data: state (data a component owns and can "
        "change itself, like whether a like button is pressed) and props (data "
        "passed IN from a parent component, which the child cannot change itself). "
        "In a LikeButton(props) function, props.postId comes from the parent — "
        "read-only here — while a local 'liked' variable is state, this "
        "component's own, and can change. When state changes, the framework "
        "automatically re-renders that piece of the UI to reflect the new value.\n\n"
        "Sort these values into state vs. props.",
    calloutHints: [
      "Props flow strictly one direction: parent → child. A child can ask its "
          "parent to change something (via a callback), but it can't reach up and "
          "change the parent's data directly.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each value into the bucket it belongs in.",
      bucketALabel: '🎛️ State (owned by this component)',
      bucketBLabel: '📨 Props (passed in from the parent)',
      items: [
        Sort2Item('liked', 'Whether THIS like button is currently pressed', true),
        Sort2Item('postId', 'The id of the post this button belongs to, given by the parent', false),
        Sort2Item('open', 'Whether a dropdown menu is currently open', true),
        Sort2Item('username', 'The username to display, passed down from a parent list', false),
      ],
      explainOk:
          "Right — state is a component's own changeable data; props are "
          "read-only data handed down from above.",
      explainBad:
          "Ask: does this component own and change this value itself (state), "
          "or did a parent hand it down (props)?",
    ),
  ),
  const Chapter(
    id: 31,
    title: 'The Virtual DOM Diff',
    avatar: '🪞',
    role: 'Narrator — comparing before-and-after snapshots',
    bodyIntro:
        "Directly touching the real DOM tree for every tiny change can be slow if "
        "it happens a lot. Many frameworks instead keep a lightweight virtual DOM "
        "— a plain-data copy of the UI tree — and build a NEW virtual tree "
        "whenever state changes, diff it against the OLD virtual tree to find "
        "exactly what changed, and apply ONLY those minimal real-DOM updates. If "
        "only one like-count number changed among a thousand posts, the diff "
        "finds just that one text node — not a full-page redraw.\n\n"
        "Order the virtual DOM update cycle.",
    calloutHints: [
      "This is the same \"find the difference\" instinct as comparing two "
          "photos — the framework only touches what's actually different.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these steps into the order a framework performs them after a "
          "state change.",
      items: [
        OrderItem('change', 'Component state changes'),
        OrderItem('newtree', 'Framework builds a new virtual tree'),
        OrderItem('diff', 'Framework diffs new tree against the old one'),
        OrderItem('patch', 'Only the minimal real DOM changes are applied'),
      ],
      explainOk:
          "Exactly — state changes, a new virtual tree is built, it's diffed "
          "against the old one, then only the real differences get patched in.",
      explainBad:
          "You can't diff before building the new tree, and the real DOM is "
          "only touched AFTER the diff finds what actually changed.",
    ),
  ),
  const Chapter(
    id: 32,
    title: 'One-Way Data Flow',
    avatar: '➡️',
    role: 'Narrator — following the water downstream',
    bodyIntro:
        "Combining state and props, most frameworks enforce one-way data flow: "
        "data flows DOWN from parent to child as props; to send information back "
        "UP, a child calls a function the parent gave it. A parent gives the "
        "child a callback function like onLike, and the child calls it when "
        "clicked — never edits the parent's state directly. This makes big apps "
        "easier to reason about: state changes always start from ONE place, "
        "instead of getting edited from a dozen scattered spots.\n\n"
        "Which statement correctly describes one-way data flow?",
    calloutHints: [
      "This is the framework version of the DOM event pattern from Chapter XI "
          "— the child \"raises an event,\" and the parent decides what to do "
          "about it.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which of these correctly follows one-way data flow?",
      options: [
        'A child component directly overwrites a variable inside its parent',
        'A parent passes data down as props, and a child calls a parent-provided callback to request a change',
        "Two sibling components directly edit each other's internal state",
        'State changes randomly without any component requesting it',
      ],
      answerIndex: 1,
      explainOk:
          "Right — data flows down as props, and any change request flows back "
          "up through a callback the parent controls.",
      explainBad:
          "The key rule: children never reach in and directly mutate a parent's "
          "(or sibling's) state — they only ASK, via a callback.",
    ),
  ),
  const Chapter(
    id: 33,
    title: 'Semantic HTML',
    avatar: '🏷️',
    role: 'Narrator — labeling things by what they truly are',
    bodyIntro:
        "Semantic HTML means using tags that describe MEANING, not just "
        "appearance — which helps screen readers, search engines, and other "
        "developers understand your page. A non-semantic <div onclick=\"submit()\">"
        "Submit</div> is different from a semantic <button>Submit</button>, <nav>, "
        "<main>, <footer>. A screen reader announces \"<button>\" as an actual, "
        "clickable button — it has no idea a plain <div> is meant to act like one.\n\n"
        "Sort these into semantic vs. non-semantic usage.",
    calloutHints: [
      "Semantic tags come with built-in behavior for free: a real <button> is "
          "keyboard-clickable automatically; a styled <div> is not.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each usage into the right bucket.",
      bucketALabel: '✅ Semantic (meaning-based tag)',
      bucketBLabel: '❌ Non-semantic (meaningless wrapper)',
      items: [
        Sort2Item('button', '<button>Submit</button>', true),
        Sort2Item('divclick', '<div onclick="submit()">Submit</div>', false),
        Sort2Item('nav', "<nav> around the site's navigation links", true),
        Sort2Item('divwrap', '<div> used only to wrap unrelated content for styling', false),
      ],
      explainOk:
          "Right — real buttons and landmark tags carry meaning; a bare div "
          "styled to look like something isn't the same as being that thing.",
      explainBad:
          "Ask: does this tag describe what the content actually IS, or is it "
          "just a generic styling wrapper pretending to be something?",
    ),
  ),
  const Chapter(
    id: 34,
    title: 'ARIA Roles & Labels',
    avatar: '🗣️',
    role: 'Narrator — giving a screen reader extra hints',
    bodyIntro:
        "Sometimes you genuinely need a custom widget HTML doesn't have a native "
        "tag for (like a custom slider). ARIA (Accessible Rich Internet "
        "Applications) attributes describe it to screen readers: <div "
        "role=\"slider\" aria-valuemin=\"0\" aria-valuemax=\"100\" "
        "aria-valuenow=\"40\"></div>. role tells assistive tech WHAT this is; "
        "aria-* attributes describe its current state, like the slider's value.\n\n"
        "Match each ARIA concept to its purpose.",
    calloutHints: [
      "First rule of ARIA: if a native HTML tag already does the job (like "
          "<button> or <input type=\"range\">), use that instead — ARIA is a "
          "backup for when nothing native fits.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a concept on the left, then click its purpose on the right.",
      pairs: [
        MatchPair('role', 'role="slider"', 'Tells assistive tech WHAT the widget is'),
        MatchPair('valuenow', 'aria-valuenow="40"', "Tells assistive tech the widget's CURRENT value"),
        MatchPair('label', 'aria-label="Close menu"', 'Gives an icon-only button a readable name'),
      ],
      explainOk:
          "Right — role defines what it is, aria-* attributes describe state, "
          "and aria-label gives unlabeled elements real names.",
    ),
  ),
  const Chapter(
    id: 35,
    title: 'Keyboard Navigation & Focus',
    avatar: '⌨️',
    role: 'Narrator — never touching the mouse',
    bodyIntro:
        "Not everyone can use a mouse. A genuinely accessible page must be fully "
        "usable with a KEYBOARD ALONE — Tab to move between interactive elements, "
        "Enter/Space to activate them, and a visible focus outline showing where "
        "you are. Removing the focus outline (button:focus { outline: none; }) "
        "without providing a clear alternative leaves keyboard users with no idea "
        "what element is currently selected — a common, serious accessibility "
        "mistake.\n\n"
        "Which practice actually helps keyboard accessibility?",
    calloutHints: [
      "tabindex=\"-1\" removes something from the normal Tab order; a positive "
          "tabindex is almost always a bad idea because it creates a confusing, "
          "hard-to-maintain custom order.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which of these actually helps keyboard-only users?",
      options: [
        'Removing all focus outlines with outline: none, with no replacement',
        'Making sure every interactive element can be reached and activated using only Tab and Enter, with a visible focus style',
        'Using <div onclick> for every clickable action instead of <button>',
        'Setting a large positive tabindex on every element',
      ],
      answerIndex: 1,
      explainOk:
          "Right — full keyboard reachability with a clear, visible focus "
          "indicator is the core of keyboard accessibility.",
      explainBad:
          "Removing focus outlines, using non-focusable divs for actions, and "
          "scrambling tab order with positive tabindex are all common "
          "accessibility mistakes.",
    ),
  ),
  const Chapter(
    id: 36,
    title: 'Color Contrast & Screen Readers',
    avatar: '👀',
    role: 'Narrator — squinting at low-contrast text',
    bodyIntro:
        "Text that's technically visible isn't always READABLE — light gray text "
        "on a white background can be nearly impossible for many users to read. "
        "Accessibility guidelines (WCAG) set minimum contrast ratios between text "
        "and its background. Screen readers add another layer: they read text, "
        "image alt text, and ARIA labels aloud — so an image with no alt "
        "attribute is effectively invisible to a blind user, even though it "
        "renders fine visually.\n\n"
        "Match each accessibility need to what actually addresses it.",
    calloutHints: [
      "Accessibility isn't a separate \"extra feature\" — captions help people "
          "in a noisy room, high contrast helps people in bright sunlight, and "
          "clear focus outlines help everyone using a keyboard, not just "
          "assistive-tech users.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a need on the left, then click its fix on the right.",
      pairs: [
        MatchPair('contrast', 'Low-contrast text is hard to read', 'Increase the contrast ratio between text and background'),
        MatchPair('alt', "A blind user can't see an image", 'Add descriptive alt text to the image'),
        MatchPair('focus', "A keyboard user can't tell what's selected", 'Keep a clear, visible focus outline'),
      ],
      explainOk:
          "Right — contrast, alt text, and visible focus each solve a different "
          "real barrier.",
    ),
  ),
  const Chapter(
    id: 37,
    title: 'Diagnose: Why Is This Page Slow?',
    avatar: '🩺',
    role: 'Narrator — running a real performance audit',
    bodyIntro:
        "This is the Professional Knowledge Check for Web Woods. A real "
        "production page is reported as \"slow\" by users. A performance audit "
        "shows: a 4MB hero image loading eagerly above the fold, a render-"
        "blocking analytics script in the <head>, no Cache-Control headers on "
        "static assets, and frequent layout-shifting ads. This is exactly the "
        "kind of ticket a professional front-end engineer triages weekly — "
        "pulling together the critical rendering path, caching, lazy loading, "
        "and reflow costs into one diagnosis.\n\n"
        "Rank these fixes by how much they'd likely help THIS specific page, "
        "most impactful first.",
    calloutHints: [
      "In real audits, tools like Lighthouse literally point at these exact "
          "four categories: render-blocking resources, unoptimized images, "
          "caching, and layout stability.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these fixes into order from MOST to LEAST impactful for this "
          "specific page.",
      items: [
        OrderItem('lazy', 'Lazy-load the 4MB hero image and compress it'),
        OrderItem('defer', 'Move/defer the render-blocking analytics script'),
        OrderItem('cache', 'Add Cache-Control headers to static assets'),
        OrderItem('shift', 'Reserve ad space to prevent layout shifting'),
      ],
      explainOk:
          "A strong real-world call: the oversized hero image and the render-"
          "blocking script are directly delaying first paint, so they matter "
          "most; caching and layout-shift fixes matter but affect fewer visits "
          "or a narrower symptom.",
      explainBad:
          "Weigh what's blocking the FIRST paint the most (the giant image, "
          "the blocking script) against smaller, longer-tail wins (caching "
          "helps repeat visits, layout-shift fixes help visual stability).",
    ),
  ),
  const Chapter(
    id: 38,
    title: 'Design a Feature End-to-End',
    avatar: '🏗️',
    role: 'Narrator — shipping a real feature',
    bodyIntro:
        "You're asked to build a \"like\" button feature end-to-end: clicking it "
        "should instantly show the new count AND persist it to the server, "
        "surviving a page reload. This pulls together nearly everything in Web "
        "Woods: DOM events, state, a fetch call to a REST endpoint, and a "
        "database row being updated on the server.\n\n"
        "Order the full stack of what happens when a user clicks \"Like.\"",
    calloutHints: [
      "Professional teams often update the UI IMMEDIATELY (optimistic update) "
          "while the server request is still in flight, then quietly correct it "
          "if the request ever fails — so the UI never feels laggy.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these into the order they happen across the whole stack.",
      items: [
        OrderItem('click', 'User clicks the Like button (DOM event fires)'),
        OrderItem('optimistic', 'UI immediately shows the new count (optimistic state update)'),
        OrderItem('request', 'A POST request is sent to /api/posts/7/like'),
        OrderItem('dbupdate', "The server updates the post's like count in the database"),
        OrderItem('confirm', 'The server responds; the UI confirms or corrects the count'),
      ],
      explainOk:
          "Exactly the professional pattern: react instantly in the UI, fire "
          "the request, update the database, then reconcile with the real "
          "server response.",
      explainBad:
          "The click always comes first, and the database is only updated once "
          "the request actually reaches the server — the UI update and the "
          "network request can overlap, but the DB change happens server-side, "
          "after the request arrives.",
    ),
  ),
  const Chapter(
    id: 39,
    title: 'Spot the Security Flaw',
    avatar: '🔎',
    role: 'Narrator — doing a code review',
    bodyIntro:
        "A pull request adds a search-results page with this snippet: "
        "\"results.innerHTML = 'You searched for: ' + userSearchTerm;\" "
        "userSearchTerm comes directly from the URL's query string, with no "
        "cleaning at all. A real code reviewer should immediately recognize the "
        "exact vulnerability class from Chapter XXIII.\n\n"
        "What vulnerability does this code introduce?",
    calloutHints: [
      "The safe fix is to set textContent instead of innerHTML when inserting "
          "plain user text — textContent never lets a string become a real, "
          "executable tag.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Inserting an unsanitized, user-controlled string directly via "
          "innerHTML introduces which vulnerability?",
      options: [
        'CSRF — a forged cross-site request',
        'XSS — a malicious script could be injected and executed via innerHTML',
        'Same-origin policy violation',
        'A caching misconfiguration',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — unsanitized input inserted via innerHTML is the textbook "
          "XSS pattern from Chapter XXIII; a user could search for a string "
          "containing a <script> tag and have it execute.",
      explainBad:
          "This is specifically about untrusted text becoming executable HTML "
          "— that's XSS, not CSRF, CORS, or caching.",
    ),
  ),
  const Chapter(
    id: 40,
    title: 'The Last Circuit: Ship It',
    avatar: '🚀',
    role: 'Narrator — the final review before launch',
    bodyIntro:
        "The final challenge of Web Woods. A launch-readiness checklist only "
        "passes if BOTH conditions are true: the page passes a Lighthouse "
        "performance audit AND it passes a basic accessibility audit (keyboard "
        "nav + contrast + alt text). Miss either one, and it doesn't ship. This "
        "mirrors a real AND-gate: both inputs must be true for the output — "
        "\"ready to launch\" — to be true. Let A = the performance audit passing, "
        "and B = the accessibility audit passing.\n\n"
        "Close the last circuit: light up the launch LED.",
    calloutHints: [
      "You've now walked the full path: how the web works, HTML/CSS/JS, "
          "layout, the DOM, APIs, responsive design, security, performance, "
          "modern component thinking, and accessibility. That's the real, "
          "professional shape of front-end web development.",
    ],
    puzzleType: PuzzleType.circuit,
    circuit: CircuitPuzzle(
      instructions:
          "A = performance audit passes, B = accessibility audit passes. Flip "
          "both switches to 1 so the AND gate's launch LED lights up.",
      gate: CircuitGate.and,
      explainOk:
          "Both switches ON means both audits pass — the AND gate lights up, "
          "and Web Woods' final Shard is restored. Ship it!",
      explainBad:
          "An AND gate only lights up when BOTH inputs are true — a real "
          "launch needs BOTH performance AND accessibility to pass, not just "
          "one.",
    ),
  ),
  const Chapter(
    id: 41,
    title: 'CI/CD for Web Apps',
    avatar: '🛠️',
    role: 'Senior Engineer — watching a pipeline go green',
    bodyIntro:
        "Welcome to the Professional Tier, engineer. In a real company, code "
        "doesn't reach production by someone dragging files onto a server. It "
        "moves through a CI/CD pipeline — Continuous Integration, Continuous "
        "Delivery/Deployment — a repeatable, automated path from commit to "
        "running service: build (npm ci && npm run build), test (npm run test), "
        "lint (npm run lint), deploy (docker push && kubectl rollout restart). "
        "Continuous Integration means every push is automatically built, linted, "
        "and tested — catching regressions in minutes, not weeks. Continuous "
        "Delivery means a passing build is always packaged and ready to ship; "
        "Continuous Deployment goes one step further and pushes it to production "
        "automatically, no human click required. Professional pipelines gate "
        "deploys on real signals: unit tests, integration tests, a successful "
        "build artifact, and often a canary or staged rollout before 100% of "
        "traffic gets the new version.\n\n"
        "Order the stages of a real CI/CD pipeline.",
    calloutHints: [
      "A pipeline that deploys on a red build is worse than no pipeline at all "
          "— the ordering (build → test → deploy) is a hard rule, not a "
          "suggestion, because each stage exists to block the next one from bad "
          "code.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these stages into the order a production pipeline actually "
          "runs them.",
      items: [
        OrderItem('push', 'Developer pushes a commit to the main branch'),
        OrderItem('build', 'CI server checks out the code and builds it'),
        OrderItem('test', 'Automated tests (unit + integration) run against the build'),
        OrderItem('package', 'A deployable artifact (e.g. a container image) is packaged and versioned'),
        OrderItem('deploy', 'The artifact is rolled out to production, often gradually'),
      ],
      explainOk:
          "Exactly the real pipeline shape: a commit triggers a build, the "
          "build must pass tests before it's packaged, and only a packaged, "
          "tested artifact ever reaches production.",
      explainBad:
          "Tests must run against a completed build BEFORE packaging, and "
          "packaging must finish BEFORE anything is deployed — skipping or "
          "reordering these gates is how broken code reaches production.",
    ),
  ),
  const Chapter(
    id: 42,
    title: 'CDNs & HTTP Caching Headers',
    avatar: '🌍',
    role: 'Senior Engineer — placing copies of the app around the globe',
    bodyIntro:
        "A single origin server in one datacenter means every user, no matter "
        "where they are, pays the same round-trip latency to reach it. A CDN "
        "(Content Delivery Network) solves this by caching your static assets — "
        "JS bundles, CSS, images — on edge servers physically close to each "
        "visitor. Real headers control this: Cache-Control: public, max-age="
        "31536000, immutable for a hashed JS bundle (cache forever), Cache-"
        "Control: no-store for a logged-in user's account page, Cache-Control: "
        "private, max-age=0, must-revalidate for the HTML shell, and ETag as a "
        "fingerprint of the current content. public means shared caches (CDNs) "
        "may store it; private restricts caching to the user's own browser. An "
        "ETag lets the browser ask \"has this changed since I last fetched it?\" "
        "via a cheap conditional request instead of re-downloading the whole "
        "file.\n\n"
        "Sort these responses into the right caching strategy.",
    calloutHints: [
      "The classic production bug: shipping a new JS bundle under the SAME "
          "filename with a long max-age. Users are stuck on the old, broken "
          "bundle until the cache expires — which is exactly why hashed "
          "filenames exist.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each response into the caching strategy that actually fits it.",
      bucketALabel: '♾️ Cache long/forever (hashed, public)',
      bucketBLabel: '🚫 Never cache / always revalidate (private)',
      items: [
        Sort2Item('hashed', 'app.3f8a1.js — filename includes a content hash', true),
        Sort2Item('account', "A logged-in user's /account/balance response", false),
        Sort2Item('logo', 'logo.a91cd.svg — hashed static asset', true),
        Sort2Item('cart', 'A shopping cart total that changes every request', false),
      ],
      explainOk:
          "Right — hashed, content-addressed assets are safe to cache forever "
          "since a new version gets a new URL; anything personal or "
          "frequently-changing must never be cached publicly.",
      explainBad:
          "Ask: does the filename change whenever the content changes (safe to "
          "cache forever), or is this personal/dynamic data that must always "
          "be fresh (never cache)?",
    ),
  ),
  const Chapter(
    id: 43,
    title: 'Containerizing a Web App',
    avatar: '📦',
    role: 'Senior Engineer — sealing the app into a portable box',
    bodyIntro:
        "\"It works on my machine\" is not a deployment strategy. Containers "
        "(Docker being the dominant tool) package your app with its exact "
        "runtime, dependencies, and OS libraries into one portable image that "
        "runs identically on a laptop, a CI runner, or a production cluster. A "
        "real production Dockerfile uses a multi-stage build: a FROM node:20 AS "
        "build stage runs npm ci and npm run build, then a final FROM nginx:"
        "alpine stage does COPY --from=build /app/dist /usr/share/nginx/html and "
        "EXPOSE 80. The multi-stage build is a professional habit, not an "
        "academic trick: the first stage has the full Node toolchain needed to "
        "build the app; the final image only contains the compiled output on a "
        "tiny nginx base — no compilers, no dev dependencies, no leftover "
        "source maps, a much smaller attack surface and image size.\n\n"
        "Match each Dockerfile concept to what it actually does.",
    calloutHints: [
      "Containers solve \"dependency drift\" (mismatched library versions "
          "across environments), but they don't replace CI/CD — the pipeline "
          "builds the image, tags it with a version, and THAT exact image is "
          "what gets deployed.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a concept on the left, then click what it does on the right.",
      pairs: [
        MatchPair('build-stage', 'FROM node:20 AS build', 'A throwaway stage with the full build toolchain'),
        MatchPair('copy-from', 'COPY --from=build /app/dist ...', 'Copies ONLY the compiled output into the final image'),
        MatchPair('final-base', 'FROM nginx:alpine (final stage)', 'A tiny production runtime with no build tools included'),
        MatchPair('expose', 'EXPOSE 80', 'Documents which port the container listens on'),
      ],
      explainOk:
          "Right — the build stage does the heavy lifting and gets thrown "
          "away; only its output crosses into the small, production-ready "
          "final image.",
    ),
  ),
  const Chapter(
    id: 44,
    title: 'Environment Configs & Secrets',
    avatar: '🔐',
    role: "Senior Engineer — refusing to hardcode a database password",
    bodyIntro:
        "The exact same container image runs in dev, staging, and production — "
        "but it needs different database URLs, API keys, and feature flags in "
        "each. Hardcoding any of that into the built app is a serious "
        "production and security mistake: a literal API key baked into source "
        "is BAD, while reading it at runtime with process.env.STRIPE_SECRET_KEY "
        "is GOOD. Non-sensitive per-environment values (a base URL, a feature "
        "flag) belong in environment variables or config files injected at "
        "deploy time. Sensitive values — API keys, database passwords, signing "
        "keys — belong in a dedicated secrets manager (like Vault, AWS Secrets "
        "Manager, or a Kubernetes Secret), never committed to git, never baked "
        "into a container image.\n\n"
        "Sort these values by where they actually belong.",
    calloutHints: [
      "A shockingly common real breach: a secret key committed to a public "
          "GitHub repo years ago, still valid, found by an automated scanner "
          "within minutes of the push. Rotating leaked secrets immediately is "
          "a genuine incident response skill, not an afterthought.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each value into where it should actually be stored.",
      bucketALabel: '⚙️ Plain env config (ok in a config file)',
      bucketBLabel: '🔐 Secrets manager (never in git, never in code)',
      items: [
        Sort2Item('apiurl', 'API_BASE_URL=https://api.example.com', true),
        Sort2Item('stripekey', 'STRIPE_SECRET_KEY', false),
        Sort2Item('flag', 'FEATURE_NEW_CHECKOUT=true', true),
        Sort2Item('dbpass', 'PRODUCTION_DATABASE_PASSWORD', false),
      ],
      explainOk:
          "Right — non-sensitive per-environment settings can live in plain "
          "config, but anything that grants access to money, data, or systems "
          "belongs in a real secrets manager.",
      explainBad:
          "Ask: would leaking this value let someone impersonate your app, "
          "drain an account, or read your database? If yes, it's a secret, "
          "not plain config.",
    ),
  ),
  const Chapter(
    id: 45,
    title: 'Horizontal Scaling of Stateless Servers',
    avatar: '🧬',
    role: 'Senior Engineer — cloning the server, not upgrading it',
    bodyIntro:
        "Traffic outgrew one server. There are two ways to respond: vertical "
        "scaling (a bigger, more powerful single machine) or horizontal scaling "
        "(many identical, smaller machines behind a load balancer). Production "
        "web systems almost always prefer horizontal scaling — it has no hard "
        "ceiling and survives a single machine dying. Horizontal scaling only "
        "works cleanly if each server is stateless — it must not keep anything "
        "in its own memory that the NEXT request depends on, because the load "
        "balancer might route that next request to a totally different server. "
        "Any request must be answerable by ANY server instance.\n\n"
        "Which of these server behaviors breaks stateless horizontal scaling?",
    calloutHints: [
      "This is why \"just add more servers\" fails for badly-designed apps: if "
          "server 2 stored a user's shopping cart in its local memory and the "
          "load balancer sends their next click to server 3, the cart appears "
          "to vanish.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A web app is deployed across 5 identical server instances behind a "
          "load balancer. Which behavior would break correctness under "
          "horizontal scaling?",
      options: [
        "Reading the user's session data from a shared Redis store on every request",
        "Storing the logged-in user's shopping cart in a local, in-memory JavaScript variable on whichever server happened to handle their first request",
        'Reading configuration from environment variables set identically on every instance',
        'Fetching product data from a shared database that every server instance can reach',
      ],
      answerIndex: 1,
      explainOk:
          "Right — in-memory state trapped on ONE server instance breaks the "
          "moment the load balancer routes a later request to a different "
          "instance. Shared stores (Redis, a DB) work everywhere; per-instance "
          "memory does not.",
      explainBad:
          "The problem is state that lives ONLY in one instance's memory — "
          "every other option here is either shared across all instances or "
          "identical on all of them, which is exactly what stateless scaling "
          "requires.",
    ),
  ),
  const Chapter(
    id: 46,
    title: 'Session Management at Scale',
    avatar: '🪪',
    role: "Senior Engineer — remembering who's logged in, across every server",
    bodyIntro:
        "A logged-in user needs the server to \"remember\" them across "
        "requests. At small scale, a common shortcut is sticky sessions: the "
        "load balancer always routes the same user back to the same server, "
        "which keeps their session in its local memory. It works — until that "
        "server restarts, deploys, or dies, silently logging out everyone stuck "
        "to it. Professional systems at scale instead externalize session state "
        "into a shared store, so ANY server can serve ANY user's request: "
        "Option A is a server-side session where a cookie holds only a session "
        "ID looked up in Redis on every request; Option B is a client-side "
        "signed JWT where the cookie/header holds a signed token containing the "
        "user's claims directly, so any server can verify the signature with "
        "no shared store lookup at all.\n\n"
        "Order the evolution of a session strategy as this app scales up.",
    calloutHints: [
      "The real tradeoff: server-side sessions can be revoked instantly (just "
          "delete the Redis key) but need a lookup on every request. JWTs skip "
          "the lookup but can't be revoked before they expire without extra "
          "machinery (a blocklist).",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these session strategies into the order a growing app "
          "typically adopts them.",
      items: [
        OrderItem('single', "One server keeps sessions in local memory (fine — there's only one server)"),
        OrderItem('sticky', "Add more servers; use sticky sessions to keep routing users to 'their' server"),
        OrderItem('outage', 'A server restart silently logs out everyone stuck to it — sticky sessions show their limit'),
        OrderItem('shared', 'Move session data into a shared store (e.g. Redis) so any server can serve any user'),
      ],
      explainOk:
          "Exactly the real progression — sticky sessions are a tempting "
          "shortcut that works only until a server disappears, which is what "
          "pushes teams to a real shared session store.",
      explainBad:
          "Sticky sessions come BEFORE their failure mode is discovered, and "
          "the shared store is the FIX adopted after that pain shows up — not "
          "a step skipped from the start.",
    ),
  ),
  const Chapter(
    id: 47,
    title: 'Caching Strategies with Redis',
    avatar: '⚡',
    role: 'Senior Engineer — sparing the database from every single read',
    bodyIntro:
        "Hitting the database for every single read doesn't scale — databases "
        "are usually the first bottleneck under real load. A fast in-memory "
        "store like Redis sits in front of (or alongside) the database as a "
        "cache for hot data. In getUserProfile(id), the app first checks "
        "redis.get(user:id) — a cache hit skips the DB entirely; on a miss it "
        "queries the database and then redis.set(user:id, user, ttl: 300) to "
        "write through. This pattern is called cache-aside: the app checks the "
        "cache first, falls back to the database on a miss, then populates the "
        "cache for next time. The TTL (time-to-live) bounds how long stale data "
        "can survive. The hardest part isn't caching — it's invalidation: when "
        "the user updates their profile, someone must delete or update user:id "
        "in Redis, or stale data lingers until the TTL expires.\n\n"
        "Order the cache-aside read/write cycle correctly.",
    calloutHints: [
      "There's an old programmer joke that's true in production: \"There are "
          "only two hard problems in computer science: cache invalidation, "
          "naming things, and off-by-one errors.\" Forgetting to invalidate a "
          "cache on write is one of the most common real production bugs.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these steps into the correct cache-aside order for a profile "
          "update followed by a read.",
      items: [
        OrderItem('update', 'User updates their profile — the database row changes'),
        OrderItem('invalidate', 'The app deletes/updates the stale user:id key in Redis'),
        OrderItem('read', 'A later request checks Redis first for user:id'),
        OrderItem('miss', 'Cache miss (it was just invalidated) — the app queries the database'),
        OrderItem('refill', 'The fresh result is written back into Redis for next time'),
      ],
      explainOk:
          "Exactly right — invalidating the stale cache entry right after the "
          "write is what prevents the NEXT read from serving outdated data.",
      explainBad:
          "If invalidation is skipped or happens too late, the very next read "
          "could return the stale cached value instead of correctly missing "
          "and re-fetching from the database.",
    ),
  ),
  const Chapter(
    id: 48,
    title: 'Rate Limiting APIs',
    avatar: '🚦',
    role: 'Senior Engineer — protecting the API from being loved to death',
    bodyIntro:
        "A public API without limits is one aggressive client (buggy, or "
        "malicious) away from an outage for everyone else. Rate limiting caps "
        "how many requests a client can make in a given window, and rejects "
        "the rest with an HTTP 429 Too Many Requests, along with headers like "
        "X-RateLimit-Limit, X-RateLimit-Remaining, and Retry-After. A common "
        "real implementation is the token bucket: each client has a bucket "
        "that refills at a steady rate (e.g. 10 tokens/second) up to a max "
        "capacity; every request costs one token, and an empty bucket means "
        "the request is rejected. This smooths out bursts while still allowing "
        "brief spikes up to the bucket's capacity.\n\n"
        "Match each rate-limiting concept to what it actually controls.",
    calloutHints: [
      "Rate limits are usually layered: a strict limit per API key for abuse "
          "prevention, a looser limit per IP for anonymous traffic, and "
          "sometimes a much higher limit for a trusted internal service — one "
          "size rarely fits every client.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a concept on the left, then click what it controls on the "
          "right.",
      pairs: [
        MatchPair('bucket-refill', 'Token bucket refill rate', 'The sustained request rate a client can maintain long-term'),
        MatchPair('bucket-capacity', 'Token bucket max capacity', 'How large a short burst of requests is allowed before limiting kicks in'),
        MatchPair('429', 'HTTP 429 response', 'Tells the client it has exceeded its limit'),
        MatchPair('retry-after', 'Retry-After header', 'Tells the client how long to wait before trying again'),
      ],
      explainOk:
          "Right — refill rate sets the long-term ceiling, capacity allows "
          "brief bursts, and 429 + Retry-After tell a well-behaved client "
          "exactly what happened and what to do next.",
    ),
  ),
  const Chapter(
    id: 49,
    title: 'OWASP Top 10 Deep Dive',
    avatar: '🛡️',
    role: 'Senior Engineer — running the industry-standard security checklist',
    bodyIntro:
        "The OWASP Top 10 is the industry's most cited list of the most "
        "critical web application security risks, refreshed periodically from "
        "real-world breach data. Professional teams treat it as a baseline "
        "checklist, not trivia: A01 Broken Access Control — users can act "
        "outside their intended permissions; A02 Cryptographic Failures — "
        "weak/missing encryption of sensitive data; A03 Injection — SQLi, XSS, "
        "command injection via untrusted input; A05 Security Misconfiguration "
        "— default creds, verbose errors, open admin panels; A07 "
        "Identification & Auth Failures — weak sessions, credential stuffing, "
        "no MFA. Notice how these map directly onto what you already know: A03 "
        "covers the XSS from Chapter XXIII and SQL injection from Database "
        "Bay; A07 covers weak auth choices from Chapter LI.\n\n"
        "Match each real bug report to the OWASP category it belongs to.",
    calloutHints: [
      "\"Broken Access Control\" has topped the list in recent years — more "
          "real breaches come from an API endpoint that forgot to check \"is "
          "this actually YOUR order?\" than from exotic cryptographic attacks.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a bug report on the left, then click its OWASP category on "
          "the right.",
      pairs: [
        MatchPair('idor', "GET /orders/1234 returns ANY user's order if you guess the ID", 'A01: Broken Access Control'),
        MatchPair('sqli', "A login form's password field is concatenated directly into a SQL query", 'A03: Injection'),
        MatchPair('plaintext', 'User passwords are stored in the database as plain, unhashed text', 'A02: Cryptographic Failures'),
        MatchPair('defaultcreds', 'The admin dashboard is still reachable with the default admin/admin login', 'A05: Security Misconfiguration'),
      ],
      explainOk:
          "Right — missing permission checks, raw SQL from user input, "
          "unhashed secrets, and forgotten defaults are textbook examples of "
          "each category.",
    ),
  ),
  const Chapter(
    id: 50,
    title: 'Defending Against CSRF, XSS & SQLi in Production',
    avatar: '🧯',
    role: 'Senior Engineer — patching three classic holes for real',
    bodyIntro:
        "Knowing an attack exists is different from defending against it in "
        "real, shipped code. Each of the \"big three\" has a concrete, "
        "standard production fix. XSS → escape/sanitize output, prefer "
        "textContent over innerHTML, set a strict Content-Security-Policy. "
        "CSRF → require a per-session CSRF token on state-changing requests, "
        "set cookies with SameSite=Strict or Lax. SQLi → ALWAYS use "
        "parameterized queries / prepared statements, NEVER string-concatenate "
        "user input into SQL — db.query(\"SELECT * FROM users WHERE email = ?\", "
        "[userEmail]) is safe, while concatenating userEmail directly into the "
        "query string is vulnerable. Note the pattern: in every case, the fix "
        "is to stop TRUSTING a raw string from the user to safely become code, "
        "a query, or a cross-site request.\n\n"
        "Match each vulnerability to its standard production-grade fix.",
    calloutHints: [
      "A parameterized query isn't just \"safer string concatenation\" — the "
          "query structure is sent to the database SEPARATELY from the "
          "values, so there is no way for a value to ever be reinterpreted as "
          "SQL syntax, no matter what it contains.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a vulnerability on the left, then click its standard fix on "
          "the right.",
      pairs: [
        MatchPair('xss-fix', 'XSS via unsanitized comments rendered as HTML', 'Escape output / use textContent + a strict CSP'),
        MatchPair('csrf-fix', 'CSRF via a hidden auto-submitting cross-site form', 'CSRF tokens + SameSite cookie attribute'),
        MatchPair('sqli-fix', 'SQL injection via string-concatenated user input', 'Parameterized queries / prepared statements'),
      ],
      explainOk:
          "Right — each attack has a specific, standard, well-tested defense; "
          "none of them are fixed by \"just being careful\" with string "
          "concatenation.",
    ),
  ),
  const Chapter(
    id: 51,
    title: 'Auth Tradeoffs: OAuth2 vs. JWT Sessions',
    avatar: '🎫',
    role: 'Senior Engineer — deciding how a user proves who they are',
    bodyIntro:
        "\"Authentication\" has real architectural tradeoffs, not just one "
        "right answer. Two patterns dominate production web systems. "
        "Server-side session: cookie holds an opaque session ID, server looks "
        "it up in a shared store each request — instantly revocable (delete "
        "the row) but needs a stateful lookup every request. Stateless JWT: "
        "cookie/header holds a signed token containing the user's claims — no "
        "lookup needed, any server verifies the signature alone, but hard to "
        "revoke before expiry. OAuth2 / OpenID Connect: a THIRD PARTY (Google, "
        "GitHub) authenticates the user and hands your app a token — users "
        "don't create/manage a new password, but your app now depends on that "
        "provider. Many real apps combine BOTH — OAuth2 to authenticate the "
        "user once, then issue their own short-lived JWT or session for "
        "subsequent requests.\n\n"
        "Which statement correctly captures a real tradeoff between these "
        "approaches?",
    calloutHints: [
      "The revocation gap is the real interview-worthy tradeoff: if a JWT is "
          "compromised, it stays valid until it expires — which is why "
          "production JWTs are usually short-lived (minutes) with a separate "
          "long-lived refresh token that CAN be revoked server-side.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Which of these is an accurate tradeoff between server-side "
          "sessions and stateless JWTs?",
      options: [
        'JWTs are always more secure than sessions in every way, with no downsides',
        'Server-side sessions can be revoked instantly by deleting server-side state; a JWT remains valid until it expires unless extra revocation machinery is built',
        'Server-side sessions require the client to store nothing at all',
        'JWTs eliminate the need for HTTPS entirely',
      ],
      answerIndex: 1,
      explainOk:
          "Right — this is the core, real tradeoff: JWTs skip a lookup at the "
          "cost of instant revocability. Neither approach is universally "
          "\"more secure\"; they trade different things.",
      explainBad:
          "The real tradeoff is about REVOCATION: sessions can be killed "
          "instantly server-side; a bare JWT cannot be un-issued before it "
          "expires without extra machinery like a refresh-token blocklist.",
    ),
  ),
  const Chapter(
    id: 52,
    title: 'Security Headers & Content Security Policy',
    avatar: '🧱',
    role: "Senior Engineer — locking down what the browser is even allowed to do",
    bodyIntro:
        "Beyond code-level fixes, production servers send security-hardening "
        "HTTP response headers that instruct the BROWSER itself to restrict "
        "dangerous behavior — a defense layer that works even if some other "
        "part of the app has a bug: Content-Security-Policy: default-src "
        "'self'; script-src 'self' cdn.example.com; Strict-Transport-Security: "
        "max-age=63072000; includeSubDomains; X-Content-Type-Options: nosniff; "
        "X-Frame-Options: DENY. A strict CSP tells the browser \"only run "
        "scripts from these exact sources\" — so even if an XSS payload "
        "somehow gets injected into the page, the browser will REFUSE to "
        "execute a <script> tag from an untrusted origin. HSTS forces the "
        "browser to always use HTTPS for this domain, even if a user types "
        "\"http://\" — closing a downgrade-attack window. X-Frame-Options: "
        "DENY stops the site from being embedded in a hidden iframe for "
        "clickjacking.\n\n"
        "Match each security header to the specific attack it blocks.",
    calloutHints: [
      "Defense in depth is the professional mindset here: sanitizing input "
          "AND setting a strict CSP together means a single missed "
          "sanitization bug doesn't automatically become a working exploit.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a header on the left, then click the attack it defends "
          "against on the right.",
      pairs: [
        MatchPair('csp', 'Content-Security-Policy', 'Scripts from untrusted origins refuse to run, even after an XSS injection'),
        MatchPair('hsts', 'Strict-Transport-Security', 'Forces HTTPS, closing a downgrade-to-HTTP attack window'),
        MatchPair('xfo', 'X-Frame-Options: DENY', 'Prevents the page from being embedded in a hidden clickjacking iframe'),
        MatchPair('xcto', 'X-Content-Type-Options: nosniff', "Stops the browser from guessing/misinterpreting a file's content type"),
      ],
      explainOk:
          "Right — each header is a targeted browser-enforced defense: CSP "
          "for script sources, HSTS for transport, X-Frame-Options for "
          "framing, nosniff for MIME confusion.",
    ),
  ),
  const Chapter(
    id: 53,
    title: 'SPA vs. SSR vs. SSG Tradeoffs',
    avatar: '⚖️',
    role: "Senior Engineer — choosing how the first byte of HTML gets built",
    bodyIntro:
        "\"How should this page render?\" is a real architectural decision "
        "with genuine tradeoffs, not a matter of taste. SPA (Single-Page App): "
        "browser downloads a near-empty HTML shell + JS bundle, JS builds the "
        "WHOLE page client-side. Fast subsequent navigation, but a blank "
        "screen until JS loads, and poor SEO unless extra work is done. SSR "
        "(Server-Side Rendering): the server renders full HTML for EVERY "
        "request, sent ready-to-paint. Fast first paint, great SEO, but the "
        "server does real work on every request. SSG (Static Site "
        "Generation): HTML is rendered once, at BUILD time, and served as "
        "plain static files from a CDN. Blazing fast and cheap to serve, but "
        "content only updates when you rebuild. Many production apps mix all "
        "three: a marketing site as SSG, a dashboard as an SPA, and a product "
        "page as SSR for SEO with dynamic pricing.\n\n"
        "Sort these real product requirements into the rendering strategy "
        "that fits best.",
    calloutHints: [
      "\"Hydration\" is the real-world seam between SSR and SPA: the server "
          "sends pre-rendered HTML for instant paint, then JavaScript "
          "\"hydrates\" it — attaching event listeners — so it becomes fully "
          "interactive.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each requirement into SSG/SSR (rendered ahead or per-request) "
          "vs. SPA (rendered in the browser).",
      bucketALabel: '🏗️ SSG/SSR (server renders HTML)',
      bucketBLabel: '💻 SPA (browser renders via JS)',
      items: [
        Sort2Item('blog', 'A marketing blog that rarely changes and needs strong SEO', true),
        Sort2Item('dashboard', 'An internal analytics dashboard, no SEO concern, heavy interactivity', false),
        Sort2Item('product', 'A product page needing SEO but showing live, per-user pricing', true),
        Sort2Item('editor', 'A rich drag-and-drop design tool used only after login', false),
      ],
      explainOk:
          "Right — SEO-sensitive, content-first pages favor server rendering "
          "(SSG/SSR); highly interactive, login-gated tools with no SEO need "
          "favor an SPA.",
      explainBad:
          "Ask: does a search engine need to read this content (favor "
          "SSR/SSG), or is this a private, interaction-heavy tool where SEO "
          "doesn't matter (favor SPA)?",
    ),
  ),
  const Chapter(
    id: 54,
    title: 'Microservices vs. Monolith',
    avatar: '🏛️',
    role: 'Senior Engineer — deciding how many deployable pieces this product is',
    bodyIntro:
        "A monolith ships the whole web product — UI backend, orders, "
        "payments, search — as one deployable unit, one codebase, one "
        "database. Microservices split those into independently deployable "
        "services, each owning its own data, talking over the network (often "
        "via REST or gRPC). Monolith: one deploy, one team can touch anything, "
        "simple local dev, but a bug in \"search\" can crash \"checkout\" too; "
        "scaling means scaling the WHOLE thing even if only one part is hot. "
        "Microservices: \"orders\" and \"payments\" scale, deploy, and fail "
        "independently; different teams own different services with clear "
        "boundaries, but now you have network calls, versioning, and "
        "distributed debugging where there used to be a single function call. "
        "The professional consensus: microservices solve ORGANIZATIONAL "
        "scaling more than raw technical scaling — a well-built monolith can "
        "serve enormous traffic.\n\n"
        "Which scenario is the strongest real argument FOR splitting out a "
        "microservice?",
    calloutHints: [
      "A famous industry pattern: many successful companies started as a "
          "monolith and split out services only once specific, painful "
          "bottlenecks actually showed up — not upfront, on a hunch.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A small startup with one team and one moderately-trafficked "
          "product is deciding on architecture. Which scenario is the "
          "STRONGEST real argument for splitting out a separate microservice "
          "right now?",
      options: [
        "It sounds more modern and impressive on the team's resume",
        'A brand-new image-processing feature needs a totally different runtime (GPU-heavy Python) and a wildly different scaling pattern than the rest of the app, and its own team will maintain it',
        "The team wants to feel like they're following the same architecture as very large tech companies",
        'The current monolith has fewer than 10,000 lines of code',
      ],
      answerIndex: 1,
      explainOk:
          "Right — a genuinely different runtime/scaling need with clear "
          "ownership is the real technical case for splitting a service; "
          "imitation and code size alone are not.",
      explainBad:
          "Splitting a service is justified by a REAL technical or "
          "organizational need (different scaling profile, different "
          "runtime, independent team ownership) — not by trend-following or "
          "an arbitrary code-size threshold.",
    ),
  ),
  const Chapter(
    id: 55,
    title: 'REST vs. GraphQL API Design',
    avatar: '🕸️',
    role: 'Senior Engineer — choosing how clients ask for data',
    bodyIntro:
        "REST models an API as fixed resources and endpoints. GraphQL flips "
        "that: the client sends a single query describing EXACTLY the fields "
        "it wants, across possibly many related resources, in one request. "
        "REST often needs multiple round trips or over-fetches: GET /users/7 "
        "returns the WHOLE user object even for unused fields, then GET "
        "/users/7/posts is a second round trip. GraphQL sends one request for "
        "the exact shape needed and returns only that. GraphQL's win is "
        "precise, single-request data fetching — great for complex UIs "
        "pulling from many related resources. Its cost: a more complex server "
        "(a resolver graph instead of simple routes), harder HTTP-level "
        "caching, and the risk of a client requesting an expensive, "
        "deeply-nested query that overloads the server.\n\n"
        "Which real scenario is the strongest argument for choosing GraphQL "
        "over REST?",
    calloutHints: [
      "REST's simplicity plays extremely well with the caching and CDN "
          "techniques from Level 11 — a GET to a stable URL is trivially "
          "cacheable. GraphQL needs deliberate extra engineering to get "
          "similar caching benefits.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Which scenario is the STRONGEST real argument for choosing "
          "GraphQL over a REST API?",
      options: [
        'The API only ever needs to serve one simple, stable resource with heavy CDN caching',
        'A mobile app on unreliable networks needs to render a complex screen pulling small slices of many related resources in exactly one request, minimizing round trips',
        'The team wants to avoid designing any resource model at all',
        'The API has no relationships between resources whatsoever',
      ],
      answerIndex: 1,
      explainOk:
          "Right — GraphQL's core strength is precise, single-request "
          "fetching across related data, which matters most on constrained "
          "networks with complex, varied UI needs.",
      explainBad:
          "GraphQL's real advantage is minimizing round trips for COMPLEX, "
          "RELATED data needs — a simple, cacheable, single-resource API is "
          "actually REST's strongest use case, not GraphQL's.",
    ),
  ),
  const Chapter(
    id: 56,
    title: 'Performance Budgets as an Architecture Constraint',
    avatar: '📊',
    role: 'Senior Engineer — treating page weight like a scarce resource',
    bodyIntro:
        "Every architectural decision so far — SSR vs. SPA, REST vs. GraphQL, "
        "lazy loading — has a real cost in bytes shipped and milliseconds to "
        "first paint. A performance budget makes that cost an explicit, "
        "enforced constraint, not an afterthought: a budget.json might set a "
        "script budget of 170KB gzip, a total budget of 400KB, and an "
        "interactive timing budget of 3000ms on a mid-tier phone. A "
        "performance budget in CI can FAIL a build the same way a failing "
        "test does — if a pull request adds a library that pushes the JS "
        "bundle over 170KB, the pipeline rejects it before it ever reaches "
        "production, forcing a conscious tradeoff decision instead of a slow, "
        "silent regression.\n\n"
        "Order the professional workflow for enforcing a performance budget.",
    calloutHints: [
      "This is where every earlier lesson becomes one connected system: a "
          "budget-busting decision shows up first as a CI failure, not as a "
          "support ticket three months later.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these into the order a team actually enforces a performance "
          "budget.",
      items: [
        OrderItem('set', 'Team sets explicit budgets (e.g. 170KB JS, 3s time-to-interactive)'),
        OrderItem('wire', 'CI pipeline measures real bundle size/timing on every pull request'),
        OrderItem('compare', 'The pipeline compares the measurement against the budget'),
        OrderItem('fail', 'If the budget is exceeded, the build fails, just like a failing test'),
        OrderItem('decide', 'The team makes a conscious tradeoff (trim the feature, or raise the budget deliberately)'),
      ],
      explainOk:
          "Exactly the professional loop — a budget is meaningless without "
          "automated measurement wired into CI, and failure should force a "
          "deliberate decision, not a silent override.",
      explainBad:
          "You need the budget defined and measured in CI BEFORE it can ever "
          "be compared or fail a build — and any decision to exceed it "
          "should happen deliberately, not automatically.",
    ),
  ),
  const Chapter(
    id: 57,
    title: 'Capstone: Design a Scalable Production Web App',
    avatar: '🧩',
    role: 'Principal Engineer — the whiteboard system design interview',
    bodyIntro:
        "This is the final gauntlet of Web Woods — the professional-engineer "
        "capstone. The scenario: design the architecture for a social app's "
        "\"feed\" feature that must handle millions of daily users, stay fast, "
        "and stay secure, pulling together EVERY level of this subject: CDN + "
        "caching for a fast worldwide feed, horizontal scaling with stateless "
        "servers for millions of concurrent users, a shared session store so "
        "sessions survive deploys, rate limiting to resist API abuse, "
        "OWASP-grade defenses and CSP against XSS/CSRF/injection, SSR for "
        "SEO on the initial feed render, and an enforced performance budget "
        "to keep the JS bundle lean. A principal engineer traces how these "
        "pieces interact: SSR means the server does real per-request work, "
        "which is exactly why it must run on stateless, horizontally-scaled "
        "instances behind a shared session store, with Redis caching hot feed "
        "data so the database isn't hit on every request, all behind rate "
        "limiting and strict security headers.\n\n"
        "Order the request lifecycle for this feed feature, end to end, in "
        "production.",
    calloutHints: [
      "This single feature touches deployment, scaling, security, AND "
          "architecture tradeoffs simultaneously — that overlap, not any one "
          "topic in isolation, is what a real senior/principal system design "
          "review actually tests.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these into the order a real request for the feed page "
          "actually flows through this architecture.",
      items: [
        OrderItem('cdnedge', 'Request hits the nearest CDN edge; static assets are served from cache'),
        OrderItem('lb', 'The dynamic feed request reaches the load balancer'),
        OrderItem('ratelimit', "The rate limiter checks the client hasn't exceeded its quota"),
        OrderItem('instance', 'A stateless server instance is picked; session is read from the shared store'),
        OrderItem('rediscache', 'The server checks Redis for cached feed data before querying the database'),
        OrderItem('ssr', 'The server renders the feed HTML (SSR) and returns it, secured by CSP headers'),
      ],
      explainOk:
          "This is the real production path: static assets never even reach "
          "your servers, dynamic requests are load-balanced and rate-limited "
          "BEFORE any expensive work, session/cache lookups happen before the "
          "database, and rendering happens last, wrapped in security "
          "headers.",
      explainBad:
          "Rate limiting and load balancing must happen BEFORE a server does "
          "any real work; cache lookups happen BEFORE hitting the database; "
          "rendering is the LAST step, not the first.",
    ),
  ),
  const Chapter(
    id: 58,
    title: 'Capstone: The Incident That Breaks Everything',
    avatar: '🚨',
    role: 'Principal Engineer — running an incident at 2 AM',
    bodyIntro:
        "Production incident, page one: the feed API is returning HTTP 500s "
        "for 40% of requests, and separately, a security researcher just "
        "reported that GET /api/feed/user/{id} returns ANY user's private "
        "posts if you change the ID in the URL. Two live problems, at once. "
        "The clue trail from logs: the error spike started 6 minutes after a "
        "deploy that added a new caching layer, the Redis connection pool "
        "shows \"pool exhausted\" errors right before each 500, the "
        "private-post leak is unrelated — it's a missing ownership check, not "
        "caching — and rolling back the deploy makes the 500s stop "
        "immediately. A principal engineer triages by SEVERITY and BLAST "
        "RADIUS, not discovery order: the data leak (Broken Access Control) "
        "exposes private user data RIGHT NOW to anyone who tries — that's the "
        "higher-severity issue even though the outage feels louder. The "
        "correct move is to mitigate BOTH in parallel: roll back the bad "
        "deploy to stop the outage, while immediately patching (or "
        "feature-flagging off) the leaking endpoint, because these are two "
        "independent root causes, not one.\n\n"
        "Order the correct incident response for these two simultaneous "
        "issues.",
    calloutHints: [
      "A dangerous mistake under pressure: assuming a scary-looking symptom "
          "(500 errors) and a scary-sounding report (a data leak) must share "
          "one root cause. Real incidents often stack coincidentally, and "
          "treating them as one problem delays fixing either.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these into the correct order a principal engineer would "
          "actually act, given both issues are live right now.",
      items: [
        OrderItem('triage', 'Confirm these are two independent root causes, not one shared bug'),
        OrderItem('leakoff', 'Immediately disable/feature-flag the leaking endpoint to stop the data exposure'),
        OrderItem('rollback', 'Roll back the bad deploy to stop the 500 errors from the exhausted Redis pool'),
        OrderItem('rootcause', 'Once stable, root-cause the pool exhaustion AND write the missing ownership check'),
        OrderItem('postmortem', 'Write a postmortem covering both issues and how to prevent each independently'),
      ],
      explainOk:
          "Exactly the professional move — confirm they're separate, stop "
          "the highest-severity harm (the active data leak) and the outage "
          "in parallel, THEN do the deeper fix and document it, instead of "
          "chasing one unified 'root cause' that doesn't exist.",
      explainBad:
          "Treating an active data leak and an unrelated outage as one "
          "problem, or fixing the deep root cause before stopping the ACTIVE "
          "harm, both delay protecting real users right now.",
    ),
  ),
  const Chapter(
    id: 59,
    title: 'Capstone: The Architecture Review Board',
    avatar: '🏢',
    role: 'Principal Engineer — defending a design in front of a review board',
    bodyIntro:
        "A team proposes: rewrite their monolithic, server-rendered checkout "
        "flow as a GraphQL-backed microservice architecture with a fully "
        "client-rendered SPA, because \"that's what modern companies use.\" "
        "You're on the review board. The actual current situation: one small "
        "team (4 engineers) owns checkout, checkout absolutely needs strong "
        "SEO for product/pricing pages, traffic is significant but comfortably "
        "served by the current monolith, there's no organizational pain — no "
        "team is blocked waiting on another team's deploys — and the stated "
        "goal is just \"modernize,\" with no specific user-facing problem "
        "cited. Weighed against everything you've learned: splitting into "
        "microservices with no organizational pain point adds network calls "
        "and operational cost for no real benefit; a fully client-rendered "
        "SPA actively HURTS the stated SEO requirement; GraphQL's "
        "precise-fetching advantage matters most for complex, varied clients "
        "— not proven need here. The proposal optimizes for looking modern, "
        "not for any concrete requirement in the room.\n\n"
        "Which single change to this proposal would you push back on "
        "hardest, and why?",
    calloutHints: [
      "A senior reviewer's real job isn't to reject new technology on "
          "principle — it's to demand that EVERY architectural change trace "
          "back to a specific requirement or pain point.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Given the stated requirements (strong SEO needed, small team, no "
          "organizational scaling pain, comfortable current load), which part "
          "of the proposal is the hardest to justify?",
      options: [
        'Using GraphQL instead of REST, since GraphQL is always strictly worse for every API',
        'Splitting into microservices with a small team and no organizational pain, AND moving checkout to a fully client-rendered SPA despite an explicit strong-SEO requirement',
        'Keeping the current performance budget unchanged',
        'Continuing to use HTTPS for the checkout flow',
      ],
      answerIndex: 1,
      explainOk:
          "Right — both the microservice split (no organizational pain to "
          "justify it) and the SPA choice (directly conflicting with a "
          "stated SEO requirement) lack a real requirement backing them; "
          "that's the actual finding, not a blanket rejection of any one "
          "technology.",
      explainBad:
          "The strongest critique targets choices that conflict with STATED "
          "requirements (SEO) or lack any real justification (splitting with "
          "no organizational pain) — not incidental, unrelated details like "
          "HTTPS or an unrelated budget.",
    ),
  ),
  const Chapter(
    id: 60,
    title: 'Capstone: The Final Systems Design Interview',
    avatar: '🎓',
    role: "Principal Engineer — the last gate before the Shard is yours",
    bodyIntro:
        "The final challenge of Web Woods, and the hardest one. A launch "
        "review requires BOTH conditions to hold before this new checkout "
        "architecture can ship: it must pass a full security review (no "
        "OWASP Top 10 category left unaddressed, CSP and auth reviewed) AND "
        "it must pass a scalability review (stateless servers, shared "
        "sessions, caching, and rate limiting all correctly wired, with a "
        "performance budget enforced in CI). Let A = the security review "
        "passing, and B = the scalability review passing. Just like the very "
        "last circuit of the foundation tier, this is a real AND-gate: a "
        "system that's perfectly secure but falls over under load isn't "
        "launch-ready, and a system that scales beautifully but leaks user "
        "data isn't launch-ready either. Production readiness is never just "
        "one axis.\n\n"
        "Close the final circuit of Web Woods: light up the launch LED.",
    calloutHints: [
      "You've now walked the full professional path: deployment pipelines, "
          "CDN caching, containers, secrets, horizontal scaling, session "
          "strategy, Redis caching, rate limiting, the OWASP Top 10, real "
          "attack defenses, auth tradeoffs, security headers, rendering "
          "strategy, service boundaries, API design, and performance "
          "budgets — the real, senior-engineer shape of production web work.",
    ],
    puzzleType: PuzzleType.circuit,
    circuit: CircuitPuzzle(
      instructions:
          "A = security review passes, B = scalability review passes. Flip "
          "both switches to 1 so the AND gate's launch LED lights up.",
      gate: CircuitGate.and,
      explainOk:
          "Both switches ON means both reviews pass — the AND gate lights "
          "up, and Web Woods' final Professional Shard is restored. You've "
          "completed the whole path, engineer.",
      explainBad:
          "An AND gate only lights up when BOTH inputs are true — a real "
          "production launch needs BOTH security AND scalability to pass, "
          "not just one.",
    ),
  ),
];
