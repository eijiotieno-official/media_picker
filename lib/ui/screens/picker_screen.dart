import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';
import 'package:media_picker/services/fetch_albums.dart';
import 'package:media_picker/services/fetch_medias.dart';
import 'package:media_picker/ui/components/medias_grid_view.dart';
import 'package:photo_manager/photo_manager.dart';

class PickerScreen extends StatefulWidget {
  final List<Media> selectedMedias;

  const PickerScreen({super.key, required this.selectedMedias});

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  AssetPathEntity? _currentAlbum;
  List<AssetPathEntity> _albums = [];
  final ScrollController _scrollController =
      ScrollController(); // ScrollController for handling scrolling behavior
  final List<Media> _medias = [];
  int _lastPage = 0;
  int _currentPage = 0;
  final List<Media> _selectedMedias = []; // List to store selected media items

  @override
  void initState() {
    super.initState();
    _selectedMedias
        .addAll(widget.selectedMedias); // Add initially selected media items
    _loadAlbums(); // Load albums when the screen initializes
    _scrollController.addListener(
        _loadMoreMedias); // Add listener to scroll controller for loading more media items
  }

  @override
  void dispose() {
    _scrollController.removeListener(
        _loadMoreMedias); // Remove listener to avoid memory leaks
    _scrollController.dispose(); // Dispose scroll controller
    super.dispose();
  }

  // Method to load albums asynchronously
  void _loadAlbums() async {
    List<AssetPathEntity> albums =
        await fetchAlbums(); // Fetch albums from service
    if (albums.isNotEmpty) {
      setState(() {
        _currentAlbum =
            albums.first; // Set the first album as the current album
        _albums = albums; // Update the list of albums
      });
      _loadMedias(); // Load media items for the current album
    }
  }

  // Method to load media items asynchronously
  void _loadMedias() async {
    _lastPage = _currentPage; // Store the current page as the last page
    if (_currentAlbum != null) {
      List<Media> medias = await fetchMedias(
          album: _currentAlbum!,
          page: _currentPage); // Fetch media items for the current album
      setState(() {
        _medias.addAll(medias); // Add fetched media items to the list
      });
    }
  }

  // Method to load more media items when scrolling
  void _loadMoreMedias() {
    if (_scrollController.position.pixels /
            _scrollController.position.maxScrollExtent >
        0.33) {
      // Check if scrolled beyond 33% of the scroll extent
      if (_currentPage != _lastPage) {
        _loadMedias(); // Load more media items
      }
    }
  }

  // Method to select or deselect a media item
  void _selectMedia(Media media) {
    bool isSelected = _selectedMedias.any((element) =>
        element.assetEntity.id ==
        media.assetEntity.id); // Check if the media item is already selected
    setState(() {
      if (isSelected) {
        _selectedMedias.removeWhere((element) =>
            element.assetEntity.id ==
            media
                .assetEntity.id); // Deselect the media item if already selected
      } else {
        _selectedMedias
            .add(media); // Select the media item if not already selected
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
                  value: e,
                  child: Text(e.name.isEmpty
                      ? "0"
                      : e.name), // Display album name in dropdown
                ),
              )
              .toList(),
          onChanged: (AssetPathEntity? value) {
            setState(() {
              _currentAlbum =
                  value; // Set the selected album as the current album
              _currentPage = 0; // Reset current page to load from the beginning
              _lastPage = 0; // Reset last page
              _medias.clear(); // Clear existing media items
            });
            _loadMedias(); // Load media items for the selected album
            _scrollController.jumpTo(0.0); // Scroll to the top
          },
        ),
      ),
      body: MediasGridView(
        medias: _medias, // Pass the list of media items to the grid view
        selectedMedias:
            _selectedMedias, // Pass the list of selected media items to the grid view
        selectMedia:
            _selectMedia, // Pass the method to select or deselect a media item
        scrollController:
            _scrollController, // Pass the scroll controller to the grid view
      ),
      floatingActionButton: _selectedMedias.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () => Navigator.pop(context,
                  _selectedMedias), // Close the screen and pass selected media items back
              child: const Icon(Icons.check_rounded), // Display check icon
            ),
    );
  }
}
