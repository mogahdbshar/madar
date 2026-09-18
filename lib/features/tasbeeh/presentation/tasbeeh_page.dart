import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/user_data_repository.dart';
import '../../../core/database/repository_providers.dart';
import '../../../core/design_system/madar_ui.dart';

class TasbeehPage extends ConsumerStatefulWidget {
  const TasbeehPage({super.key});
  @override ConsumerState<TasbeehPage> createState() => _State();
}

class _State extends ConsumerState<TasbeehPage> {
  int count = 0;
  int target = 33;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final repo = ref.read(userDataRepositoryProvider);
    final savedCount = await repo.getSetting('tasbeeh.count');
    final savedTarget = await repo.getSetting('tasbeeh.target');
    if (!mounted) return;
    setState(() {
      count = int.tryParse(savedCount ?? '') ?? 0;
      target = int.tryParse(savedTarget ?? '') ?? 33;
      loaded = true;
    });
  }

  Future<void> _save() async {
    final repo = ref.read(userDataRepositoryProvider);
    await repo.setSetting('tasbeeh.count', count.toString());
    await repo.setSetting('tasbeeh.target', target.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MadarPage(
      title: 'التسبيح',
      child: !loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(18),
              children: [
                MadarGlassCard(
                  child: Column(
                    children: [
                      Text(count.toString(), style: Theme.of(context).textTheme.displayLarge),
                      Text('الهدف: $target'),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: () async {
                          setState(() => count++);
                          await _save();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('تسبيح'),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          setState(() => count = 0);
                          await _save();
                        },
                        child: const Text('إعادة'),
                      ),
                      Wrap(
                        spacing: 8,
                        children: [33, 100, 300].map((value) => ChoiceChip(
                          label: Text(value.toString()),
                          selected: target == value,
                          onSelected: (_) async {
                            setState(() => target = value);
                            await _save();
                          },
                        )).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const MadarGlassCard(
                  child: Text('الجلسة محفوظة محلياً على الجهاز ويمكن استئنافها بعد إغلاق التطبيق.'),
                ),
              ],
            ),
    );
  }
}
