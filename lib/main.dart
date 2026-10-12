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
      title: 'Course Explorer - Tahap 1',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const CourseDetailPage(),
    );
  }
}

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  // Identitas Mahasiswa wajib tampil di kode
  final String studentName = "Jack Rich Loro";
  final String studentId = "2415051101";

  // Contoh Local State menggunakan setState
  bool isExpanded = false;

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
            const Text(
              'Pemrograman Mobile & Praktikum Flutter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              isExpanded
                  ? 'Materi ini membahas konsep UI Fundamentals, State Management, Provider, dan arsitektur aplikasi secara mendalam.'
                  : 'Materi ini membahas konsep UI Fundamentals...',
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded; // Mengubah local state
                });
              },
              child: Text(isExpanded ? 'Sembunyikan' : 'Baca Selengkapnya'),
            ),
          ],
        ),
      ),
    );
  }
}