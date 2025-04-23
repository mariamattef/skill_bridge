import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hal_app/services/pref.service.dart';

import 'skill_bridge.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesService.init();
  await Firebase.initializeApp();
  runApp(const SkillBridge());
}
