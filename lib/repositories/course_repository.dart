// Student ID: 2415051101 - Jack Rich Loro

import 'package:flutter_ui_fundamentals/models/course.dart';
import 'package:flutter_ui_fundamentals/services/course_data_source.dart';

class CourseRepository {
  CourseRepository(this.dataSource);

  final CourseDataSource dataSource;

  Future<List<Course>> getCourses() => dataSource.getCourses();

  Future<Course> createCourse(Course course) => dataSource.createCourse(course);

  Future<void> updateCourse(String id, Course course) => dataSource.updateCourse(id, course);

  Future<void> deleteCourse(String id) => dataSource.deleteCourse(id);
}