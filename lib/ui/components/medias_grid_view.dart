import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';
import 'package:media_picker/ui/components/media_item.dart';

// Widget to display a grid of media items
class MediasGridView extends StatelessWidget {
  final List<Media> medias; // List of all media items
  final List<Media> selectedMedias; // List of selected media items
  final Function(Media) selectMedia; // Callback function to select a media item
  final ScrollController scrollController; // Controller for scrolling

  const MediasGridView({
    super.key, // Unique identifier for the widget
    required this.medias, // List of all media items
    required this.selectedMedias, // List of selected media items
    required this.selectMedia, // Callback function to select a media item
    required this.scrollController, // Controller for scrolling
  }); // Passes the key to the super constructor

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: GridView.builder(
        controller: scrollController, // Assign the provided scroll controller
        physics: const BouncingScrollPhysics(), // Apply bouncing scroll physics
        itemCount: medias.length, // Set the number of items in the grid
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columns in the grid
          mainAxisSpacing: 3, // Spacing between rows
          crossAxisSpacing: 3, // Spacing between columns
        ),
        itemBuilder: (context, index) => MediaItem(
          // Build each media item using the MediaItem widget
          media: medias[index], // Pass the current media item
          isSelected: selectedMedias.any((element) =>
              element.assetEntity.id ==
              medias[index]
                  .assetEntity
                  .id), // Check if the media item is selected
          selectMedia: selectMedia, // Pass the selectMedia callback function
        ),
      ),
    );
  }
}
