import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';
import 'drift_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(openMadarDatabase());
  ref.onDispose(db.close);
  return db;
});
