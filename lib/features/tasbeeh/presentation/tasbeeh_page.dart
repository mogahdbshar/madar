import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/design_system/madar_ui.dart';

class TasbeehPage extends ConsumerStatefulWidget {
  const TasbeehPage({super.key});
  @override ConsumerState<TasbeehPage> createState() => _State();
}
class _State extends ConsumerState<TasbeehPage> {
  int count = 0;
  int target = 33;
  @override Widget build(BuildContext context) => MadarPage(
    title: 'التسبيح',
    child: ListView(padding: const EdgeInsets.all(24), children: [
      MadarGlassCard(child: Column(children: [
        const Text('جلسة التسبيح'),
        const SizedBox(height: 8),
        Text('$count', style: Theme.of(context).textTheme.displayLarge),
        Text('الهدف $target'),
        const SizedBox(height: 18),
        SizedBox(height: 64, width: double.infinity, child: FilledButton(
          onPressed: () async {
            final next = count + 1;
            setState(() => count = next);
            await ref.read(userDataRepositoryProvider).saveProgress(
              contentType: 'tasbeeh', contentId: 'current', position: next);
          },
          child: const Text('تسبيح'),
        )),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton(onPressed: () => setState(() => count = 0), child: const Text('تصفير')),
          TextButton(onPressed: () => setState(() => target = target == 33 ? 100 : 33), child: const Text('تغيير الهدف')),
        ]),
      ])),
    ],
  );
}
