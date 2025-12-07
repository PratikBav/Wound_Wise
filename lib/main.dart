import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'constants/app_constants.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const WoundWiseApp());
}

class WoundWiseApp extends StatelessWidget {
  const WoundWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
