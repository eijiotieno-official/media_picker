import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaItem extends StatelessWidget {
  final Media media;
  final bool isSelected;
  final Function select;
  const MediaItem({
    super.key,
    required this.media,
    required this.isSelected,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => select(media),
      child: Stack(
        children: [
          media.widget,
          if (media.assetEntity.type == AssetType.video)
            const Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.play_arrow_rounded,
                  ),
                ),
              ),
            ),
          if (isSelected) _buildIsSelected(),
        ],
      ),
    );
  }

  Widget _buildIsSelected() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            const Positioned.fill(
              child: Center(
                child: Icon(Icons.check_rounded),
              ),
            ),
          ],
        ),
      );
}
