enum SearchSection { quran, hadith, adhkar, library, namesOfAllah }

class SearchResult {
  const SearchResult({required this.id, required this.title, required this.section, required this.source});
  final String id;
  final String title;
  final SearchSection section;
  final String source;
}
