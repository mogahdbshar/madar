import 'package:drift/drift.dart';

part 'app_database.g.dart';

class ContentSources extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get reference => text()();
  TextColumn get license => text()();
  TextColumn get version => text()();
  TextColumn get verificationStatus => text()();
  DateTimeColumn get collectedAt => dateTime().nullable()();
  @override Set<Column<Object>> get primaryKey => {id};
}

class ContentPackages extends Table {
  TextColumn get id => text()();
  TextColumn get version => text()();
  TextColumn get source => text()();
  TextColumn get sha256 => text()();
  IntColumn get schemaVersion => integer()();
  DateTimeColumn get installedAt => dateTime().nullable()();
  @override Set<Column<Object>> get primaryKey => {id};
}

class QuranSurahs extends Table {
  IntColumn get number => integer()();
  TextColumn get nameArabic => text()();
  TextColumn get nameLatin => text()();
  IntColumn get ayahCount => integer()();
  TextColumn get revelationType => text().nullable()();
  @override Set<Column<Object>> get primaryKey => {number};
}

class QuranAyahs extends Table {
  TextColumn get id => text()();
  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  TextColumn get originalText => text()();
  TextColumn get searchText => text().nullable()();
  TextColumn get sourceId => text()();
  @override Set<Column<Object>> get primaryKey => {id};
}

class HadithCollections extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get sourceId => text()();
  @override Set<Column<Object>> get primaryKey => {id};
}

class HadithEntries extends Table {
  TextColumn get id => text()();
  TextColumn get collectionId => text()();
  TextColumn get book => text().nullable()();
  TextColumn get chapter => text().nullable()();
  TextColumn get number => text().nullable()();
  TextColumn get originalText => text()();
  TextColumn get narrator => text().nullable()();
  TextColumn get sourceId => text()();
  @override Set<Column<Object>> get primaryKey => {id};
}

class HadithGradings extends Table {
  TextColumn get id => text()();
  TextColumn get hadithId => text()();
  TextColumn get authority => text()();
  TextColumn get grade => text()();
  TextColumn get sourceReference => text()();
  @override Set<Column<Object>> get primaryKey => {id};
}

class Adhkar extends Table {
  TextColumn get id => text()();
  TextColumn get category => text()();
  TextColumn get originalText => text()();
  IntColumn get count => integer().nullable()();
  TextColumn get sourceId => text()();
  TextColumn get sourceReference => text()();
  @override Set<Column<Object>> get primaryKey => {id};
}

class Bookmarks extends Table {
  TextColumn get id => text()();
  TextColumn get contentType => text()();
  TextColumn get contentId => text()();
  DateTimeColumn get createdAt => dateTime()();
  @override Set<Column<Object>> get primaryKey => {id};
}

class ReadingProgress extends Table {
  TextColumn get id => text()();
  TextColumn get contentType => text()();
  TextColumn get contentId => text()();
  DateTimeColumn get updatedAt => dateTime()();
  @override Set<Column<Object>> get primaryKey => {id};
}

class WorshipEntries extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get completed => boolean()();
  @override Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [
  ContentSources,
  ContentPackages,
  QuranSurahs,
  QuranAyahs,
  HadithCollections,
  HadithEntries,
  HadithGradings,
  Adhkar,
  Bookmarks,
  ReadingProgress,
  WorshipEntries,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);
  @override int get schemaVersion => 1;
}
