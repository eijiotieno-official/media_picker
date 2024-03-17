import 'package:permission_handler/permission_handler.dart';

Future<void> grantPermissions() async {
  final bool videosGranted = await Permission.videos.isGranted;
  final bool photosGranted = await Permission.videos.isGranted;

  // If permissions are not granted, request them
  if (!photosGranted || !videosGranted) {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.videos,
      Permission.photos,
    ].request();

    // If permissions are permanently denied, open app settings
    if (statuses[Permission.videos] == PermissionStatus.permanentlyDenied ||
        statuses[Permission.photos] == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  }
}
