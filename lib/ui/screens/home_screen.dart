import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';
import 'package:media_picker/ui/screens/picker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Media> _selectedMedias = [];

  void _updateSelectedMedias(List<Media> entities) {
    setState(() {
      _selectedMedias.addAll(entities);
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
          List<Media>? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PickerScreen(selectedMedias: _selectedMedias);
              },
            ),
          );
          if (result != null) {
            _updateSelectedMedias(result);
          }
        },
        child: const Icon(Icons.image_rounded),
      ),
    );
  }
}
