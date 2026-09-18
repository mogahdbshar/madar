import 'audio_track.dart';

abstract interface class AudioRepository {
  Future<List<AudioTrack>> getTracks();
}