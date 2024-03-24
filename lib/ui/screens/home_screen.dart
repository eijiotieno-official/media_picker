import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';
import 'package:media_picker/ui/screens/picker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List to hold selected media items
  final List<Media> _selectedMedias = [];

  // Method to handle FloatingActionButton onPressed event
  Future<void> _handleFloatingActionButton() async {
    // Navigate to the picker screen
    final List<Media>? result = await Navigator.push<List<Media>>(
      context,
      MaterialPageRoute(
        builder: (context) => PickerScreen(
          selectedMedias: _selectedMedias,
        ),
      ),
    );

    if (result != null) {
      // Update selected media items with the result from the picker screen
      _updateSelectedMedias(result);
    }
  }

  void _updateSelectedMedias(List<Media> result) {
    setState(() {
      // Clear existing selected media items
      _selectedMedias.clear();
      // Add newly selected media items
      _selectedMedias.addAll(result);
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
            padding: const EdgeInsets.all(8.0),
            child: _selectedMedias[index].widget,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleFloatingActionButton,
        child: const Icon(
          Icons.image_rounded,
        ),
      ),
    );
  }
}
