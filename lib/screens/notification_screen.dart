import 'package:flutter/material.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      '🎉 مرحبًا بك في SkillBridge!',
      '📌 لا تنسَ إكمال مهمة "Flutter"',
      '🔥 لقد أتممت 90% من "مشروع التدريب العملي"',
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.notifications, color: Colors.deepPurple),
            title: Text(notifications[index]),
          ),
        );
      },
    );
  }
}
