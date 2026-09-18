import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/design_system/madar_ui.dart';
import '../../../core/permissions/permission_service.dart';
import '../domain/prayer_calculator.dart';
import '../domain/prayer_calculation.dart';
import '../domain/prayer_models.dart';

class PrayerPage extends StatefulWidget {
  const PrayerPage({super.key});
  @override State<PrayerPage> createState() => _PrayerState();
}

class _PrayerState extends State<PrayerPage> {
  final lat = TextEditingController();
  final lon = TextEditingController();
  bool loading = false;
  String? error;

  @override
  void dispose() { lat.dispose(); lon.dispose(); super.dispose(); }

  Future<void> _useLocation() async {
    setState(() { loading = true; error = null; });
    try {
      final granted = await const MadarPermissionService().requestLocation();
      if (!granted) throw StateError('لم يتم السماح بالموقع.');
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw StateError('خدمة الموقع في الجهاز متوقفة.');
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
      );
      lat.text = position.latitude.toStringAsFixed(6);
      lon.text = position.longitude.toStringAsFixed(6);
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
    final now = DateTime.now();
    final hasLocation = latitude != null && longitude != null &&
        latitude >= -90 && latitude <= 90 && longitude >= -180 && longitude <= 180;
    final times = hasLocation
        ? const PrayerCalculator().calculate(
            date: now, latitude: latitude!, longitude: longitude!, timeZoneOffsetHours: DateTime.now().timeZoneOffset.inMinutes / 60,
            settings: const PrayerCalculationSettings(
              method: PrayerCalculationMethod.muslimWorldLeague,
            ),
          )
        : const <PrayerTime>[];

    return MadarPage(
      title: 'الصلاة',
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          MadarGlassCard(
            child: Column(
              children: [
                const Text('الموقع مطلوب لحساب المواقيت. لا يستخدمه مَدار إلا بعد موافقتك.'),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: TextField(
                    controller: lat,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                    decoration: const InputDecoration(labelText: 'خط العرض'),
                    onChanged: (_) => setState(() {}),
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
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (!hasLocation)
            const MadarGlassCard(child: Text('أدخل إحداثيات المدينة يدوياً أو اختر استخدام موقعي لعرض المواقيت.'))
          else
            ...times.map((p) => ListTile(
              title: Text(_name(p.name)),
              trailing: Text(p.dateTime.hour.toString().padLeft(2,'0') + ':' + p.dateTime.minute.toString().padLeft(2,'0')),
            )),
        ],
      ),
    );
  }

  String _name(PrayerName n) => switch (n) {
    PrayerName.fajr => 'الفجر',
    PrayerName.sunrise => 'الشروق',
    PrayerName.dhuhr => 'الظهر',
    PrayerName.asr => 'العصر',
    PrayerName.maghrib => 'المغرب',
    PrayerName.isha => 'العشاء',
    PrayerName.qiyam => 'قيام الليل',
  };
}
