import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class MadarNotificationService{
 MadarNotificationService({FlutterLocalNotificationsPlugin? plugin}):plugin=plugin??FlutterLocalNotificationsPlugin();
 final FlutterLocalNotificationsPlugin plugin;
 Future<void> initialize()async{tz.initializeTimeZones();const s=InitializationSettings(android:AndroidInitializationSettings('@mipmap/ic_launcher'),iOS:DarwinInitializationSettings());await plugin.initialize(s);}
 Future<bool> requestPermission()async{final a=plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();final ar=await a?.requestNotificationsPermission();final i=plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();final ir=await i?.requestPermissions(alert:true,badge:true,sound:true);return ar??ir??false;}
 Future<void> showReminder({required int id,required String title,required String body})async{const d=NotificationDetails(android:AndroidNotificationDetails('madar_reminders','تنبيهات مَدار',channelDescription:'تنبيهات يختارها المستخدم',importance:Importance.high,priority:Priority.high),iOS:DarwinNotificationDetails());await plugin.show(id:id,title:title,body:body,notificationDetails:d);}
 Future<void> schedule({required int id,required String title,required String body,required DateTime dateTime})async{const d=NotificationDetails(android:AndroidNotificationDetails('madar_scheduled','تنبيهات يختارها المستخدم',importance:Importance.high,priority:Priority.high),iOS:DarwinNotificationDetails());await plugin.zonedSchedule(id:id,title:title,body:body,scheduledDate:tz.TZDateTime.from(dateTime,tz.local),notificationDetails:d,androidScheduleMode:AndroidScheduleMode.inexactAllowWhileIdle);}
}