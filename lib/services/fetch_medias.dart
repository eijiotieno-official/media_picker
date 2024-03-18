import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';

Future<List<Media>> fetchMedias({
  required AssetPathEntity album,
  required int page,
}) async {
  List<Media> medias = [];

  final List<AssetEntity> entities =
      await album.getAssetListPaged(page: page, size: 30);

  for (AssetEntity entity in entities) {
    Media media = Media(
      assetEntity: entity,
      widget: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        fit: BoxFit.cover,
        image: AssetEntityImageProvider(
          entity,
          thumbnailSize: const ThumbnailSize.square(500),
          isOriginal: false,
        ),
      ),
    );
    medias.add(media);
  }

  return medias;
}
