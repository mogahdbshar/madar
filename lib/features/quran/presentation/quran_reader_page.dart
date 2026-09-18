import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/repository_providers.dart';
import '../../../core/design_system/madar_ui.dart';
import '../domain/quran_models.dart';
final quranAyahsProvider = FutureProvider.family<List<QuranAyah>, int>((ref, surah) => ref.watch(quranRepositoryProvider).getAyahs(surah));
class QuranReaderPage extends ConsumerStatefulWidget {
  const QuranReaderPage({super.key, required this.surahNumber});
  final int surahNumber;
  @override ConsumerState<QuranReaderPage> createState() => _State();
}
class _State extends ConsumerState<QuranReaderPage> {
  int mode = 1;
  @override Widget build(BuildContext context) => MadarPage(
    title: 'سورة ' + widget.surahNumber.toString(),
    actions: [IconButton(
      tooltip: 'حفظ موضع القراءة',
      onPressed: () => ref.read(userDataRepositoryProvider).saveProgress(contentType: 'quran-surah', contentId: widget.surahNumber.toString(), position: 0),
      icon: const Icon(Icons.bookmark_add_rounded),
    )],
    child: ListView(padding: const EdgeInsets.all(18), children: [
      SegmentedButton<int>(
        segments: const [
          ButtonSegment(value: 0, label: Text('مصحف'), icon: Icon(Icons.chrome_reader_mode_rounded)),
          ButtonSegment(value: 1, label: Text('قراءة'), icon: Icon(Icons.text_fields_rounded)),
          ButtonSegment(value: 2, label: Text('دراسة'), icon: Icon(Icons.school_rounded)),
        ],
        selected: {mode}, onSelectionChanged: (v) => setState(() => mode = v.first),
      ),
      const SizedBox(height: 18),
      ref.watch(quranAyahsProvider(widget.surahNumber)).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('تعذر تحميل الآيات: ' + e.toString()),
        data: (ayahs) => ayahs.isEmpty ? const MadarGlassCard(child: Text('لا توجد آيات في الحزمة المحلية.')) : _content(ayahs),
      ),
    ]),
  );
  Widget _content(List<QuranAyah> ayahs) => Column(children: [
    if (mode == 2) const MadarGlassCard(child: Text('وضع الدراسة يعرض النص الموثق. التفسير والترجمات تظهر عند تثبيت حزمها المرخصة.')),
    ...ayahs.map((a) => MadarGlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(a.text, textDirection: TextDirection.rtl, style: TextStyle(fontSize: mode == 2 ? 24 : 28, height: 1.9, fontWeight: FontWeight.w500)),
      const SizedBox(height: 8), Text('آية ' + a.ayahNumber.toString()),
    ]))),
  ]);
}
