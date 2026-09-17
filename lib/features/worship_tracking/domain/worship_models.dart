enum WorshipType { prayer, quran, adhkar, tasbeeh }

class WorshipEntry {
  const WorshipEntry({required this.id, required this.type, required this.date, required this.completed});
  final String id;
  final WorshipType type;
  final DateTime date;
  final bool completed;
}
