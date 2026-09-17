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

enum AsrJuristicMethod { standard, hanafi }

enum HighLatitudeRule { middleOfTheNight, seventhOfTheNight, angleBased }

class PrayerCalculationSettings {
  const PrayerCalculationSettings({
    this.method = PrayerCalculationMethod.muslimWorldLeague,
    this.asrMethod = AsrJuristicMethod.standard,
    this.highLatitudeRule = HighLatitudeRule.middleOfTheNight,
    this.fajrAngle = 18,
    this.ishaAngle = 17,
  });

  final PrayerCalculationMethod method;
  final AsrJuristicMethod asrMethod;
  final HighLatitudeRule highLatitudeRule;
  final double fajrAngle;
  final double ishaAngle;
}
