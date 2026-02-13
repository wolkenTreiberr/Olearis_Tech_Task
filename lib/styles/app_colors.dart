import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.appBar,
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.error,
  });

  final Color primary;
  final Color appBar;
  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color error;

  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>()!;

  static const light = AppColors(
    primary: Color(0xFF75C252),
    appBar: Color(0xFF42A5F5),
    background: Colors.white,
    textPrimary: Color(0xFF212121),
    textSecondary: Color(0xFF9E9E9E),
    border: Colors.black,
    error: Color(0xFFD32F2F),
  );

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? appBar,
    Color? background,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? error,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      appBar: appBar ?? this.appBar,
      background: background ?? this.background,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      error: error ?? this.error,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      appBar: Color.lerp(appBar, other.appBar, t)!,
      background: Color.lerp(background, other.background, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
