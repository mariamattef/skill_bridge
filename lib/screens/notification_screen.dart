import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final List<String> notifications = const [
    "مرحبًا بك في SkillBridge!",
    "تم تسجيل الدخول بنجاح!",
  ];

  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                "لا يوجد إشعارات حالياً",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                return _buildNotificationItem(notifications[index], context);
              },
            ),
    );
  }

  Widget _buildNotificationItem(String notification, BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("تم الضغط على الإشعار: $notification"),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.deepPurple,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: const Icon(Icons.notifications, color: Colors.deepPurple),
          title: Text(
            notification,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
