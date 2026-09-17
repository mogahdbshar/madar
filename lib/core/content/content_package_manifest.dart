class ContentPackageManifest {
  const ContentPackageManifest({
    required this.id,
    required this.version,
    required this.schemaVersion,
    required this.sha256,
    required this.license,
    required this.source,
  });

  final String id;
  final String version;
  final int schemaVersion;
  final String sha256;
  final String license;
  final String source;
}
