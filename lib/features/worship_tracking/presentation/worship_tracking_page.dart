import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/repository_providers.dart';
import '../../../core/design_system/madar_ui.dart';
import '../domain/worship_models.dart';
class WorshipTrackingPage extends ConsumerStatefulWidget{const WorshipTrackingPage({super.key});@override ConsumerState<WorshipTrackingPage> createState()=>_State();}
class _State extends ConsumerState<WorshipTrackingPage>{
 final Map<String,bool> done={'الفجر':false,'الظهر':false,'العصر':false,'المغرب':false,'العشاء':false,'القرآن':false,'الأذكار':false};
 @override Widget build(BuildContext c)=>MadarPage(title:'متابعة العبادة',child:ListView(padding:const EdgeInsets.all(18),children:[
 const MadarGlassCard(child:Text('سجل عبادتك لنفسك. لا توجد نقاط أو منافسة.')),const SizedBox(height:16),
 ...done.keys.map((k)=>MadarGlassCard(child:CheckboxListTile(value:done[k],onChanged:(v)async{final value=v??false;setState(()=>done[k]=value);await ref.read(worshipRepositoryProvider).save(WorshipEntry(id:k+'_'+DateTime.now().millisecondsSinceEpoch.toString(),type:k,date:DateTime.now(),completed:value));},title:Text(k),controlAffinity:ListTileControlAffinity.leading)))
 ]));}