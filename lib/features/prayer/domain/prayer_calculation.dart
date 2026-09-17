enum PrayerCalculationMethod {
  muslimWorldLeague,
  egyptian,
  karachi,
  ummAlQura,
  dubai,
  moonsightingCommittee,
  northAmerica,
  tehran,
  other,
}

enum AsrJuristicMethod {
  standard,
  hanafi,
}

class PrayerCalculationSettings {
  const PrayerCalculationSettings({
    this.method = PrayerCalculationMethod.muslimWorldLeague,
    this.asrMethod = AsrJuristicMethod.standard,
    this.highLatitudeRule = 'middleOfTheNight',
    this.fajrAngle = 18,
    this.ishaAngle = 17,
  });

  final PrayerCalculationMethod method;
  final AsrJuristicMethod asrMethod;
  final String highLatitudeRule;
  final double fajrAngle;
  final double ishaAngle;
}
