import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_provider.dart';
import 'content_bootstrap.dart';

final contentBootstrapProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final installed = await (db.select(db.contentPackages)
    ..where((t) => t.id.equals('madar-quran-core'))).getSingleOrNull();
  if (installed == null) {
    await const MadarContentBootstrap().installBundledQuran(db);
  }
});
