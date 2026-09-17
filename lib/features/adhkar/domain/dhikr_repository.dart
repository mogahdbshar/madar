import 'dhikr_models.dart';

abstract interface class DhikrRepository {
  Future<List<Dhikr>> getAll();
  Future<List<Dhikr>> search(String query);
}
