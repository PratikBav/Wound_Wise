import 'package:flutter/material.dart';

/// App color palette derived from the WoundWise logo
class AppColors {
  // Primary colors from logo
  static const Color darkBlue = Color(0xFF1E497A); // Dark Blue (W left)
  static const Color limeGreen = Color(0xFF6CC04A); // Lime Green (W right)
  static const Color tealCyan = Color(0xFF5AB5AE); // Teal/Cyan (brain outline)
  static const Color lightBlueTeal = Color(0xFF4092C0); // Light Blue/Teal (dots)
  
  // Primary color (main brand color)
  static const Color primary = darkBlue;
  static const Color primaryLight = lightBlueTeal;
  
  // Secondary colors
  static const Color secondary = limeGreen;
  static const Color secondaryLight = Color(0xFF8FD66E);
  
  // Accent colors
  static const Color accent = tealCyan;
  static const Color accentLight = Color(0xFF7FCCC7);
  
  // Background colors
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color surface = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFFFFFFF);
  
  // Status colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = limeGreen;
  
  // Gradient colors
  static LinearGradient primaryGradient = const LinearGradient(
    colors: [darkBlue, lightBlueTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient secondaryGradient = const LinearGradient(
    colors: [limeGreen, tealCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient accentGradient = const LinearGradient(
    colors: [tealCyan, lightBlueTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient backgroundGradient = const LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF0F8FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Prevent instantiation
  AppColors._();
}
