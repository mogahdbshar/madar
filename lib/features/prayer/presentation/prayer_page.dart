import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';

class PrayerPage extends StatelessWidget {
  const PrayerPage({super.key});
  @override Widget build(BuildContext context) => MadarPage(title: 'الصلاة', child: ListView(padding: const EdgeInsets.all(18), children: [
    const MadarGlassCard(child: ListTile(leading: Icon(Icons.access_time_rounded), title: Text('مواقيت الصلاة'), subtitle: Text('تظهر بعد اختيار الموقع أو المدينة وطريقة الحساب'))),
    const SizedBox(height: 18),
    MadarFeatureTile(icon: Icons.location_on_outlined, title: 'الموقع', subtitle: 'تحديد تلقائي أو اختيار مدينة يدوياً', onTap: () {}),
    const SizedBox(height: 10),
    MadarFeatureTile(icon: Icons.calculate_outlined, title: 'طريقة الحساب', subtitle: 'طرق حساب متعددة وإعداد العصر', onTap: () {}),
    const SizedBox(height: 10),
    MadarFeatureTile(icon: Icons.notifications_none_rounded, title: 'الأذان والتنبيهات', subtitle: 'إعداد مستقل لكل صلاة', onTap: () {}),
  ]));
}
