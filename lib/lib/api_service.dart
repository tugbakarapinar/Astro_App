import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const _baseUrl = 'https://api.astromend.com';

  static Future<Map<String, dynamic>> registerUser({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String birthdate,
    required String phone,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/account/register');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
        'birthdate': birthdate,
        'phone': phone,
      }),
    );
    final body = jsonDecode(res.body);
    if (res.statusCode == 201) {
      return body; // { success: true, userId: ... }
    } else {
      throw Exception(body['message'] ?? 'Kayıt başarısız');
    }
  }

  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/account/login');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final body = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return body; // { success: true, userId: ..., username: ..., email: ... }
    } else {
      throw Exception(body['message'] ?? 'Giriş başarısız');
    }
  }
}
