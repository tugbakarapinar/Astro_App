import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profilim"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/profile_placeholder.png"),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, size: 20),
                      onPressed: () {
                        // Profil fotoğrafı değiştirme işlemi buraya
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "Tuğba Karapınar",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Astrolog - İstanbul",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const Divider(height: 40),
          const ListTile(
            leading: Icon(Icons.email_outlined),
            title: Text("tugba@example.com"),
          ),
          const ListTile(
            leading: Icon(Icons.phone_outlined),
            title: Text("+90 555 555 5555"),
          ),
          const ListTile(
            leading: Icon(Icons.cake_outlined),
            title: Text("07 Ocak 2002"),
          ),
          const ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text("Kadıköy, İstanbul"),
          ),
          const Divider(height: 40),
          ElevatedButton.icon(
            onPressed: () {
              // Giriş ekranına yönlendirme işlemi buraya
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
            label: const Text("Çıkış Yap"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
