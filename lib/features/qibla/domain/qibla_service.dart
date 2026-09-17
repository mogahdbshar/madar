import 'qibla_models.dart';

abstract interface class QiblaService {
  Stream<double> headingDegrees();
  Future<QiblaDirection> calculateDirection({
    required double latitude,
    required double longitude,
  });
}
