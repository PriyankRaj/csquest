import 'package:flutter/material.dart';
import '../models/cq_models.dart';

/// All 10 topics now have 60 lessons each (real, checked content — see
/// lib/data/cq_*_data.dart), aggregated in cq_all_lessons.dart.
final cqTopics = <Topic>[
  const Topic(
    id: 'movement',
    name: 'Bring a Character to Life',
    place: 'Rolling Meadows',
    icon: '🚶',
    color: Color(0xFF4C97FF),
    tagline: 'Steps, turns, and facing the right way',
    available: true,
  ),
  const Topic(id: 'goto-xy', name: 'Build a Teleporter', place: 'Coordinate Cove', icon: '🌀', color: Color(0xFF9966FF), tagline: 'Exact x/y positions', available: true),
  const Topic(id: 'loops', name: 'Draw With Loops', place: 'Loop-the-Loop Valley', icon: '🔁', color: Color(0xFFFFAB19), tagline: 'Repeat blocks, drawing shapes', available: true),
  const Topic(id: 'looks-sound', name: 'Animate & Add Sound', place: 'Costume Carnival', icon: '🎭', color: Color(0xFFFF6680), tagline: 'Say, show/hide, and sound', available: true),
  const Topic(id: 'events', name: 'Wire Up Game Controls', place: 'Click & Key Kingdom', icon: '🕹️', color: Color(0xFF59C059), tagline: 'Reacting to the edge of the world', available: true),
  const Topic(id: 'variables', name: 'Build a Scoreboard', place: 'Number Nook', icon: '🔢', color: Color(0xFFFF8C1A), tagline: 'Variables that track a score', available: true),
  const Topic(id: 'sensing', name: 'Make Smart Decisions', place: 'Decision Docks', icon: '🔎', color: Color(0xFF4CBFE0), tagline: 'If on edge, and sensing blocks', available: true),
  const Topic(id: 'combo-racer', name: 'Build a Racing Game', place: 'Racetrack Ridge', icon: '🏎️', color: Color(0xFFE0524C), tagline: 'Put it all together — a racer', available: true),
  const Topic(id: 'combo-chaser', name: 'Build a Catching Game', place: 'Chase Canyon', icon: '🏃', color: Color(0xFFB07CE0), tagline: 'A chase-and-catch game', available: true),
  const Topic(id: 'combo-talking', name: 'Build an Interactive Story', place: 'Chatterbox Channel', icon: '💬', color: Color(0xFF3DDBB0), tagline: 'A talking, narrated story', available: true),
];
