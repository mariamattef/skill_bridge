import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/color_utilis.dart';

class CustomElevatedButton extends StatelessWidget {
 final void Function() onPressed;
  // String label;
 final double? width;
 final Color? backgroundColor;
 final Color? foregroundColor;
 final Widget? child;
 final String? text;
 final double? horizontal;
  CustomElevatedButton({
    required this.onPressed,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
    this.child,
    this.text,
    this.horizontal,
    super.key,
  }) {
    assert(
      child != null || text != null,
      'child Or Text must not equal to null',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: horizontal ?? 20.h),
      child: SizedBox(
        width: width,
        height: 52.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: ColorUtility.grayLight),
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            backgroundColor: backgroundColor ?? ColorUtility.purble,
            foregroundColor: foregroundColor ?? Colors.white,
            surfaceTintColor: Colors.white,
          ),
          onPressed: onPressed,
          child:
              text != null
                  ? Text(
                    text!,
                    style:  TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                  : child,
        ),
      ),
    );
  }
}
