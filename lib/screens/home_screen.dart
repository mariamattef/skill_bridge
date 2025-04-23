import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {'title': 'Learn Flutter', 'progress': 0.7},
      {'title': 'Read Programming Book', 'progress': 0.4},
      {'title': 'Practical Training Project', 'progress': 0.9},
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Text(
            'Welcome 👋',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12.h),
          Center(
            child: SvgPicture.asset('assets/images/skills.svg', height: 100.h),
          ),
          SizedBox(height: 24.h),
          Text(
            'Your Current Tasks',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          ...tasks.map((task) {
            final double progress = task['progress'] as double;
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Card(
                elevation: 3,
                color: progress >= 0.8 ? Colors.green[50] : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  title: Text('${task['title']!}'),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: LinearProgressIndicator(
                      value: progress,
                      color: Colors.deepPurple,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  trailing: Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(
                      color: progress >= 0.8 ? Colors.green : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
