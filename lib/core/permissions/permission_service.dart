import 'package:permission_handler/permission_handler.dart';
class MadarPermissionService{
 const MadarPermissionService();
 Future<bool> requestNotifications() async => (await Permission.notification.request()).isGranted;
 Future<bool> requestLocation() async => (await Permission.locationWhenInUse.request()).isGranted;
 Future<void> openSystemSettings()=>openAppSettings();
}