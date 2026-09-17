import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/quran/presentation/quran_page.dart';
import '../../features/hadith/presentation/hadith_page.dart';
import '../../features/adhkar/presentation/adhkar_page.dart';
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
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/quran', builder: (_, __) => const QuranPage()),
    GoRoute(path: '/hadith', builder: (_, __) => const HadithPage()),
    GoRoute(path: '/adhkar', builder: (_, __) => const AdhkarPage()),
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
