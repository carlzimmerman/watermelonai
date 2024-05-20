import 'dart:io';
import 'package:image/image.dart' as img; // Use a different import alias to avoid conflicts
import 'package:flutter/foundation.dart';

class ImageUtils {
  // Image Resizing
  static Future<File?> resizeImage(File imageFile, int targetWidth) async {
    try {
      final image = img.decodeImage(await imageFile.readAsBytes());
      if (image != null) {
        final resizedImage = img.copyResize(image, width: targetWidth);
        final newFile = await imageFile.writeAsBytes(img.encodePng(resizedImage));
        return newFile;
      }
    } catch (e) {
      debugPrint('Error resizing image: $e');
    }
    return null;
  }

// Image Rotation (if needed)
// ... (implement rotation logic here)

// Image Cropping (if needed)
// ... (implement cropping logic here)

// Other image manipulation functions...
}
