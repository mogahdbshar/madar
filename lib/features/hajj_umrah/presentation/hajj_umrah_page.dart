import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';
class HajjUmrahPage extends StatelessWidget{
 const HajjUmrahPage({super.key});
 @override Widget build(BuildContext c)=>MadarPage(title:'الحج والعمرة',child:ListView(padding:const EdgeInsets.all(18),children:[
  const MadarGlassCard(child:Text('الدليل لا يعرض حكماً دينياً من الذاكرة. عند تثبيت حزمة موثقة ستظهر خطوات المناسك ومصادر كل حكم ودعاء.')),
  const SizedBox(height:16),
  for(final x in ['الإحرام والمواقيت','ترتيب المناسك','الأدعية والأذكار','الأخطاء الشائعة','وضع المتابعة'])
   Padding(padding:const EdgeInsets.only(bottom:10),child:MadarFeatureTile(icon:Icons.checklist_rounded,title:x,subtitle:'بانتظار حزمة المحتوى الموثقة',onTap:(){}))
 ]));
}