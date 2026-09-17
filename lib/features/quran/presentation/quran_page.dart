import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/madar_ui.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});
  @override Widget build(BuildContext context) => MadarPage(
    title: 'القرآن',
    actions: [IconButton(onPressed: () => context.push('/search'), icon: const Icon(Icons.search_rounded))],
    child: ListView(padding: const EdgeInsets.all(18), children: [
      const MadarGlassCard(child: ListTile(leading: Icon(Icons.bookmark_rounded), title: Text('متابعة القراءة'), subtitle: Text('سيظهر آخر موضع بعد أول قراءة محفوظة'))),
      const SizedBox(height: 18),
      MadarSection(title: 'طريقة العرض', child: Wrap(spacing: 10, runSpacing: 10, children: const [
        ChoiceChip(label: Text('مصحف'), selected: true), ChoiceChip(label: Text('قراءة'), selected: false), ChoiceChip(label: Text('دراسة'), selected: false),
      ])),
      const SizedBox(height: 18),
      MadarFeatureTile(icon: Icons.menu_book_rounded, title: 'السور', subtitle: 'قائمة السور والقراءة المحلية', onTap: () {}),
      const SizedBox(height: 10),
      MadarFeatureTile(icon: Icons.download_rounded, title: 'المحتوى دون اتصال', subtitle: 'حزم قرآن موثقة وقابلة للتحقق', onTap: () {}),
      const SizedBox(height: 10),
      MadarFeatureTile(icon: Icons.tune_rounded, title: 'تخصيص القراءة', subtitle: 'الخط والتباعد والوضع الليلي', onTap: () {}),
    ]),
  );
}
