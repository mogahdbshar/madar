import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/quran/presentation/quran_page.dart';
import '../../features/hadith/presentation/hadith_page.dart';
import '../../features/adhkar/presentation/adhkar_page.dart';
import '../../features/worship_tracking/presentation/worship_tracking_page.dart';
import '../../features/prayer/presentation/prayer_page.dart';
import '../../features/qibla/presentation/qibla_page.dart';
import '../../features/calendar/presentation/calendar_page.dart';
import '../../features/names_of_allah/presentation/names_page.dart';
import '../../features/tasbeeh/presentation/tasbeeh_page.dart';
import '../../features/hajj_umrah/presentation/hajj_umrah_page.dart';
import '../../features/library/presentation/library_page.dart';
import '../../features/audio/presentation/audio_page.dart';
import '../../features/search/presentation/search_page.dart';
import '../../features/settings/presentation/settings_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) => GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (_, __, child) => MadarShell(child: child),
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomePage()),
        GoRoute(path: '/quran', builder: (_, __) => const QuranPage()),
        GoRoute(path: '/hadith', builder: (_, __) => const HadithPage()),
        GoRoute(path: '/adhkar', builder: (_, __) => const AdhkarPage()),
        GoRoute(path: '/worship', builder: (_, __) => const WorshipTrackingPage()),
      ],
    ),
    GoRoute(path: '/prayer', builder: (_, __) => const PrayerPage()),
    GoRoute(path: '/qibla', builder: (_, __) => const QiblaPage()),
    GoRoute(path: '/calendar', builder: (_, __) => const CalendarPage()),
    GoRoute(path: '/names', builder: (_, __) => const NamesPage()),
    GoRoute(path: '/tasbeeh', builder: (_, __) => const TasbeehPage()),
    GoRoute(path: '/hajj-umrah', builder: (_, __) => const HajjUmrahPage()),
    GoRoute(path: '/library', builder: (_, __) => const LibraryPage()),
    GoRoute(path: '/audio', builder: (_, __) => const AudioPage()),
    GoRoute(path: '/search', builder: (_, __) => const SearchPage()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
  ],
));

class MadarShell extends StatefulWidget {
  const MadarShell({super.key, required this.child});
  final Widget child;
  @override State<MadarShell> createState() => _MadarShellState();
}

class _MadarShellState extends State<MadarShell> {
  int index = 0;
  @override Widget build(BuildContext context) => Scaffold(
    body: widget.child,
    bottomNavigationBar: NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (value) {
        if (value == 4) { _openMore(context); return; }
        setState(() => index = value);
        const routes = ['/', '/quran', '/hadith', '/adhkar'];
        context.go(routes[value]);
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'الرئيسية'),
        NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book_rounded), label: 'القرآن'),
        NavigationDestination(icon: Icon(Icons.auto_stories_outlined), selectedIcon: Icon(Icons.auto_stories_rounded), label: 'الحديث'),
        NavigationDestination(icon: Icon(Icons.volunteer_activism_outlined), selectedIcon: Icon(Icons.volunteer_activism_rounded), label: 'العبادة'),
        NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'المزيد'),
      ],
    ),
  );

  void _openMore(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => SafeArea(child: Wrap(children: [
        _tile(context, 'الصلاة', Icons.access_time_rounded, '/prayer'),
        _tile(context, 'القبلة', Icons.explore_rounded, '/qibla'),
        _tile(context, 'التقويم الإسلامي', Icons.calendar_month_rounded, '/calendar'),
        _tile(context, 'أسماء الله', Icons.auto_awesome_rounded, '/names'),
        _tile(context, 'التسبيح', Icons.radio_button_checked_rounded, '/tasbeeh'),
        _tile(context, 'الحج والعمرة', Icons.mosque_rounded, '/hajj-umrah'),
        _tile(context, 'المكتبة', Icons.local_library_rounded, '/library'),
        _tile(context, 'الصوت', Icons.headphones_rounded, '/audio'),
        _tile(context, 'الإعدادات', Icons.settings_rounded, '/settings'),
      ])),
    );
  }

  Widget _tile(BuildContext context, String title, IconData icon, String route) => ListTile(
    leading: Icon(icon), title: Text(title),
    onTap: () { Navigator.pop(context); context.push(route); },
  );
}
