abstract final class SearchNormalizer {
  static String normalizeArabic(String value) {
    return value.replaceAll(RegExp(r'[إأآٱ]'), 'ا').replaceAll('ى', 'ي').replaceAll('ة', 'ه').replaceAll(RegExp(r'[ًٌٍَُِّْـ]'), '').replaceAll(RegExp(r'[^\u0600-\u06FF\u0030-\u0039a-zA-Z ]'), ' ').replaceAll(RegExp(r'\\s+'), ' ').trim().toLowerCase();
  }
}
