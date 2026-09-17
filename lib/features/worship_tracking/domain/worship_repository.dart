import 'worship_models.dart';

abstract interface class WorshipRepository {
  Future<void> save(WorshipEntry entry);
  Future<List<WorshipEntry>> forDate(DateTime date);
}
