import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/repository_providers.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/design_system/madar_ui.dart';
import '../domain/quran_models.dart';

final quranAyahsProvider = FutureProvider.family<List<QuranAyah>, int>(
  (ref, surah) => ref.watch(quranRepositoryProvider).getAyahs(surah),
);

class QuranReaderPage extends ConsumerStatefulWidget {
  const QuranReaderPage({super.key, required this.surahNumber});
  final int surahNumber;
  @override ConsumerState<QuranReaderPage> createState()=>_State();
}
class _State extends ConsumerState<QuranReaderPage> {
  int mode=1;
  @override Widget build(BuildContext context)=>MadarPage(
    title:'سورة '+widget.surahNumber.toString(),
    actions:[
      IconButton(
        tooltip:'حفظ موضع القراءة',
        onPressed:()=>ref.read(userDataRepositoryProvider).saveProgress(
          contentType:'quran-surah',contentId:widget.surahNumber.toString(),position:0),
        icon:const Icon(Icons.bookmark_add_rounded),
      ),
    ],
    child:ListView(padding:const EdgeInsets.all(18),children:[
      SegmentedButton<int>(
        segments:const [
          ButtonSegment(value:0,label:Text('مصحف'),icon:Icon(Icons.chrome_reader_mode_rounded)),
          ButtonSegment(value:1,label:Text('قراءة'),icon:Icon(Icons.text_fields_rounded)),
          ButtonSegment(value:2,label:Text('دراسة'),icon:Icon(Icons.school_rounded)),
        ],
        selected:{mode},onSelectionChanged:(v)=>setState(()=>mode=v.first),
      ),
      const SizedBox(height:18),
      ref.watch(quranAyahsProvider(widget.surahNumber)).when(
        loading:()=>const Center(child:CircularProgressIndicator()),
        error:(e,_)=>Text('تعذر تحميل الآيات: '+e.toString()),
        data:(ayahs)=>ayahs.isEmpty
          ? const MadarGlassCard(child:Text('لا توجد آيات في حزمة المحتوى المحلية الموثقة.'))
          : _content(context,ayahs),
      ),
    ]),
  );
  Widget _content(BuildContext context,List<QuranAyah> ayahs){
    if(mode==2)return Column(children:[
      const MadarGlassCard(child:Text('وضع الدراسة جاهز لعرض التفسير والترجمات والروابط عندما تكون حزمها الموثقة مثبتة.')),
      const SizedBox(height:12),...ayahs.map((a)=>_ayah(a,study:true)),
    ]);
    return Column(children:ayahs.map((a)=>_ayah(a,study:false)).toList());
  }
  Widget _ayah(QuranAyah ayah,{required bool study})=>MadarGlassCard(
    child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(ayah.text,textDirection:TextDirection.rtl,style:TextStyle(
        fontSize:study?24:28,height:1.9,fontWeight:FontWeight.w500)),
      const SizedBox(height:8),Align(alignment:AlignmentDirectional.centerStart,child:Text('آية '+ayah.ayahNumber.toString())),
      if(study)const Padding(padding:EdgeInsets.only(top:10),child:Text('المصدر والتفسير والترجمة تُعرض هنا فقط بعد تثبيت حزم موثقة ومرخصة.')),
    ]));
}
