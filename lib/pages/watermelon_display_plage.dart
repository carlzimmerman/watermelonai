import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/watermelon.dart';
import '../providers/watermelon_provider.dart';

class WatermelonDisplayPage extends StatelessWidget {
  const WatermelonDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final watermelonProvider = Provider.of<WatermelonProvider>(context);
    final watermelonData = watermelonProvider.watermelonData;

    return Scaffold(
      appBar: AppBar(title: const Text('Watermelon Analysis')),
      body: watermelonData != null
          ? SingleChildScrollView( // Allow scrolling for long content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the watermelon image (you'll need to add image loading here)
              Center(
                child: Image.file(File(watermelonProvider.imagePath!), height: 200),
              ),
              const SizedBox(height: 20),
              Text('Name: ${watermelonData.name}', style: const TextStyle(fontSize: 18)),
              Text('Size: ${watermelonData.size}', style: const TextStyle(fontSize: 18)),
              Text('Juicyness: ${watermelonData.juicyness}', style: const TextStyle(fontSize: 18)),
              Text('Symmetry: ${watermelonData.symmetry}', style: const TextStyle(fontSize: 18)),
              Text('Freshness: ${watermelonData.freshness}', style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      )
          : const Center(
        child: Text('No watermelon data found.'),
      ),
    );
  }
}
