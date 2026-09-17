import 'content_source.dart';

class ContentRecord {
  const ContentRecord({
    required this.id,
    required this.type,
    required this.source,
    required this.originalText,
    this.searchText,
  });

  final String id;
  final String type;
  final ContentSource source;

  /// Immutable source text as supplied by the approved source.
  final String originalText;

  /// Optional normalized field for indexing. Never used as the displayed
  /// religious text when normalization changes the original.
  final String? searchText;
}
