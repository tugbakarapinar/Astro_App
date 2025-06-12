import 'package:flutter/material.dart';
import 'change_password_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          _buildSettingsSectionTitle("HESAP"),
          _buildSettingsTile(Icons.person, "Profil Bilgileri", () {}),
         _buildSettingsTile(Icons.lock, "Şifreyi Değiştir", () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
  );
}),

          _buildSettingsTile(Icons.phone_android, "Telefon Numarası", () {}),

          const Divider(height: 32),

          _buildSettingsSectionTitle("UYGULAMA"),
          _buildSettingsTile(Icons.notifications, "Bildirim Ayarları", () {}),
          _buildSettingsTile(Icons.privacy_tip, "Gizlilik Politikası", () {}),
          _buildSettingsTile(Icons.info_outline, "Hakkında", () {}),

          const Divider(height: 32),

          _buildSettingsSectionTitle("DİĞER"),
          _buildSettingsTile(Icons.logout, "Çıkış Yap", () {
            // Giriş ekranına yönlendirilebilir
          }),
        ],
      ),
    );
  }

  Widget _buildSettingsSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(
        title,
        style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
