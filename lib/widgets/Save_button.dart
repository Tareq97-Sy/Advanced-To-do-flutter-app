import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveButton extends StatelessWidget {
  SaveButton({super.key, required this.save, required this.clear});
  final VoidCallback save;
  final VoidCallback clear;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        save;
        clear;
        // Get.back();
      },
      style: ElevatedButton.styleFrom(
          fixedSize: Size(100, 43),
          elevation: 12.0,
          textStyle: const TextStyle(color: Colors.white)),
      child: const Text('Save Task'),
    );
  }
}
