enum MadarPermission { notifications, location, exactAlarms, sensors }

class PermissionExplanation {
  const PermissionExplanation({
    required this.permission,
    required this.title,
    required this.reason,
  });
  final MadarPermission permission;
  final String title;
  final String reason;
}

abstract final class PermissionCatalog {
  static const notifications = PermissionExplanation(
    permission: MadarPermission.notifications,
    title: 'الإشعارات',
    reason: 'لإشعارات الأذان والأذكار والتنبيهات التي تختارها.',
  );
  static const location = PermissionExplanation(
    permission: MadarPermission.location,
    title: 'الموقع',
    reason: 'لحساب مواقيت الصلاة واتجاه القبلة تلقائيًا.',
  );
  static const exactAlarms = PermissionExplanation(
    permission: MadarPermission.exactAlarms,
    title: 'التنبيهات الدقيقة',
    reason: 'تُستخدم فقط إذا كانت ميزة اختارها المستخدم تحتاج توقيتًا دقيقًا فعلًا.',
  );
  static const sensors = PermissionExplanation(
    permission: MadarPermission.sensors,
    title: 'حساسات الجهاز',
    reason: 'لاستخدام البوصلة والحساب الحركي لاتجاه القبلة.',
  );
}
