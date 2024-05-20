import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watermelonai/pages/image_preview_page.dart';
import 'package:watermelonai/providers/watermelon_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      if (_imageFile != null) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePreviewPage(imagePath: _imageFile!.path),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watermelon AI '),
      ),
      body: Center(
        child: Text("Take a picture or upload a photo of a watermelon"),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'cameraFab', // Assign a unique hero tag
            onPressed: () => _getImage(ImageSource.camera),
            tooltip: 'Take Photo',
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 16.0),
          FloatingActionButton(
            heroTag: 'galleryFab', // Assign a unique hero tag
            onPressed: () => _getImage(ImageSource.gallery),
            tooltip: 'Pick from Gallery',
            child: const Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}
