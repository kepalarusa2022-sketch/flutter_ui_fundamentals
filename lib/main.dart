// Student ID: 2415051101 - Jack Rich Loro

import 'package:flutter/material.dart';

// 1. Membuat ChangeNotifier class terpisah untuk mengelola state
class CourseState extends ChangeNotifier {
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
    notifyListeners(); // Memberi tahu widget yang mendengarkan bahwa state berubah
  }
}

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer - Tahap 5',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const ChangeNotifierPage(),
    );
  }
}

class ChangeNotifierPage extends StatefulWidget {
  const ChangeNotifierPage({super.key});

  @override
  State<ChangeNotifierPage> createState() => _ChangeNotifierPageState();
}

class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  final String studentName = "Jack Rich Loro";
  final String studentId = "2415051101";

  // Inisialisasi CourseState
  final CourseState courseState = CourseState();

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
            AnimatedBuilder(
              animation: courseState,
              builder: (context, child) {
                return Text(
                  'Total Favorites (ChangeNotifier): ${courseState.favorites.length}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'State Management & Architecture',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    AnimatedBuilder(
                      animation: courseState,
                      builder: (context, child) {
                        final bool fav = courseState.isFavorite('SM-01');
                        return IconButton(
                          icon: Icon(
                            fav ? Icons.favorite : Icons.favorite_border,
                            color: fav ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            courseState.toggleFavorite('SM-01');
                          },
                        );
                      },
                    ),
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