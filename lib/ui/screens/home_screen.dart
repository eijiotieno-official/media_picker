import 'package:flutter/material.dart';
import 'package:media_picker/models/media.dart';
import 'package:media_picker/ui/screens/picker_screen.dart';

// Home screen widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

// State class for the home screen
class _HomeScreenState extends State<HomeScreen> {
  final List<Media> _selectedMedias = []; // List to hold selected media items

  // Method to update selected media items
  void _updateSelectedMedias(List<Media> entities) {
    setState(() {
      _selectedMedias.clear(); // Clear existing selected media items
      _selectedMedias.addAll(entities); // Add newly selected media items
    });
  }

  // Method to handle FloatingActionButton onPressed event
  Future<void> _handleFloatingActionButton() async {
    final List<Media>? result = await Navigator.push<List<Media>>(
      // Navigate to the picker screen
      context,
      MaterialPageRoute(
        builder: (context) => PickerScreen(
            selectedMedias:
                _selectedMedias), // Pass the selected media items to the picker screen
      ),
    );
    if (result != null) {
      _updateSelectedMedias(
          result); // Update selected media items with the result from the picker screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Media Picker"), // App bar title
      ),
      body: ListView.builder(
        itemCount: _selectedMedias.length, // Number of selected media items
        physics: const BouncingScrollPhysics(), // Apply bouncing scroll physics
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              // Apply padding to each selected media item
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child:
                _selectedMedias[index].widget, // Display selected media widget
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            _handleFloatingActionButton, // Call _handleFloatingActionButton method when FloatingActionButton is pressed
        child: const Icon(Icons.image_rounded), // Floating action button icon
      ),
    );
  }
}
