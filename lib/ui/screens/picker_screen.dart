import 'package:flutter/material.dart';
import 'package:media_picker/services/fetch_albums.dart';
import 'package:photo_manager/photo_manager.dart';

class PickerScreen extends StatefulWidget {
  final List<AssetEntity> selectedEntities;
  const PickerScreen({super.key, required this.selectedEntities});

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  List<AssetEntity> _selectedEntities = [];

  void _selectEntity(AssetEntity entity) {
    bool isSelected =
        _selectedEntities.any((element) => element.id == entity.id);

    if (isSelected) {
      setState(() {
        _selectedEntities.removeWhere((element) => element.id == entity.id);
      });
    } else {
      setState(() {
        _selectedEntities.add(entity);
      });
    }
  }

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
        }
      },
    );
  }

  @override
  void initState() {
    _selectedEntities.addAll(widget.selectedEntities);
    _loadAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<AssetPathEntity>(
          value: _currentAlbum,
          items: _albums
              .map(
                (e) => DropdownMenuItem<AssetPathEntity>(
                  child: Text(
                    e.name,
                  ),
                ),
              )
              .toList(),
          onChanged: (AssetPathEntity? value) {
            setState(() {
              _currentAlbum = value;
            });
          },
        ),
      ),
    );
  }
}
