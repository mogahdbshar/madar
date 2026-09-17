import '../../../core/content/search_normalizer.dart';

class SearchIndexEntry {
  const SearchIndexEntry({required this.id, required this.type, required this.title, required this.text, required this.source});
  final String id;
  final String type;
  final String title;
  final String text;
  final String source;
}

class SearchIndex {
  final Map<String, SearchIndexEntry> _entries = {};
  void add(SearchIndexEntry item) => _entries[item.id] = item;
  void addAll(Iterable<SearchIndexEntry> items) { for (final item in items) { add(item); } }
  List<SearchIndexEntry> search(String query) {
    final q = SearchNormalizer.normalizeArabic(query);
    if (q.isEmpty) return const [];
    final tokens = q.split(' ');
    return _entries.values.where((item) {
      final haystack = SearchNormalizer.normalizeArabic(item.title + ' ' + item.text);
      return tokens.every(haystack.contains);
    }).toList(growable: false);
  }
}
