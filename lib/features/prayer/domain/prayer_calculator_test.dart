import 'package:flutter_test/flutter_test.dart';
import 'prayer_calculator.dart';

void main() {
  test('calculator returns the five daily prayers plus sunrise', () {
    final result = const PrayerCalculator().calculate(
      date: DateTime(2026, 9, 17),
      latitude: 21.5,
      longitude: 39.8,
      timeZoneOffsetHours: 3,
    );
    expect(result.length, 6);
    expect(result.first.name.name, 'fajr');
  });
}
