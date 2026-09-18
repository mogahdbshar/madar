import '../../../core/database/app_database.dart';
import '../domain/audio_repository.dart';
import '../domain/audio_track.dart';
class DriftAudioRepository implements AudioRepository {
  DriftAudioRepository(this.db);
  final AppDatabase db;
  @override
  Future<List<AudioTrack>> getTracks() async {
    final rows = await db.select(db.audioTracks).get();
    return rows.map((r) => AudioTrack(id: r.id, title: r.title, uri: Uri.tryParse(r.uri) ?? Uri(), source: r.sourceId)).toList();
  }
}
