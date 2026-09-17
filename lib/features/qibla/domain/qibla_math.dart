import 'dart:math' as math;

class QiblaMath {
  const QiblaMath._();
  static const kaabaLatitude = 21.422487;
  static const kaabaLongitude = 39.826206;

  static double bearingToMakkah({
    required double latitude,
    required double longitude,
  }) {
    final phi1 = _rad(latitude);
    final phi2 = _rad(kaabaLatitude);
    final deltaLambda = _rad(kaabaLongitude - longitude);
    final y = math.sin(deltaLambda);
    final x = math.cos(phi1) * math.tan(phi2) -
        math.sin(phi1) * math.cos(deltaLambda);
    return (_deg(math.atan2(y, x)) + 360) % 360;
  }

  static double shortestAngularDifference(double target, double heading) =>
      ((target - heading + 540) % 360) - 180;

  static double _rad(double degrees) => degrees * math.pi / 180;
  static double _deg(double radians) => radians * 180 / math.pi;
}
