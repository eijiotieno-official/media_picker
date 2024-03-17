import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _selectedEntities.addAll(widget.selectedEntities);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
