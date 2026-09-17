class HadithReference {
  const HadithReference({
    required this.collection,
    required this.book,
    this.chapter,
    this.number,
  });

  final String collection;
  final String book;
  final String? chapter;
  final String? number;
}
