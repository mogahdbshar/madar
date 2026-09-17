import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';

class AdhkarPage extends StatelessWidget {
  const AdhkarPage({super.key});
  @override Widget build(BuildContext context) => MadarPage(title: 'الأذكار والأدعية', child: ListView(padding: const EdgeInsets.all(18), children: [
    const MadarGlassCard(child: ListTile(leading: Icon(Icons.wb_sunny_outlined), title: Text('أذكار اليوم'), subtitle: Text('محتوى موثق مع المصدر والمرجع والعدد عند ثبوته'))),
    const SizedBox(height: 18),
    ...['الصباح والمساء','بعد الصلاة','النوم والاستيقاظ','السفر والمناسبات'].map((x) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MadarFeatureTile(icon: Icons.bookmark_border_rounded, title: x, subtitle: 'عرض المحتوى الموثق المتاح', onTap: () {}),
    )),
  ]));
}
