import 'package:just_audio/just_audio.dart';
import '../domain/audio_service.dart';
import '../domain/audio_track.dart';

class JustAudioMadarService implements MadarAudioService {
  JustAudioMadarService([AudioPlayer? player]):player=player??AudioPlayer();
  final AudioPlayer player;
  @override Future<void> play(AudioTrack track) => player.setUrl(track.uri.toString()).then((_)=>player.play());
  @override Future<void> pause()=>player.pause();
  @override Future<void> seek(Duration position)=>player.seek(position);
  @override Future<void> setSpeed(double speed)=>player.setSpeed(speed);
  Future<void> stop()=>player.stop();
  Future<void> dispose()=>player.dispose();
}