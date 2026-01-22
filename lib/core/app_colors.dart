import 'package:flutter/material.dart';

/// App-wide color constants for consistent theming
/// 
/// ============================================
/// HOW TO CHANGE PRIMARY COLOR:
/// ============================================
/// Simply change the value of [primary] below, and it will automatically
/// update throughout the entire app in:
/// - All buttons (Continue, Google, Facebook)
/// - Logo colors
/// - Hearts in illustrations
/// - All themed components
/// 
/// Example: Change to blue
///   static const Color primary = Color(0xFF2196F3);
/// 
/// Example: Change to green
///   static const Color primary = Color(0xFF4CAF50);
/// ============================================
class AppColors {
  // ============================================
  // PRIMARY COLOR - CHANGE THIS TO UPDATE ALL SCREENS
  // ============================================
  static const Color primary = Color(0xFF122903); // Dark green
  
  // Background colors
  static const Color background = Color(0xffffffff); // White
  
  // Primary color variations (derived from primary)
  static Color get lightPink => Color.lerp(primary, Colors.white, 0.3) ?? const Color(0xFFA5C99A);
  static Color get logoDark => Color.lerp(primary, Colors.black, 0.1) ?? const Color(0xFF0F1F02);
  static Color get logoLight => Color.lerp(primary, Colors.black, 0.15) ?? const Color(0xFF0D1A02);
  
  // Text colors
  static const Color darkBrown = Color(0xFF122903); // Dark green for text
  
  // Illustration colors
  static const Color skinTone = Color(0xFFE8D5C4); // Light beige for skin tone
  static const Color darkSuit = Color(0xFF122903); // Dark green for suit
  static const Color columnsBg = Color(0xFFE8F5E9); // Light green-gray for columns
  
  // Social media colors
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color facebookBlue = Color(0xFF1877F2);
}

