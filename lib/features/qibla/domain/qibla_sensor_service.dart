import 'dart:async';
import 'dart:math' as math;
import 'package:sensors_plus/sensors_plus.dart';
import 'qibla_math.dart';

class QiblaReading {
  const QiblaReading({required this.heading, required this.qiblaBearing});
  final double heading;
  final double qiblaBearing;
  double get relative => QiblaMath.shortestAngularDifference(qiblaBearing, heading);
}

class QiblaSensorService {
  const QiblaSensorService();
  Stream<QiblaReading> stream({required double latitude, required double longitude}) {
    final controller = StreamController<QiblaReading>();
    AccelerometerEvent? accel;
    MagnetometerEvent? mag;
    void emit() {
      if (accel == null || mag == null || controller.isClosed) return;
      final a = accel!, m = mag!;
      final norm = math.sqrt(a.x*a.x + a.y*a.y + a.z*a.z);
      if (norm < 0.1) return;
      final ax=a.x/norm, ay=a.y/norm, az=a.z/norm;
      final pitch=math.asin(-ax);
      final roll=math.atan2(ay,az);
      final xh=m.x*math.cos(pitch)+m.z*math.sin(pitch);
      final yh=m.x*math.sin(roll)*math.sin(pitch)+m.y*math.cos(roll)-m.z*math.sin(roll)*math.cos(pitch);
      final heading=(math.atan2(yh,xh)*180/math.pi+360)%360;
      controller.add(QiblaReading(heading:heading,qiblaBearing:QiblaMath.bearingToMakkah(latitude: latitude, longitude: longitude)));
    }
    final s1=accelerometerEventStream().listen((e){accel=e;emit();});
    final s2=magnetometerEventStream().listen((e){mag=e;emit();});
    controller.onCancel=(){s1.cancel();s2.cancel();};
    return controller.stream;
  }
}
