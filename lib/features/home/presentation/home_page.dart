import 'package:flutter/material.dart';
import '../../../core/design_system/madar_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('مَدار'),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))],
    ),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const _PrayerCard(),
        const SizedBox(height: 16),
        _Section(title: 'الوصول السريع', children: [
          _Action('القرآن', Icons.menu_book_rounded, '/quran'),
          _Action('الأذكار', Icons.auto_awesome_rounded, '/adhkar'),
          _Action('الحديث', Icons.library_books_rounded, '/hadith'),
          _Action('القبلة', Icons.explore_rounded, '/qibla'),
        ]),
        const SizedBox(height: 16),
        _Section(title: 'متابعة عبادتك', children: [
          _Action('متابعة القراءة', Icons.bookmark_rounded, '/quran'),
          _Action('التسبيح', Icons.touch_app_rounded, '/tasbeeh'),
        ]),
      ],
    ),
  );
}

class _PrayerCard extends StatelessWidget {
  const _PrayerCard();
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(22),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('مواقيت الصلاة', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text('سيتم عرض الصلاة القادمة والعد التنازلي بعد تفعيل الموقع أو اختيار المدينة.'),
        const SizedBox(height: 14),
        const Text('هجري • ميلادي'),
      ]),
    ),
  );
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});
  final String title; final List<Widget> children;
  @override Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 10),
      Wrap(spacing: 10, runSpacing: 10, children: children),
    ],
  );
}

class _Action extends StatelessWidget {
  const _Action(this.label, this.icon, this.route);
  final String label; final IconData icon; final String route;
  @override Widget build(BuildContext context) => FilledButton.tonalIcon(
    onPressed: () => GoRouter.of(context).push(route),
    icon: Icon(icon), label: Text(label),
  );
}
