class ContentPackage {
  const ContentPackage({
    required this.id,
    required this.version,
    required this.source,
    required this.sha256,
    required this.schemaVersion,
  });

  final String id;
  final String version;
  final String source;
  final String sha256;
  final int schemaVersion;
}
