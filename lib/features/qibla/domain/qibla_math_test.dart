import 'package:flutter_test/flutter_test.dart';
import 'qibla_math.dart';

void main() {
  test('Makkah bearing is normalized to 0..360', () {
    final bearing = QiblaMath.bearingToMakkah(
      latitude: 21.422487,
      longitude: 39.826206,
    );
    expect(bearing, closeTo(0, 0.0001));
  });

  test('shortest angular difference wraps across north', () {
    expect(QiblaMath.shortestAngularDifference(5, 355), closeTo(10, 0.0001));
    expect(QiblaMath.shortestAngularDifference(355, 5), closeTo(-10, 0.0001));
  });
}
