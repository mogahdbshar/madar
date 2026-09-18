import 'package:permission_handler/permission_handler.dart';

class MadarPermissionService {
  const MadarPermissionService();

  Future<bool> requestNotifications() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<bool> requestLocation() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  Future<bool> openSystemSettings() => openAppSettings();
}
