import 'dart:convert';
import 'dart:typed_data';
import 'content_package_manifest.dart';
import 'content_validator.dart';

class ContentPackageReader {
  const ContentPackageReader();

  ContentPackageManifest readManifest(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('حزمة المحتوى غير صالحة.');
    }
    final m = decoded['manifest'];
    if (m is! Map<String, dynamic>) {
      throw const FormatException('بيانات الحزمة لا تحتوي على manifest.');
    }
    String requiredString(String key) {
      final value = m[key];
      if (value is! String || value.trim().isEmpty) {
        throw FormatException('الحقل $key مفقود.');
      }
      return value;
    }
    final schema = m['schemaVersion'];
    if (schema is! int) throw const FormatException('schemaVersion غير صالح.');
    return ContentPackageManifest(
      id: requiredString('id'),
      version: requiredString('version'),
      schemaVersion: schema,
      sha256: requiredString('sha256'),
      license: requiredString('license'),
      source: requiredString('source'),
    );
  }

  bool verifyPayload(Uint8List bytes, ContentPackageManifest manifest) =>
      ContentValidator.matchesSha256(bytes, manifest.sha256);
}
