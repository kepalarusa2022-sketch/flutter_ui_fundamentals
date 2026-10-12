// Student ID: 2415051101 - Jack Rich Loro

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ui_fundamentals/models/course.dart';

class CourseProvider extends ChangeNotifier {
  final Set<String> favorites = {};

  bool isFavorite(String code) {
    return favorites.contains(code);
  }

  void toggleFavorite(String code) {
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(),
      child: const CourseExplorerApp(),
    ),
  );
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer - Tahap 8',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const ModelTestPage(),
    );
  }
}

class ModelTestPage extends StatelessWidget {
  const ModelTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String studentName = "Jack Rich Loro";
    final String studentId = "2415051101";

    // Mengubah Map<String, dynamic> (data JSON tiruan) menjadi object Course
    final Map<String, dynamic> rawJson = {
      'code': 'T8-01',
      'title': 'State Management & Architecture',
      'credits': 3,
      'status': 'active'
    };

    final Course course = Course.fromJson(rawJson);

    return Scaffold(
      appBar: AppBar(
        title: Text('$studentId - $studentName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pengujian Model Course & FromJson',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kode: ${course.code}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('Mata Kuliah: ${course.title}'),
                    Text('SKS: ${course.credits}'),
                    Text('Status: ${course.status}', style: const TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}