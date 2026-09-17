import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});
  @override Widget build(BuildContext context) => MadarPage(title: 'التقويم الإسلامي', child: ListView(padding: const EdgeInsets.all(18), children: [
    const MadarGlassCard(child: ListTile(title: Text('الهجري والميلادي'), subtitle: Text('عرض التاريخين معاً والتحويل بينهما'))),
    const SizedBox(height: 18),
    MadarFeatureTile(icon: Icons.calendar_month_rounded, title: 'الشهر الهجري', subtitle: 'عرض شهري للمناسبات والأيام', onTap: () {}),
    const SizedBox(height: 10),
    MadarFeatureTile(icon: Icons.event_rounded, title: 'المناسبات', subtitle: 'رمضان وعرفة وعاشوراء وغيرها وفق منهجية واضحة', onTap: () {}),
    const SizedBox(height: 10),
    MadarFeatureTile(icon: Icons.info_outline_rounded, title: 'اختلاف بدايات الأشهر', subtitle: 'إظهار المنهجية والاختلاف عند الحاجة', onTap: () {}),
  ]));
}
