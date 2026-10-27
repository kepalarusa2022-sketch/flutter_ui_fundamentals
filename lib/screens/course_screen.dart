import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ui_fundamentals/providers/course_provider.dart';
import 'package:flutter_ui_fundamentals/widgets/course_card.dart';
import 'package:flutter_ui_fundamentals/widgets/error_view.dart';
import 'package:flutter_ui_fundamentals/screens/favorites_screen.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String studentName = "Jack Rich Loro";
    final String studentId = "2415051101";

    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('$studentId - $studentName'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            tooltip: 'Halaman Favorit',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Kursus (Favorites: ${provider.favorites.length})',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => context.read<CourseProvider>().loadCourses(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.error != null) {
                    return ErrorView(
                      message: provider.error!,
                      onRetry: () => context.read<CourseProvider>().loadCourses(),
                    );
                  }

                  if (provider.courses.isEmpty) {
                    return const Center(child: Text('Data course belum tersedia'));
                  }

                  return ListView.builder(
                    itemCount: provider.courses.length,
                    itemBuilder: (context, index) {
                      final course = provider.courses[index];
                      return CourseCard(course: course);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}