import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';

class CourseService {
  // Endpoint REST API yang diberikan
  static const String apiUrl = 'https://course-api-pearl.vercel.app/courses';

  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      
      // Konversi data JSON menjadi List<Course>
      List<Course> courses = body
          .map((dynamic item) => Course.fromJson(item))
          .toList();
          
      return courses;
    } else {
      throw Exception('Gagal memuat data course. Status Code: ${response.statusCode}');
    }
  }
}