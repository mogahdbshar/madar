import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/repository_providers.dart';
import '../../../core/design_system/madar_ui.dart';
final quranSurahsProvider=FutureProvider((ref)=>ref.watch(quranRepositoryProvider).getSurahs());
class QuranPage extends ConsumerWidget{
 const QuranPage({super.key});
 @override Widget build(BuildContext context,WidgetRef ref)=>MadarPage(title:'القرآن',child:ListView(padding:const EdgeInsets.all(18),children:[
  MadarGlassCard(child:ListTile(leading:const Icon(Icons.bookmark_rounded),title:const Text('متابعة القراءة'),subtitle:const Text('آخر موضع محفوظ يظهر هنا'))),
  const SizedBox(height:18),
  MadarSection(title:'السور',child:ref.watch(quranSurahsProvider).when(
   loading:()=>const Center(child:CircularProgressIndicator()),
   error:(e,_)=>Text('تعذر تحميل السور: '+e.toString()),
   data:(items)=>items.isEmpty?const Text('لا توجد حزمة قرآن محلية مثبتة بعد.'):Column(children:items.map((s)=>ListTile(
    leading:CircleAvatar(child:Text(s.number.toString())),title:Text(s.nameArabic),subtitle:Text(s.nameLatin+' • '+s.ayahCount.toString()+' آية'),
    onTap:()=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('فتح سورة '+s.nameArabic+' سيُربط بقارئ الآيات في الدفعة التالية.')))
   )).toList())
  ))
 ]));
}