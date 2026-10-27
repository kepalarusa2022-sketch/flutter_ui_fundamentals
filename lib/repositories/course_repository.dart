import 'package:flutter_ui_fundamentals/models/course.dart';
import 'package:flutter_ui_fundamentals/services/course_service.dart';

class CourseRepository {
  final CourseService service;

  CourseRepository(this.service);

  Future<List<Course>> getCourses() {
    return service.fetchCourses(); // Diperbarui dari loadCourses() menjadi fetchCourses()
  }
}