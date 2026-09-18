import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MadarNotificationService {
  MadarNotificationService({FlutterLocalNotificationsPlugin? plugin}):plugin=plugin??FlutterLocalNotificationsPlugin();
  final FlutterLocalNotificationsPlugin plugin;
  Future<void> initialize() async {
    const settings=InitializationSettings(android:AndroidInitializationSettings('@mipmap/ic_launcher'),iOS:DarwinInitializationSettings());
    await plugin.initialize(settings);
  }
  Future<bool> requestPermission() async {
    final android=plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final a=await android?.requestNotificationsPermission();
    final ios=plugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();
    final i=await ios?.requestPermissions(alert:true,badge:true,sound:true);
    return a??i??false;
  }
  Future<void> showReminder({required int id,required String title,required String body}) async {
    const details=NotificationDetails(
      android:AndroidNotificationDetails('madar_reminders','تنبيهات مَدار',channelDescription:'تنبيهات الأذكار والتنبيهات التي يختارها المستخدم',importance:Importance.high,priority:Priority.high),
      iOS:DarwinNotificationDetails());
    await plugin.show(id:id,title:title,body:body,notificationDetails:details);
  }
  Future<void> schedule({required int id,required String title,required String body,required DateTime dateTime}) async {
    const details=NotificationDetails(
      android:AndroidNotificationDetails('madar_scheduled','تنبيهات مَدار المجدولة',channelDescription:'تنبيهات يختارها المستخدم',importance:Importance.high,priority:Priority.high),
      iOS:DarwinNotificationDetails());
    await plugin.zonedSchedule(id:id,title:title,body:body,scheduledDate:TZDateTime.from(dateTime,local),notificationDetails:details,androidScheduleMode:AndroidScheduleMode.inexactAllowWhileIdle);
  }
}