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
  late Future<List<WorshipEntry>> future;
  @override void initState() { super.initState(); _reload(); }
  void _reload() { future = ref.read(worshipRepositoryProvider).forDate(DateTime.now()); }
  @override Widget build(BuildContext context) => MadarPage(title: 'متابعة العبادة', child: FutureBuilder<List<WorshipEntry>>(
    future: future,
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
      final done = {for (final item in snapshot.data!) item.type: item.completed};
      return ListView(padding: const EdgeInsets.all(18), children: [
        const MadarGlassCard(child: Text('تتبع يومي هادئ، بدون نقاط أو منافسة.')),
        const SizedBox(height: 16),
        for (final type in WorshipType.values)
          SwitchListTile(
            title: Text(_label(type)),
            value: done[type] ?? false,
            onChanged: (value) async {
              final now = DateTime.now();
              await ref.read(worshipRepositoryProvider).save(WorshipEntry(
                id: type.name + ':' + now.year.toString() + '-' + now.month.toString() + '-' + now.day.toString(),
                type: type, date: now, completed: value,
              ));
              setState(_reload);
            },
          ),
      ]);
    },
  ));
  String _label(WorshipType type) => switch (type) {
    WorshipType.prayer => 'الصلاة',
    WorshipType.quran => 'القرآن',
    WorshipType.adhkar => 'الأذكار',
    WorshipType.tasbeeh => 'التسبيح',
  };
}
