import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';

// Widget to display a media item with optional selection overlay
class MediaItem extends StatelessWidget {
  final Media media; // The media to display
  final bool isSelected; // Indicates whether the media is selected
  final Function selectMedia; // Callback function when the media is tapped

  const MediaItem({
    required this.media, // The media to display
    required this.isSelected, // Indicates whether the media is selected
    required this.selectMedia, // Callback function when the media is tapped
    super.key, // Unique identifier for the widget
  }); // Passes the key to the super constructor

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          selectMedia(media), // Callback function when the media is tapped
      child: Stack(
        children: [
          _buildMediaWidget(), // Display the media widget with optional padding
          if (isSelected)
            _buildIsSelectedOverlay(), // Display the selected overlay if the media is selected
        ],
      ),
    );
  }

  // Build the media widget with optional padding
  Widget _buildMediaWidget() {
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.all(
            isSelected ? 10.0 : 0.0), // Apply padding if the media is selected
        child: media.widget, // Display the media widget
      ),
    );
  }

  // Build the selected overlay
  Widget _buildIsSelectedOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.1), // Semi-transparent black overlay
        child: const Center(
          child: Icon(
            Icons.check_circle_rounded, // Checkmark icon
            color: Colors.white, // White color for the icon
            size: 30, // Size of the icon
          ),
        ),
      ),
    );
  }
}
