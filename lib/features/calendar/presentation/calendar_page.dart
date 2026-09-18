import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/calendar/hijri_converter.dart';
import '../../../core/design_system/madar_ui.dart';
class CalendarPage extends StatelessWidget{
 const CalendarPage({super.key});
 @override Widget build(BuildContext context){
  final now=DateTime.now(),h=const HijriConverter().fromGregorian(now);
  return MadarPage(title:'التقويم الإسلامي',child:ListView(padding:const EdgeInsets.all(18),children:[
   MadarGlassCard(child:Column(children:[Text(DateFormat('EEEE d MMMM yyyy','ar').format(now)),const SizedBox(height:8),Text(h.day.toString()+' / '+h.month.toString()+' / '+h.year.toString()+' هـ',style:Theme.of(context).textTheme.headlineSmall),const SizedBox(height:6),const Text('التاريخ الحسابي قد يختلف عن ثبوت الهلال والمنهجية المحلية.') ])),
   const SizedBox(height:18),const MadarGlassCard(child:Text('ستظهر المناسبات الإسلامية من حزمة موثقة مع منهجيتها ومصدرها.'))
  ]));
 }
}