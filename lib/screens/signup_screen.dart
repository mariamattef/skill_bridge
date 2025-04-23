import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubits/auth_cubit/auth_cubit.dart';
import '../widgets/auth/auth_template.widget.dart';
import '../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = '/sign_up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthTemplateWidget(
      onSignUp: () async {
        await context.read<AuthCubit>().signUp(
          context: context,
          emailController: emailController,
          nameController: nameController,
          passwordController: passwordController,
        );
      },
      body: Column(
        children: [
          CustomTextFormField(
            controller: nameController,
            hintText: 'Milad Attef ',
            labelText: 'Full Name',
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            controller: emailController,
            hintText: 'Demo@gmail.com',
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 10.h),
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

          SizedBox(height: 10.h),
          CustomTextFormField(
            controller: confirmPasswordController,
            hintText: '***********',
            labelText: 'Confirm Password',
            obscureText: !isConfirmPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            suffix: IconButton(
              onPressed: () {
                setState(() {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                });
              },
              icon: Icon(
                isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
            
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../cubits/signup_cubit/signup_cubit.dart';

// class SignUpScreen extends StatefulWidget {
//   static const String id = '/sign_up';
//   const SignUpScreen({super.key});

//   @override
//   SignUpScreenState createState() => SignUpScreenState();
// }

// class SignUpScreenState extends State<SignUpScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Sign Up")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: BlocConsumer<SignUpCubit, SignUpState>(
//           listener: (context, state) {
//             if (state is SignUpSuccess) {
//               // Navigate to another page after successful sign-up
//             } else if (state is SignUpFailure) {
//               // Show error message
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
//             }
//           },
//           builder: (context, state) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(labelText: 'Email'),
//                 ),
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: 'Password'),
//                 ),
//                 SizedBox(height: 20),
//                 if (state is SignUpLoading)
//                   Center(child: CircularProgressIndicator())
//                 else
//                   ElevatedButton(
//                     onPressed: () {
//                       String email = _emailController.text;
//                       String password = _passwordController.text;
//                       context.read<SignUpCubit>().signUp(email, password);
//                     },
//                     child: Text("Sign Up"),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
