import 'hadith_models.dart';
import 'hadith_reference.dart';

abstract interface class HadithRepository {
  Future<HadithRecord?> getByReference(HadithReference reference);
  Future<List<HadithRecord>> search(String query);
}
