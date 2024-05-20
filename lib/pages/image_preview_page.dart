import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watermelonai/pages/watermelon_display_plage.dart';
import '../providers/watermelon_provider.dart';

class ImagePreviewPage extends StatelessWidget {
  final String imagePath;

  const ImagePreviewPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'checkFab',
        onPressed: () async {
          await Provider.of<WatermelonProvider>(context, listen: false)
              .analyzeWatermelon(imagePath); // Use the correct method name

          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WatermelonDisplayPage()),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
