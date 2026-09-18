import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/repository_providers.dart';
import '../../../core/design_system/madar_ui.dart';
class HadithPage extends ConsumerStatefulWidget{const HadithPage({super.key});@override ConsumerState<HadithPage> createState()=>_State();}
class _State extends ConsumerState<HadithPage>{String q='';
 @override Widget build(BuildContext c)=>MadarPage(title:'الحديث',child:ListView(padding:const EdgeInsets.all(18),children:[
  TextField(onSubmitted:(v)=>setState(()=>q=v.trim()),decoration:const InputDecoration(prefixIcon:Icon(Icons.search_rounded),hintText:'ابحث في الأحاديث')),
  const SizedBox(height:16),
  if(q.isEmpty)const MadarGlassCard(child:Text('ابدأ البحث في الأحاديث المثبتة على جهازك.'))
  else FutureBuilder(future:ref.read(hadithRepositoryProvider).search(q),builder:(c,s){if(!s.hasData)return const Center(child:CircularProgressIndicator());final items=s.data!;if(items.isEmpty)return const Text('لا توجد نتائج.');return Column(children:items.map((h)=>MadarGlassCard(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(h.text,textDirection:TextDirection.rtl,style:const TextStyle(fontSize:19,height:1.7)),const SizedBox(height:8),Text('المصدر: '+h.source)])).toList());})
 ]));}