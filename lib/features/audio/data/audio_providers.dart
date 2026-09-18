import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../domain/audio_repository.dart';
import 'audio_repository.dart';
import 'just_audio_service.dart';

final audioRepositoryProvider=Provider<AudioRepository>((ref)=>DriftAudioRepository(ref.watch(appDatabaseProvider)));
final madarAudioServiceProvider=Provider<JustAudioMadarService>((ref){
  final service=JustAudioMadarService();
  ref.onDispose(service.dispose);
  return service;
});