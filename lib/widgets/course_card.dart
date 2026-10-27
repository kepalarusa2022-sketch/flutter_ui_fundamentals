// Student ID: 2415051101 - Jack Rich Loro

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ui_fundamentals/models/course.dart';
import 'package:flutter_ui_fundamentals/providers/course_provider.dart';
import 'package:flutter_ui_fundamentals/screens/edit_course_screen.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final isFav = provider.isFavorite(course.code);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          course.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Kode: ${course.code} | SKS: ${course.credits} | Status: ${course.status}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Tombol Edit (Tahap 7)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              tooltip: 'Edit Kursus',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditCourseScreen(course: course),
                  ),
                );
              },
            ),
            // Tombol Delete dengan AlertDialog Konfirmasi (Tahap 8)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Hapus Kursus',
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Konfirmasi Hapus'),
                    content: Text('Apakah Anda yakin ingin menghapus kursus "${course.title}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  final success = await provider.deleteCourse(course.code);

                  if (!context.mounted) return;

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Kursus berhasil dihapus!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal menghapus kursus: ${provider.error}')),
                    );
                  }
                }
              },
            ),
            // Tombol Favorit
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : null,
              ),
              tooltip: 'Favorit',
              onPressed: () {
                provider.toggleFavorite(course.code);
              },
            ),
          ],
        ),
      ),
    );
  }
}