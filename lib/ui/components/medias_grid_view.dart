import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';
import 'package:media_picker/ui/components/media_item.dart';

class MediasGridView extends StatelessWidget {
  final List<Media> medias;
  final List<Media> selectedMedias;
  final VoidCallback select;
  const MediasGridView({
    super.key,
    required this.medias,
    required this.selectedMedias,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: medias.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
      ),
      itemBuilder: (context, index) => MediaItem(
        media: medias[index],
        isSelected: selectedMedias.any((element) =>
            element.assetEntity.id == medias[index].assetEntity.id),
        select: select,
      ),
    );
  }
}
