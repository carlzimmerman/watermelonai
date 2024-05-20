import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watermelonai/pages/camera_page.dart';
import 'package:watermelonai/providers/watermelon_provider.dart';


void main() => runApp(const WatermelonAIApp());

class WatermelonAIApp extends StatelessWidget {
  const WatermelonAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WatermelonProvider(),
      child: MaterialApp(
        title: 'Watermelon AI',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const CameraPage(), // Start with the camera page
      ),
    );
  }
}
