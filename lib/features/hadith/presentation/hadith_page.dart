import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';

class HadithPage extends StatelessWidget {
  const HadithPage({super.key});
  @override Widget build(BuildContext context) => MadarPage(title: 'الحديث', child: ListView(padding: const EdgeInsets.all(18), children: [
    const MadarGlassCard(child: ListTile(leading: Icon(Icons.auto_stories_rounded), title: Text('المصادر أولاً'), subtitle: Text('المجموعة ثم الكتاب ثم الباب ثم رقم الحديث'))),
    const SizedBox(height: 18),
    MadarFeatureTile(icon: Icons.collections_bookmark_rounded, title: 'المجموعات', subtitle: 'عرض كتب الحديث المتاحة محلياً', onTap: () {}),
    const SizedBox(height: 10),
    MadarFeatureTile(icon: Icons.search_rounded, title: 'بحث الحديث', subtitle: 'بحث محلي مع الفلاتر والمصادر', onTap: () {}),
    const SizedBox(height: 10),
    MadarFeatureTile(icon: Icons.verified_outlined, title: 'درجات الحديث', subtitle: 'تظهر منسوبة إلى مصدر الحكم عند توفرها', onTap: () {}),
  ]));
}
