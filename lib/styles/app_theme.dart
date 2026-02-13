import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData buildAppTheme() {
  const colors = AppColors.light;

  return ThemeData(
    useMaterial3: true,
    extensions: [colors],
    brightness: Brightness.light,
    primaryColor: colors.primary,
    scaffoldBackgroundColor: colors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.primary,
      brightness: Brightness.light,
      primary: colors.primary,
      error: colors.error,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.appBar,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 4,
      shadowColor: Colors.black,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colors.appBar,
      selectionColor: colors.appBar.withValues(alpha: 0.3),
      selectionHandleColor: colors.appBar,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: colors.textSecondary),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colors.textSecondary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colors.appBar),
      ),
      hintStyle: TextStyle(color: colors.textSecondary),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(
          allowEnterRouteSnapshotting: false,
        ),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}
