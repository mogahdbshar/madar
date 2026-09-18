import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/repository_providers.dart';
import '../../../core/design_system/madar_ui.dart';
import '../domain/worship_models.dart';
class WorshipTrackingPage extends ConsumerStatefulWidget {
  const WorshipTrackingPage({super.key});
  @override ConsumerState<WorshipTrackingPage> createState() => _State();
}
class _State extends ConsumerState<WorshipTrackingPage> {
  final Map<String, bool> done = {'الفجر': false, 'الظهر': false, 'العصر': false, 'المغرب': false, 'العشاء': false, 'القرآن': false, 'الأذكار': false};
  WorshipType _type(String value) => switch (value) {
    'القرآن' => WorshipType.quran,
    'الأذكار' => WorshipType.adhkar,
    _ => WorshipType.prayer,
  };
  @override Widget build(BuildContext context) => MadarPage(title: 'متابعة العبادة', child: ListView(padding: const EdgeInsets.all(18), children: [
    const MadarGlassCard(child: Text('سجل عبادتك لنفسك. لا توجد نقاط أو منافسة.')),
    const SizedBox(height: 16),
    ...done.keys.map((key) => MadarGlassCard(child: CheckboxListTile(
      value: done[key],
      onChanged: (value) async {
        final completed = value ?? false;
        setState(() => done[key] = completed);
        await ref.read(worshipRepositoryProvider).save(WorshipEntry(id: key + '_' + DateTime.now().millisecondsSinceEpoch.toString(), type: _type(key), date: DateTime.now(), completed: completed));
      },
      title: Text(key), controlAffinity: ListTileControlAffinity.leading,
    ))),
  ]));
}
