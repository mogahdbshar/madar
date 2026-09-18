import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

const quranUrl = 'https://raw.githubusercontent.com/Mushaf-Learning/quran-text/main/uthmani/quran-uthmani.txt';
const metadataUrl = 'https://raw.githubusercontent.com/Mushaf-Learning/quran-text/main/metadata/surahs.json';

Future<String> getUrl(String url) async {
  final client = HttpClient();
  try {
    final request = await client.getUrl(Uri.parse(url));
    request.headers.set(HttpHeaders.userAgentHeader, 'MADAR-content-builder/1.0');
    final response = await request.close();
    if (response.statusCode != 200) throw StateError('Download failed: ' + response.statusCode.toString());
    final bytes = await response.fold<List<int>>(<int>[], (a,b) => a..addAll(b));
    return utf8.decode(bytes);
  } finally { client.close(force: true); }
}

void main() async {
  final out = Directory('assets/data');
  await out.create(recursive: true);
  final quran = await getUrl(quranUrl);
  final metadata = jsonDecode(await getUrl(metadataUrl)) as List;
  final lines = quran.split(RegExp(r'\r?\n')).where((e) => e.trim().isNotEmpty).toList();
  final ayahs = <Map<String,dynamic>>[];
  for (final line in lines) {
    final p = line.split('|');
    if (p.length < 3) continue;
    final s = int.tryParse(p[0].trim());
    final a = int.tryParse(p[1].trim());
    if (s == null || a == null) continue;
    ayahs.add({'id': '$s:$a', 'surahNumber': s, 'ayahNumber': a, 'text': p.sublist(2).join('|'), 'sourceId': 'tanzil-quran-v1.1'});
  }
  if (ayahs.length != 6236) throw StateError('Quran validation failed: ' + ayahs.length.toString());
  if (metadata.length != 114) throw StateError('Surah metadata validation failed.');
  final surahs = metadata.map<Map<String,dynamic>>((e) => {
    'number': e['number'] ?? e['id'],
    'nameArabic': e['name_arabic'] ?? e['nameArabic'],
    'nameLatin': e['name_transliteration'] ?? e['name_english'] ?? e['nameEnglish'] ?? '',
    'ayahCount': e['ayah_count'] ?? e['ayahCount'],
    'revelationType': e['revelation_place'] ?? e['revelationPlace'],
  }).toList();
  final hash = sha256.convert(utf8.encode(quran)).toString();
  final package = {'manifest': {'id':'madar-quran-core','version':'tanzil-1.1','schemaVersion':1,'sha256':hash,'license':'CC BY 3.0','source':'Tanzil Project — https://tanzil.net/'}, 'sources':[{'id':'tanzil-quran-v1.1','name':'Tanzil Quran Project','reference':'https://tanzil.net/download/','license':'CC BY 3.0','version':'1.1','verificationStatus':'verified'}], 'quranSurahs':surahs, 'quranAyahs':ayahs};
  await File('assets/data/madar_quran_package.json').writeAsString(const JsonEncoder.withIndent('  ').convert(package));
  await File('assets/data/TANZIL_NOTICE.txt').writeAsString('Tanzil Quran Text\nCopyright (C) 2007-2021 Tanzil Project\nLicense: Creative Commons Attribution 3.0\nSource: https://tanzil.net/\n');
  stdout.writeln('MADAR Quran package generated: 6236 ayahs.');
}