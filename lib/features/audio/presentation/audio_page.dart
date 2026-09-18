import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_system/madar_ui.dart';
import '../data/audio_providers.dart';
class AudioPage extends ConsumerWidget{
 const AudioPage({super.key});
 @override Widget build(BuildContext context,WidgetRef ref)=>MadarPage(title:'الصوت',child:FutureBuilder(
  future:ref.read(audioRepositoryProvider).getTracks(),
  builder:(c,s){if(!s.hasData)return const Center(child:CircularProgressIndicator());final items=s.data!;
   return ListView(padding:const EdgeInsets.all(18),children:[
    const MadarGlassCard(child:Text('مشغل الصوت يعتمد على الملفات الموثقة المثبتة أو التي ينزلها المستخدم اختيارياً.')),
    const SizedBox(height:16),
    if(items.isEmpty)const Text('لا توجد ملفات صوتية موثقة مثبتة حالياً.')
    else ...items.map((t)=>Card(child:ListTile(leading:const Icon(Icons.play_circle_outline_rounded),title:Text(t.title),subtitle:Text('المصدر: '+t.source),onTap:()=>ref.read(madarAudioServiceProvider).play(t))))
   ]);
  }));
}