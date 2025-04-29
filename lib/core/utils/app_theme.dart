import 'package:flutter/material.dart';
import 'package:techware_products/core/utils/app_colors.dart';

AppColors appColor(context) => Theme.of(context).extension<AppColors>()!;

ThemeData getAppTheme(BuildContext context) {
  return ThemeData(
    extensions: const <ThemeExtension<AppColors>>[
      AppColors(
        background: Color(0xff1E201E),
        primary: Color(0xffECDFCC),
        primaryText: Color(0xffE4EFE7),
        secondaryText: Color(0xff4A4A4A),
        subText: Color(0xff737373),
        errorText: Color(0xffdb292a),
        buttonColor: Color(0xff3E7B27),
        whiteColor: Color(0xfffafafa)
      ),
    ],
    fontFamily: 'Manrope',
  );
}