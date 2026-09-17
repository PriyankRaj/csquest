import '../models/pq_models.dart';
import 'pq_ai_data.dart';
import 'pq_cloud_distributed_data.dart';
import 'pq_compilers_data.dart';
import 'pq_cybersecurity_data.dart';
import 'pq_data_structures_data.dart';
import 'pq_dbms_data.dart';
import 'pq_digital_logic_data.dart';
import 'pq_ml_data.dart';
import 'pq_networks_data.dart';
import 'pq_os_data.dart';
import 'pq_software_engineering_data.dart';
import 'pq_webtech_data.dart';

/// Subject catalog — all 12 subjects now have full ported content (60
/// chapters each, 61 for Networks which had one extra in the source),
/// mirroring the web version's process-quest/subjects/*.js files.
final pqSubjects = <Subject>[
  Subject(
    id: 'os',
    name: 'Operating Systems',
    icon: '🖥️',
    place: 'Process Peninsula',
    tagline: 'Live the life cycle of a process, from birth to exit()',
    chapters: osChapters,
    available: true,
  ),
  Subject(
    id: 'data-structures',
    name: 'Data Structures',
    icon: '🌳',
    place: 'Structure Woods',
    tagline: 'Stacks, queues, trees, and graphs',
    chapters: dataStructuresChapters,
    available: true,
  ),
  Subject(
    id: 'digital-logic',
    name: 'Digital Logic',
    icon: '🔌',
    place: 'Circuit Cliffs',
    tagline: 'Gates, flip-flops, and binary',
    chapters: digitalLogicChapters,
    available: true,
  ),
  Subject(
    id: 'networks',
    name: 'Computer Networks',
    icon: '🌐',
    place: 'Packet Bay',
    tagline: 'From cables to the cloud',
    chapters: networksChapters,
    available: true,
  ),
  Subject(
    id: 'dbms',
    name: 'Databases',
    icon: '🗄️',
    place: 'Query Quarry',
    tagline: 'Tables, joins, and transactions',
    chapters: dbmsChapters,
    available: true,
  ),
  Subject(
    id: 'ai',
    name: 'Artificial Intelligence',
    icon: '🧠',
    place: 'Inference Isle',
    tagline: 'Search, logic, and agents',
    chapters: aiChapters,
    available: true,
  ),
  Subject(
    id: 'ml',
    name: 'Machine Learning',
    icon: '📈',
    place: 'Gradient Gorge',
    tagline: 'Models that learn from data',
    chapters: mlChapters,
    available: true,
  ),
  Subject(
    id: 'webtech',
    name: 'Web Technologies',
    icon: '🕸️',
    place: 'Browser Bluffs',
    tagline: 'HTML, CSS, JS and the DOM',
    chapters: webtechChapters,
    available: true,
  ),
  Subject(
    id: 'software-engineering',
    name: 'Software Engineering',
    icon: '🔧',
    place: 'Craft Cove',
    tagline: 'Version control, testing, CI/CD',
    chapters: softwareEngineeringChapters,
    available: true,
  ),
  Subject(
    id: 'cloud-distributed',
    name: 'Cloud & Distributed Systems',
    icon: '☁️',
    place: 'Cloud Cluster Isles',
    tagline: 'Containers, orchestration, consensus',
    chapters: cloudDistributedChapters,
    available: true,
  ),
  Subject(
    id: 'compilers',
    name: 'Compilers & Languages',
    icon: '🔤',
    place: 'Compiler Coast',
    tagline: 'Lexing, parsing, type systems',
    chapters: compilersChapters,
    available: true,
  ),
  Subject(
    id: 'cybersecurity',
    name: 'Cybersecurity',
    icon: '🛡️',
    place: 'Cyber Citadel',
    tagline: 'Cryptography and threat modeling',
    chapters: cybersecurityChapters,
    available: true,
  ),
];
