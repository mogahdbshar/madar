import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/repository_providers.dart';
import '../../../core/design_system/madar_ui.dart';
import '../data/hadith_download_service.dart';

class HadithPage extends ConsumerStatefulWidget {
  const HadithPage({super.key});
  @override ConsumerState<HadithPage> createState() => _State();
}

class _State extends ConsumerState<HadithPage> {
  String q = '';
  String? downloading;

  Future<void> _download(String key) async {
    setState(() => downloading = key);
    try {
      final count = await const HadithDownloadService()
          .installCollection(ref.read(appDatabaseProvider), key);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تثبيت ' + count.toString() + ' حديثاً.')),
      );
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذر تثبيت المجموعة: ' + e.toString())),
      );
    } finally {
      if (mounted) setState(() => downloading = null);
    }
  }

  @override
  Widget build(BuildContext c) => MadarPage(
    title: 'الحديث',
    child: ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const MadarGlassCard(
          child: Text('مصادر الحديث تُنزّل من مصدر مفتوح مرخّص ومثبت بإصدار محدد. لا يكتب مَدار الحديث من الذاكرة ولا يغيّر نصه.'),
        ),
        const SizedBox(height: 14),
        MadarSection(
          title: 'المجموعات',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: HadithDownloadService.collections.entries.take(9).map((e) => FilledButton.tonal(
              onPressed: downloading == null ? () => _download(e.key) : null,
              child: Text(downloading == e.key ? 'جاري التنزيل...' : e.value),
            )).toList(),
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          onSubmitted: (v) => setState(() => q = v.trim()),
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'ابحث في الأحاديث المثبتة'),
        ),
        const SizedBox(height: 16),
        if (q.isEmpty)
          const MadarGlassCard(child: Text('ثبّت مجموعة أولاً، ثم ابحث فيها محلياً دون اتصال.'))
        else
          FutureBuilder(
            future: ref.read(hadithRepositoryProvider).search(q),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              final items = snapshot.data!;
              if (items.isEmpty) return const Text('لا توجد نتائج.');
              return Column(children: items.map((h) => MadarGlassCard(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(h.text, textDirection: TextDirection.rtl, style: const TextStyle(fontSize: 19, height: 1.7)),
                  const SizedBox(height: 8),
                  Text('المصدر: ' + h.source),
                ]),
              )).toList());
            },
          ),
      ],
    ),
  );
}
