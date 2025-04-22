import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../custom_text_form_field.dart';
import '../widgets/custom_elevated_button.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({super.key});
  static const id = '/Confirm_password';

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  late TextEditingController passwordController;
  late TextEditingController confirmpPasswordControllerr;

  final bool _isLoading = false;
  @override
  void initState() {
    passwordController = TextEditingController();
    confirmpPasswordControllerr = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmpPasswordControllerr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:  EdgeInsets.all(10.0.r),
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
                  padding:  EdgeInsets.all(10.0.r),
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomTextFormField(
                            controller: passwordController,
                            hintText: '***********',
                            labelText: 'Password',
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                           SizedBox(height: 20.h),
                          CustomTextFormField(
                            controller: confirmpPasswordControllerr,
                            hintText: '***********',
                            labelText: 'Confirm Password',
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  onPressed: () async {
                                    if (passwordController.text !=
                                        confirmpPasswordControllerr.text) {
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
                                        .submitPassword(
                                          context: context,
                                          passwordController:
                                              passwordController,
                                          confirmPasswordController:
                                              confirmpPasswordControllerr,
                                        );
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
