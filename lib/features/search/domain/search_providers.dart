import 'package:flutter_riverpod/flutter_riverpod.dart';import '../../../core/database/database_provider.dart';import 'local_search_service.dart';
final localSearchServiceProvider=Provider<LocalSearchService>((ref)=>LocalSearchService(ref.watch(appDatabaseProvider)));
final localSearchProvider=FutureProvider.family<List<LocalSearchResult>,String>((ref,q)=>ref.watch(localSearchServiceProvider).search(q));
