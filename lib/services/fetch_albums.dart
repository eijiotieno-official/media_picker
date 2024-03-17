import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

Future<List<AssetPathEntity>> fetchAlbums() async {
  List<AssetPathEntity> albums = [];

  // final PermissionState permissionState =
  //     await PhotoManager.requestPermissionExtend();

  final bool storageGranted = await Permission.storage.isGranted;

  // If permissions are not granted, request them
  if (!storageGranted) {
    final Map<Permission, PermissionStatus> statuses = await [
      // Permission.audio,
      Permission.storage,
    ].request();

    // If permissions are permanently denied, open app settings
    if (statuses[Permission.storage] == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  } else {
    albums = await PhotoManager.getAssetPathList();
  }

  // if (permissionState.isAuth) {
  //   albums = await PhotoManager.getAssetPathList();
  // } else if (permissionState.hasAccess) {
  //   albums = await PhotoManager.getAssetPathList();
  // } else {
  //   await PhotoManager.openSetting();
  // }

  return albums;
}
