import 'prayer_calculation.dart';
import 'prayer_models.dart';

abstract interface class PrayerService {
  Future<List<PrayerTime>> calculate({
    required DateTime date,
    required double latitude,
    required double longitude,
    required PrayerCalculationSettings settings,
  });
}
