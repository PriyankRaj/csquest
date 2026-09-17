import '../models/pq_models.dart';

/// Ported from process-quest/subjects/ml.js — "Machine Learning" / Learning
/// Lagoon, all 60 chapters (Levels 1-15), real content trimmed of HTML markup.
final mlChapters = <Chapter>[
  const Chapter(
    id: 1,
    title: 'Learning From Examples',
    avatar: '🐣',
    role: 'Narrator — splashing into Learning Lagoon',
    bodyIntro:
        "🌊 Splash! I rolled right into Learning Lagoon, and it's full of computers "
        "that learn things — instead of someone writing down every single rule "
        "for them.\n\n📏 Normally, if you want a computer to do something, you "
        "write step-by-step instructions. But some jobs are too tricky for exact "
        "rules. Like: \"is this a photo of a 🐱 cat or a 🐶 dog?\" Nobody can "
        "write a perfect rule for that!\n\nSo instead, we show the computer lots "
        "and lots of examples — say 🐱 100 cat photos and 🐶 100 dog photos — "
        "until it starts noticing patterns on its own, like \"cats usually have "
        "pointy ears 🔺\" or \"dogs have longer noses 👃.\" This is called Machine "
        "Learning (ML): teaching by example, not by rule.\n\n🆕 Once it has "
        "learned the pattern, it can guess correctly on a brand new photo it has "
        "never seen before. That's the whole magic trick! ✨",
    calloutHints: [
      "🚲 Think of it like learning to ride a bike. Nobody gave you an exact "
          "rulebook — you practiced again and again until your brain figured out "
          "the pattern of balance.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "🤔 Which of these jobs is the BEST fit for Machine Learning instead "
          "of hand-written rules?",
      options: [
        '➕ Adding two numbers together',
        '🐱🐶 Guessing whether a photo shows a cat or a dog',
        '🔑 Checking if a password is at least 8 characters long',
        '💡 Turning a light bulb on when a button is pressed',
      ],
      answerIndex: 1,
      explainOk:
          "Yes! 🎉 Nobody can write one perfect rule for 'catness' — but a "
          "computer can learn the pattern from thousands of example photos.",
      explainBad:
          "Think about which task is too fuzzy for a simple exact rule. Adding "
          "numbers, checking password length, and pressing a button all have "
          "clear, exact rules already — no learning needed.",
    ),
  ),
  const Chapter(
    id: 2,
    title: 'Flashcards for Computers',
    avatar: '🗂️',
    role: 'Narrator — practicing with flashcards',
    bodyIntro:
        "🗂️ To teach a computer, I need training data — that's just a fancy "
        "name for \"a big pile of examples.\" Each example also needs a label "
        "🏷️: the correct answer, so the computer knows what it should have "
        "guessed.\n\n🎴 It's exactly like flashcards! Say I hand the computer "
        "just 4 flashcards:\n\n🐱 Photo #1 → labeled \"cat\"\n🐱 Photo #2 → "
        "labeled \"cat\"\n🐶 Photo #3 → labeled \"dog\"\n🐶 Photo #4 → labeled "
        "\"dog\"\n\n👀 One side shows a picture (the example), and the back "
        "tells you the answer (the label). The computer looks at thousands of "
        "these flashcards, checks its guess against the label, and slowly "
        "adjusts itself to get better and better. 📈\n\n🪄 See those dots "
        "wiggling into place? That wobbly line is the computer slowly adjusting "
        "itself so it fits the examples as closely as it can. The more good "
        "flashcards (training data) I give it, the smarter its guesses become.",
    calloutHints: [
      "🗑️ Garbage in, garbage out: if your flashcards are wrong or messy, the "
          "computer will learn the WRONG pattern. Good training data matters "
          "more than almost anything else!",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a description on the left, then click the word it matches on "
          "the right.",
      pairs: [
        MatchPair('pile', '📚 A big pile of examples used to teach the computer',
            'Training data'),
        MatchPair('answer',
            '🏷️ The correct answer written on the back of the flashcard', 'Label'),
      ],
      explainOk:
          "Exactly — 🎉 training data is the pile of examples, and each one "
          "comes with a label telling the computer the right answer.",
    ),
  ),
  const Chapter(
    id: 3,
    title: 'Memorizing vs. Understanding',
    avatar: '📖',
    role: 'Narrator — cramming for a test',
    bodyIntro:
        "📖 Here's a trap I almost fell into. Imagine a kid who memorizes the "
        "exact answers to 🔢 20 practice math questions, word for word — but "
        "doesn't actually understand HOW to do the math. Give them a 21st "
        "question that looks a little different, and they're stuck! 😵\n\n🤖 "
        "Computers can make the exact same mistake. It's called overfitting: "
        "the computer memorizes its training examples so closely — even weird "
        "little mistakes or oddities in them — that it forgets to learn the "
        "general pattern. It looks perfect on the practice flashcards, but "
        "fails on brand new ones.\n\n✅ The fix is to always test the computer "
        "on examples it has never seen during training — a \"pop quiz\" set "
        "📝, usually called test data. If it does great on practice but badly "
        "on the pop quiz, it overfit.",
    calloutHints: [
      "🧠 Good learning = understanding the pattern well enough to handle NEW "
          "situations, not just repeating memorized answers.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "📊 A computer gets 100% correct on its training flashcards, but "
          "only 40% correct on brand new photos it never studied. What most "
          "likely happened?",
      options: [
        '🌟 It learned the general pattern perfectly',
        '🗑️ It overfit — it memorized the training examples instead of '
            'learning the real pattern',
        '🔌 The computer is broken and needs to be restarted',
        '🖥️ It needs a bigger screen to see the photos better',
      ],
      answerIndex: 1,
      explainOk:
          "Right! 🎯 Perfect score on practice but a bad score on new examples "
          "is the classic sign of overfitting — memorizing instead of truly "
          "understanding.",
      explainBad:
          "A huge gap between 'perfect on practice' and 'bad on brand new "
          "examples' is the telltale sign of overfitting — the computer "
          "memorized instead of learning the pattern.",
    ),
  ),
  const Chapter(
    id: 4,
    title: 'Sorting Buckets vs. Guessing Numbers',
    avatar: '🎯',
    role: 'Narrator — two kinds of guesses',
    bodyIntro:
        "🎯 Machine Learning guesses come in two main flavors, and it's "
        "important to know which one you're doing!\n\n🗂️ Classification — "
        "sorting something into one of a few buckets. \"Is this a 🐱 cat or a "
        "🐶 dog?\" \"Is this email 🚫 spam or ✅ not spam?\" The answer is "
        "always a category, a label, a bucket.\n\n📈 Regression — guessing an "
        "actual number. \"How 🌱 tall will this plant be in one week?\" \"What "
        "will the 🌡️ temperature be tomorrow?\" The answer is a number that "
        "can be almost anything.\n\n💡 A good way to remember: if the answer "
        "is a word or category 🏷️, it's classification. If the answer is a "
        "number that can vary smoothly 🔢, it's regression.\n\n🧩 Sort these "
        "questions into the right bucket.",
    calloutHints: [
      "🧠 Same computer brain, same idea of learning from examples — just a "
          "different shape of question being asked at the end!",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Drag these four questions into order so that the two "
          "CLASSIFICATION questions come first, followed by the two "
          "REGRESSION questions.",
      items: [
        OrderItem('spam', '🚫 Is this email spam or not spam? (classification)'),
        OrderItem('animal',
            '🐱🐶🐦 Is this a picture of a cat, dog, or bird? (classification)'),
        OrderItem('price', '🏠 What price will this house sell for? (regression)'),
        OrderItem('temp', "🌡️ What will tomorrow's temperature be? (regression)"),
      ],
      explainOk:
          "Exactly — spam-or-not and cat-vs-dog-vs-bird are both category "
          "buckets (classification), while house price and temperature are "
          "both numbers that can be almost anything (regression). 🎉",
      explainBad:
          "Sort by the SHAPE of the answer: a category/bucket answer (spam vs "
          "not, or which animal) is classification and always comes first; a "
          "number answer (a price, a temperature) is regression and comes "
          "second.",
    ),
  ),
  const Chapter(
    id: 5,
    title: 'Supervised Learning: An Answer Key',
    avatar: '🧑‍🏫',
    role: 'Narrator — grading with an answer key',
    bodyIntro:
        "Let's zoom in on the loop from Level 1. When every training example "
        "comes with a correct label, we call it supervised learning — "
        "\"supervised\" because a teacher (the label) is watching over every "
        "guess.\n\nThe loop looks like this: the model sees an input, makes a "
        "guess, we compare that guess to the label (the answer key), and if "
        "it's wrong, the model nudges itself to get closer next time. Repeat "
        "thousands of times.",
    calloutHints: [
      "Almost everything you've learned so far — cat-vs-dog, spam-vs-not, the "
          "line of best fit — has been supervised learning. It's the most "
          "common kind of ML in the real world.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a term on the left, then click its meaning on the right.",
      pairs: [
        MatchPair('sup', 'Supervised learning',
            'Training with labeled examples (an answer key)'),
        MatchPair('label2', 'Label', 'The correct answer attached to an example'),
        MatchPair('adjust', 'Adjust & retry',
            "Nudging the model closer when it's wrong"),
      ],
      explainOk:
          "Correct — supervised learning always has an answer key guiding "
          "every guess.",
    ),
  ),
  const Chapter(
    id: 6,
    title: 'Unsupervised Learning: No Answer Key',
    avatar: '🔍',
    role: 'Narrator — exploring without a teacher',
    bodyIntro:
        "Now flip it: what if nobody labels anything? That's unsupervised "
        "learning — the model only sees raw examples with no \"correct "
        "answer\" attached, and has to find structure on its own.\n\nThe most "
        "common trick is clustering: grouping similar things together just "
        "because they LOOK similar in the data, without ever being told what "
        "the groups should be called.",
    calloutHints: [
      "Real use: a store doesn't know your \"customer type\" label, but "
          "clustering can group shoppers by behavior — \"bulk buyers,\" "
          "\"weekend browsers\" — automatically.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "Which of these is an UNSUPERVISED learning task?",
      options: [
        'Predicting house price from labeled sale prices',
        'Grouping thousands of customers into similar-behavior clusters with '
            'no predefined groups',
        'Classifying emails as spam using a labeled training set',
        "Predicting tomorrow's temperature from labeled historical weather "
            'data',
      ],
      answerIndex: 1,
      explainOk:
          "Right — there's no answer key telling the model what the customer "
          "groups should be; it discovers them itself.",
      explainBad:
          "Look for the option with NO labels at all — the other three all "
          "have a labeled correct answer to learn from.",
    ),
  ),
  const Chapter(
    id: 7,
    title: 'Clustering Fruit by Feel',
    avatar: '🍉',
    role: 'Narrator — sorting a fruit basket',
    bodyIntro:
        "Picture dumping a mixed fruit basket onto a table and plotting each "
        "fruit by weight and sweetness. Nobody labeled which dot is which "
        "fruit — but when you look at the scatter, two natural blobs jump "
        "out: small-and-tart fruit in one corner, big-and-sweet fruit in "
        "another.\n\nA clustering algorithm does exactly that automatically — "
        "it finds the centers of the blobs and assigns every point to its "
        "nearest blob.",
    calloutHints: [
      "This is the same idea behind \"customers who bought this also bought "
          "that\" — grouping by similarity, not by a label anyone typed in.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each fruit into the cluster it naturally belongs with, based "
          "on size and sweetness.",
      bucketALabel: '🍊 Small & Tart Cluster',
      bucketBLabel: '🍉 Big & Sweet Cluster',
      items: [
        Sort2Item('orange', '🍊 Orange — small, a little tart', true),
        Sort2Item('lime', '🍋 Lime — small, tart', true),
        Sort2Item('melon', '🍈 Melon — big, sweet', false),
        Sort2Item('watermelon', '🍉 Watermelon — big, sweet', false),
      ],
      explainOk:
          "Exactly — no one told the algorithm the labels; it just grouped by "
          "how similar the fruit are.",
      explainBad:
          "Group by feel: small+tart fruit belong together, big+sweet fruit "
          "belong together — that's clustering by similarity.",
    ),
  ),
  const Chapter(
    id: 8,
    title: 'Supervised or Unsupervised?',
    avatar: '🧩',
    role: 'Narrator — a quick sorting drill',
    bodyIntro:
        "The whole decision boils down to one question: do you have labels? "
        "If yes, it's supervised. If no, it's unsupervised — the model has "
        "to find its own structure.",
    calloutHints: [
      "Real teams often start unsupervised (explore the data, find groups) "
          "and THEN collect labels for supervised learning once they know "
          "what to predict.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each scenario into Supervised or Unsupervised.",
      bucketALabel: '🏷️ Supervised (has labels)',
      bucketBLabel: '🔍 Unsupervised (no labels)',
      items: [
        Sort2Item(
            'spamlabel', 'Emails already marked spam / not-spam by users', true),
        Sort2Item('grouping',
            'Grouping songs by audio similarity with no genre tags', false),
        Sort2Item('pricepred',
            'Predicting house price from past sales WITH known prices', true),
        Sort2Item('anomalyless',
            "Finding unusual server logs with no 'normal/unusual' tags given",
            false),
      ],
      explainOk:
          "All correct — labeled answer keys mean supervised; raw, untagged "
          "data means unsupervised.",
      explainBad:
          "Check each one for a labeled correct answer. If it has one, it's "
          "supervised. If it's just raw data with no tags, it's "
          "unsupervised.",
    ),
  ),
  const Chapter(
    id: 9,
    title: 'The Line of Best Fit',
    avatar: '📏',
    role: 'Narrator — drawing through the dots',
    bodyIntro:
        "Time to teach a computer to draw a straight line through scattered "
        "data — this is linear regression. Every dot is one training example "
        "(x, y). We want ONE line, y = slope·x + intercept, that sits as "
        "close as possible to ALL the dots at once.\n\nThe slope tells you "
        "how steeply y rises as x increases; the intercept tells you where "
        "the line crosses when x = 0.",
    calloutHints: [
      "This is the simplest possible ML model — and it's still used "
          "everywhere, from predicting sales to estimating delivery times, "
          "because it's fast and easy to explain.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question: "In linear regression, what does the fitted line represent?",
      options: [
        'The single training example with the highest y value',
        'A line chosen to sit as close as possible to ALL the training points '
            'at once',
        "A random guess that's redrawn every time you ask",
        'The exact path connecting every dot in order',
      ],
      answerIndex: 1,
      explainOk:
          "Right — it's the best overall compromise line, not a line through "
          "any one point or a connect-the-dots path.",
      explainBad:
          "The line isn't connecting dots in order or picking one favorite "
          "point — it's the single best compromise across every point.",
    ),
  ),
  const Chapter(
    id: 10,
    title: 'The Cost Function: How Wrong Is It?',
    avatar: '📐',
    role: 'Narrator — measuring the gaps',
    bodyIntro:
        "How do we know if a line is \"good\"? We measure the vertical gap "
        "between each dot and the line — that gap is the error for that "
        "point. The cost function squares every error and adds them all "
        "up.\n\nWhy square them? So negative and positive errors don't "
        "cancel out, and big mistakes get punished much more than small "
        "ones.",
    calloutHints: [
      "Training a model is really just: try a line, compute the cost, try a "
          "slightly different line, see if the cost went down. Repeat until "
          "the cost stops improving.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A line has huge dashed gaps to every dot. Another line has tiny "
          "gaps to every dot. Which has the LOWER cost?",
      options: [
        'The line with huge gaps — bigger is better',
        'The line with tiny gaps — smaller total squared error means lower '
            'cost',
        'They always have the same cost',
        'Cost only depends on the slope, not the gaps',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — smaller gaps mean smaller squared errors, which means a "
          "lower (better) cost.",
      explainBad:
          "Cost = sum of squared gaps between the line and the dots. Smaller "
          "gaps always mean lower cost.",
    ),
  ),
  const Chapter(
    id: 11,
    title: 'Gradient Descent: Walking Downhill',
    avatar: '⛰️',
    role: 'Narrator — rolling downhill toward the minimum',
    bodyIntro:
        "Now the clever part: how does the model FIND the best line without "
        "trying every possible line? It uses gradient descent — imagine the "
        "cost function as a bowl-shaped valley. The model starts somewhere "
        "on the slope and takes small steps in the downhill direction, over "
        "and over, until it settles at the bottom (the lowest cost).",
    calloutHints: [
      "Every \"step\" nudges the model's numbers (its weights) a little bit "
          "toward whatever direction reduces the error the most, right now.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps gradient descent actually follows.",
      items: [
        OrderItem('start', 'Start with a random guess for the line'),
        OrderItem('measure', 'Measure the current cost (how wrong the line is)'),
        OrderItem('direction', 'Figure out which direction reduces cost the most'),
        OrderItem('step', 'Take a small step in that downhill direction'),
        OrderItem('repeat', 'Repeat until the cost stops getting lower'),
      ],
      explainOk:
          "That's gradient descent — guess, measure, find the downhill "
          "direction, step, and repeat until it settles.",
      explainBad:
          "You must measure the cost BEFORE finding a direction, and a "
          "direction BEFORE stepping. Repeating always comes last.",
    ),
  ),
  const Chapter(
    id: 12,
    title: 'Reading a Prediction Off the Line',
    avatar: '🔮',
    role: 'Narrator — using the line to predict',
    bodyIntro:
        "Once the line is trained, using it is easy: plug in a new x value, "
        "follow the line, and read off the predicted y. No more training "
        "needed — this is called inference, using the model you already "
        "trained.",
    calloutHints: [
      "Training happens once (or occasionally); inference (making "
          "predictions) happens constantly, every time a real user asks the "
          "model something.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Using an already-trained line to predict a brand new y from a new "
          "x is called...",
      options: ['Training', 'Inference (prediction)', 'Overfitting', 'Clustering'],
      answerIndex: 1,
      explainOk:
          "Right — inference is using a trained model to make a prediction on "
          "new input.",
      explainBad:
          "Training is fitting the line in the first place. Using that "
          "finished line on a new input is called inference.",
    ),
  ),
  const Chapter(
    id: 13,
    title: 'Decision Trees: Twenty Questions',
    avatar: '🌳',
    role: 'Narrator — asking one question at a time',
    bodyIntro:
        "A decision tree classifies things by asking a chain of yes/no "
        "questions, branching left or right each time, until it lands on an "
        "answer at a \"leaf.\" It's exactly like playing 20 Questions.\n\nThe "
        "trick is choosing GOOD questions early — ones that split the data "
        "into the most useful groups — so you need as few questions as "
        "possible.",
    calloutHints: [
      "Decision trees are popular because a human can literally read the "
          "questions and understand exactly why the model made its decision "
          "— many other models are a black box.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a path on the left, then click where it lands on the right.",
      pairs: [
        MatchPair('hotdry', 'Temp > 20°C? YES → Is it raining? NO', 'Sunny day'),
        MatchPair(
            'hotrain', 'Temp > 20°C? YES → Is it raining? YES', 'Bring umbrella'),
        MatchPair('cold', 'Temp > 20°C? NO', 'Jacket weather'),
      ],
      explainOk:
          "You just traced a decision tree exactly the way the model does — "
          "one branch at a time.",
    ),
  ),
  const Chapter(
    id: 14,
    title: 'k-Nearest Neighbors',
    avatar: '🧭',
    role: 'Narrator — asking the neighbors',
    bodyIntro:
        "k-Nearest Neighbors (k-NN) classifies a new point by looking at its "
        "k closest neighbors in the training data and taking a majority "
        "vote. If most of its 3 closest neighbors are labeled \"cat,\" the "
        "new point gets labeled \"cat\" too.\n\nThere's no real \"training\" "
        "step — k-NN just remembers all the data and compares distances "
        "whenever it needs to predict.",
    calloutHints: [
      "Choosing k matters: too small (like k=1) and one weird neighbor can "
          "throw off the vote; too big and you start averaging in neighbors "
          "that aren't really similar anymore.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "With k=3, a new point's three closest neighbors are labeled: cat, "
          "cat, dog. What does k-NN predict?",
      options: [
        'Dog, because it appeared',
        'Cat, because 2 of the 3 nearest neighbors are cats (majority vote)',
        "It can't decide",
        'Whichever label was seen first in training',
      ],
      answerIndex: 1,
      explainOk:
          "Right — k-NN takes a majority vote among the k nearest neighbors: "
          "2 cats beat 1 dog.",
      explainBad:
          "k-NN predicts whichever label is the MAJORITY among the k nearest "
          "neighbors — 2 out of 3 cats wins.",
    ),
  ),
  const Chapter(
    id: 15,
    title: 'Logistic Regression: A Probability',
    avatar: '📊',
    role: 'Narrator — squeezing a line into a curve',
    bodyIntro:
        "Despite the name, logistic regression is used for classification, "
        "not number-guessing. It takes a straight-line-style score and "
        "squishes it through an S-shaped curve so the output always lands "
        "between 0 and 1 — a probability.\n\nIf the probability is above "
        "0.5, predict \"yes\"; otherwise predict \"no.\"",
    calloutHints: [
      "This gives you more than just an answer — it tells you HOW CONFIDENT "
          "the model is. A 0.51 and a 0.99 both predict \"yes,\" but they "
          "mean very different things.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Logistic regression outputs 0.92 for 'is this email spam?'. What "
          "should the model predict?",
      options: [
        'Not spam, because 0.92 is a weird number',
        'Spam — 0.92 is well above the 0.5 threshold',
        'It must ask a human',
        'The email is 92% deleted',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — any probability above 0.5 crosses the threshold into a "
          "'spam' prediction, and 0.92 is a very confident one.",
      explainBad:
          "Compare the probability to the 0.5 threshold. 0.92 is well above "
          "it, so the model predicts spam — and confidently so.",
    ),
  ),
  const Chapter(
    id: 16,
    title: 'Picking the Right Classifier',
    avatar: '🧰',
    role: 'Narrator — choosing the right tool',
    bodyIntro:
        "Three classifiers, three different strengths. Decision trees "
        "explain themselves clearly. k-NN needs no training, just data and "
        "a distance measure. Logistic regression gives fast, "
        "well-calibrated probabilities.",
    calloutHints: [
      "There's rarely one \"best\" algorithm — the right choice depends on "
          "whether you need explainability, speed, a probability score, or "
          "how much data you have.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a business need on the left, then click the best-fit "
          "algorithm on the right.",
      pairs: [
        MatchPair('explain',
            'A regulator needs to see exactly why we rejected a loan',
            'Decision Tree'),
        MatchPair('small', 'We have very little data and want something simple',
            'k-Nearest Neighbors'),
        MatchPair('prob', 'We need a calibrated probability of fraud, fast',
            'Logistic Regression'),
      ],
      explainOk:
          "Exactly — explainability → tree, tiny simple dataset → k-NN, fast "
          "probability → logistic regression.",
    ),
  ),
  const Chapter(
    id: 17,
    title: 'Meet the Neuron',
    avatar: '⚡',
    role: 'Narrator — inside a single neuron',
    bodyIntro:
        "A neural network is built from tiny units called neurons. Each "
        "neuron takes several inputs (x1, x2, x3...), multiplies each one by "
        "its own weight (w1, w2, w3...), adds them all up, and passes that "
        "sum through an activation function to produce one output.",
    calloutHints: [
      "Weights are exactly what gets adjusted during training — learning IS "
          "finding the right weights so the neuron's output matches "
          "reality.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a part on the left, then click its job on the right.",
      pairs: [
        MatchPair('weight', 'Weight',
            'A number that scales how much one input matters'),
        MatchPair('sum', 'Weighted sum (Σ)', 'Adds up every input times its weight'),
        MatchPair('activation', 'Activation function',
            "Turns the sum into the neuron's final output"),
      ],
      explainOk:
          "Correct — inputs get scaled by weights, summed up, then passed "
          "through an activation function.",
    ),
  ),
  const Chapter(
    id: 18,
    title: 'Stacking Layers',
    avatar: '🏗️',
    role: 'Narrator — building upward',
    bodyIntro:
        "One neuron alone can't learn much. Stack many neurons into a "
        "layer, and stack several layers one after another — an input "
        "layer, one or more hidden layers, and an output layer — and you "
        "get a full neural network.",
    calloutHints: [
      "Each hidden layer can learn a slightly more abstract feature than the "
          "last — early layers might detect edges in an image, later layers "
          "might detect whole shapes.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In a neural network, which layer's neurons directly receive the "
          "raw input data?",
      options: [
        'The output layer',
        'A randomly chosen hidden layer',
        'The input layer',
        'Whichever layer has the most neurons',
      ],
      answerIndex: 2,
      explainOk:
          "Right — the input layer is always first, taking in the raw data "
          "before anything else happens.",
      explainBad:
          "The INPUT layer always comes first and receives the raw data "
          "directly; hidden layers process it afterward, and output comes "
          "last.",
    ),
  ),
  const Chapter(
    id: 19,
    title: 'Activation Functions: Adding Bend',
    avatar: '〜',
    role: 'Narrator — comparing three curves',
    bodyIntro:
        "Without an activation function, stacking layers would just be one "
        "big straight-line calculation — no better than a single line. "
        "Activation functions add a \"bend,\" letting the network represent "
        "curved, complex patterns.\n\nStep — either fully off or fully on, "
        "an old classic\n\nSigmoid — smooth S-curve, squeezes to 0-1\n\nReLU "
        "— flat at zero, then rises in a straight line; simple and very "
        "popular today",
    calloutHints: [
      "Modern deep networks mostly use ReLU in hidden layers because it's "
          "cheap to compute and trains faster than sigmoid in deep stacks.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a function on the left, then click its description on the "
          "right.",
      pairs: [
        MatchPair('step2', 'Step', 'Sharp on/off switch'),
        MatchPair('sigmoid2', 'Sigmoid', 'Smooth S-curve between 0 and 1'),
        MatchPair('relu2', 'ReLU', 'Flat at zero, then rises like a ramp'),
      ],
      explainOk:
          "Correct — step is a hard switch, sigmoid is a smooth S, ReLU is a "
          "flat-then-ramp.",
    ),
  ),
  const Chapter(
    id: 20,
    title: 'Why Deeper Nets Learn More',
    avatar: '🧠',
    role: 'Narrator — going deeper',
    bodyIntro:
        "With enough neurons and layers, a neural network can approximate "
        "extremely complex, wiggly patterns — far beyond a single straight "
        "line. Each extra layer gives the network more \"bends\" it's "
        "allowed to use.",
    calloutHints: [
      "This power is also a risk — a network with too much capacity for too "
          "little data is exactly the overfitting trap you already learned "
          "about back in Level 1 and 8.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A very deep network trained on only 20 examples performs badly on "
          "new data. What's the most likely cause?",
      options: [
        'The network is too simple to learn anything',
        'The network overfit — too much capacity for too little data',
        'Neural networks can never work with images',
        'The activation function was drawn incorrectly',
      ],
      answerIndex: 1,
      explainOk:
          "Right — huge capacity plus tiny data is a classic recipe for "
          "overfitting.",
      explainBad:
          "A deep network with very little training data has way more "
          "capacity than it needs — that mismatch is what causes "
          "overfitting.",
    ),
  ),
  const Chapter(
    id: 21,
    title: 'The Forward Pass',
    avatar: '➡️',
    role: 'Narrator — following data through the network',
    bodyIntro:
        "Every prediction starts with a forward pass: input data flows "
        "through the network layer by layer — weighted sum, then "
        "activation, then on to the next layer — until it reaches the "
        "output as a final prediction.",
    calloutHints: [
      "The forward pass is exactly what happens every time you use a "
          "trained model (inference) — training just repeats it many times "
          "while ALSO correcting the weights afterward.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps of one forward pass through a neuron.",
      items: [
        OrderItem('in2', 'Receive the input values'),
        OrderItem('sum2', 'Multiply each input by its weight and sum them'),
        OrderItem('act2', 'Pass the sum through the activation function'),
        OrderItem('out2',
            'Send the result on as the prediction (or to the next layer)'),
      ],
      explainOk:
          "That's the forward pass — input, weighted sum, activation, "
          "output.",
      explainBad:
          "The weighted sum must happen before activation, and activation "
          "before the result is passed onward.",
    ),
  ),
  const Chapter(
    id: 22,
    title: 'The Backward Pass: Backpropagation',
    avatar: '⬅️',
    role: 'Narrator — tracing the blame backward',
    bodyIntro:
        "After a forward pass, we know the error (prediction minus true "
        "label). Backpropagation traces that error BACKWARD through the "
        "network, figuring out how much each individual weight contributed "
        "to the mistake, so gradient descent knows exactly how to adjust "
        "each one.",
    calloutHints: [
      "This is the \"blame assignment\" step — instead of guessing which of "
          "thousands of weights caused the error, backprop calculates each "
          "weight's exact share of the blame.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the steps of backpropagation after a forward pass.",
      items: [
        OrderItem('err', 'Compute the error: prediction minus true label'),
        OrderItem(
            'blame', 'Trace backward, assigning each weight its share of the blame'),
        OrderItem('grad',
            'Compute the gradient (direction to reduce error) for each weight'),
        OrderItem('update', 'Update every weight a small step in that direction'),
      ],
      explainOk:
          "Exactly — error first, then blame flows backward, then "
          "gradients, then the weight update.",
      explainBad:
          "You need the error before you can assign blame, and blame before "
          "computing gradients and updating weights.",
    ),
  ),
  const Chapter(
    id: 23,
    title: 'Learning Rate: Step Size Matters',
    avatar: '🎛️',
    role: 'Narrator — turning the dial',
    bodyIntro:
        "The learning rate controls how big each gradient descent step is. "
        "Too small, and training crawls along, taking forever to reach the "
        "bottom. Too big, and the steps overshoot the minimum entirely, "
        "bouncing back and forth without ever settling.",
    calloutHints: [
      "Picking a good learning rate is one of the most important — and most "
          "finicky — decisions in training any model. Many teams try "
          "several and see which converges best.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "During training, the loss jumps wildly up and down every step "
          "and never settles. What's the most likely fix?",
      options: [
        'Increase the learning rate even more',
        "Decrease the learning rate so steps don't overshoot",
        'Add more layers to the network',
        'Remove all the training data',
      ],
      answerIndex: 1,
      explainOk:
          "Right — wild, non-settling oscillation is the classic symptom of "
          "too-large a learning rate; shrinking it usually fixes it.",
      explainBad:
          "Bouncing wildly without settling means the steps are too big — "
          "that calls for a SMALLER learning rate, not a bigger one.",
    ),
  ),
  const Chapter(
    id: 24,
    title: 'Epochs & Batches',
    avatar: '🔁',
    role: 'Narrator — going through the deck again',
    bodyIntro:
        "Training data is usually split into small batches rather than "
        "processed all at once. One full pass through the ENTIRE training "
        "set is called an epoch. Models are typically trained for many "
        "epochs — going through the whole deck of flashcards over and "
        "over.",
    calloutHints: [
      "More epochs generally help — until they don't. Train too many epochs "
          "and the model starts memorizing quirks in the training set: "
          "overfitting creeping back in.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "The model has just finished processing every single training "
          "example exactly once. What just completed?",
      options: ['One batch', 'One epoch', 'One backward pass only', 'One learning rate'],
      answerIndex: 1,
      explainOk:
          "Correct — a full pass over the entire training set is exactly "
          "one epoch.",
      explainBad:
          "A batch is just a small chunk of data. Finishing the ENTIRE "
          "training set once is called one epoch.",
    ),
  ),
  const Chapter(
    id: 25,
    title: 'The 95% Accuracy Trap',
    avatar: '🚨',
    role: 'Narrator — a suspiciously good score',
    bodyIntro:
        "Imagine 950 \"not spam\" emails and only 50 spam emails. A lazy "
        "model that ALWAYS predicts \"not spam\" scores 95% accuracy — while "
        "catching literally zero spam. On imbalanced data, accuracy alone "
        "can be dangerously misleading.",
    calloutHints: [
      "This is exactly why real teams look past accuracy to metrics like "
          "precision and recall, which you'll build next — they expose "
          "failures accuracy hides.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A spam filter scores 95% accuracy but never flags a single spam "
          "email. What's happening?",
      options: [
        'The model is excellent and should ship immediately',
        'The data is imbalanced (few spam examples), so accuracy hides a '
            'useless model',
        "95% accuracy is impossible, there's a bug",
        "Spam filters don't need accuracy",
      ],
      answerIndex: 1,
      explainOk:
          "Right — with so few spam examples, always guessing 'not spam' "
          "racks up high accuracy while being completely useless.",
      explainBad:
          "With very few spam examples in the data, a model that never "
          "predicts spam still scores high accuracy — but it's useless. "
          "That's the imbalance trap.",
    ),
  ),
  const Chapter(
    id: 26,
    title: 'The Confusion Matrix',
    avatar: '🧮',
    role: 'Narrator — the four outcomes',
    bodyIntro:
        "Every prediction on a yes/no problem falls into one of four boxes: "
        "a True Positive (TP) (correctly said yes), a False Positive (FP) "
        "(wrongly said yes), a False Negative (FN) (wrongly said no), or a "
        "True Negative (TN) (correctly said no). This 2x2 grid is the "
        "confusion matrix — the foundation for every metric that follows.",
    calloutHints: [
      "Read it as: rows = what actually happened, columns = what the model "
          "predicted. Anywhere the row and column disagree is a mistake.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a description on the left, then click its matching box on "
          "the right.",
      pairs: [
        MatchPair(
            'tp2', 'Model said spam, and it really was spam', 'True Positive'),
        MatchPair(
            'fp2', 'Model said spam, but it was NOT spam', 'False Positive'),
        MatchPair(
            'fn2', 'Model said not-spam, but it WAS spam', 'False Negative'),
        MatchPair(
            'tn2', "Model said not-spam, and it really wasn't", 'True Negative'),
      ],
      explainOk:
          "Perfect — you've matched every box of the confusion matrix "
          "correctly.",
    ),
  ),
  const Chapter(
    id: 27,
    title: 'Precision vs. Recall',
    avatar: '🎯',
    role: 'Narrator — two different promises',
    bodyIntro:
        "Precision asks: of everything the model FLAGGED as positive, how "
        "much was actually correct? (TP / (TP + FP)) — it's about the "
        "predicted column.\n\nRecall asks: of everything that was ACTUALLY "
        "positive, how much did the model catch? (TP / (TP + FN)) — it's "
        "about the actual row.",
    calloutHints: [
      "A spam filter that's very cautious has high precision but might miss "
          "spam (low recall). A cancer screening test wants high recall — "
          "better to flag extra cases than miss a real one.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A medical test should catch almost every real case of a disease, "
          "even if it means a few false alarms. Which metric should be "
          "prioritized?",
      options: ['Precision', 'Recall', 'Neither matters here', 'Only accuracy matters'],
      answerIndex: 1,
      explainOk:
          "Right — catching nearly every real case is exactly what high "
          "recall means, even at the cost of some false positives.",
      explainBad:
          "Catching almost every REAL case (even with some false alarms) is "
          "what RECALL measures. Precision cares about how clean the "
          "flagged set is, not how complete it is.",
    ),
  ),
  const Chapter(
    id: 28,
    title: 'F1 Score: The Balance Point',
    avatar: '⚖️',
    role: 'Narrator — balancing the scale',
    bodyIntro:
        "Sometimes you need ONE number that balances both precision and "
        "recall — that's the F1 score, the harmonic mean of the two. It's "
        "high only when BOTH precision and recall are reasonably good; it "
        "punishes a model that's great at one and terrible at the other.",
    calloutHints: [
      "If a model has 100% precision but only 10% recall, its F1 score will "
          "be low — reminding you that being \"always right when it speaks "
          "up\" isn't enough if it barely speaks up at all.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A model has 95% precision but only 15% recall. What happens to "
          "its F1 score?",
      options: [
        'F1 will be very high, close to 95%',
        'F1 will be low, because it balances BOTH precision and recall',
        'F1 is undefined in this case',
        'F1 always equals accuracy',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — F1 punishes the big gap; a very low recall drags F1 "
          "down even with great precision.",
      explainBad:
          "F1 balances precision AND recall together — a very low recall "
          "drags the F1 score down no matter how high precision is.",
    ),
  ),
  const Chapter(
    id: 29,
    title: 'Overfitting Revisited',
    avatar: '🌊',
    role: 'Narrator — the wiggly line trap, again',
    bodyIntro:
        "Back in Level 1 you spotted overfitting from a symptom (great on "
        "training, bad on new data). Now look at the shape of it: a wiggly "
        "line can pass through EVERY training dot perfectly, while a "
        "smoother line misses a few dots slightly but tracks the real "
        "underlying trend much better.",
    calloutHints: [
      "More flexibility (more parameters, deeper networks, higher-degree "
          "curves) always makes overfitting easier — which is exactly why "
          "the next few chapters exist.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "One line hits every training dot exactly (very wiggly). Another "
          "line is smooth and misses a few dots slightly. Which will likely "
          "do better on NEW data?",
      options: [
        "The wiggly line — it's more accurate on training data",
        'The smooth line — it captures the trend without chasing noise',
        'Both will perform identically',
        'Neither can be trusted with any error',
      ],
      answerIndex: 1,
      explainOk:
          "Right — the smooth line generalizes better; the wiggly line "
          "memorized noise specific to the training set.",
      explainBad:
          "Perfect fit on training data is a red flag, not a good sign — "
          "the smoother line usually generalizes better to new data.",
    ),
  ),
  const Chapter(
    id: 30,
    title: 'Regularization: A Penalty for Complexity',
    avatar: '🎛️',
    role: 'Narrator — dialing down complexity',
    bodyIntro:
        "Regularization fights overfitting by adding a penalty for "
        "complexity directly into the cost function — the model gets "
        "\"punished\" for having very large weights or being unnecessarily "
        "complicated, nudging it toward simpler, smoother solutions.",
    calloutHints: [
      "Two common flavors: L1 regularization can push some weights all the "
          "way to zero (effectively ignoring less-useful inputs); L2 "
          "regularization just shrinks all weights smoothly.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "What does adding a regularization penalty to training actually "
          "do?",
      options: [
        'Adds more training data automatically',
        'Punishes overly complex/large weights, encouraging simpler models',
        'Makes the model train faster with no other effect',
        'Removes the need for a test set',
      ],
      answerIndex: 1,
      explainOk:
          "Right — regularization penalizes complexity directly, steering "
          "the model away from overfitting.",
      explainBad:
          "Regularization changes the COST FUNCTION to penalize overly "
          "large or complex weights — it doesn't add data or speed up "
          "training by itself.",
    ),
  ),
  const Chapter(
    id: 31,
    title: 'Dropout: Randomly Turning Off Neurons',
    avatar: '🎲',
    role: 'Narrator — a random switch-off',
    bodyIntro:
        "Dropout is a regularization trick just for neural networks: during "
        "each training step, a random subset of neurons is temporarily "
        "switched off. This forces the network to not over-rely on any "
        "single neuron, spreading the learned pattern across many of them "
        "instead.",
    calloutHints: [
      "At prediction time (inference), dropout is turned off — all neurons "
          "are active. It's purely a training-time trick to build a more "
          "robust network.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "When is dropout actually randomly switching off neurons?",
      options: [
        'Only during training',
        'Only during inference/prediction',
        'Both training and inference, always',
        "Never — it's just a theory",
      ],
      answerIndex: 0,
      explainOk:
          "Correct — dropout is a training-time-only technique; at "
          "inference all neurons are active.",
      explainBad:
          "Dropout only randomly disables neurons DURING TRAINING. When the "
          "finished model makes real predictions, every neuron is active.",
    ),
  ),
  const Chapter(
    id: 32,
    title: 'Cross-Validation: Multiple Pop Quizzes',
    avatar: '🔄',
    role: 'Narrator — rotating the test set',
    bodyIntro:
        "One single train/test split can be unlucky — maybe the test set "
        "happened to be unusually easy or hard. k-fold cross-validation "
        "splits the data into k equal folds, trains k times, each time "
        "holding out a DIFFERENT fold as the test set, and averages the "
        "results.",
    calloutHints: [
      "This gives a much more reliable estimate of how the model will "
          "really perform, because every single example gets a turn being "
          "tested on.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps of running 5-fold cross-validation.",
      items: [
        OrderItem('split5', 'Split the data into 5 equal folds'),
        OrderItem(
            'hold', 'Hold out fold 1 as the test set, train on the other 4'),
        OrderItem('score1',
            'Record the score, then repeat holding out fold 2, then fold 3, '
                'and so on'),
        OrderItem('average', 'Average all 5 scores for the final estimate'),
      ],
      explainOk:
          "That's k-fold cross-validation — every fold gets a turn as the "
          "test set, then you average the results.",
      explainBad:
          "You must split into folds first, then rotate the held-out fold "
          "across rounds, and only average at the very end.",
    ),
  ),
  const Chapter(
    id: 33,
    title: 'Wisdom of the Crowd',
    avatar: '👥',
    role: 'Narrator — many weak opinions, one strong answer',
    bodyIntro:
        "A single weak model might guess right only 60% of the time. But "
        "combine MANY weak models and let them vote — an ensemble — and the "
        "combined prediction is often far more accurate than any single "
        "model alone, as long as the models make somewhat different "
        "mistakes.",
    calloutHints: [
      "This only works if the individual models aren't all wrong in the "
          "SAME way — variety among the models is what makes the crowd's "
          "vote valuable.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Why does combining several weak models often outperform any "
          "single one?",
      options: [
        "Ensembles are just bigger, so they're automatically better",
        'Different models make different mistakes, and voting cancels many '
            'of them out',
        'Ensembles need less training data',
        'Combining models always doubles accuracy',
      ],
      answerIndex: 1,
      explainOk:
          "Right — as long as the models err differently, a majority vote "
          "washes out many individual mistakes.",
      explainBad:
          "The real reason is that different models make DIFFERENT "
          "mistakes — a vote across them cancels many of those mistakes "
          "out.",
    ),
  ),
  const Chapter(
    id: 34,
    title: 'Bagging: Random Forests',
    avatar: '🌲',
    role: 'Narrator — a forest of trees',
    bodyIntro:
        "Bagging (bootstrap aggregating) trains many models INDEPENDENTLY, "
        "each on a slightly different random sample of the data, then "
        "averages or votes their predictions. A Random Forest is bagging "
        "applied to decision trees — many trees, each a bit different, "
        "voting together.",
    calloutHints: [
      "Bagging mainly fights variance — it smooths out the wild swings a "
          "single overfit tree might make, without needing any single tree "
          "to be perfect.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In bagging (like a Random Forest), how are the individual models "
          "trained relative to each other?",
      options: [
        "Sequentially, each fixing the last one's mistakes",
        'Independently and in parallel, each on a random data sample',
        'All on the exact same data, in the exact same order',
        'Only one model is ever trained',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — bagging trains many models independently and in "
          "parallel on random samples, then combines their votes.",
      explainBad:
          "Bagging's defining trait is INDEPENDENT, parallel training on "
          "random samples — not a sequential fix-the-last-mistake process "
          "(that's boosting).",
    ),
  ),
  const Chapter(
    id: 35,
    title: 'Boosting: Learn From Mistakes',
    avatar: '🪜',
    role: 'Narrator — climbing one fix at a time',
    bodyIntro:
        "Boosting trains models SEQUENTIALLY — each new model focuses extra "
        "attention on the examples the previous models got wrong. The final "
        "prediction is a weighted blend of all of them.",
    calloutHints: [
      "Boosting mainly fights bias — it can turn a chain of individually "
          "weak models into a very strong final predictor, though it's more "
          "sensitive to noisy data than bagging.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions: "Arrange the steps of training a boosted ensemble.",
      items: [
        OrderItem('m1b', 'Train Model 1 on the full dataset'),
        OrderItem('findmiss', 'Find which examples Model 1 got wrong'),
        OrderItem('m2b',
            'Train Model 2, focusing extra attention on those missed '
                'examples'),
        OrderItem('repeatb', 'Repeat, adding more models that fix remaining mistakes'),
        OrderItem('blend', 'Combine all models into one weighted final prediction'),
      ],
      explainOk:
          "That's boosting — each model in the chain focuses on fixing what "
          "came before, ending in one combined blend.",
      explainBad:
          "You must find the mistakes before training the NEXT model to fix "
          "them, and the final blend always comes last.",
    ),
  ),
  const Chapter(
    id: 36,
    title: 'Choosing Bagging vs. Boosting',
    avatar: '⚙️',
    role: 'Narrator — picking an ensemble strategy',
    bodyIntro:
        "Bagging trains independently and reduces variance — good when a "
        "model tends to overfit wildly. Boosting trains sequentially and "
        "reduces bias — good when individual models are consistently a bit "
        "too weak.",
    calloutHints: [
      "In practice, both are workhorses of real-world ML — Random Forests "
          "(bagging) and Gradient Boosted Trees (boosting) power a huge "
          "share of production tabular-data models.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a symptom on the left, then click the better-suited "
          "strategy on the right.",
      pairs: [
        MatchPair('wildvar', 'Individual trees overfit wildly and disagree a lot',
            'Bagging (reduces variance)'),
        MatchPair('consistentweak',
            'Every model is consistently a little too weak/biased',
            'Boosting (reduces bias)'),
      ],
      explainOk:
          "Exactly — high variance calls for bagging's averaging effect; "
          "consistent weakness calls for boosting's sequential fixing.",
    ),
  ),
  const Chapter(
    id: 37,
    title: 'Diagnosing Bias vs. Variance',
    avatar: '🩺',
    role: 'Narrator — a professional diagnosis',
    bodyIntro:
        "Plot training error and validation error against model "
        "complexity: training error keeps dropping as complexity "
        "increases, but validation error forms a U-shape. On the LEFT of "
        "the curve (too simple) both errors are high — that's high bias / "
        "underfitting. On the RIGHT (too complex), training error is tiny "
        "but validation error rises again — that's high variance / "
        "overfitting. The sweet spot is the bottom of the U.",
    calloutHints: [
      "Professional ML work is largely about reading this curve — and "
          "knowing that the fix for high bias (add complexity, more "
          "features) is the OPPOSITE of the fix for high variance "
          "(regularize, add data, simplify).",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Training error is very low, but validation error is high and "
          "rising. What's the diagnosis and the right fix?",
      options: [
        'High bias — add more model complexity',
        'High variance/overfitting — regularize, simplify, or get more data',
        'The data is corrupted — throw away all training data',
        'This is normal and needs no action',
      ],
      answerIndex: 1,
      explainOk:
          "Correct — a big gap between low training error and high "
          "validation error is the signature of overfitting (high "
          "variance); regularizing or adding data helps.",
      explainBad:
          "Low training error with high validation error is the classic "
          "overfitting (high variance) signature — the fix is to simplify "
          "or regularize, not add MORE complexity.",
    ),
  ),
  const Chapter(
    id: 38,
    title: 'Choosing a Model for the Business',
    avatar: '💼',
    role: 'Narrator — a real stakeholder meeting',
    bodyIntro:
        "A real project rarely starts with \"which algorithm is most "
        "accurate?\" It starts with constraints: does a regulator require an "
        "explainable decision? Is the data huge and messy, or small and "
        "clean? Does the prediction need to run in 5 milliseconds on a "
        "phone, or can it run overnight on a server?",
    calloutHints: [
      "The \"best\" model on a leaderboard is often the WRONG choice in "
          "production if it can't be explained, can't run fast enough, or "
          "costs too much to serve at scale.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A bank must explain every loan denial to regulators by law, and "
          "has a modest, clean dataset. Which choice best fits?",
      options: [
        "A giant deep neural network, because it's the most powerful option",
        'A decision tree or logistic regression, because they are '
            'explainable and fit the data size',
        'Whatever model scored highest on an unrelated public leaderboard',
        'No model at all, since regulation exists',
      ],
      answerIndex: 1,
      explainOk:
          "Right — the legal requirement to explain decisions makes an "
          "explainable model the correct professional choice here, not the "
          "most powerful one.",
      explainBad:
          "The legal requirement to explain every decision rules out "
          "black-box models — an explainable model (tree/logistic "
          "regression) is the professional choice, even if a neural net "
          "might score marginally higher.",
    ),
  ),
  const Chapter(
    id: 39,
    title: 'The Deployment Tradeoff',
    avatar: '🚀',
    role: 'Narrator — shipping to production',
    bodyIntro:
        "In production, accuracy is only one axis. Latency (how fast a "
        "prediction returns) and cost (compute needed to serve it) matter "
        "just as much. A complex ensemble might be 2% more accurate but 10x "
        "slower and far more expensive to run at scale — often not worth "
        "it.",
    calloutHints: [
      "Senior ML engineers are constantly trading a little accuracy for a "
          "lot of speed or cost savings — \"good enough and fast\" "
          "frequently beats \"best and slow\" in the real world.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A complex ensemble is 2% more accurate but 10x slower and 8x "
          "more expensive to serve than a simple model. For a real-time "
          "mobile feature, what's the professional call?",
      options: [
        'Always ship the most accurate model, no exceptions',
        'Weigh the small accuracy gain against the latency and cost hit — '
            'the simpler model may be the better production choice',
        'Accuracy is the only metric that ever matters',
        'Ship both models randomly and see what happens',
      ],
      answerIndex: 1,
      explainOk:
          "Right — professional deployment decisions weigh accuracy against "
          "latency and cost; a small accuracy gain rarely justifies a 10x "
          "slowdown for a real-time feature.",
      explainBad:
          "In production, a small accuracy gain has to be weighed against a "
          "big latency and cost increase — for a real-time feature, the "
          "simpler, faster model is often the smarter call.",
    ),
  ),
  const Chapter(
    id: 40,
    title: 'Ship or Hold? The Final Knowledge Check',
    avatar: '🏆',
    role: 'Narrator — the professional readiness review',
    bodyIntro:
        "You've reached the deepest waters of Learning Lagoon. Before any "
        "real model ships, a professional team runs it through a readiness "
        "checklist: tested on a true holdout set, evaluated with the right "
        "metric for the problem (not just accuracy), checked for bias "
        "across different groups of users, and backed by a monitoring and "
        "rollback plan for when reality inevitably differs from training "
        "data.",
    calloutHints: [
      "This is the last Shard of Learning Lagoon — get this right, and "
          "you've shown you can think like a professional ML engineer, not "
          "just a model-fitter.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A model scores 99% accuracy on its TRAINING set. The team wants "
          "to ship it today with no further checks. What's the single most "
          "important missing step?",
      options: [
        'Nothing — 99% accuracy on training data is proof enough to ship',
        'Evaluate it on a true holdout/test set with metrics suited to the '
            'problem, and check for bias before shipping',
        'Retrain it on the exact same data one more time for luck',
        'Increase the learning rate and ship immediately',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — training accuracy alone proves nothing about "
          "real-world performance. A true holdout evaluation, the right "
          "metrics, and a bias/monitoring check are what separate a "
          "professional launch from a guess. Learning Lagoon's Shard is "
          "restored!",
      explainBad:
          "Training accuracy alone can hide overfitting and bias "
          "completely — a professional launch always requires holdout "
          "evaluation, the right metrics for the problem, and a "
          "bias/monitoring check first.",
    ),
  ),
  const Chapter(
    id: 41,
    title: 'The Train-Deploy-Monitor Loop',
    avatar: '🛰️',
    role: 'Narrator — landing in the Deployment Frontier',
    bodyIntro:
        "Learning Lagoon taught you how to build a good model. The "
        "Deployment Frontier is about everything that happens AFTER "
        "training finishes — because a model sitting in a notebook makes "
        "nobody's product better. Professional teams run every model "
        "through the same loop:\n\nTrain — fit the candidate model on the "
        "current training data.\n\nValidate — check it against a holdout "
        "set AND real business metrics, not just accuracy.\n\nDeploy — ship "
        "it behind a flag or canary, never straight to 100%.\n\nMonitor — "
        "watch live metrics continuously, forever, not just on launch "
        "day.\n\nThe loop doesn't stop at \"Monitor\" — production data and "
        "feedback flow back into the NEXT training run, which is why this "
        "is drawn as a loop, not a line.\n\npipeline:\n  - stage: train        "
        "# produces a versioned model artifact\n  - stage: validate      # "
        "gate: must beat current champion on holdout\n  - stage: deploy         "
        "# gate: canary before full rollout\n  - stage: monitor         # "
        "feeds drift + performance data back to \"train\"",
    calloutHints: [
      "This whole discipline is called MLOps — the DevOps mindset applied "
          "to models, where the model itself is a build artifact with a "
          "version, a registry, and a rollback plan.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the stages of a professional train/deploy/monitor "
          "pipeline.",
      items: [
        OrderItem('trainstage', 'Train a new candidate model on current data'),
        OrderItem('validatestage',
            'Validate it against a holdout set and real business metrics'),
        OrderItem('deploystage',
            'Deploy behind a canary or flag, not straight to 100% of traffic'),
        OrderItem('monitorstage',
            'Monitor live metrics continuously, feeding results back into '
                'the next training run'),
      ],
      explainOk:
          "Correct — train, validate against a real gate, deploy carefully, "
          "then monitor forever, feeding results back into the loop.",
      explainBad:
          "You must validate BEFORE deploying (never ship something you "
          "haven't gated), and deploying always comes before monitoring the "
          "live result.",
    ),
  ),
  const Chapter(
    id: 42,
    title: 'Model Versioning & Rollback',
    avatar: '🗄️',
    role: 'Narrator — a registry full of past champions',
    bodyIntro:
        "Every model that ever gets deployed should be an immutable, "
        "versioned artifact in a model registry — not a file someone "
        "overwrote on a server. A version isn't just the weights; it's the "
        "weights PLUS the exact training data snapshot, code commit, and "
        "hyperparameters that produced it, so you can always answer \"what "
        "exactly is running in production right now?\"\n\nThe whole point of "
        "versioning is that you can instantly roll back to the last "
        "known-good version — call it the champion — the moment a new "
        "version misbehaves. No re-training, no debugging under pressure: "
        "just flip back to what already worked.",
    calloutHints: [
      "In software, a bad deploy is annoying. In ML, a bad model version "
          "can quietly bleed money or trust for hours before anyone "
          "notices — which is exactly why rollback needs to be a single "
          "fast action, not a multi-day fire drill.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A newly deployed model v5 is live for one hour and conversion "
          "rate has dropped 12%. What's the correct immediate action?",
      options: [
        'Patch the code and redeploy v5 again right away',
        'Roll back to the last known-good version (v4) immediately, then '
            'investigate v5 offline',
        'Wait a full week to gather more data before deciding anything',
        'Retrain v5 with more epochs and redeploy it directly',
      ],
      answerIndex: 1,
      explainOk:
          "Right — stop the bleeding first with an instant rollback to the "
          "known-good version, then investigate the failure calmly with the "
          "pressure off.",
      explainBad:
          "The immediate priority is stopping user-facing harm — roll back "
          "to the known-good champion version FIRST, then debug v5 "
          "afterward without live traffic at risk.",
    ),
  ),
  const Chapter(
    id: 43,
    title: 'Canary Rollout: Promote or Roll Back',
    avatar: '🐤',
    role: 'Narrator — sending a canary in first',
    bodyIntro:
        "Instead of switching every user to a new model instantly, a canary "
        "rollout sends just a small slice of live traffic — say 5% — to the "
        "new model while the rest keeps using the current champion. Key "
        "\"guardrail\" metrics (error rate, latency, and the real business "
        "KPI) are compared between the two groups before any further "
        "rollout happens.\n\nThe new model only gets promoted toward 100% if "
        "it clears BOTH guardrails — an acceptable error rate AND "
        "acceptable latency. If either one fails, the rollout halts and "
        "traffic rolls back to the champion automatically.",
    calloutHints: [
      "Canarying turns a risky all-or-nothing bet into a controlled, "
          "reversible experiment — the small slice of traffic is the cost "
          "of finding out early, before the whole user base is affected.",
    ],
    puzzleType: PuzzleType.circuit,
    circuit: CircuitPuzzle(
      instructions:
          "A = error rate is within bounds, B = latency is within bounds. "
          "Flip both switches to 1 so the promotion LED lights up — the "
          "canary should only be promoted to 100% traffic when BOTH "
          "guardrails pass.",
      gate: CircuitGate.and,
      explainOk:
          "Exactly — a canary only gets promoted when EVERY guardrail "
          "metric passes at once. One green metric and one red metric "
          "should still block the rollout.",
      explainBad:
          "Promotion needs BOTH guardrails green at the same time — that's "
          "an AND gate. A canary that fails latency should never be "
          "promoted just because its error rate looks fine.",
    ),
  ),
  const Chapter(
    id: 44,
    title: 'Training-Serving Skew',
    avatar: '🧪',
    role: 'Narrator — chasing a silent bug',
    bodyIntro:
        "Features usually get computed twice: once offline, in a batch job "
        "over historical data (to build training sets), and once online, "
        "in real time, the moment a live request comes in (to build the "
        "input the deployed model actually sees). If those two code paths "
        "compute the same feature even slightly differently, the model "
        "quietly sees different inputs at inference than it ever saw "
        "during training. This is training-serving skew, and it can tank "
        "accuracy without throwing a single error.\n\nThe professional fix "
        "is a feature store — one shared definition of each feature, "
        "computed once and reused by both the offline training pipeline "
        "and the online serving path, with point-in-time correctness: "
        "every training example only ever sees feature values as they "
        "existed at that historical moment, never values from the future.",
    calloutHints: [
      "A model that looks great in offline evaluation but flops in "
          "production is one of the most common — and most confusing — "
          "professional ML bugs, and skew is very often the cause.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions: "Click a term on the left, then click its meaning on the right.",
      pairs: [
        MatchPair('skewterm', 'Training-serving skew',
            'Offline and online feature code compute the same feature '
                'differently'),
        MatchPair('fsterm', 'Feature store',
            'One shared, reused definition of each feature for training and '
                'serving'),
        MatchPair('pitterm', 'Point-in-time correctness',
            'A training example only sees feature values as of that '
                'historical moment'),
      ],
      explainOk:
          "Correct — a feature store with point-in-time correctness is "
          "exactly how professional teams prevent training-serving skew.",
    ),
  ),
  const Chapter(
    id: 45,
    title: 'Why Distribute Training at All',
    avatar: '🌌',
    role: 'Narrator — crossing into the Scaling Wastes',
    bodyIntro:
        "Some models and datasets are simply too big for one machine: the "
        "parameters don't fit in one GPU's memory, or one GPU would take "
        "weeks to finish one pass over the data. Distributed training "
        "spreads the work across many GPUs or machines working together so "
        "training that would take weeks can finish in hours.\n\nBut "
        "distributing isn't free. Workers must periodically communicate (to "
        "share progress), and that communication takes time — so going "
        "from 1 GPU to 64 GPUs almost never gives you a clean 64x speedup. "
        "You get a large speedup that gets LESS efficient per-GPU as you "
        "add more workers, because communication overhead grows too.",
    calloutHints: [
      "A senior engineer's first question when scaling is never \"how many "
          "more GPUs can we add?\" — it's \"where exactly is the "
          "bottleneck: compute, memory, or the network between workers?\"",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A model takes 3 weeks to train on 1 GPU. The team gets access to "
          "64 identical GPUs. What's the realistic expectation?",
      options: [
        'It will now take exactly 3 weeks ÷ 64, a perfectly clean speedup',
        'It will finish much faster, but noticeably less than a clean 64x '
            'speedup because of communication/sync overhead',
        'It will take the same 3 weeks — more GPUs never help',
        'It will take LONGER than 3 weeks no matter what',
      ],
      answerIndex: 1,
      explainOk:
          "Right — distributed training gives a big real speedup, but "
          "communication and synchronization overhead always eat into "
          "perfect linear scaling.",
      explainBad:
          "More GPUs almost always help a lot, but never for free — "
          "synchronizing work between them costs time, so the speedup is "
          "large but sub-linear, not a clean divide-by-64.",
    ),
  ),
  const Chapter(
    id: 46,
    title: 'Data Parallelism vs. Model Parallelism',
    avatar: '🧩',
    role: 'Narrator — two different ways to split the work',
    bodyIntro:
        "Data parallelism: the FULL model is copied onto every worker; each "
        "worker processes a different shard of the DATA and computes "
        "gradients; the gradients are then synchronized (averaged) across "
        "all workers before each update. Use this when the model fits "
        "comfortably on one device but the dataset (or desired throughput) "
        "is huge.\n\nModel parallelism: the model itself is split across "
        "devices — different layers, or even different slices of the same "
        "layer, live on different GPUs — because the model is simply too "
        "large to fit on one device at all. Every worker sees the SAME "
        "data, but only computes its own piece of the network.",
    calloutHints: [
      "Real large-model training often combines both at once: model "
          "parallelism to fit a huge model across a few GPUs, then data "
          "parallelism to replicate that whole group across many more "
          "GPUs.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions:
          "Drag each scenario into the parallelism strategy it calls for.",
      bucketALabel: '🧬 Data Parallelism',
      bucketBLabel: '🧠 Model Parallelism',
      items: [
        Sort2Item('fitsmall',
            'Model fits easily on one GPU, but the dataset is 50 billion rows',
            true),
        Sort2Item('toobig',
            "A 175-billion-parameter model doesn't fit in a single GPU's "
                'memory at all',
            false),
        Sort2Item('throughput',
            'Team wants faster training by processing many data shards at '
                'once',
            true),
        Sort2Item('layersplit',
            'Different layers of one huge network are placed on different '
                'GPUs',
            false),
      ],
      explainOk:
          "Exactly — split the DATA when the model fits but the dataset is "
          "huge; split the MODEL when the model itself is too big for one "
          "device.",
      explainBad:
          "Ask: does the model fit on one device? If yes but data is huge → "
          "data parallelism. If the model itself doesn't fit → model "
          "parallelism.",
    ),
  ),
  const Chapter(
    id: 47,
    title: 'Bigger Than Memory: Sharding & Mini-Batches',
    avatar: '🗃️',
    role: 'Narrator — a dataset too big to hold in your hands',
    bodyIntro:
        "When a dataset is far bigger than RAM (or even bigger than any "
        "single disk), you never load it all at once. Instead, the data is "
        "sharded — split into many chunks spread across storage — and "
        "training streams small mini-batches from those shards, usually "
        "through a shuffle buffer so the model doesn't see data in a "
        "suspiciously fixed order.\n\nBecause a run can take hours or days, "
        "the model state is checkpointed periodically to disk — if a "
        "machine crashes at hour 40 of a 72-hour run, training resumes from "
        "the last checkpoint instead of starting over from zero.",
    calloutHints: [
      "Mini-batching isn't just a memory trick — it's also WHY gradient "
          "descent works efficiently at scale: you get frequent, "
          "noisy-but-useful gradient updates instead of one giant, rare "
          "update per full pass.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange how a dataset far bigger than memory actually gets "
          "trained on.",
      items: [
        OrderItem('shard1', 'Shard the dataset across many storage nodes/files'),
        OrderItem('shuffle1',
            'Stream shuffled mini-batches from those shards, a few at a '
                'time'),
        OrderItem('gradstep', 'Compute gradients and update the model on each '
            'mini-batch'),
        OrderItem(
            'ckpt', 'Periodically checkpoint the model to disk in case of a crash'),
      ],
      explainOk:
          "That's the flow — shard the data, stream shuffled mini-batches, "
          "update on each one, and checkpoint along the way.",
      explainBad:
          "You can't stream mini-batches before the data is sharded, and "
          "checkpointing happens continuously ALONGSIDE training, well "
          "after the first gradient steps.",
    ),
  ),
  const Chapter(
    id: 48,
    title: 'Gradient Sync: All-Reduce & Stragglers',
    avatar: '🔗',
    role: 'Narrator — waiting on the slowest link',
    bodyIntro:
        "In synchronous data-parallel training, every worker computes its "
        "own gradients, and then all workers combine them together — often "
        "via an all-reduce operation — before anyone is allowed to update "
        "their weights. This keeps every worker's model copy perfectly in "
        "sync.\n\nThe catch: synchronous training runs only as fast as its "
        "SLOWEST worker. If one machine is overloaded, on slower hardware, "
        "or has a flaky network link — a straggler — every other worker "
        "sits idle waiting for it. Adding more workers can make straggler "
        "risk WORSE, not better, since more machines means more chances "
        "one of them lags.",
    calloutHints: [
      "Real large-scale systems fight this with asynchronous updates, "
          "gradient compression, or simply detecting and evicting "
          "straggler machines — because the fix for \"one slow worker\" is "
          "never just \"add more workers.\"",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "In synchronous data-parallel training across 100 workers, one "
          "worker is stuck on an overloaded, slow machine. What happens to "
          "overall training throughput?",
      options: [
        'Nothing — the other 99 fast workers simply outvote the slow one',
        'Overall throughput gets bottlenecked down to the pace of that one '
            'straggler',
        'Throughput increases, because slow workers contribute less noisy '
            'gradients',
        'It has no effect since gradients are computed independently '
            'forever',
      ],
      answerIndex: 1,
      explainOk:
          "Right — synchronous all-reduce waits for every worker, so one "
          "straggler drags the whole cluster down to its pace.",
      explainBad:
          "Because synchronous training must combine EVERY worker's "
          "gradients before updating, the entire cluster waits on the "
          "slowest one — a single straggler bottlenecks everyone.",
    ),
  ),
  const Chapter(
    id: 49,
    title: 'Distribution Shift: The World Moved',
    avatar: '🌊',
    role: 'Narrator — entering the Fortress of Trust',
    bodyIntro:
        "A model is trained on a snapshot of the past. In production, the "
        "real world keeps changing — new products launch, user behavior "
        "shifts, fraudsters invent new tricks — and the live data "
        "distribution can drift away from what the model was trained on. "
        "This is distribution shift (sometimes called concept drift), and "
        "it's dangerous precisely because the model's original TEST set "
        "still looks fine; nothing about that old snapshot changed.\n\nThis "
        "is really overfitting to the past in disguise: a model trained "
        "(and validated) only on historical data implicitly assumes the "
        "future looks like history. When that assumption breaks, accuracy "
        "quietly erodes with no code change at all.",
    calloutHints: [
      "This is exactly why professional teams never trust a static offline "
          "test score forever — they keep re-checking against FRESH, live "
          "data, because the ground can shift underneath a model that "
          "never changed.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A fraud model trained on last year's data starts missing new "
          "fraud patterns emerging this year — yet it still scores exactly "
          "the same on its original test set. What's happening?",
      options: [
        'Nothing is wrong — the original test score proves the model is fine',
        "Distribution shift — fraud patterns changed, so the model's "
            'training-era assumptions no longer hold',
        'The model needs a bigger learning rate immediately',
        'The test set was corrupted and must be deleted',
      ],
      answerIndex: 1,
      explainOk:
          "Right — the old test set is frozen in the past and can't reveal "
          "that the real, live world has moved on. That's the essence of "
          "distribution shift.",
      explainBad:
          "An unchanged score on an OLD test set tells you nothing about "
          "NEW, live patterns — the real world can shift underneath a "
          "model even while its old scorecard looks perfect.",
    ),
  ),
  const Chapter(
    id: 50,
    title: 'Monitoring & Drift Detection',
    avatar: '📡',
    role: 'Narrator — watching the dashboards',
    bodyIntro:
        "To catch distribution shift before it becomes a crisis, "
        "production teams continuously compare LIVE data against a frozen "
        "baseline captured from training time — tracking the distribution "
        "of input features, the distribution of the model's own "
        "predictions, and the real downstream business metric.\n\nA common "
        "tool is a distance metric between the live and baseline "
        "distributions (for example, Population Stability Index or KL "
        "divergence) — when that number crosses a threshold, it fires an "
        "alert, well before the business metric itself has visibly "
        "cratered.",
    calloutHints: [
      "Good monitoring catches problems in HOURS. No monitoring means you "
          "find out when a human notices revenue dropped — which can be "
          "days later, after real damage is already done.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the steps of setting up production drift monitoring.",
      items: [
        OrderItem(
            'baseline1', 'Capture a baseline distribution from the training data'),
        OrderItem('compute1',
            'Continuously compute a distance metric between live and '
                'baseline features'),
        OrderItem(
            'threshold1', 'Alert automatically when that metric crosses a set threshold'),
        OrderItem('investigate1',
            "Investigate the cause and trigger retraining or a fix if it's "
                'real drift'),
      ],
      explainOk:
          "Correct — baseline first, continuous comparison next, an "
          "automatic alert on threshold, then human investigation and a "
          "fix.",
      explainBad:
          "You need a baseline before you can measure distance from it, "
          "and the threshold alert must fire BEFORE a human investigates — "
          "not after.",
    ),
  ),
  const Chapter(
    id: 51,
    title: 'Adversarial Robustness',
    avatar: '🕶️',
    role: 'Narrator — a sticker that fools a self-driving car',
    bodyIntro:
        "Some inputs are deliberately crafted, not naturally occurring: an "
        "adversarial example is a real input with a tiny, often "
        "imperceptible-to-humans perturbation added, specifically designed "
        "to flip a model's prediction — frequently with VERY high "
        "confidence in the wrong answer. A few carefully placed stickers on "
        "a stop sign can make a vision model call it a speed-limit sign, at "
        "99% confidence.\n\nThis matters most in security-sensitive "
        "systems: fraud detection, content moderation, autonomous driving, "
        "spam filtering — anywhere a motivated attacker benefits from "
        "fooling the model on purpose. Defenses include adversarial "
        "training (training on deliberately perturbed examples), input "
        "validation, and ensembling diverse models so one clever attack "
        "doesn't fool all of them at once.",
    calloutHints: [
      "High confidence is NOT the same as correctness — a professional "
          "model owner assumes some fraction of inputs may be actively "
          "hostile, not just naturally noisy.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A stop-sign image with a few small, carefully placed stickers "
          "gets classified by a self-driving model as a speed-limit sign — "
          "with 99% confidence. What is this an example of?",
      options: [
        'Normal random noise the model should ignore',
        'An adversarial example — a deliberately crafted input meant to '
            'fool the model',
        'Overfitting to the training set',
        'A perfectly correct prediction the model should trust',
      ],
      answerIndex: 1,
      explainOk:
          "Right — deliberately crafted perturbations that flip a "
          "prediction, often with dangerously high confidence, are the "
          "signature of an adversarial example.",
      explainBad:
          "Random noise doesn't target a model on purpose — a carefully "
          "placed, deliberate perturbation designed to fool the model is "
          "the definition of an adversarial example.",
    ),
  ),
  const Chapter(
    id: 52,
    title: 'Differential Privacy Basics',
    avatar: '🔐',
    role: 'Narrator — protecting one person inside a crowd',
    bodyIntro:
        "Simply removing names from a dataset (\"anonymization\") is often "
        "not enough — a determined attacker with outside information can "
        "sometimes re-identify individuals from supposedly \"anonymous\" "
        "aggregate statistics or model outputs. Differential privacy fixes "
        "this mathematically: calibrated random noise is added to a "
        "computation (a query result, or even the gradients during "
        "training via DP-SGD) so that the output would look nearly "
        "identical whether or not any ONE specific person's data was "
        "included at all.\n\nThe amount of noise is controlled by a privacy "
        "budget (often written as epsilon, ε): a smaller epsilon means "
        "stronger privacy but noisier, less useful results — a direct, "
        "tunable tradeoff between privacy and accuracy.",
    calloutHints: [
      "Differential privacy gives a mathematical GUARANTEE, not just a "
          "promise — that's what makes it the professional standard for "
          "releasing sensitive aggregate data, well beyond just stripping "
          "names.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A hospital wants to release aggregate statistics from patient "
          "records without leaking any individual's data, even to an "
          "attacker who already has some outside information about a "
          "patient. What should they use?",
      options: [
        'Just remove patient names from the dataset before releasing it',
        'Differential privacy — calibrated noise that gives a mathematical '
            'guarantee no individual can be pinpointed',
        'Round all the numbers to the nearest thousand and call it safe',
        "Nothing extra is needed since it's already aggregate data",
      ],
      answerIndex: 1,
      explainOk:
          "Right — plain anonymization can be reversed with outside "
          "information; differential privacy's calibrated noise gives an "
          "actual mathematical privacy guarantee.",
      explainBad:
          "Removing names or rounding numbers can still be "
          "reverse-engineered with outside knowledge — differential "
          "privacy is the technique that gives a real, provable "
          "guarantee.",
    ),
  ),
  const Chapter(
    id: 53,
    title: 'Bias-Variance as a System-Design Decision',
    avatar: '🏛️',
    role: "Narrator — stepping into the Architect's Labyrinth",
    bodyIntro:
        "You already know how to DIAGNOSE bias vs. variance from a "
        "learning curve. A system architect goes one step further and "
        "treats it as a design lever chosen up front, based on "
        "constraints:\n\nLatency-constrained, must-explain-every-decision, "
        "or data-scarce systems often deliberately CHOOSE a simpler, "
        "higher-bias model — and then fight bias with better features, not "
        "more model complexity.\n\nHigh-stakes-accuracy systems with "
        "abundant clean data can afford a more complex, lower-bias model — "
        "as long as regularization, more data, or ensembling keeps the "
        "resulting variance in check.",
    calloutHints: [
      "\"Which model is more accurate on a leaderboard\" is the wrong "
          "first question. \"Given our constraints, where do we WANT to "
          "sit on the bias-variance line — and how do we control the risk "
          "on the other side?\" is the right one.",
    ],
    puzzleType: PuzzleType.sort2,
    sort2: Sort2Puzzle(
      instructions: "Drag each scenario into the design move it calls for.",
      bucketALabel: '📈 Increase Model Capacity',
      bucketBLabel: '🛡️ Regularize / Simplify',
      items: [
        Sort2Item('underfitcase',
            'Both training and validation error are high and close '
                'together',
            true),
        Sort2Item('overfitcase',
            'Training error is near zero but validation error is high and '
                'rising',
            false),
        Sort2Item('plentydata',
            'Plenty of clean data available and the model still '
                'underperforms everywhere',
            true),
        Sort2Item('tinydata',
            'Only a small dataset is available and the model is a huge deep '
                'network',
            false),
      ],
      explainOk:
          "Exactly — high bias everywhere calls for more capacity; a big "
          "train/validation gap or too little data for the model size "
          "calls for regularizing or simplifying.",
      explainBad:
          "High error on BOTH sets means the model is too simple (add "
          "capacity). A big gap between low training error and high "
          "validation error means it's too complex for the data "
          "(regularize).",
    ),
  ),
  const Chapter(
    id: 54,
    title: 'Production Ensemble Architecture Patterns',
    avatar: '🏗️',
    role: 'Narrator — three ways to combine models safely',
    bodyIntro:
        "Beyond bagging and boosting, production systems use ensembles as "
        "ARCHITECTURE patterns, not just accuracy tricks:\n\nStacking — "
        "several base models' predictions become the INPUT features to a "
        "final meta-model, which learns how to best combine them.\n\n"
        "Champion/Challenger — the current champion serves all traffic "
        "while a challenger is evaluated live (often via canary) before it "
        "can earn the champion spot.\n\nShadow deployment — a challenger "
        "model runs in parallel on real live traffic and its predictions "
        "are logged and scored, but NEVER shown to real users — a "
        "zero-risk way to validate a new model against reality before it "
        "ever affects anyone.",
    calloutHints: [
      "Shadow deployment is often the safest first step for a risky new "
          "model — you get real production signal with none of the "
          "production risk.",
    ],
    puzzleType: PuzzleType.match,
    match: MatchPuzzle(
      instructions:
          "Click a pattern on the left, then click its description on the "
          "right.",
      pairs: [
        MatchPair('stackterm', 'Stacking',
            "Base models' outputs feed a meta-model that combines them"),
        MatchPair('champterm', 'Champion/Challenger',
            'Current best model serves traffic while a challenger earns its '
                'spot'),
        MatchPair('shadowterm', 'Shadow deployment',
            'New model scored on live traffic but never shown to real '
                'users'),
      ],
      explainOk:
          "Correct — stacking combines outputs, champion/challenger is a "
          "live competition, shadow deployment is a risk-free rehearsal.",
    ),
  ),
  const Chapter(
    id: 55,
    title: 'Online vs. Batch Learning',
    avatar: '⏱️',
    role: 'Narrator — two different rhythms of learning',
    bodyIntro:
        "Batch learning: the model is retrained periodically (nightly, "
        "weekly) on a full or rolling window of data, then redeployed as a "
        "new version. Predictable, reproducible, and easy to validate "
        "before it ships — but the model is always somewhat stale between "
        "retrains.\n\nOnline (incremental) learning: the model updates "
        "continuously as new examples arrive, adapting to changes almost "
        "immediately. Powerful for fast-moving environments — but riskier: "
        "a burst of bad or even maliciously poisoned data can corrupt the "
        "model in real time, with far less chance for a human to review "
        "the change before it takes effect.",
    calloutHints: [
      "A very common real compromise: online SIGNALS (fast features, fast "
          "alerts) feeding into a periodically retrained BATCH model, "
          "rather than choosing one extreme or the other.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A fraud model needs to adapt within minutes to a brand-new "
          "attack pattern happening right now, but the team is worried "
          "about an attacker poisoning an unconstrained online model. "
          "What's the professionally sound approach?",
      options: [
        "Pure nightly batch retraining only — it's simpler, ignore the "
            'speed requirement',
        'Fully unconstrained online learning with no review, for maximum '
            'speed',
        'Fast online signals/alerts feeding a model, with guardrails and '
            'human review before any online update takes lasting effect',
        "Do nothing differently — fraud patterns aren't worth adapting to "
            'quickly',
      ],
      answerIndex: 2,
      explainOk:
          "Right — real systems usually blend the speed of online signals "
          "with review guardrails, rather than accepting either pure batch "
          "staleness or pure online risk.",
      explainBad:
          "Pure batch is too slow for a live attack, and fully "
          "unconstrained online learning is an open door for poisoning — "
          "the professional answer combines fast signals with review "
          "guardrails.",
    ),
  ),
  const Chapter(
    id: 56,
    title: 'Sync vs. Async Inference',
    avatar: '🔀',
    role: 'Narrator — two shapes of a serving request',
    bodyIntro:
        "Synchronous inference: the caller sends a request and BLOCKS, "
        "waiting for the model's response before doing anything else — "
        "required whenever a user or another system is directly waiting on "
        "the result right now (a chat message being screened before it's "
        "shown, a fraud check before a payment clears).\n\nAsynchronous "
        "inference: a request is placed on a queue, a worker picks it up "
        "whenever capacity allows, and the result is delivered later (via "
        "callback, database write, or notification) — ideal for expensive "
        "models, large batch jobs, or anything that doesn't need to block "
        "a user in the moment.",
    calloutHints: [
      "Choosing wrong in either direction hurts: forcing a slow, expensive "
          "model synchronously into a user's critical path tanks latency; "
          "needlessly making something async that a user IS waiting on "
          "just adds confusing delay.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A content moderation model takes 400ms and must approve every "
          "chat message before it is shown to anyone else. What serving "
          "pattern is required?",
      options: [
        'Asynchronous — queue it and check back later',
        'Synchronous — the caller must block for the result before the '
            'message can be shown',
        'It doesn\'t matter, pick whichever is cheaper to run',
        'Batch it up and process once per day',
      ],
      answerIndex: 1,
      explainOk:
          "Right — since nothing else can happen (the message can't be "
          "shown) until moderation finishes, this MUST be synchronous, in "
          "the critical path.",
      explainBad:
          "Because the message literally cannot be shown until moderation "
          "returns an answer, this has to be synchronous — async or batch "
          "would either block forever or show unmoderated messages.",
    ),
  ),
  const Chapter(
    id: 57,
    title: 'Capstone: Designing a Recommendation System',
    avatar: '🏆',
    role: "Narrator — the Machine's Reckoning begins",
    bodyIntro:
        "A real recommendation system is rarely one model — it's a "
        "PIPELINE, because scoring every possible item for every user with "
        "a heavy model would be far too slow. Production recsys "
        "architecture funnels down in stages:\n\nCandidate generation "
        "(retrieval) — cheaply narrow millions of items down to a few "
        "hundred plausible candidates, often via embeddings and "
        "approximate nearest-neighbor search.\n\nRanking — a richer, "
        "heavier model scores those few hundred candidates using detailed "
        "features, ranking them by predicted relevance.\n\nRe-ranking / "
        "business rules — the top results get adjusted for diversity, "
        "freshness, or business constraints (don't show 5 near-duplicate "
        "items in a row).\n\nServe & log — the final list is returned to "
        "the user, and the interaction (click, ignore, purchase) is logged "
        "as a future training example.",
    calloutHints: [
      "Watch for feedback-loop bias: if you only ever show and log the "
          "items your current model already favors, you never collect "
          "fresh signal about the items it's ignoring — popular items get "
          "more popular for no reason but exposure.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the stages of a real-time recommendation request from "
          "start to finish.",
      items: [
        OrderItem('retrieve1',
            'Candidate generation: cheaply narrow millions of items to a '
                'few hundred'),
        OrderItem('rank1',
            'Ranking: a heavier model scores those candidates by predicted '
                'relevance'),
        OrderItem('rerank1',
            'Re-ranking: adjust the top results for diversity and business '
                'rules'),
        OrderItem('servelog1',
            'Serve the final list to the user and log the interaction for '
                'future training'),
      ],
      explainOk:
          "That's the funnel — cheap retrieval first, a heavier ranking "
          "model second, business-rule re-ranking third, then serve and "
          "log for the next training cycle.",
      explainBad:
          "You must narrow candidates BEFORE the heavy ranking model can "
          "afford to score them, and re-ranking happens on the "
          "already-ranked short list, right before serving.",
    ),
  ),
  const Chapter(
    id: 58,
    title: 'Capstone: Fraud Detection & Label Leakage',
    avatar: '🕵️',
    role: 'Narrator — a bug hiding in plain sight',
    bodyIntro:
        "A fraud model shows a nearly perfect offline AUC — but performs "
        "terribly once live. Investigation finds one suspicious feature: "
        "chargebacks_on_account, computed from the account's ENTIRE "
        "history, including chargebacks that happened AFTER the "
        "transaction being scored. In other words, the training pipeline "
        "let a little piece of the future — a strong hint the transaction "
        "really was fraud — leak backward into a feature used to predict "
        "fraud on that very transaction.\n\nThis is label leakage: a "
        "feature (or the label itself) contains information that would "
        "not actually be available at real prediction time. It's a "
        "training-serving-skew cousin, but even sneakier — the model looks "
        "brilliant offline precisely because it's silently cheating, and "
        "that cheat is IMPOSSIBLE to reproduce live, because the future "
        "hasn't happened yet.",
    calloutHints: [
      "The professional defense is a strict feature-availability audit: "
          "for every single feature, ask \"would this exact value have "
          "existed at the moment we needed to make this real prediction?\" "
          "— not \"does it help offline accuracy?\"",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "A fraud model has near-perfect offline AUC but performs terribly "
          "live. One feature, 'chargebacks on this account,' is computed "
          "from the account's FULL history — including chargebacks that "
          "happened after the scored transaction. What's the bug?",
      options: [
        'Nothing is wrong — a high offline AUC guarantees a great live '
            'model',
        "Label leakage — a feature contains future information that "
            "wouldn't exist yet at real prediction time",
        'The model just needs a lower learning rate',
        "The dataset is too small to matter",
      ],
      answerIndex: 1,
      explainOk:
          "Right — using a feature that includes information from AFTER "
          "the event you're predicting is classic label leakage; it "
          "inflates offline metrics while being impossible to replicate "
          "live.",
      explainBad:
          "A feature built from data that only exists AFTER the moment "
          "you're predicting is label leakage — it explains a suspiciously "
          "perfect offline score that can never hold up in real time.",
    ),
  ),
  const Chapter(
    id: 59,
    title: 'Capstone: Anatomy of a Production Incident',
    avatar: '🚨',
    role: 'Narrator — reconstructing what went wrong',
    bodyIntro:
        "Put everything from levels 11-14 together. A recommendation "
        "model's click-through rate silently drops 8% over two days. "
        "Here's how a professional incident actually gets handled, end to "
        "end:\n\nAn automated monitoring alert fires because a live "
        "feature distribution crossed its drift threshold.\n\nThe on-call "
        "engineer CONFIRMS it's a real regression, not just noisy metrics, "
        "by checking the trend over a longer window.\n\nThey immediately "
        "ROLL BACK to the last known-good model version to stop further "
        "damage — before doing any deep investigation.\n\nRoot-cause "
        "analysis afterward finds the real cause: a new upstream data "
        "source silently changed a feature's units, creating a sudden "
        "distribution shift.\n\nThe team fixes the upstream pipeline, adds "
        "a regression test AND a monitor for that exact feature, and only "
        "then redeploys.",
    calloutHints: [
      "Notice the order: STOP the bleeding (rollback) always comes before "
          "finding the root cause — a professional team never leaves a "
          "known-bad model live just to keep debugging it in place.",
    ],
    puzzleType: PuzzleType.order,
    order: OrderPuzzle(
      instructions:
          "Arrange the correct professional response to a live production "
          "regression.",
      items: [
        OrderItem(
            'alertfire', 'Automated monitoring alert fires on a drift/metric '
                'threshold'),
        OrderItem('confirmreal',
            "On-call engineer confirms it's a real regression, not noise"),
        OrderItem('rollbackfast',
            'Roll back immediately to the last known-good model version'),
        OrderItem('rootcause1',
            'Investigate and find the true root cause (an upstream data '
                'change)'),
        OrderItem('fixmonitor',
            'Fix the pipeline, add a regression test and monitor, then '
                'redeploy'),
      ],
      explainOk:
          "Exactly right — detect, confirm, roll back FAST to stop the "
          "damage, then root-cause it properly, and only redeploy once the "
          "fix is guarded by a new test and monitor.",
      explainBad:
          "Rolling back to stop user-facing harm must happen BEFORE the "
          "deep root-cause investigation — and redeploying only happens "
          "after the fix is verified and monitored.",
    ),
  ),
  const Chapter(
    id: 60,
    title: "The Machine's Reckoning: Principal Engineer Gauntlet",
    avatar: '👑',
    role: "Narrator — the final, hardest Shard of Learning Lagoon",
    bodyIntro:
        "Final challenge. You're the principal ML engineer for a real-time "
        "ad-bidding system: a sub-10-millisecond serving budget, billions "
        "of requests per day, a legal requirement to explain adverse "
        "decisions to regulators, and a known history of adversaries "
        "actively trying to game the model. Every lesson from Levels 11-14 "
        "collides here at once.\n\nThink through latency, explainability, "
        "adversarial risk, and safe rollout together — not as four "
        "separate problems, but as one system design.",
    calloutHints: [
      "There is no single \"best model.\" The right answer is always an "
          "ARCHITECTURE: what serves in the hot path, what runs offline, "
          "how you roll out safely, and how you catch trouble before users "
          "do.",
    ],
    puzzleType: PuzzleType.mcq,
    mcq: McqPuzzle(
      question:
          "Given a sub-10ms serving budget, billions of requests/day, a "
          "legal explainability requirement, and known adversarial gaming "
          "attempts, what's the soundest overall strategy?",
      options: [
        'Ship the single most accurate deep ensemble directly in the hot '
            'path, since accuracy matters most',
        'Serve a fast, explainable model in the critical path (fed by '
            'features informed by a heavier offline model/pipeline), roll '
            'out new versions via canary and shadow evaluation, monitor '
            'continuously for drift and adversarial signals, and keep a '
            'fast rollback path ready',
        'Skip explainability since it slows things down, and add it only if '
            'a regulator complains',
        'Use unconstrained online learning so the model updates itself '
            'instantly against new adversarial patterns with no review',
      ],
      answerIndex: 1,
      explainOk:
          "Exactly right — a principal engineer designs the WHOLE system: "
          "a fast interpretable model in the hot path, heavier intelligence "
          "pushed offline, safe canary/shadow rollout, continuous "
          "monitoring for drift and adversarial behavior, and a rollback "
          "plan always ready. That's professional ML engineering, and it "
          "restores Learning Lagoon's final Shard!",
      explainBad:
          "A single giant model in a sub-10ms hot path breaks the latency "
          "budget, skipping explainability breaks the law, and "
          "unconstrained online learning invites exactly the adversarial "
          "poisoning you were warned about. The real answer combines a "
          "fast explainable serving path, safe rollout, and continuous "
          "monitoring — a system, not just a model.",
    ),
  ),
];
