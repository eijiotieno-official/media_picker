// Function to fetch media items from a specific album and page
import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';

Future<List<Media>> fetchMedias({
  required AssetPathEntity album, // The album from which to fetch media
  required int page, // The page number of media to fetch
}) async {
  // List to hold the fetched media items
  List<Media> medias = [];

  try {
    // Get a list of asset entities from the specified album and page
    final List<AssetEntity> entities =
        await album.getAssetListPaged(page: page, size: 30);

    // Loop through each asset entity and create corresponding Media objects
    for (var entity in entities) {
      // Assign the asset entity to the Media object
      Media media = Media(
        assetEntity: entity,
        // Create a FadeInImage widget to display the media thumbnail
        widget: FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: AssetEntityImageProvider(
            entity,
            thumbnailSize: const ThumbnailSize.square(500),
            isOriginal: false,
          ),
          fit: BoxFit.cover,
        ),
      );

      // Add the created Media object to the list
      medias.add(media);
    }
  } catch (e) {
    debugPrint('Erro fetching media: $e');
  }

  // Return the list of fetched media items
  return medias;
}
