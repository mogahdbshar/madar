class ContentSource {
  const ContentSource({
    required this.id,
    required this.name,
    required this.reference,
    required this.license,
    required this.verificationStatus,
  });

  final String id;
  final String name;
  final String reference;
  final String license;
  final String verificationStatus;
}
