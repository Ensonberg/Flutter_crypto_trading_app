import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

/// Default [ThemeData] for Example
class AppTheme {
  /// Default constructor for Example [ThemeData]
  AppTheme(this._brightness);

  final Brightness _brightness;

  /// Exposes theme data to MaterialApp
  ThemeData get themeData {
    return ThemeData(brightness: _brightness).copyWith(
      colorScheme: _colorScheme,
      useMaterial3: true,
      // errorColor: AppColors.error,
      //  textTheme: GoogleFonts.ubuntuTextTheme(themeData.textTheme)
    );
  }

  ColorScheme get _colorScheme => ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: _brightness,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      tertiary: AppColors.accentColor,
      onError: AppColors.error);
}
