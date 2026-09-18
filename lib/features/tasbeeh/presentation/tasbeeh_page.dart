import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';
class TasbeehPage extends StatefulWidget{const TasbeehPage({super.key});@override State<TasbeehPage> createState()=>_State();}
class _State extends State<TasbeehPage>{int count=0;int target=33;
 @override Widget build(BuildContext c)=>MadarPage(title:'التسبيح',child:ListView(padding:const EdgeInsets.all(18),children:[
 MadarGlassCard(child:Column(children:[Text(count.toString(),style:Theme.of(c).textTheme.displayLarge),Text('الهدف: $target'),const SizedBox(height:20),FilledButton(onPressed:()=>setState(()=>count++),child:const Padding(padding:EdgeInsets.all(20),child:Text('تسبيح'))),TextButton(onPressed:()=>setState(()=>count=0),child:const Text('إعادة'))])),
 const SizedBox(height:16),const MadarGlassCard(child:Text('اختيار الذكر وعدده سيتم من المحتوى الموثق، مع حفظ الجلسات محلياً.'))
 ]));}