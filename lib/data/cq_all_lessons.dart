import '../models/cq_models.dart';
import 'cq_combo_chaser_data.dart';
import 'cq_combo_racer_data.dart';
import 'cq_combo_talking_data.dart';
import 'cq_events_data.dart';
import 'cq_goto_xy_data.dart';
import 'cq_looks_sound_data.dart';
import 'cq_loops_data.dart';
import 'cq_movement_data.dart';
import 'cq_sensing_data.dart';
import 'cq_variables_data.dart';

/// Every Code Quest lesson across all 10 topics, in one place. Each topic's
/// file owns a disjoint global id range (see that file's header) so ids
/// never collide even though every lesson is authored independently.
final cqAllLessons = <Lesson>[
  ...cqMovementLessons,
  ...cqGotoXyLessons,
  ...cqLoopsLessons,
  ...cqLooksSoundLessons,
  ...cqEventsLessons,
  ...cqVariablesLessons,
  ...cqSensingLessons,
  ...cqComboRacerLessons,
  ...cqComboChaserLessons,
  ...cqComboTalkingLessons,
];
