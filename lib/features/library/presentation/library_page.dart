import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/design_system/madar_ui.dart';
class LibraryPage extends ConsumerWidget{
 const LibraryPage({super.key});
 @override Widget build(BuildContext c,WidgetRef ref)=>MadarPage(title:'المكتبة الإسلامية',child:FutureBuilder(future:ref.read(appDatabaseProvider).select(ref.read(appDatabaseProvider).libraryItems).get(),builder:(c,s){
  if(!s.hasData)return const Center(child:CircularProgressIndicator());final items=s.data!;
  return ListView(padding:const EdgeInsets.all(18),children:[const MadarGlassCard(child:Text('المكتبة تعتمد على محتوى موثق ومرخص فقط.')),const SizedBox(height:16),
   if(items.isEmpty)const Text('لا توجد مواد مكتبية موثقة مثبتة حالياً.')
   else ...items.map((x)=>Padding(padding:const EdgeInsets.only(bottom:10),child:MadarGlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(x.title,style:Theme.of(c).textTheme.titleLarge),Text(x.category),if(x.author!=null)Text(x.author!),Text(x.content,maxLines:6,overflow:TextOverflow.ellipsis),Text('المصدر: '+x.sourceId)]))))
  ]);
 }));
}