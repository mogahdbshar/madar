import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/design_system/madar_ui.dart';
class NamesPage extends ConsumerWidget{
 const NamesPage({super.key});
 @override Widget build(BuildContext c,WidgetRef ref)=>MadarPage(title:'أسماء الله الحسنى',child:FutureBuilder(future:ref.read(appDatabaseProvider).select(ref.read(appDatabaseProvider).namesOfAllah).get(),builder:(c,s){
  if(!s.hasData)return const Center(child:CircularProgressIndicator());final items=s.data!;
  return ListView(padding:const EdgeInsets.all(18),children:[const MadarGlassCard(child:Text('الأسماء ومعانيها من حزمة موثقة مع المصدر عند توفره.')),const SizedBox(height:16),
   if(items.isEmpty)const Text('لا توجد حزمة أسماء موثقة مثبتة حالياً.')
   else ...items.map((n)=>Padding(padding:const EdgeInsets.only(bottom:10),child:MadarGlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(n.arabicName,style:Theme.of(c).textTheme.headlineSmall),Text(n.meaning),if(n.explanation!=null)Text(n.explanation!),Text('المصدر: '+n.sourceId)]))))
  ]);
 }));
}