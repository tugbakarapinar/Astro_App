import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Mesajlar'),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: 8,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/user_placeholder.png'),
            ),
            title: const Text(
              'Kullanıcı Adı',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Son mesaj içeriği buraya gelecek...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '12:45',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 4),
                CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text('2', style: TextStyle(fontSize: 10, color: Colors.white)),
                ),
              ],
            ),
            onTap: () {
              // Mesaj detay ekranına yönlendirme
            },
          );
        },
      ),
    );
  }
}
