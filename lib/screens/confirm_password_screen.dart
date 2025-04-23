import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_app/widgets/custom_elevated_button.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../widgets/custom_text_form_field.dart'
    show CustomTextFormField; // غيري المسار حسب مشروعك

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({required this.oobCode, super.key});
  static const id = '/Confirm_password';
  final String oobCode;

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  late TextEditingController passwordController;
  late TextEditingController confirmpPasswordControllerr;

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  @override
  void initState() {
    passwordController = TextEditingController();
    confirmpPasswordControllerr = TextEditingController();

    super.initState();
  }

  late String oobCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      oobCode = args;
      print("Received oobCode: $oobCode");
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmpPasswordControllerr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("OOB Code: ${widget.oobCode}");

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(10.0.r),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Text(
                'Confirm Password',
                style: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold),
              ),
              Form(
                child: Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomTextFormField(
                            controller: passwordController,
                            hintText: '***********',
                            labelText: 'Password',
                            obscureText: !isPasswordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomTextFormField(
                            controller: confirmpPasswordControllerr,
                            hintText: '***********',
                            labelText: 'Confirm Password',
                            obscureText: !isConfirmPasswordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                              icon: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  onPressed: () async {
                                    final password = passwordController.text;
                                    final confirmPassword =
                                        confirmpPasswordControllerr.text;

                                    if (password != confirmPassword) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Passwords do not match',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    await context
                                        .read<AuthCubit>()
                                        .confirmPasswordReset(
                                          context: context,
                                          oobCode: widget.oobCode,
                                          newPassword: password,
                                        );
                                  },

                                  child: Text(
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
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
