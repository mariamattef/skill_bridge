import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../widgets/auth/auth_template.widget.dart';
import '../widgets/custom_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  static const String id = '/sign_in';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isPasswordVisible = false;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthTemplateWidget(
      onLogin: () async {
        await context.read<AuthCubit>().login(
          context: context,
          emailController: emailController,
          passwordController: passwordController,
        );

        // بعد نجاح تسجيل الدخول، قم بتفعيل التهيئة للإشعارات عبر Cubit
        // context.read<FirebaseMessagingCubit>().initializeFCM();
      },
      body: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: emailController,
              hintText: 'Demo@gmail.com',
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Your Email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
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
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getValidate(String value, String title) {
    if (value.isEmpty) {
      return title;
    }
  }
}
