import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/watermelon.dart';

class WatermelonService {
  static Future<Watermelon?> analyzeWatermelon(String imagePath) async {


    final apiKey = 'GEMINI_API_KEY'; // Replace with your actual API key


    if (apiKey == null) {
      throw Exception('API Key not found.');
    }

    final imageFile = File(imagePath);
    final imageBytes = await imageFile.readAsBytes();

    final model = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: apiKey,
    );

    final prompt = '''
Analyze the given image of a watermelon and provide information about it in a valid JSON object.

Include the following details:

* **name:** (if identifiable, otherwise "Watermelon")
* **size:** ("Small", "Medium", "Large")
* **juicyness:** ("Low", "Medium", "High", "Very High")
* **symmetry:** ("Poor", "Average", "Good", "Excellent")
* **freshness:** ("Old", "Ripe", "Just Picked")


Example output:

{
  "name": "Watermelon",
  "size": "Large",
  "juicyness": "High",
  "symmetry": "Good",
  "freshness": "Ripe"
}

Important:
- Only return a single valid JSON object.
- Avoid using characters that can break JSON formatting, such as unescaped quotes or symbols like &.
- Ensure every string is enclosed in double quotes.
- Make sure all fields are complete and the JSON object is not cut off.
Output:
''';  // Added for clarity

    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', Uint8List.fromList(imageBytes)),
      ])
    ];

    final response = await model.generateContent(content);

    if (response.candidates != null && response.candidates!.isNotEmpty) {
      final candidate = response.candidates!.first;

      if (candidate.content.parts != null && candidate.content.parts.isNotEmpty) {
        final textPart = candidate.content.parts.firstWhere(
              (part) => part is TextPart,
          orElse: () => TextPart(''),
        ) as TextPart;

        if (textPart.text.isNotEmpty) {
          try {
            // Clean up the response text
            var cleanedText = textPart.text
                .replaceAll('```json', '') // Remove code block markers
                .replaceAll('```', '')
                .trim();

            // Ensure all special characters are properly escaped
            cleanedText = json.encode(json.decode(cleanedText));

            final extractedData = jsonDecode(cleanedText);
            if (extractedData is Map<String, dynamic>) {
              return Watermelon.fromJson(extractedData);
            }
          } catch (e) {
            debugPrint('JSON parsing error: $e');
          }
        }
      }
    }

    return null;
  }
}
