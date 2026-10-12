import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ui_fundamentals/models/course.dart';
import 'package:flutter_ui_fundamentals/providers/course_provider.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final String studentName = "Jack Rich Loro";
    final String studentId = "2415051101";

    final provider = context.watch<CourseProvider>();
    final isFav = provider.isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(
        title: Text('$studentId - $studentName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            course.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                            size: 30,
                          ),
                          onPressed: () {
                            context.read<CourseProvider>().toggleFavorite(course.code);
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    Text('Kode Mata Kuliah: ${course.code}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('Bobot SKS: ${course.credits} SKS', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('Status: ${course.status}', style: const TextStyle(fontSize: 16, color: Colors.green)),
                    const SizedBox(height: 12),
                    Text(
                      'Status Favorit: ${isFav ? "Favorit Anda" : "Bukan Favorit"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isFav ? Colors.red : Colors.grey[700],
                      ),
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