import 'package:flutter/material.dart';
import 'package:media_picker/services/grant_permissions.dart';
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
    // Handle any exceptions that occur during album fetching
    debugPrint('Error fetching albums: $e');
    return []; // Return an empty list if an error occurs
  }
}
