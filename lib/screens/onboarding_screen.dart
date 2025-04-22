import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hal_app/screens/signin_screen.dart';

import '../services/pref.service.dart';
import '../utilities/color_utilis.dart';
import '../utilities/image_utility.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/onboarding/elevated_button_rounded.dart';
import '../widgets/onboarding/onboard_indicator.dart';
import '../widgets/onboarding/onboard_item_widget.dart';
import 'signup_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = 'OnBoardingpage';

  const OnBoardingScreen({super.key});
  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  final _kDuration = const Duration(milliseconds: 300);
  final _kCurve = Curves.ease;

  void onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding:  EdgeInsets.all(8.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  currentIndex == 3
                      ? TextButton(
                        onPressed: () {
                          _skipFunction(2);
                        },
                        child:  Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                      : TextButton(
                        onPressed: () {
                          _skipFunction(3);
                        },
                        child:  Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: onChangedFunction,
                children: const <Widget>[
                  OnBoardItemWidget(
                    title: 'Track Your Skills',
                    image: ImageUtility.goals,
                    description: 'Easily track your skill development journey',
                  ),
                  OnBoardItemWidget(
                    title: 'Stay Organized',
                    image: ImageUtility.organizer,
                    description:
                        'Keep your learning tasks in one place and never miss a step',
                  ),
                  OnBoardItemWidget(
                    title: 'Achieve More',
                    image: ImageUtility.achive,
                    description: 'Set goals and celebrate your achievements!',
                  ),
                  OnBoardItemWidget(
                    title: 'Join a Community',
                    image: ImageUtility.join,
                    description:
                        'Connect with others, share progress, and grow together',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                OnBoardIndicator(positionIndex: 0, currentIndex: currentIndex),
                 SizedBox(width: 10.w),
                OnBoardIndicator(positionIndex: 1, currentIndex: currentIndex),
                 SizedBox(width: 10.w),
                OnBoardIndicator(positionIndex: 2, currentIndex: currentIndex),
                 SizedBox(width: 10.w),
                OnBoardIndicator(positionIndex: 3, currentIndex: currentIndex),
              ],
            ),
             SizedBox(height: 30.h),
            getButtons,
          ],
        ),
      ),
    );
  }

  void pushSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }

  previousFunction() {
    _pageController.previousPage(duration: _kDuration, curve: _kCurve);
  }

  _skipFunction(int index) {
    _pageController.jumpToPage(index);
  }

  void onLogin() {
    PreferencesService.isOnBoardingSeen = true;
    Navigator.pushReplacementNamed(context, SignInScreen.id);
  }

  Widget get getButtons =>
      currentIndex == 3
          ? CustomElevatedButton(
            width: double.infinity,
            onPressed: () => onLogin(),
            text: 'Sign In',
          )
          : Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentIndex == 0 || currentIndex == 3
                    ? const Text('')
                    : ElevatedButtonRounded(
                      onPressed: () {
                        previousFunction();
                      },
                      icon: const Icon(Icons.arrow_back, size: 30),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        ColorUtility.grayLight,
                      ),
                    ),
                currentIndex == 3
                    ? SizedBox.shrink()
                    : ElevatedButtonRounded(
                      onPressed: () {
                        nextFunction();
                      },
                      icon: const Icon(Icons.arrow_forward, size: 30),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        ColorUtility.purble,
                      ),
                    ),
              ],
            ),
          );
}
