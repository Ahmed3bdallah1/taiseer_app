import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData getLightTheme() {
  return ThemeData.light().copyWith(
      sliderTheme: const SliderThemeData(
        showValueIndicator: ShowValueIndicator.always,
      ),
      appBarTheme: const AppBarTheme(elevation: 0, color: Colors.white),
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: Colors.white,
      highlightColor: Colors.transparent,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0, foregroundColor: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColor.primary),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColor.primary,
        secondary: AppColor.primary,
      ));
}

// ThemeData getDarkTheme() {
//   Color mainColor = AppColor.primaryDark;
//
//   return ThemeData.dark().copyWith(
//       appBarTheme:
//           const AppBarTheme(elevation: 0, color: AppColor.backgroundColordark),
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       primaryColor: AppColor.primaryDark,
//       scaffoldBackgroundColor: AppColor.backgroundColordark,
//       floatingActionButtonTheme:
//           const FloatingActionButtonThemeData(elevation: 0),
//       dividerColor: AppColor.primaryDark.withOpacity(0.1),
//       focusColor: AppColor.primaryDark,
//       toggleableActiveColor: mainColor,
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(primary: mainColor),
//       ),
//       colorScheme: ColorScheme.dark(
//         primary: mainColor,
//         secondary: mainColor,
//       ));
// }
