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
      body: ListView.builder(
        itemCount: _selectedMedias.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: _selectedMedias[index].widget,
          );
        },
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
            setState(() {
              _selectedMedias.clear();
            });
            _updateSelectedMedias(result);
          }
        },
        child: const Icon(Icons.image_rounded),
      ),
    );
  }
}
