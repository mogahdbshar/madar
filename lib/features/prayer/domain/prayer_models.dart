enum PrayerName { fajr, sunrise, dhuhr, asr, maghrib, isha, qiyam }

class PrayerTime {
  const PrayerTime({required this.name, required this.dateTime});
  final PrayerName name;
  final DateTime dateTime;
}
