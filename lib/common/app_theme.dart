import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static const _fontFamily = 'Quicksand';

  final Brightness brightness;
  final Color primaryColor;
  final Color secondaryColor;

  Color get primaryTextColor {
    return AppColors.textBlack;
  }

  /// Material design text theme.
  /// ```
  /// NAME         SIZE  WEIGHT  SPACING
  /// headline1    96.0  light   -1.5
  /// headline2    60.0  light   -0.5
  /// headline3    48.0  regular  0.0
  /// headline4    34.0  regular  0.25
  /// headline5    24.0  regular  0.0
  /// headline6    20.0  medium   0.15
  /// subtitle1    16.0  regular  0.15
  /// subtitle2    14.0  medium   0.1
  /// body1        16.0  regular  0.5   (bodyText1)
  /// body2        14.0  regular  0.25  (bodyText2)
  /// button       14.0  medium   1.25
  /// caption      12.0  regular  0.4
  /// overline     10.0  regular  1.5
  final TextTheme textTheme;

  /// Create a ColorScheme instance.
  const AppTheme({
    this.brightness = Brightness.light,
    this.primaryColor = const Color(0xFFF17B00),
    this.secondaryColor = const Color(0xFFD20043),
    this.textTheme = const TextTheme(
      headline1: TextStyle(fontSize: 96.0, color: AppColors.textBlack),
      headline2: TextStyle(fontSize: 60.0, color: AppColors.textBlack),
      headline3: TextStyle(fontSize: 48.0, color: AppColors.textBlack),
      headline4: TextStyle(fontSize: 34.0, color: AppColors.textBlack),
      headline5: TextStyle(fontSize: 24.0, color: AppColors.textBlack),
      headline6: TextStyle(
          fontSize: 20.0,
          color: AppColors.textBlack,
          fontWeight: FontWeight.w500),
      subtitle1: TextStyle(fontSize: 16.0, color: AppColors.textBlack),
      subtitle2: TextStyle(
          fontSize: 14.0,
          color: AppColors.textBlack,
          fontWeight: FontWeight.w500),
      bodyText1: TextStyle(fontSize: 16.0, color: AppColors.textBlack),
      bodyText2: TextStyle(fontSize: 14.0, color: AppColors.textBlack),
      button: TextStyle(
          fontSize: 14.0,
          color: AppColors.textBlack,
          fontWeight: FontWeight.w500),
      caption: TextStyle(fontSize: 12.0, color: AppColors.textBlack),
      overline: TextStyle(fontSize: 14.0, color: AppColors.textBlack),
    ),
  });

  bool get isDark => brightness == Brightness.dark;

  ThemeData toThemeData() {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      backgroundColor: AppColors.background,
      scaffoldBackgroundColor: AppColors.background,
      accentColor: secondaryColor,
      colorScheme: ColorScheme(
        primary: primaryColor,
        primaryVariant: primaryColor,
        secondary: secondaryColor,
        secondaryVariant: secondaryColor,
        surface: AppColors.background,
        background: AppColors.background,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.red,
        brightness: brightness,
      ),
      textTheme: textTheme,
      iconTheme: IconThemeData(
        color: secondaryColor,
      ),
      shadowColor: AppColors.shadowColor,
      dividerColor: AppColors.divider,
      unselectedWidgetColor: AppColors.borderColor,
      fontFamily: _fontFamily,
    );
  }

  // static AppTheme of(BuildContext context) {
  //   return context
  //       .dependOnInheritedWidgetOfExactType<InheritedAppTheme>()!
  //       .theme;
  // }
}

// class InheritedAppTheme extends InheritedWidget {
//   /// Creates [InheritedWidget] from a provided [AppTheme] class
//   const InheritedAppTheme({
//     Key? key,
//     required this.theme,
//     required Widget child,
//   }) : super(key: key, child: child);
//
//   /// Represents chat theme
//   final AppTheme theme;
//
//   @override
//   bool updateShouldNotify(InheritedAppTheme oldWidget) =>
//       theme.hashCode != oldWidget.theme.hashCode;
// }
