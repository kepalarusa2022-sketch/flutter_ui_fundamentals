// Student ID: 2415051101 - Jack Rich Loro

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      title: 'Course Explorer - Tahap 7',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const WatchReadConsumerPage(),
    );
  }
}

class WatchReadConsumerPage extends StatelessWidget {
  const WatchReadConsumerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String studentName = "Jack Rich Loro";
    final String studentId = "2415051101";

    // 1. Menggunakan watch() untuk memantau total favorite dan memicu rebuild pada halaman ini
    final totalFavorites = context.watch<CourseProvider>().favorites.length;

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
              'Total Favorites (watch): $totalFavorites',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    // 3. Menggunakan Consumer pada bagian kecil UI (icon button saja)
                    Consumer<CourseProvider>(
                      builder: (context, provider, child) {
                        final bool isFav = provider.isFavorite('T7-01');
                        return IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            // 2. Menggunakan read() pada onPressed untuk memanggil aksi tanpa listen
                            context.read<CourseProvider>().toggleFavorite('T7-01');
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