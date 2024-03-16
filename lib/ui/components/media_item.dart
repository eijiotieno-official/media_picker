import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';

class MediaItem extends StatelessWidget {
  final Media media;
  final bool isSelected;
  final VoidCallback select;
  const MediaItem({
    super.key,
    required this.media,
    required this.isSelected,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
