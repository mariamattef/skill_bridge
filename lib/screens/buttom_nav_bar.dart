import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hal_app/screens/home_screen.dart';
import 'package:hal_app/screens/requeste_screen.dart';
import 'package:hal_app/screens/settings_screen.dart';
import 'package:hal_app/utilities/color_utilis.dart';

import 'notification_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const String id = '/BottomNavBar';
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    NotificationsScreen(),
    RequestsScreen(),
    SettingsScreen(),
  ];

  final List<String> _titles = [
    'Home',
    'Notifications',
    'Requests',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        foregroundColor: Colors.white,
        shadowColor: const Color.fromARGB(135, 145, 135, 135),
        backgroundColor: ColorUtility.purble,
        title: Text(_titles[_selectedIndex]),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: ColorUtility.purble,
        animationDuration: Duration(milliseconds: 300),
        height: 60,
        index: _selectedIndex,
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.notifications, color: Colors.white),
          Icon(Icons.request_page, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
