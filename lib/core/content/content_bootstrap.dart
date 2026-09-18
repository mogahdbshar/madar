import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';

class MadarContentBootstrap {
  const MadarContentBootstrap();

  Future<void> installBundledQuran(AppDatabase db) async {
    final raw = await rootBundle.loadString('assets/data/madar_quran_package.json');
    final package = jsonDecode(raw) as Map<String,dynamic>;
    final manifest = Map<String,dynamic>.from(package['manifest'] as Map);
    final sources = (package['sources'] as List).cast<Map>();
    final surahs = (package['quranSurahs'] as List).cast<Map>();
    final ayahs = (package['quranAyahs'] as List).cast<Map>();
    final names = (package['namesOfAllah'] as List?)?.cast<Map>() ?? const <Map>[];
    final adhkar = (package['adhkar'] as List?)?.cast<Map>() ?? const <Map>[];
    if (surahs.length != 114 || ayahs.length != 6236 || names.length != 99 || adhkar.isEmpty) {
      throw StateError('حزمة القرآن غير مكتملة.');
    }

    await db.transaction(() async {
      for (final s in sources) {
        await db.into(db.contentSources).insertOnConflictUpdate(
          ContentSourcesCompanion.insert(
            id:s['id'].toString(), name:s['name'].toString(),
            reference:s['reference'].toString(), license:s['license'].toString(),
            version:s['version'].toString(), verificationStatus:s['verificationStatus'].toString(),
          ),
        );
      }
      await db.batch((b) {
        for (final s in surahs) {
          b.insert(db.quranSurahs, QuranSurahsCompanion.insert(
            number:s['number'] as int, nameArabic:s['nameArabic'].toString(),
            nameLatin:s['nameLatin'].toString(), ayahCount:s['ayahCount'] as int,
            revelationType:Value(s['revelationType']?.toString()),
          ), mode:InsertMode.insertOrReplace);
        }
        for (final n in names) {
        b.insert(db.namesOfAllah, NamesOfAllahCompanion.insert(
          id:n['id'].toString(), arabicName:n['arabicName'].toString(),
          meaning:n['meaning'].toString(), explanation:Value(n['explanation']?.toString()), sourceId:n['sourceId'].toString(),
        ), mode:InsertMode.insertOrReplace);
      }
      for (final d in adhkar) {
        b.insert(db.adhkar, AdhkarCompanion.insert(
          id:d['id'].toString(), category:d['category'].toString(), originalText:d['originalText'].toString(),
          count:Value((d['count'] as num?)?.toInt()), sourceId:d['sourceId'].toString(), sourceReference:d['sourceReference'].toString(),
        ), mode:InsertMode.insertOrReplace);
      }
      for (final a in ayahs) {
          b.insert(db.quranAyahs, QuranAyahsCompanion.insert(
            id:a['id'].toString(), surahNumber:a['surahNumber'] as int,
            ayahNumber:a['ayahNumber'] as int, originalText:a['text'].toString(),
            searchText:Value(a['text'].toString()), sourceId:a['sourceId'].toString(),
          ), mode:InsertMode.insertOrReplace);
        }
      });
      await db.into(db.contentPackages).insertOnConflictUpdate(
        ContentPackagesCompanion.insert(
          id:manifest['id'].toString(), version:manifest['version'].toString(),
          source:manifest['source'].toString(), sha256:manifest['sha256'].toString(),
          schemaVersion:manifest['schemaVersion'] as int, installedAt:Value(DateTime.now()),
        ),
      );
    });
  }
}
