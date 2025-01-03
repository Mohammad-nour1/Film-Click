import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.themoviedb.org/3'; // رابط الـ API الأساسي
  final String apiKey =
      'e3b6fcb49b7013992afe9de907365812'; // استبدلها بمفتاح الـ API الخاص بك

  // دالة عامة لإجراء طلب GET
  Future<dynamic> getRequest(String endpoint) async {
    final url =
        Uri.parse('$baseUrl/$endpoint?api_key=$apiKey'); // بناء رابط الطلب

    try {
      final response = await http.get(url); // تنفيذ الطلب

      if (response.statusCode == 200) {
        return json.decode(response.body); // فك التشفير وإرجاع البيانات
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e'); // التعامل مع الأخطاء
    }
  }
}
