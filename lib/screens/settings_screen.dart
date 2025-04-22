import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('الملف الشخصي'),
          subtitle: Text('اسم المستخدم: Mariam'),
          trailing: Icon(Icons.edit),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.color_lens),
          title: Text('تغيير المظهر'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('تسجيل الخروج'),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم تسجيل الخروج')),
            );
          },
        ),
      ],
    );
  }
}
