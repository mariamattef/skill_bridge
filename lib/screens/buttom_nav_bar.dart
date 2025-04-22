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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        foregroundColor: Colors.white,
        shadowColor: const Color.fromARGB(135, 145, 135, 135),
        backgroundColor: ColorUtility.purble,
        title: Text("SkillBridge"),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: ColorUtility.purble,
        animationDuration: Duration(milliseconds: 300),
        height: 60,
        index: _selectedIndex,
        items: [
          Icon(Icons.edit_note_outlined, color: Colors.white),
          Icon(Icons.sticky_note_2, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
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

  // Widget _buildDrawer(BuildContext context, AppThemeState themeState) {
  //   bool isDark = themeState.isDark;
  //   Color primaryColor = themeState.primaryColor;
  //   Color backgroundColor = isDark ? Colors.grey[900]! : Colors.white;
  //   Color textColor = isDark ? Colors.white : Colors.black;
  //   Color iconColor = isDark ? Colors.white : primaryColor;

  //   return BuildDrawer(
  //       backgroundColor: backgroundColor,
  //       primaryColor: primaryColor,
  //       textColor: textColor,
  //       iconColor: iconColor);
  // }
}
