import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_app/screens/confirm_password_screen.dart';
import 'package:hal_app/screens/home_screen.dart';
import 'package:hal_app/screens/onboarding_screen.dart';
import 'package:hal_app/screens/signin_screen.dart';
import 'package:hal_app/screens/signup_screen.dart';
import 'package:hal_app/screens/splash_screen.dart';

import 'cubits/auth_cubit/auth_cubit.dart';
import 'screens/buttom_nav_bar.dart';
import 'screens/not_found_screen.dart';
import 'screens/reset_password_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SkillBridge extends StatefulWidget {
  const SkillBridge({super.key});

  @override
  State<SkillBridge> createState() => _SkillBridgeState();
}

class _SkillBridgeState extends State<SkillBridge> {
  @override
  void initState() {
    super.initState();
    _handleDynamicLink(); 
  }

  void _handleDynamicLink() async {
    FirebaseDynamicLinks.instance.onLink
        .listen((dynamicLinkData) {
          final Uri deepLink = dynamicLinkData.link;
          final String? oobCode = deepLink.queryParameters['oobCode'];

          if (deepLink.queryParameters['mode'] == 'resetPassword' &&
              oobCode != null) {
            navigatorKey.currentState?.pushNamed(
              ConfirmPasswordScreen.id,
              arguments: oobCode,
            );
          }
        })
        .onError((error) {
          print('Dynamic Link Failed: $error');
        });
  }

  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [BlocProvider<AuthCubit>(create: (context) => AuthCubit())],
        child: MaterialApp(
          navigatorKey: navigatorKey,

          debugShowCheckedModeBanner: false,
          title: 'SkillBridge',
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (context) => SplashScreen());
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
                  builder: (context) => ConfirmPasswordScreen(oobCode: ''),
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
