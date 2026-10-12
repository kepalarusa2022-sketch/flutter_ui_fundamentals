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
      title: 'Course Explorer - Tahap 2',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const ParentStatePage(),
    );
  }
}

// Parent Widget memegang state favorites
class ParentStatePage extends StatefulWidget {
  const ParentStatePage({super.key});

  @override
  State<ParentStatePage> createState() => _ParentStatePageState();
}

class _ParentStatePageState extends State<ParentStatePage> {
  final String studentName = "Jack Rich Loro";
  final String studentId = "2415051101";

  // Shared State di Parent
  int favoriteCount = 2;
  bool isCourse1Favorite = true;
  bool isCourse2Favorite = false;

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
              'Total Favorites (Parent State): $favoriteCount',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Child 1
            CourseItemWidget(
              courseTitle: 'Git & GitHub',
              status: 'done',
              isFavorite: isCourse1Favorite,
              onFavoriteToggle: () {
                setState(() {
                  isCourse1Favorite = !isCourse1Favorite;
                  favoriteCount += isCourse1Favorite ? 1 : -1;
                });
              },
            ),
            const SizedBox(height: 10),
            // Child 2
            CourseItemWidget(
              courseTitle: 'State Management',
              status: 'active',
              isFavorite: isCourse2Favorite,
              onFavoriteToggle: () {
                setState(() {
                  isCourse2Favorite = !isCourse2Favorite;
                  favoriteCount += isCourse2Favorite ? 1 : -1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Child Widget yang menerima data lewat constructor dan callback (Prop Drilling)
class CourseItemWidget extends StatelessWidget {
  final String courseTitle;
  final String status;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const CourseItemWidget({
    super.key,
    required this.courseTitle,
    required this.status,
    required this.isFavorite,
    required this.onFavoriteToggle,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(courseTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Status: $status', style: const TextStyle(color: Colors.grey)),
              ],
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: onFavoriteToggle, // Mengirim aksi ke parent via callback
            ),
          ],
        ),
      ),
    );
  }
}