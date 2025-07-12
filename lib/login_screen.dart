import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? errorText;

  Future<void> login() async {
    final email    = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => errorText = 'Lütfen e-posta ve şifreyi boş bırakmayın.');
      return;
    }

    setState(() {
      isLoading = true;
      errorText = null;
    });

    try {
      const baseUrl = 'https://astromend-api-1.onrender.com';
      final uri = Uri.parse('$baseUrl/api/account/login');
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('📥 Status Code: ${response.statusCode}');
      debugPrint('📥 Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home', arguments: email);
      } else {
        setState(() => errorText = data['message'] ?? 'Hatalı e-posta veya şifre.');
      }
    } on TimeoutException {
      setState(() => errorText = 'Sunucu zaman aşımına uğradı. Tekrar deneyin.');
    } catch (e) {
      setState(() => errorText = 'Sunucu hatası: $e');
      debugPrint('❌ Hata: $e');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/loginbackground.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/astromend_logo.png', width: 200),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'ornek@example.com',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.85),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Şifre',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.85),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (errorText != null)
                    Text(errorText!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: isLoading ? null : login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Giriş Yap', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.65),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Şifremi Unuttum', style: TextStyle(color: Colors.deepPurple)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.65),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Kayıt Ol', style: TextStyle(color: Colors.deepPurple)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
