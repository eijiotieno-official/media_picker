import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

// Define a class to hold media assets and corresponding widgets
class Media {
  // Represents a media asset managed by photo_manager
  final AssetEntity assetEntity;
  // Represents a Flutter widget associated with the asset
  final Widget widget;
  Media({
    required this.assetEntity,
    required this.widget,
  });
}
