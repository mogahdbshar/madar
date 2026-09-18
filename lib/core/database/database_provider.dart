import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';import 'drift_database.dart';import 'user_data_repository.dart';
final appDatabaseProvider=Provider<AppDatabase>((ref){final db=AppDatabase(openMadarDatabase());ref.onDispose(db.close);return db;});
final userDataRepositoryProvider=Provider<UserDataRepository>((ref)=>UserDataRepository(ref.watch(appDatabaseProvider)));
