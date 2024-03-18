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
  Future<void> _loadAlbums() async {
    await fetchAlbums().then(
      (value) {
        if (value.isNotEmpty) {
          setState(() {
            _currentAlbum = value.first;
            _albums = value;
          });
          _loadMedias();
        }
      },
    );
  }

  final ScrollController _scrollController = ScrollController();

  final List<Media> _medias = [];
  int _lastPage = 0;
  int _currentPage = 0;

  Future<void> _loadMedias() async {
    _lastPage = _currentPage;
    if (_currentAlbum != null) {
      await fetchMedias(album: _currentAlbum!, page: _currentPage).then(
        (value) {
          setState(() {
            _medias.addAll(value);
          });
        },
      );
    }
  }

  @override
  void initState() {
    _selectedMedias.addAll(widget.selectedMedias);
    _loadAlbums();

    super.initState();

    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels /
                _scrollController.position.maxScrollExtent >
            0.33) {
          if (_currentPage != _lastPage) {
            _loadMedias();
          }
        }
      },
    );
  }

  final List<Media> _selectedMedias = [];

  void _selectMedia(Media media) {
    bool isSelected = _selectedMedias
        .any((element) => element.assetEntity.id == media.assetEntity.id);

    if (isSelected) {
      setState(() {
        _selectedMedias.removeWhere(
            (element) => element.assetEntity.id == media.assetEntity.id);
      });
    } else {
      setState(() {
        _selectedMedias.add(media);
      });
    }
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
                  child: Text(
                    e.name.isEmpty ? "0" : e.name,
                  ),
                ),
              )
              .toList(),
          onChanged: (AssetPathEntity? value) {
            setState(() {
              _currentAlbum = value;
              _currentPage = 0;
              _lastPage = 0;
              _medias.clear();
            });
            _loadMedias();
            _scrollController.jumpTo(0.0);
          },
        ),
      ),
      body: MediasGridView(
        medias: _medias,
        selectedMedias: _selectedMedias,
        selectMedia: _selectMedia,
        scrollController: _scrollController,
      ),
      floatingActionButton: _selectedMedias.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () => Navigator.pop(context, _selectedMedias),
              child: const Icon(Icons.check_rounded),
            ),
    );
  }
}
