import 'dart:convert';
import 'dart:typed_data';
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import 'content_package_reader.dart';

class ContentPackageInstaller {
  const ContentPackageInstaller();
  Future<void> installJson({required AppDatabase db,required Uint8List payload,required String manifestJson}) async {
    final reader=const ContentPackageReader();
    final manifest=reader.readManifest(manifestJson);
    if(!reader.verifyPayload(payload,manifest)) throw const FormatException('فشل تحقق SHA-256 لحزمة المحتوى.');
    final decoded=jsonDecode(utf8.decode(payload));
    if(decoded is! Map<String,dynamic>) throw const FormatException('محتوى الحزمة غير صالح.');
    final sources=decoded['sources'];
    if(sources is List) {
      for(final raw in sources.whereType<Map<String,dynamic>>()) {
        await db.into(db.contentSources).insertOnConflictUpdate(ContentSourcesCompanion.insert(
          id: raw['id']?.toString()??'', name:raw['name']?.toString()??'',
          reference:raw['reference']?.toString()??'', license:raw['license']?.toString()??'',
          version:raw['version']?.toString()??manifest.version,
          verificationStatus:raw['verificationStatus']?.toString()??'verified'));
      }
    }
    final pkg=ContentPackagesCompanion.insert(id:manifest.id,version:manifest.version,source:manifest.source,
      sha256:manifest.sha256,schemaVersion:manifest.schemaVersion,installedAt:Value(DateTime.now()));
    await db.into(db.contentPackages).insertOnConflictUpdate(pkg);
  }
}