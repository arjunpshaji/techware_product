import 'package:flutter/material.dart';

Map<int, Color> color = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};

class AppColors extends ThemeExtension<AppColors> {
  final Color? background;
  final Color? primary;
  final Color? primaryText;
  final Color? secondaryText;
  final Color? subText;
  final Color? errorText;
  final Color? buttonColor;
  final Color? whiteColor;

  const AppColors({
    required this.background,
    required this.primary,
    required this.primaryText,
    required this.secondaryText,
    required this.subText,
    required this.errorText,
    required this.buttonColor,
    required this.whiteColor,
  });

  @override
  AppColors copyWith({
    Color? background,
    Color? primary,
    Color? primaryText,
    Color? secondaryText,
    Color? subText,
    Color? errorText,
    Color? buttonColor,
    Color? whiteColor,
  }) {
    return AppColors(
      background: background ?? this.background,
      primary: primary ?? this.primary,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      subText: subText ?? this.subText,
      errorText: errorText ?? this.errorText,
      buttonColor: buttonColor ?? this.buttonColor,
      whiteColor: whiteColor ?? this.whiteColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      background: Color.lerp(background, other.background, t),
      primary: Color.lerp(primary, other.primary, t),
      primaryText: Color.lerp(primaryText, other.primaryText, t),
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t),
      subText: Color.lerp(subText, other.subText, t),
      errorText: Color.lerp(errorText, other.errorText, t),
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
      whiteColor: Color.lerp(whiteColor, other.whiteColor, t),
    );
  }
}