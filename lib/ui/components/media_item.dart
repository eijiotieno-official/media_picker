import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:media_picker/models/media.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaItem extends StatelessWidget {
  final Media media;
  final bool isSelected;
  final Function selectMedia;
  const MediaItem({
    super.key,
    required this.media,
    required this.isSelected,
    required this.selectMedia,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMedia(media),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(isSelected ? 10.0 : 0.0),
              child: media.widget,
            ),
          ),
          if (media.assetEntity.type == AssetType.video && !isSelected)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          if (media.assetEntity.type == AssetType.video)
            const Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (isSelected) _buildIsSelected(),
        ],
      ),
    );
  }

  Widget _buildIsSelected() => Stack(
    children: [
      Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
      const Positioned.fill(
            child: Center(
              child: Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
    ],
  );
}
