import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/design_system/madar_ui.dart';
import '../domain/prayer_calculator.dart';
import '../domain/prayer_calculation.dart';
import '../domain/prayer_models.dart';

class PrayerPage extends StatefulWidget {
  const PrayerPage({super.key});
  @override State<PrayerPage> createState() => _State();
}
class _State extends State<PrayerPage> {
  final lat = TextEditingController(text: '12.7855');
  final lon = TextEditingController(text: '45.0187');
  PrayerCalculationMethod method = PrayerCalculationMethod.muslimWorldLeague;
  @override void dispose() { lat.dispose(); lon.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
    final latitude = double.tryParse(lat.text);
    final longitude = double.tryParse(lon.text);
    final now = DateTime.now();
    final times = latitude == null || longitude == null ? const <PrayerTime>[] :
      PrayerCalculator().calculate(date: now, latitude: latitude, longitude: longitude,
        timeZoneOffsetHours: now.timeZoneOffset.inMinutes / 60);
    return MadarPage(title: 'الصلاة', child: ListView(padding: const EdgeInsets.all(18), children: [
      MadarGlassCard(child: Column(children: [
        Row(children: [
          Expanded(child: TextField(controller: lat, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'خط العرض'))),
          const SizedBox(width: 10),
          Expanded(child: TextField(controller: lon, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'خط الطول'))),
        ]),
        const SizedBox(height: 10),
        DropdownButtonFormField<PrayerCalculationMethod>(
          initialValue: method,
          items: PrayerCalculationMethod.values.map((x) => DropdownMenuItem(value: x, child: Text(x.name))).toList(),
          onChanged: (value) => setState(() => method = value ?? method)),
        const SizedBox(height: 10),
        FilledButton(onPressed: () => setState(() {}), child: const Text('حساب المواقيت')),
      ])),
      const SizedBox(height: 18),
      if (times.isNotEmpty) ...times.map((time) => ListTile(
        title: Text(_name(time.name)),
        trailing: Text(DateFormat('HH:mm').format(time.dateTime)))),
      Text('التاريخ: ' + DateFormat('yyyy-MM-dd').format(now)),
      const SizedBox(height: 12),
      const MadarGlassCard(child: Text('هذا مسار حساب أولي. لا يعتمد كمرجع إنتاجي حتى تتم مطابقته مع مراجع حساب موثوقة واختبارات متعددة للمواقع وطرق الحساب.')),
    ]));
  }
  String _name(PrayerName n) => switch (n) {
    PrayerName.fajr => 'الفجر', PrayerName.sunrise => 'الشروق', PrayerName.dhuhr => 'الظهر',
    PrayerName.asr => 'العصر', PrayerName.maghrib => 'المغرب', PrayerName.isha => 'العشاء',
    PrayerName.qiyam => 'قيام الليل',
  };
}
