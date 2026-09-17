import 'search_models.dart';

abstract interface class SearchService {
  Future<List<SearchResult>> search(String query, {SearchSection? section});
}
