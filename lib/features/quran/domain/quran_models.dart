class QuranSurah {
  const QuranSurah({required this.number, required this.nameArabic, required this.nameLatin, required this.ayahCount});
  final int number; final String nameArabic; final String nameLatin; final int ayahCount;
}

class QuranAyah { const QuranAyah({required this.id,required this.surahNumber,required this.ayahNumber,required this.text}); final String id; final int surahNumber; final int ayahNumber; final String text; }
