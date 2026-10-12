// Student ID: 2415051101 - Jack Rich Loro

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ui_fundamentals/services/course_service.dart';
import 'package:flutter_ui_fundamentals/repositories/course_repository.dart';
import 'package:flutter_ui_fundamentals/providers/course_provider.dart';
import 'package:flutter_ui_fundamentals/screens/course_screen.dart';

void main() {
  final courseService = CourseService();
  final courseRepository = CourseRepository(courseService);

  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(courseRepository)..loadCourses(),
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
      title: 'Course Explorer - Tahap 12',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const CourseScreen(),
    );
  }
}