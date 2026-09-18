import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/madar_ui.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: CustomScrollView(slivers: [
      SliverAppBar(pinned: true, title: const Text('مَدار'), actions: [IconButton(onPressed: () => context.push('/search'), icon: const Icon(Icons.search_rounded))]),
      SliverPadding(padding: const EdgeInsets.fromLTRB(18, 12, 18, 28), sliver: SliverList(delegate: SliverChildListDelegate([
        MadarGlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('اليوم', style: Theme.of(context).textTheme.labelLarge), const SizedBox(height: 6),
          Text('الصلاة القادمة', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 4),
          const Text('اختر موقعك أو مدينة يدوية لعرض المواقيت'), const SizedBox(height: 14),
          FilledButton.tonalIcon(onPressed: () => context.push('/prayer'), icon: const Icon(Icons.access_time_rounded), label: const Text('مواقيت الصلاة')),
        ])),
        const SizedBox(height: 18),
        MadarSection(title: 'الوصول السريع', child: GridView.count(
          crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.65,
          children: const [_Quick('القرآن', Icons.menu_book_rounded, '/quran'), _Quick('الحديث', Icons.auto_stories_rounded, '/hadith'), _Quick('الأذكار', Icons.wb_sunny_outlined, '/adhkar'), _Quick('القبلة', Icons.explore_rounded, '/qibla')],
        )),
        const SizedBox(height: 22),
        MadarSection(title: 'العبادة', child: Column(children: [
          MadarFeatureTile(icon: Icons.track_changes_rounded, title: 'متابعة العبادة', subtitle: 'سجل يومي للصلاة والقرآن والأذكار والتسبيح', onTap: () => context.push('/worship')),
          const SizedBox(height: 10),
          MadarFeatureTile(icon: Icons.auto_awesome_rounded, title: 'التسبيح', subtitle: 'جلسة عداد تحفظ تقدمك محلياً', onTap: () => context.push('/tasbeeh')),
        ])),
      ])),
    ])),
  );
}
class _Quick extends StatelessWidget {
  const _Quick(this.title, this.icon, this.route);
  final String title, route; final IconData icon;
  @override Widget build(BuildContext context) => InkWell(borderRadius: BorderRadius.circular(22), onTap: () => context.push(route), child: MadarGlassCard(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 28), const SizedBox(height: 8), Text(title)])));
}
