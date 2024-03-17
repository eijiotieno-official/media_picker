import 'package:flutter/material.dart';
import 'package:media_picker/ui/screens/picker_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AssetEntity> _selectedEntities = [];

  void _updateSelectedEntities(List<AssetEntity> entities) {
    setState(() {
      _selectedEntities.addAll(entities);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Picker"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<AssetEntity>? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PickerScreen(selectedEntities: _selectedEntities);
              },
            ),
          );
          if (result != null) {
            _updateSelectedEntities(result);
          }
        },
        child: const Icon(Icons.image_rounded),
      ),
    );
  }
}
