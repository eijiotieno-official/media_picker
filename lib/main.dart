import 'package:flutter/material.dart';
import 'package:media_picker/ui/screens/home_screen.dart';

void main() {
  runApp(const MainApp()); // Entry point of the application
}

class MainApp extends StatelessWidget {
  const MainApp({super.key}); // Constructor for MainApp widget

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(), // Set HomeScreen as the home page of the MaterialApp
    );
  }
}
