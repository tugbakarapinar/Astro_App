import 'package:flutter/material.dart';
import 'activity_main_screen.dart';
import 'dashboard_screen.dart';
import 'messages_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    ActivityMainScreen(),
    DashboardScreen(),
    MessagesScreen(),
    NotificationScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Panel'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Mesaj'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Bildirim'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ayarlar'),
        ],
      ),
    );
  }
}
