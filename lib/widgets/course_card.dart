import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ui_fundamentals/models/course.dart';
import 'package:flutter_ui_fundamentals/providers/course_provider.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final isFav = provider.isFavorite(course.code);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(
          course.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Kode: ${course.code} | SKS: ${course.credits} | Status: ${course.status}',
        ),
        trailing: IconButton(
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            provider.toggleFavorite(course.code);
          },
        ),
      ),
    );
  }
}