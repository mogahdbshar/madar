import 'dart:math' as math;
import 'prayer_calculation.dart';
import 'prayer_models.dart';

class PrayerCalculator {
  const PrayerCalculator();

  List<PrayerTime> calculate({
    required DateTime date,
    required double latitude,
    required double longitude,
    required double timeZoneOffsetHours,
    PrayerCalculationSettings settings = const PrayerCalculationSettings(),
  }) {
    final effective = _settingsFor(settings);
    final julian = _julian(date.toUtc());
    final declination = _sunDeclination(julian);
    final equation = _equationOfTime(julian);
    final noon = 12 + timeZoneOffsetHours - longitude / 15 - equation / 60;

    final fajr = _sunAngleTime(
      effective.fajrAngle, latitude, declination, noon, true,
    );
    final sunrise = _sunAngleTime(0.833, latitude, declination, noon, true);
    final dhuhr = noon;
    final asrFactor = effective.asrMethod == AsrJuristicMethod.hanafi ? 2.0 : 1.0;
    final asr = _asrTime(asrFactor, latitude, declination, noon);
    final sunset = _sunAngleTime(0.833, latitude, declination, noon, false);
    final isha = _sunAngleTime(
      effective.ishaAngle, latitude, declination, noon, false,
    );

    final base = DateTime(date.year, date.month, date.day);
    return [
      PrayerTime(name: PrayerName.fajr, dateTime: _atLocal(base, fajr)),
      PrayerTime(name: PrayerName.sunrise, dateTime: _atLocal(base, sunrise)),
      PrayerTime(name: PrayerName.dhuhr, dateTime: _atLocal(base, dhuhr)),
      PrayerTime(name: PrayerName.asr, dateTime: _atLocal(base, asr)),
      PrayerTime(name: PrayerName.maghrib, dateTime: _atLocal(base, sunset)),
      PrayerTime(name: PrayerName.isha, dateTime: _atLocal(base, isha)),
    ];
  }

  double _julian(DateTime utc) {
    final y = utc.year;
    final m = utc.month;
    final d = utc.day + (utc.hour / 24) + (utc.minute / 1440);
    final a = ((14 - m) ~/ 12);
    final yy = y + 4800 - a;
    final mm = m + 12 * a - 3;
    return d + ((153 * mm + 2) ~/ 5) + 365 * yy +
        (yy ~/ 4) - (yy ~/ 100) + (yy ~/ 400) - 32045;
  }

  double _sunDeclination(double j) {
    final n = j - 2451545.0;
    final g = _rad((357.529 + 0.98560028 * n) % 360);
    final q = (280.459 + 0.98564736 * n) % 360;
    final l = _rad((q + 1.915 * math.sin(g) + 0.020 * math.sin(2 * g)) % 360);
    return math.asin(0.39779 * math.sin(l));
  }

  double _equationOfTime(double j) {
    final n = j - 2451545.0;
    final g = _rad((357.529 + 0.98560028 * n) % 360);
    final q = (280.459 + 0.98564736 * n) % 360;
    final l = _rad((q + 1.915 * math.sin(g) + 0.020 * math.sin(2 * g)) % 360);
    final e = 23.439 - 0.00000036 * n;
    final y = math.tan(_rad(e) / 2);
    final y2 = y * y;
    final eq = y2 * math.sin(2 * _rad(q)) -
        2 * 0.016708 * math.sin(g) +
        4 * 0.016708 * y2 * math.sin(g) * math.cos(2 * _rad(q)) -
        0.5 * y2 * y2 * math.sin(4 * _rad(q)) -
        1.25 * 0.016708 * 0.016708 * math.sin(2 * g);
    return 4 * _deg(eq);
  }

  double _sunAngleTime(
    double angle, double latitude, double declination, double noon, bool rising,
  ) {
    final lat = _rad(latitude);
    final h = _rad(-angle);
    final cosH = (math.sin(h) - math.sin(lat) * math.sin(declination)) /
        (math.cos(lat) * math.cos(declination));
    if (cosH.abs() > 1) return noon;
    final hours = _deg(math.acos(cosH)) / 15;
    return rising ? noon - hours : noon + hours;
  }

  double _asrTime(double factor, double latitude, double declination, double noon) {
    final angle = -_deg(math.atan(1 / (factor + math.tan((_rad(latitude) - declination).abs()))));
    return _sunAngleTime(angle, latitude, declination, noon, false);
  }

  DateTime _atLocal(DateTime base, double hours) {
    final minutes = (hours * 60).round();
    return base.add(Duration(minutes: minutes));
  }

  PrayerCalculationSettings _settingsFor(PrayerCalculationSettings s) {
    switch(s.method){
      case PrayerCalculationMethod.muslimWorldLeague:return PrayerCalculationSettings(method:s.method,asrMethod:s.asrMethod,highLatitudeRule:s.highLatitudeRule,fajrAngle:18,ishaAngle:17);
      case PrayerCalculationMethod.egyptian:return PrayerCalculationSettings(method:s.method,asrMethod:s.asrMethod,highLatitudeRule:s.highLatitudeRule,fajrAngle:19.5,ishaAngle:17.5);
      case PrayerCalculationMethod.karachi:return PrayerCalculationSettings(method:s.method,asrMethod:s.asrMethod,highLatitudeRule:s.highLatitudeRule,fajrAngle:18,ishaAngle:18);
      case PrayerCalculationMethod.ummAlQura:return PrayerCalculationSettings(method:s.method,asrMethod:s.asrMethod,highLatitudeRule:s.highLatitudeRule,fajrAngle:18.5,ishaAngle:0);
      case PrayerCalculationMethod.dubai:return PrayerCalculationSettings(method:s.method,asrMethod:s.asrMethod,highLatitudeRule:s.highLatitudeRule,fajrAngle:18.2,ishaAngle:18.2);
      case PrayerCalculationMethod.moonsightingCommittee:return PrayerCalculationSettings(method:s.method,asrMethod:s.asrMethod,highLatitudeRule:s.highLatitudeRule,fajrAngle:18,ishaAngle:18);
      case PrayerCalculationMethod.northAmerica:return PrayerCalculationSettings(method:s.method,asrMethod:s.asrMethod,highLatitudeRule:s.highLatitudeRule,fajrAngle:15,ishaAngle:15);
      case PrayerCalculationMethod.tehran:return PrayerCalculationSettings(method:s.method,asrMethod:s.asrMethod,highLatitudeRule:s.highLatitudeRule,fajrAngle:17.7,ishaAngle:14);
      case PrayerCalculationMethod.other:return s;
    }
  }

  double _rad(double d) => d * math.pi / 180;
  double _deg(double r) => r * 180 / math.pi;
}
