import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page Not Found")),
      body: Center(
        child: Text(
          "404 - Page Not Found",
          style: TextStyle(fontSize: 24.sp),
        ),
      ),
    );
  }
}
