// Student ID: 2415051101 - Jack Rich Loro

import 'package:flutter_ui_fundamentals/models/course.dart';

abstract class CourseDataSource {
  Future<List<Course>> getCourses();
  Future<Course> createCourse(Course course);
  Future<void> updateCourse(String id, Course course);
  Future<void> deleteCourse(String id);
}