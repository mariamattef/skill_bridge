import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {'title': 'تعلم Flutter', 'progress': 0.7},
      {'title': 'قراءة كتاب برمجة', 'progress': 0.4},
      {'title': 'مشروع تدريب عملي', 'progress': 0.9},
    ];

    return SingleChildScrollView(
      padding:  EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Center(
            child: Lottie.asset('assets/animations/development.json', height: 200.h),
          ),
          SizedBox(height: 16.h),
          Center(
            child: SvgPicture.asset('assets/images/skills.svg', height:100.h),
          ),
          SizedBox(height: 16.h),
          Text(
            'مهامك الحالية',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          ...tasks.map((task) {
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                title: Text('${task['title']!}'),
                subtitle: LinearProgressIndicator(
                  value: task['progress'] as double,
                  color: Colors.deepPurple,
                  backgroundColor: Colors.grey[300],
                ),
                trailing: Text('${((task['progress'] as double) * 100).toInt()}%'),
              ),
            );
          }),
        ],
      ),
    );
  }
}












// class HomeScreen extends StatelessWidget {
//   static const String id = '/home';
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: Text(
//           'Welcome to the Home Screen!',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }