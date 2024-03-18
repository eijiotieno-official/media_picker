import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

// Define a class to hold media assets and corresponding widgets
class Media {
  final AssetEntity
      assetEntity; // Represents a media asset managed by photo_manager
  final Widget widget; // Represents a Flutter widget associated with the asset
  Media({
    required this.assetEntity, // Initialize with a required AssetEntity
    required this.widget, // Initialize with a required Widget
  });
}
