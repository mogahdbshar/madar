import '../../../core/database/app_database.dart';
import '../../../core/content/search_normalizer.dart';
class LocalSearchResult{const LocalSearchResult({required this.type,required this.id,required this.title,required this.snippet});final String type,id,title,snippet;}
class LocalSearchService{
 LocalSearchService(this.db);final AppDatabase db;
 Future<List<LocalSearchResult>> search(String rawQuery)async{
  final query=SearchNormalizer.normalize(rawQuery).trim();if(query.isEmpty)return const [];
  final results=<LocalSearchResult>[];
  final ayahs=await(db.select(db.quranAyahs)..where((t)=>t.originalText.contains(query))..limit(30)).get();
  results.addAll(ayahs.map((r)=>LocalSearchResult(type:'القرآن',id:r.id,title:'القرآن • '+r.surahNumber.toString()+':'+r.ayahNumber.toString(),snippet:r.originalText)));
  final hadith=await(db.select(db.hadithEntries)..where((t)=>t.originalText.contains(query))..limit(30)).get();
  results.addAll(hadith.map((r)=>LocalSearchResult(type:'الحديث',id:r.id,title:'الحديث • '+(r.number??''),snippet:r.originalText)));
  final adhkar=await(db.select(db.adhkar)..where((t)=>t.originalText.contains(query))..limit(30)).get();
  results.addAll(adhkar.map((r)=>LocalSearchResult(type:'الأذكار',id:r.id,title:'الأذكار • '+r.category,snippet:r.originalText)));
  final duas=await(db.select(db.duaEntries)..where((t)=>t.originalText.contains(query))..limit(20)).get();
  results.addAll(duas.map((r)=>LocalSearchResult(type:'الأدعية',id:r.id,title:'الدعاء • '+r.category,snippet:r.originalText)));
  final names=await(db.select(db.namesOfAllah)..where((t)=>t.arabicName.contains(query))..limit(20)).get();
  results.addAll(names.map((r)=>LocalSearchResult(type:'أسماء الله',id:r.id,title:r.arabicName,snippet:r.meaning)));
  return results;
 }
}