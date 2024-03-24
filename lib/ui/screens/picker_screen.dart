import 'package:flutter/material.dart';
import 'package:media_picker/services/fetch_albums.dart';
import 'package:media_picker/services/fetch_medias.dart';
import 'package:media_picker/ui/components/media_grid_view.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../models/media.dart';

class PickerScreen extends StatefulWidget {
  final List<Media> selectedMedias;
  const PickerScreen({super.key, required this.selectedMedias});

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  // List to store selected media items
  final List<Media> _selectedMedias = [];

  AssetPathEntity? _currentAlbum;
  List<AssetPathEntity> _albums = [];
  // Method to load albums asynchronosly
  void _loadAlbums() async {
    // Fetch albums from service
    List<AssetPathEntity> albums = await fetchAlbums();
    if (albums.isNotEmpty) {
      setState(() {
        // Set the first album as the current album
        _currentAlbum = albums.first;
        //Update the list of albums
        _albums = albums;
      });

      // Load media items for the current album
      _loadMedias();
    }
  }

  final List<Media> _medias = [];
  int _lastPage = 0;
  int _currentPage = 0;
  // Method to load media items asynchronously
  void _loadMedias() async {
    // Store the current page as the last page
    _lastPage = _currentPage;
    if (_currentAlbum != null) {
      // Fetch media items for the current album
      List<Media> medias =
          await fetchMedias(album: _currentAlbum!, page: _currentPage);

      setState(() {
        // Add fetched media items to the list
        _medias.addAll(medias);
      });
    }
  }

  @override
  void initState() {
    // Add initially selected media items
    _selectedMedias.addAll(widget.selectedMedias);
    // Load albums when the screen initializes
    _loadAlbums();
    super.initState();
    // Add listener to scroll controller for loading more media items
    _scrollController.addListener(_loadMoreMedias);
  }

  final ScrollController _scrollController = ScrollController();

  // Method to load more media items when scrolling
  void _loadMoreMedias() {
    if (_scrollController.position.pixels /
            _scrollController.position.maxScrollExtent >
        0.33) {
      // Check if scrolled beyond 33% of the scroll extent
      if (_currentPage != _lastPage) {
        _loadMedias();
      }
    }
  }

  @override
  void dispose() {
    // Remove listener to avoid memory leaks
    _scrollController.removeListener(_loadMoreMedias);
    // Dispose scroll controller
    _scrollController.dispose();
    super.dispose();
  }

  // Method to select or deselect a media item
  void _selectMedia(Media media) {
    bool isSelected = _selectedMedias
        .any((element) => element.assetEntity.id == media.assetEntity.id);

    setState(() {
      if (isSelected) {
        // Deselect the media item if already selected
        _selectedMedias.removeWhere(
            (element) => element.assetEntity.id == media.assetEntity.id);
      } else {
        // Select the media item if not already selected
        _selectedMedias.add(media);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<AssetPathEntity>(
          borderRadius: BorderRadius.circular(16.0),
          value: _currentAlbum,
          items: _albums
              .map(
                (e) => DropdownMenuItem<AssetPathEntity>(
                  child: Text(e.name.isEmpty ? "0" : e.name),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              // Set the selected album as the current album
              _currentAlbum = value;
              // Reset current page to load from the beginning
              _currentPage = 0;
              // Reset last page
              _lastPage = 0;
              // Clear existing media items
              _medias.clear();
            });
            // Load media items for the selected album
            _loadMedias();
            // Scroll to the top
            _scrollController.jumpTo(0.0);
          },
        ),
      ),
      body: MediaGridView(
        medias: _medias,
        selectedMedias: _selectedMedias,
        selectMedia: _selectMedia,
        scrollController: _scrollController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context, _selectedMedias),
        child: const Icon(Icons.check_rounded),
      ),
    );
  }
}
