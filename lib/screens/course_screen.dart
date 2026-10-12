import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ui_fundamentals/providers/course_provider.dart';
import 'package:flutter_ui_fundamentals/widgets/course_card.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Kursus (Refactored Structure)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 48),
                          const SizedBox(height: 8),
                          Text(
                            'Terjadi kesalahan: ${provider.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => context.read<CourseProvider>().loadCourses(),
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (provider.courses.isEmpty) {
                    return const Center(child: Text('Tidak ada data kursus.'));
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