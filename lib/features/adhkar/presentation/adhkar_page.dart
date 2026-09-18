import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/repository_providers.dart';
import '../../../core/design_system/madar_ui.dart';
class AdhkarPage extends ConsumerWidget{
 const AdhkarPage({super.key});
 @override Widget build(BuildContext c,WidgetRef ref)=>MadarPage(title:'الأذكار والأدعية',child:FutureBuilder(future:ref.read(dhikrRepositoryProvider).getAll(),builder:(c,s){
  if(!s.hasData)return const Center(child:CircularProgressIndicator());final items=s.data!;
  return ListView(padding:const EdgeInsets.all(18),children:[const MadarGlassCard(child:Text('الأذكار من الحزمة المحلية الموثقة، مع المصدر والعدد عند ثبوته.')),const SizedBox(height:16),
   if(items.isEmpty)const Text('لا توجد حزمة أذكار موثقة مثبتة حالياً.')
   else ...items.map((d)=>Padding(padding:const EdgeInsets.only(bottom:10),child:MadarGlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(d.text,textDirection:TextDirection.rtl,style:const TextStyle(fontSize:21,height:1.8)),Text('العدد: '+d.count.toString()),Text('المصدر: '+d.source)]))))
  ]);
 }));
}