import 'package:flutter/material.dart';

class WorkoutAppThemeData {
  static final ThemeData lightThemeData = themeData(_lightColorScheme);
  static final ThemeData darkThemeData = themeData(_darkColorScheme);

  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Roboto Condensed',
    );
  }

  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF005AC1),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD8E2FF),
    onPrimaryContainer: Color(0xFF001A41),
    secondary: Color(0xFF535E78),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD8E2FF),
    onSecondaryContainer: Color(0xFF0F1B32),
    tertiary: Color(0xFF76517B),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFED6FF),
    onTertiaryContainer: Color(0xFF2D0E34),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFEFBFF),
    onBackground: Color(0xFF1B1B1F),
    surface: Color(0xFFFEFBFF),
    onSurface: Color(0xFF1B1B1F),
    surfaceVariant: Color(0xFFE1E2EC),
    onSurfaceVariant: Color(0xFF44474F),
    outline: Color(0xFF74777F),
    shadow: Color(0xFF000000),
    inverseSurface: Color(0xFF303033),
    onInverseSurface: Color(0xFFF2F0F4),
    inversePrimary: Color(0xFFADC6FF),
    surfaceTint: Color(0xFF005AC1),
  );

  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFADC6FF),
    onPrimary: Color(0xFF002E69),
    primaryContainer: Color(0xFF004494),
    onPrimaryContainer: Color(0xFFD8E2FF),
    secondary: Color(0xFFBBC6E4),
    onSecondary: Color(0xFF253048),
    secondaryContainer: Color(0xFF3B475F),
    onSecondaryContainer: Color(0xFFD8E2FF),
    tertiary: Color(0xFFE5B8E8),
    onTertiary: Color(0xFF44244A),
    tertiaryContainer: Color(0xFF5D3A62),
    onTertiaryContainer: Color(0xFFFED6FF),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFB4AB),
    background: Color(0xFF1B1B1F),
    onBackground: Color(0xFFE3E2E6),
    surface: Color(0xFF1B1B1F),
    onSurface: Color(0xFFE3E2E6),
    surfaceVariant: Color(0xFF44474F),
    onSurfaceVariant: Color(0xFFC4C6D0),
    outline: Color(0xFF8E9099),
    shadow: Color(0xFF000000),
    inverseSurface: Color(0xFFE3E2E6),
    onInverseSurface: Color(0xFF303033),
    inversePrimary: Color(0xFF005AC1),
    surfaceTint: Color(0xFFADC6FF),
  );

  static const bottomBarHeight = 80.0;

  static const pageMargin = 16.0;

  static const exerciseThumbnailHeight = 50.0;
  static const exerciseThumbnailMargin = EdgeInsets.fromLTRB(0, 5, 10, 5);
  static const exerciseThumbnailPadding = EdgeInsets.all(5);
  static BorderRadius get exerciseThumbnailBorderRadius =>
      BorderRadius.circular(12.0);

  static const exerciseTitleHeight = 48.0;
  static const exerciseSetHeight = 48.0;
  static const exerciseSetDataMargin = 20.0;

  static const workoutPickerTitleMargin = EdgeInsets.fromLTRB(0, 80, 0, 0);
  static const workoutPickerMargin = EdgeInsets.symmetric(vertical: 10);

  static const animationDuration = Duration(milliseconds: 300);

  static const tabHeight = 46.0;

  static const opacityDisabled = 0.4;
}