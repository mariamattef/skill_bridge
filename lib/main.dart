import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_app/screens/confirm_password_screen.dart';
import 'package:hal_app/screens/home_screen.dart';
import 'package:hal_app/screens/onboarding_screen.dart';
import 'package:hal_app/screens/signin_screen.dart';
import 'package:hal_app/screens/signup_screen.dart';

import 'cubits/auth_cubit/auth_cubit.dart';
import 'firebase_options.dart';
import 'screens/buttom_nav_bar.dart';
import 'screens/not_found_screen.dart';
import 'screens/reset_password_screen.dart';
import 'services/pref.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Failed to initialize Firebase: $e');
  }
  // FirebaseSrorageReference.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SkillBridge',

          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (context) => BottomNavBar());
              case '/onboarding':
                return MaterialPageRoute(
                  builder: (context) => OnBoardingScreen(),
                );
              case '/sign_in':
                return MaterialPageRoute(builder: (context) => SignInScreen());
              case '/sign_up':
                return MaterialPageRoute(builder: (context) => SignUpScreen());
              case '/Reset_passwrd':
                return MaterialPageRoute(
                  builder: (context) => ResetPasswrdScreen(),
                );
              case '/Confirm_password':
                return MaterialPageRoute(
                  builder: (context) => ConfirmPasswordScreen(),
                );
              case '/home':
                return MaterialPageRoute(builder: (context) => HomeScreen());
              case '/BottomNavBar':
                return MaterialPageRoute(builder: (context) => BottomNavBar());
              default:
                return MaterialPageRoute(
                  builder: (context) => NotFoundScreen(),
                );
            }
          },
        ),
      ),
    );
  }
}



// Platform  Firebase App Id
// web       1:1028098768662:web:66f1d026715938872b5a37
// android   1:1028098768662:android:074ee9fc3b243c0a2b5a37
// ios       1:1028098768662:ios:533e9dc444c69e172b5a37