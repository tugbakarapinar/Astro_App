import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:async';


class ApiService {
  static const String baseUrl = 'https://api.astromend.com';
  static const Duration timeoutDuration = Duration(seconds: 30);

  static Future<void> registerUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/api/account/register');
    
    if (kDebugMode) {
      print("📤 Register API Request: ${jsonEncode(userData)}");
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': userData['username'],
          'email': userData['email'],
          'password': userData['password'],
          'password_confirmation': userData['confirm_password'],
          'birth_date': userData['birth_date'],
          'phone': userData['phone'],
        }),
      ).timeout(timeoutDuration);

      if (kDebugMode) {
        print("📥 Register API Response: ${response.statusCode} - ${response.body}");
      }

      final responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else if (response.statusCode == 422) {
        final errors = responseData['errors'] ?? {};
        if (errors.containsKey('email')) {
          throw Exception('Bu email adresi zaten kullanılıyor');
        } else if (errors.containsKey('phone')) {
          throw Exception('Bu telefon numarası zaten kullanılıyor');
        } else {
          throw Exception(responseData['message'] ?? 'Kayıt işlemi başarısız oldu');
        }
      } else {
        throw Exception(responseData['message'] ?? 'Kayıt işlemi başarısız oldu');
      }
    } on http.ClientException catch (e) {
      throw Exception('Sunucuyla bağlantı kurulamadı: ${e.message}');
    } on TimeoutException {
      throw Exception('İstek zaman aşımına uğradı');
    } on FormatException {
      throw Exception('Geçersiz yanıt formatı');
    } catch (e) {
      throw Exception('Beklenmeyen bir hata oluştu: $e');
    }
  }

  static Future<bool> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/account/login');
    
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(timeoutDuration);

      if (kDebugMode) {
        print("📥 Login API Response: ${response.statusCode} - ${response.body}");
      }

      final responseData = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(responseData['message'] ?? 'Giriş başarısız');
      }
    } catch (e) {
      throw Exception('Giriş işlemi sırasında hata: $e');
    }
  }
}
