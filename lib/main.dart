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
      title: 'Course Explorer - Tahap 4',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const ValueNotifierPage(),
    );
  }
}

class ValueNotifierPage extends StatelessWidget {
  const ValueNotifierPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Identitas Mahasiswa
    final String studentName = "Jack Rich Loro";
    final String studentId = "2415051101";

    // 1. Membuat ValueNotifier<int> untuk nilai sederhana (jumlah favorite)
    final ValueNotifier<int> favoriteCounter = ValueNotifier<int>(2);

    return Scaffold(
      appBar: AppBar(
        title: Text('$studentId - $studentName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. Menampilkan nilai dengan ValueListenableBuilder agar rebuild area spesifik saja
            ValueListenableBuilder<int>(
              valueListenable: favoriteCounter,
              builder: (context, value, child) {
                return Text(
                  'Total Favorites (ValueNotifier): $value',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pemrograman Mobile Flutter',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // 3. Tombol untuk mengubah value notifier
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        favoriteCounter.value += 1; // Mengubah nilai notifier
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