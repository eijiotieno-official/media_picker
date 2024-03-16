import 'package:photo_manager/photo_manager.dart';

Future<List<AssetPathEntity>> fetchAlbums() async {
  List<AssetPathEntity> albums = [];

  final PermissionState permissionState =
      await PhotoManager.requestPermissionExtend();

  if (permissionState.isAuth) {
    albums = await PhotoManager.getAssetPathList();
  } else if (permissionState.hasAccess) {
    albums = await PhotoManager.getAssetPathList();
  } else {
    await PhotoManager.openSetting();
  }

  return albums;
}
