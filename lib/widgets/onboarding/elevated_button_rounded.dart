import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonRounded extends StatelessWidget {
 final void Function()? onPressed;
  final WidgetStateProperty<Color?>? backgroundColor;
 final Widget? icon;

const  ElevatedButtonRounded(
      {required this.onPressed,
      required this.icon,
      required this.backgroundColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(
          Colors.white,
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.all(15.r),
        ),
        shape: WidgetStateProperty.all<CircleBorder>(CircleBorder()),
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
