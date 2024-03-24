import 'package:flutter/material.dart';
import 'package:media_picker/services/grant_permission.dart';
import 'package:photo_manager/photo_manager.dart';

// Function to fetch albums while ensuring necessary permissions are granted
Future<List<AssetPathEntity>> fetchAlbums() async {
  try {
    // Ensure permissions are granted before fetching albums
    await grantPermissions();

    // Fetch the list of asset paths (albums)
    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();

    return albums;
  } catch (e) {
    // Handle any execeptions that occur during albums fetching
    debugPrint('Error fetching albums: $e');
    return [];
  }
}
