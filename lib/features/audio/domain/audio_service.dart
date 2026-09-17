import 'audio_track.dart';

abstract interface class MadarAudioService {
  Future<void> play(AudioTrack track);
  Future<void> pause();
  Future<void> seek(Duration position);
  Future<void> setSpeed(double speed);
}
