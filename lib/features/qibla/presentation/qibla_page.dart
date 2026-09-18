import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/design_system/madar_ui.dart';
import '../../../core/permissions/permission_service.dart';
import '../domain/qibla_sensor_service.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});
  @override State<QiblaPage> createState() => _State();
}

class _State extends State<QiblaPage> {
  final lat = TextEditingController();
  final lon = TextEditingController();
  bool loading = false;
  String? error;
  Stream<QiblaReading>? qiblaStream;

  @override
  void dispose() { lat.dispose(); lon.dispose(); super.dispose(); }

  Future<void> _useLocation() async {
    setState(() { loading = true; error = null; });
    try {
      final granted = await const MadarPermissionService().requestLocation();
      if (!granted) throw StateError('لم يتم السماح بالموقع.');
      if (!await Geolocator.isLocationServiceEnabled()) throw StateError('خدمة الموقع متوقفة.');
      final p = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
      );
      lat.text = p.latitude.toStringAsFixed(6);
      lon.text = p.longitude.toStringAsFixed(6);
      _refreshStream();
    } catch (e) {
      error = e.toString();
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final latitude = double.tryParse(lat.text);
    final longitude = double.tryParse(lon.text);
    final valid = latitude != null && longitude != null &&
        latitude >= -90 && latitude <= 90 && longitude >= -180 && longitude <= 180;

    return MadarPage(
      title: 'القبلة',
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          MadarGlassCard(
            child: Column(children: [
              const Text('تحتاج القبلة إلى موقعك واتجاه الجهاز. كل منهما لا يُستخدم إلا بعد موافقتك.'),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: TextField(
                  controller: lat,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: const InputDecoration(labelText: 'خط العرض'),
                  onChanged: (_) { _refreshStream(); setState(() {}); },
                )),
                const SizedBox(width: 10),
                Expanded(child: TextField(
                  controller: lon,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                  decoration: const InputDecoration(labelText: 'خط الطول'),
                  onChanged: (_) => setState(() {}),
                )),
              ]),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: loading ? null : _useLocation,
                icon: const Icon(Icons.my_location_rounded),
                label: Text(loading ? 'جاري تحديد الموقع...' : 'استخدام موقعي'),
              ),
              if (error != null) Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ),
            ]),
          ),
          const SizedBox(height: 14),
          if (!valid)
            const MadarGlassCard(child: Text('أدخل الإحداثيات أو استخدم الموقع لبدء البوصلة.'))
          else
            StreamBuilder<QiblaReading>(
              stream: qiblaStream,
              builder: (context, snapshot) {
                final reading = snapshot.data;
                if (reading == null) {
                  return const MadarGlassCard(child: Column(children: [
                    Icon(Icons.explore_rounded, size: 150),
                    Text('بانتظار حساسات الاتجاه...'),
                    SizedBox(height: 8),
                    Text('حرّك الهاتف بشكل رقم 8 إذا احتاجت البوصلة إلى معايرة.'),
                  ]));
                }
                final bearing = _bearing(latitude!, longitude!);
                final relative = ((bearing - reading.heading + 540) % 360) - 180;
                return MadarGlassCard(child: Column(children: [
                  Transform.rotate(
                    angle: relative * math.pi / 180,
                    child: const Icon(Icons.navigation_rounded, size: 150),
                  ),
                  Text('اتجاه القبلة: ' + bearing.toStringAsFixed(1) + '°'),
                  Text('الانحراف الحالي: ' + relative.abs().toStringAsFixed(1) + '°'),
                  const SizedBox(height: 8),
                  const Text('أبعد الهاتف عن الأجسام المغناطيسية عند المعايرة.'),
                ]));
              },
            ),
        ],
      ),
    );
  }

  void _refreshStream() {
    final a = double.tryParse(lat.text);
    final o = double.tryParse(lon.text);
    if (a == null || o == null) { qiblaStream = null; return; }
    qiblaStream = QiblaSensorService().stream(latitude: a, longitude: o);
  }

  double _bearing(double latitude, double longitude) {
    const kaabaLat = 21.422487;
    const kaabaLon = 39.826206;
    final phi1 = latitude * math.pi / 180;
    final phi2 = kaabaLat * math.pi / 180;
    final dl = (kaabaLon - longitude) * math.pi / 180;
    final y = math.sin(dl) * math.cos(phi2);
    final x = math.cos(phi1) * math.sin(phi2) - math.sin(phi1) * math.cos(phi2) * math.cos(dl);
    return (math.atan2(y, x) * 180 / math.pi + 360) % 360;
  }
}
