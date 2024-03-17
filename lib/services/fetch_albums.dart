import 'package:media_picker/services/grant_permissions.dart';
import 'package:photo_manager/photo_manager.dart';

Future<List<AssetPathEntity>> fetchAlbums() async {
  await grantPermissions();

  List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();

  return albums;
}
