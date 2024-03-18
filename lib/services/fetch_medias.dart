import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';

// Function to fetch media items from a specific album and page
Future<List<Media>> fetchMedias({
  required AssetPathEntity album, // The album from which to fetch media
  required int page, // The page number of media to fetch
}) async {
  List<Media> medias = []; // List to hold fetched media items

  try {
    // Get a list of asset entities from the specified album and page
    final List<AssetEntity> entities =
        await album.getAssetListPaged(page: page, size: 30);

    // Loop through each asset entity and create corresponding Media objects
    for (AssetEntity entity in entities) {
      Media media = Media(
        assetEntity: entity, // Assign the asset entity to the Media object
        // Create a FadeInImage widget to display the media thumbnail
        widget: FadeInImage(
          placeholder: MemoryImage(kTransparentImage), // Placeholder image
          fit: BoxFit.cover, // Set the fit mode to cover
          // Use AssetEntityImageProvider to load the media thumbnail
          image: AssetEntityImageProvider(
            entity,
            thumbnailSize: const ThumbnailSize.square(500), // Thumbnail size
            isOriginal: false, // Load a non-original (thumbnail) image
          ),
        ),
      );
      medias.add(media); // Add the created Media object to the list
    }
  } catch (e) {
    // Handle any exceptions that occur during fetching
    debugPrint('Error fetching media: $e');
  }

  return medias; // Return the list of fetched media items
}
