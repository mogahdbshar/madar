import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/design_system/madar_theme.dart';
import '../core/routing/app_router.dart';
class MadarApp extends ConsumerWidget {
 const MadarApp({super.key});
 @override Widget build(BuildContext context,WidgetRef ref)=>MaterialApp.router(
  title:'مَدار | MADAR',debugShowCheckedModeBanner:false,theme:MadarTheme.light(),darkTheme:MadarTheme.dark(),
  themeMode:ThemeMode.system,routerConfig:ref.watch(appRouterProvider),locale:const Locale('ar'),
  supportedLocales:const [Locale('ar'),Locale('en')]);
}
