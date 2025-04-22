import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  String hintText;
  String labelText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  bool? obscureText;
  Widget? suffix;

  CustomTextFormField(
      {required this.hintText,
      this.keyboardType,
      required this.labelText,
      this.controller,
      this.onChanged,
      this.validator,
      this.obscureText,
      this.suffix,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.all(8.0.r),
            child: Text(
              labelText,
              style:  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            onChanged: onChanged,
            controller: controller,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
