import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:hal_app/services/pref.service.dart';
import 'screens/confirm_password_screen.dart' show ConfirmPasswordScreen;
import 'skill_bridge.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  await Firebase.initializeApp();
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
  final Uri deepLink = dynamicLinkData.link;
  final String? oobCode = deepLink.queryParameters['oobCode'];
  final String? mode = deepLink.queryParameters['mode'];

  if (mode == 'resetPassword' && oobCode != null) {
    navigatorKey.currentState?.pushNamed(
      ConfirmPasswordScreen.id,
      arguments: oobCode,
    );
  }
}).onError((error) {
  print('Dynamic Link Error: $error');
});


    runApp(const SkillBridge());
}

