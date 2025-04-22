import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}