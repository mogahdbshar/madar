import 'quran_models.dart';
import 'quran_reference.dart';

abstract interface class QuranRepository {
  Future<List<QuranSurah>> getSurahs();
  Future<String> getAyah(QuranReference reference);
  Future<List<QuranAyah>> getAyahs(int surahNumber);
}
