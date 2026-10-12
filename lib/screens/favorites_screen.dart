import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ui_fundamentals/providers/course_provider.dart';
import 'package:flutter_ui_fundamentals/widgets/course_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String studentName = "Jack Rich Loro";
    final String studentId = "2415051101";

    final provider = context.watch<CourseProvider>();
    final favoriteCourses = provider.courses
        .where((course) => provider.isFavorite(course.code))
        .toList();

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
              'Kursus Favorit Saya (${favoriteCourses.length})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: favoriteCourses.isEmpty
                  ? const Center(
                      child: Text('Belum ada kursus yang difavoritkan.'),
                    )
                  : ListView.builder(
                      itemCount: favoriteCourses.length,
                      itemBuilder: (context, index) {
                        return CourseCard(course: favoriteCourses[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}