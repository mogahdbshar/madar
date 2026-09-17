import 'package:flutter/material.dart';
import '../../../core/design_system/madar_spacing.dart';
import '../../../core/localization/app_strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.appName)),
        body: ListView(
          padding: const EdgeInsets.all(MadarSpacing.lg),
          children: [
            Card(
              color: colors.primaryContainer,
              child: const Padding(
                padding: EdgeInsets.all(MadarSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الصلاة القادمة'),
                    SizedBox(height: MadarSpacing.sm),
                    Text('سيتم حسابها وفق الموقع وطريقة الحساب المختارة'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: MadarSpacing.lg),
            const Wrap(
              spacing: MadarSpacing.sm,
              runSpacing: MadarSpacing.sm,
              children: [
                ActionChip(label: Text('القرآن'), onPressed: null),
                ActionChip(label: Text('الأذكار'), onPressed: null),
                ActionChip(label: Text('الحديث'), onPressed: null),
                ActionChip(label: Text('القبلة'), onPressed: null),
              ],
            ),
            const SizedBox(height: MadarSpacing.lg),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(MadarSpacing.xl),
                child: Text('المحتوى اليومي سيأتي من حزم المحتوى الموثقة.'),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const NavigationBar(
          selectedIndex: 0,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'القرآن'),
            NavigationDestination(icon: Icon(Icons.auto_stories_outlined), label: 'الحديث'),
            NavigationDestination(icon: Icon(Icons.volunteer_activism_outlined), label: 'العبادة'),
            NavigationDestination(icon: Icon(Icons.more_horiz), label: 'المزيد'),
          ],
        ),
      ),
    );
  }
}
