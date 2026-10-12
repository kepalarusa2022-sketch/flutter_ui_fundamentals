// Student ID: 2415051101 - Jack Rich Loro

import 'package:flutter/material.dart';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer - Tahap 3',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const LiftingStatePage(),
    );
  }
}

// Parent Widget sebagai Single Source of Truth
class LiftingStatePage extends StatefulWidget {
  const LiftingStatePage({super.key});

  @override
  State<LiftingStatePage> createState() => _LiftingStatePageState();
}

class _LiftingStatePageState extends State<LiftingStatePage> {
  final String studentName = "Jack Rich Loro";
  final String studentId = "2415051101";

  // Single Source of Truth untuk status favorit course
  bool isCourseFavorite = false;

  void _handleFavoriteChanged() {
    setState(() {
      isCourseFavorite = !isCourseFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$studentId - $studentName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status Global (Parent): ${isCourseFavorite ? "Favorit ❤️" : "Bukan Favorit 🤍"}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Widget Child 1 menerima data dari Single Source of Truth
            CourseCardWidget(
              title: 'Flutter UI Fundamentals',
              isFavorite: isCourseFavorite,
              onFavoriteChanged: _handleFavoriteChanged,
            ),
            const SizedBox(height: 10),
            // Widget Child 2 menyerap nilai yang sama agar konsisten
            CourseCardWidget(
              title: 'State Management & Architecture',
              isFavorite: isCourseFavorite,
              onFavoriteChanged: _handleFavoriteChanged,
            ),
          ],
        ),
      ),
    );
  }
}

// Child Widget yang mengandalkan constructor dan callback (Lifting State Up)
class CourseCardWidget extends StatelessWidget {
  final String title;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;

  const CourseCardWidget({
    super.key,
    required this.title,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: onFavoriteChanged,
            ),
          ],
        ),
      ),
    );
  }
}