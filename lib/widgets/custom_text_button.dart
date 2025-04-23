import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/color_utilis.dart';

class CustomTextButton extends StatelessWidget {
 final String label;
 final Color? color;
 final void Function()? onPressed;
 const CustomTextButton(
      {required this.label,
      this.color = ColorUtility.purble,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: InkWell(
          onTap: onPressed,
          child: Text(
            label,
            style: TextStyle(color: color ?? Color(0xFFEA4335), fontSize: 15.sp),
          )),
    );
  }
}
