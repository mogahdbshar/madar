import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MadarNotificationService {
  MadarNotificationService({FlutterLocalNotificationsPlugin? plugin})
      : plugin = plugin ?? FlutterLocalNotificationsPlugin();
  final FlutterLocalNotificationsPlugin plugin;

  Future<void> initialize() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await plugin.initialize(settings);
  }

  Future<void> showReminder({required int id, required String title, required String body}) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'madar_reminders',
        'تنبيهات مَدار',
        channelDescription: 'تنبيهات الأذكار والتنبيهات التي يختارها المستخدم',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    await plugin.show(id: id, title: title, body: body, notificationDetails: details);
  }
}
