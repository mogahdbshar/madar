import 'package:drift/drift.dart';

part 'app_database.g.dart';

class ContentSources extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get url => text().nullable()();
  TextColumn get license => text().nullable()();
  TextColumn get version => text().nullable()();
  TextColumn get verificationStatus => text()();
  DateTimeColumn get collectedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [ContentSources])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;
}
