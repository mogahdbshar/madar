import 'dart:convert';
import 'dart:io';
import '../../../core/database/app_database.dart';

class HadithDownloadService {
  const HadithDownloadService();

  static const revision = '1ef8f97ac41cd04845081de79529d879966c6fbc';
  static const repoApi = 'https://api.github.com/repos/CheeseWithSauce/HadithsJSONFormat/git/trees/' + revision;

  static const collections = <String, String>{
    'bukhari': 'صحيح البخاري',
    'muslim': 'صحيح مسلم',
    'abudawud': 'سنن أبي داود',
    'tirmidhi': 'جامع الترمذي',
    'nasai': 'سنن النسائي',
    'ibnmajah': 'سنن ابن ماجه',
    'malik': 'موطأ مالك',
    'riyad': 'رياض الصالحين',
    'adab': 'الأدب المفرد',
    'ahmad': 'مسند أحمد',
    'bulugh': 'بلوغ المرام',
    'darimi': 'سنن الدارمي',
    'forty': 'الأربعون',
    'HisnAlMuslim': 'حصن المسلم',
    'mishkat': 'مشكاة المصابيح',
    'shamail': 'الشمائل المحمدية',
  };

  Future<List<String>> _files(String collection) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse(repoApi));
      request.headers.set(HttpHeaders.userAgentHeader, 'MADAR-hadith/1.0');
      final response = await request.close();
      if (response.statusCode != 200) throw StateError('تعذر قراءة فهرس الحديث.');
      final bytes = await response.fold<List<int>>(<int>[], (a,b)=>a..addAll(b));
      final tree = jsonDecode(utf8.decode(bytes)) as Map<String,dynamic>;
      final entries = (tree['tree'] as List).cast<Map>();
      return entries
          .map((e)=>e['path']?.toString())
          .whereType<String>()
          .where((p)=>p.startsWith('Sunnah/' + collection + '/') && p.endsWith('.json'))
          .toList();
    } finally { client.close(force: true); }
  }

  Future<List<Map<String,dynamic>>> _downloadJson(String path) async {
    final url = 'https://raw.githubusercontent.com/CheeseWithSauce/HadithsJSONFormat/' + revision + '/' + path;
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse(url));
      request.headers.set(HttpHeaders.userAgentHeader, 'MADAR-hadith/1.0');
      final response = await request.close();
      if (response.statusCode != 200) throw StateError('تعذر تنزيل ملف حديث.');
      final bytes = await response.fold<List<int>>(<int>[], (a,b)=>a..addAll(b));
      final decoded = jsonDecode(utf8.decode(bytes));
      return (decoded as List).map((e)=>Map<String,dynamic>.from(e as Map)).toList();
    } finally { client.close(force: true); }
  }

  Future<int> installCollection(AppDatabase db, String collection) async {
    if (!collections.containsKey(collection)) throw ArgumentError('مجموعة غير معروفة.');
    final paths = await _files(collection);
    if (paths.isEmpty) throw StateError('لم يتم العثور على ملفات المجموعة.');
    var count = 0;
    await db.transaction(() async {
      await db.into(db.contentSources).insertOnConflictUpdate(
        ContentSourcesCompanion.insert(
          id:'hadith-mit-' + collection,
          name:'HadithsJSONFormat — ' + (collections[collection] ?? collection),
          reference:'https://github.com/CheeseWithSauce/HadithsJSONFormat',
          license:'MIT',
          version:revision,
          verificationStatus:'source-pinned',
        ),
      );
      for (final path in paths) {
        final items = await _downloadJson(path);
        for (final h in items) {
          final id = collection + ':' + (h['reference']?.toString() ?? h['id'].toString());
          final reference = h['reference']?.toString() ?? '';
          final book = h['book']?.toString();
          final grade = h['grade']?.toString();
          await db.into(db.hadithEntries).insertOnConflictUpdate(
            HadithEntriesCompanion.insert(
              id:id, collectionId:collection, book:Value(book), chapter:Value(book),
              number:Value(h['id']?.toString()), originalText:h['arabic']?.toString() ?? '',
              narrator:Value(null), sourceId:'hadith-mit-' + collection,
            ),
          );
          if (grade != null && grade.isNotEmpty) {
            await db.into(db.hadithGradings).insertOnConflictUpdate(
              HadithGradingsCompanion.insert(
                id:id + ':grade', hadithId:id, authority:'المصدر',
                grade:grade, sourceReference:reference,
              ),
            );
          }
          count++;
        }
      }
    });
    return count;
  }
}
