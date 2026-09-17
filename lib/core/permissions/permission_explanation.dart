enum MadarPermission {
  notifications,
  location,
  exactAlarms,
  sensors,
}

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
