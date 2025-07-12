import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/intl.dart';
import 'package:astro_app/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool agreed = false;
  String fullName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String birthDate = '';
  String phone = '';
  DateTime? selectedDate;

  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecial = false;
  bool hasMinLength = false;
  bool emailTaken = false;
  bool phoneTaken = false;

  Future<void> registerUser() async {
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Telefon numarası boş olamaz")),
      );
      return;
    }

    try {
      await ApiService.registerUser({
        'username': fullName,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
        'birth_date': birthDate,
        'phone': phone,
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Başarılı'),
          content: const Text('Kayıt işlemi başarıyla tamamlandı.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              ),
              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      );
    } catch (e) {
      final errorMessage = e.toString().toLowerCase();
      setState(() {
        emailTaken = errorMessage.contains('email') || errorMessage.contains('e-posta');
        phoneTaken = errorMessage.contains('phone') || errorMessage.contains('telefon');
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kayıt başarısız: ${e.toString()}")),
      );
    }
  }

  void checkPassword(String value) {
    setState(() {
      hasUppercase = value.contains(RegExp(r'[A-Z]'));
      hasLowercase = value.contains(RegExp(r'[a-z]'));
      hasSpecial = value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
      hasMinLength = value.length >= 8;
      password = value;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('tr', 'TR'),
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        birthDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF1DD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.deepPurple),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Image.asset('assets/images/astromend_logo.png', height: 100),
              const SizedBox(height: 8),
              const Text("Kayıt Ol", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildField("Ad Soyad", "Adınızı ve soyadınızı girin", onChanged: (val) => fullName = val),
                    const SizedBox(height: 10),
                    _buildField("E-mail adresi", "example@mail.com",
                        inputType: TextInputType.emailAddress,
                        onChanged: (val) {
                          setState(() => email = val);
                          if (emailTaken) setState(() => emailTaken = false);
                        },
                        errorText: emailTaken ? 'Bu e-mail zaten kullanılıyor.' : null),
                    const SizedBox(height: 10),
                    _buildField("Şifre", "Şifrenizi girin", obscure: true, onChanged: checkPassword),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        _passwordRule("En az 1 büyük harf", hasUppercase),
                        _passwordRule("En az 1 küçük harf", hasLowercase),
                        _passwordRule("En az 1 özel karakter", hasSpecial),
                        _passwordRule("En az 8 karakter", hasMinLength),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildField("Şifre Tekrarı", "Şifrenizi tekrar girin",
                        obscure: true, 
                        onChanged: (val) => confirmPassword = val,
                        validator: (val) {
                          if (val != password) {
                            return 'Şifreler eşleşmiyor';
                          }
                          return null;
                        }),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft, 
                      child: Text("Doğum Tarihi", style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: TextEditingController(text: birthDate),
                          decoration: InputDecoration(
                            hintText: "GG/AA/YYYY",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12), 
                              borderSide: const BorderSide(width: 1.4)),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                          ),
                          validator: (val) => val == null || val.isEmpty ? 'Bu alan zorunlu' : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Telefon Numarası", style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    IntlPhoneField(
                      decoration: InputDecoration(
                        hintText: "5XX XXX XX XX",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12), 
                          borderSide: const BorderSide(width: 1.4)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                        errorText: phoneTaken ? 'Bu telefon numarası zaten kullanılıyor.' : null,
                      ),
                      initialCountryCode: 'TR',
                      onChanged: (phoneNumber) {
                        setState(() => phone = phoneNumber.completeNumber);
                        if (phoneTaken) setState(() => phoneTaken = false);
                      },
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: agreed,
                          onChanged: (val) => setState(() => agreed = val ?? false),
                        ),
                        const Expanded(
                          child: Text("Kullanıcı sözleşmesini okudum, onaylıyorum."),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && agreed) {
                          registerUser();
                        } else if (!agreed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Lütfen kullanıcı sözleşmesini onaylayın")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Kayıt Ol', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint,
      {bool obscure = false,
      TextInputType? inputType,
      required Function(String) onChanged,
      String? Function(String?)? validator,
      String? errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        TextFormField(
          keyboardType: inputType,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), 
              borderSide: const BorderSide(width: 1.4)),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
          validator: validator ?? ((value) => value == null || value.isEmpty ? 'Bu alan zorunlu' : null),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _passwordRule(String text, bool valid) {
    return Row(
      children: [
        Icon(valid ? Icons.check_circle : Icons.cancel, 
             color: valid ? Colors.green : Colors.red, 
             size: 18),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}