import 'package:flutter/material.dart';
import '../../../core/design_system/madar_ui.dart';
import '../domain/prayer_calculator.dart';
import '../domain/prayer_calculation.dart';
import '../domain/prayer_models.dart';
class PrayerPage extends StatelessWidget{const PrayerPage({super.key});
 @override Widget build(BuildContext c){final now=DateTime.now();final times=const PrayerCalculator().calculate(date:now,latitude:13.58,longitude:44.02,timeZoneOffsetHours:3,settings:const PrayerCalculationSettings(method:PrayerCalculationMethod.muslimWorldLeague));
 return MadarPage(title:'الصلاة',child:ListView(padding:const EdgeInsets.all(18),children:[const MadarGlassCard(child:Text('المواقيت الحالية مبنية على إحداثيات افتراضية ويمكن استبدالها بموقع المستخدم أو مدينة يختارها.')),const SizedBox(height:16),...times.map((p)=>ListTile(title:Text(_name(p.name)),trailing:Text(p.dateTime.hour.toString().padLeft(2,'0')+':'+p.dateTime.minute.toString().padLeft(2,'0')))]);}
 String _name(PrayerName n)=>switch(n){PrayerName.fajr=>'الفجر',PrayerName.sunrise=>'الشروق',PrayerName.dhuhr=>'الظهر',PrayerName.asr=>'العصر',PrayerName.maghrib=>'المغرب',PrayerName.isha=>'العشاء',PrayerName.qiyam=>'قيام الليل'};
}