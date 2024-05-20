import 'package:flutter/foundation.dart';
import '../models/watermelon.dart';
import '../services/watermelon_service.dart';

class WatermelonProvider extends ChangeNotifier {
  Watermelon? _watermelonData;
  String? _imagePath; // Add imagePath to store the path

  Watermelon? get watermelonData => _watermelonData;
  String? get imagePath => _imagePath; // Add getter for imagePath

  Future<void> analyzeWatermelon(String imagePath) async {
    try {
      final analyzedData = await WatermelonService.analyzeWatermelon(imagePath);
      _watermelonData = analyzedData;
      _imagePath = imagePath; // Store the imagePath
    } catch (e) {
      _watermelonData = null;
      _imagePath = null;
    } finally {
      notifyListeners();
    }
  }
}

