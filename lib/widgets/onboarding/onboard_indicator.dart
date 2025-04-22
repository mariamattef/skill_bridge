import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_app/utilities/color_utilis.dart';

class OnBoardIndicator extends StatelessWidget {
  final int? positionIndex, currentIndex;
  const OnBoardIndicator({super.key, this.currentIndex, this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      width: positionIndex == currentIndex ? 40.w : 30.w,
      decoration: BoxDecoration(
        color:
            positionIndex == currentIndex ? ColorUtility.purble : Colors.black,
        borderRadius: BorderRadius.circular(5.r),
      ),
    );
  }
}
