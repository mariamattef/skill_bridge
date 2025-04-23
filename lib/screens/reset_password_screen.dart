import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_app/screens/confirm_password_screen.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/custom_elevated_button.dart';

class ResetPasswrdScreen extends StatefulWidget {
  static const String id = '/Reset_passwrd';
  const ResetPasswrdScreen({super.key});

  @override
  State<ResetPasswrdScreen> createState() => _ResetPasswrdScreenState();
}

class _ResetPasswrdScreenState extends State<ResetPasswrdScreen> {
  final _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 50.h),
             Text(
              'Reset Password',
              style: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 100.h),
            CustomTextFormField(
              controller: _email,
              hintText: 'Demo@gmail.com',
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
             SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () async {
                      bool success = await context
                          .read<AuthCubit>()
                          .resetPassword(
                            context: context,
                            emailController: _email,
                          );
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Password reset link sent to your email',
                            ),
                          ),
                        );
                        Navigator.pushNamed(context, ConfirmPasswordScreen.id);
                      }
                    },
                    child:  Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
