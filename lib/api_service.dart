import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL artık localhost
  static const String _baseUrl = 'http://localhost:5000';
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  /// Kullanıcı kayıt isteği
  static Future<bool> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String birthDate,
    String phoneNumber = '',
  }) async {
    final uri = Uri.parse('$_baseUrl/api/account/register');
    final body = jsonEncode({
      'fullName': fullName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
    });

    final response = await http.post(uri, headers: _headers, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      print('📦 Request Body: $body');
      print('🔎 Status: ${response.statusCode}, Body: ${response.body}');
      return false;
    }
  }

  // Diğer endpoint’ler de benzer şekilde:
  // static Future<...> loginUser(...) async { ... }
  // static Future<...> fetchProfile(...) async { ... }
}
