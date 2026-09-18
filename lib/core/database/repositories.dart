import 'app_database.dart';
import '../../features/quran/domain/quran_models.dart';
import '../../features/quran/domain/quran_reference.dart';
import '../../features/quran/domain/quran_repository.dart';
import '../../features/hadith/domain/hadith_models.dart';
import '../../features/hadith/domain/hadith_reference.dart';
import '../../features/hadith/domain/hadith_repository.dart';
import '../../features/adhkar/domain/dhikr_models.dart';
import '../../features/adhkar/domain/dhikr_repository.dart';
import '../../features/worship_tracking/domain/worship_models.dart';
import '../../features/worship_tracking/domain/worship_repository.dart';

class DriftQuranRepository implements QuranRepository {
  DriftQuranRepository(this.db); final AppDatabase db;
  @override Future<List<QuranSurah>> getSurahs() async { final rows=await db.select(db.quranSurahs).get(); return rows.map((r)=>QuranSurah(number:r.number,nameArabic:r.nameArabic,nameLatin:r.nameLatin,ayahCount:r.ayahCount)).toList(); }
  @override Future<String> getAyah(QuranReference reference) async { final row=await (db.select(db.quranAyahs)..where((t)=>t.surahNumber.equals(reference.surahNumber)&t.ayahNumber.equals(reference.ayahNumber))).getSingleOrNull(); if(row==null) throw StateError('الآية غير موجودة في المحتوى المحلي.'); return row.originalText; }
}
class DriftHadithRepository implements HadithRepository {
  DriftHadithRepository(this.db); final AppDatabase db;
  @override Future<HadithRecord?> getByReference(HadithReference reference) async { final row=await (db.select(db.hadithEntries)..where((t)=>t.collectionId.equals(reference.collectionId)&t.number.equals(reference.number))).getSingleOrNull(); return row==null?null:HadithRecord(id:row.id,text:row.originalText,source:row.sourceId); }
  @override Future<List<HadithRecord>> search(String query) async { final rows=await (db.select(db.hadithEntries)..where((t)=>t.originalText.contains(query))..limit(50)).get(); return rows.map((r)=>HadithRecord(id:r.id,text:r.originalText,source:r.sourceId)).toList(); }
}
class DriftDhikrRepository implements DhikrRepository {
  DriftDhikrRepository(this.db); final AppDatabase db;
  @override Future<List<Dhikr>> getAll() async { final rows=await db.select(db.adhkar).get(); return rows.map((r)=>Dhikr(id:r.id,text:r.originalText,count:r.count??0,source:r.sourceId)).toList(); }
  @override Future<List<Dhikr>> search(String query) async { final rows=await (db.select(db.adhkar)..where((t)=>t.originalText.contains(query))..limit(50)).get(); return rows.map((r)=>Dhikr(id:r.id,text:r.originalText,count:r.count??0,source:r.sourceId)).toList(); }
}
class DriftWorshipRepository implements WorshipRepository {
  DriftWorshipRepository(this.db); final AppDatabase db;
  @override Future<void> save(WorshipEntry entry) async { await db.into(db.worshipEntries).insertOnConflictUpdate(WorshipEntriesCompanion.insert(id:entry.id,type:entry.type.name,date:entry.date,completed:entry.completed)); }
  @override Future<List<WorshipEntry>> forDate(DateTime date) async { final start=DateTime(date.year,date.month,date.day),end=start.add(const Duration(days:1)); final rows=await (db.select(db.worshipEntries)..where((t)=>t.date.isBetweenValues(start,end))).get(); return rows.map((r)=>WorshipEntry(id:r.id,type:WorshipType.values.firstWhere((x)=>x.name==r.type,orElse:()=>WorshipType.quran),date:r.date,completed:r.completed)).toList(); }
}