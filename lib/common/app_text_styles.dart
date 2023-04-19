import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/configs/app_configs.dart';

class AppTextStyle {
  ///Black
  static final black =
      TextStyle(color: Colors.black, fontFamily: AppConfigs.fontFamily);

  //s12
  static final whiteS8 = white.copyWith(fontSize: 8);
  static final whiteS8Regular = whiteS8.copyWith(fontWeight: FontWeight.w400);

  //s12
  static final blackS12 = black.copyWith(fontSize: 12);
  static final blackS12Bold = blackS12.copyWith(fontWeight: FontWeight.bold);
  static final blackS12W500 = blackS12.copyWith(fontWeight: FontWeight.w500);
  static final blackS12W800 = blackS12.copyWith(fontWeight: FontWeight.w800);
  static final blackS12W300 = blackS12.copyWith(fontWeight: FontWeight.w300);
  static final blackS12Regular = blackS12.copyWith(fontWeight: FontWeight.w400);

  //s14
  static final blackS14 = black.copyWith(fontSize: 14);
  static final blackS14Bold = blackS14.copyWith(fontWeight: FontWeight.bold);
  static final blackS14W800 = blackS14.copyWith(fontWeight: FontWeight.w800);
  static final blackS14W300 = blackS14.copyWith(fontWeight: FontWeight.w300);
  static final blackS14Regular = blackS14.copyWith(fontWeight: FontWeight.w400);

  //s16
  static final blackS16 = black.copyWith(fontSize: 16);
  static final blackS16Bold = blackS16.copyWith(fontWeight: FontWeight.bold);
  static final blackS16W800 = blackS16.copyWith(fontWeight: FontWeight.w800);
  static final blackS16W500 = blackS16.copyWith(fontWeight: FontWeight.w500);
  static final blackS16Regular = blackS16.copyWith(fontWeight: FontWeight.w400);

  //s18
  static final blackS18 = black.copyWith(fontSize: 18);
  static final blackS18Bold = blackS18.copyWith(fontWeight: FontWeight.bold);
  static final blackS18W500 = blackS18.copyWith(fontWeight: FontWeight.w500);
  static final blackS18W600 = blackS18.copyWith(fontWeight: FontWeight.w600);
  static final blackS18W700 = blackS18.copyWith(fontWeight: FontWeight.w700);
  static final blackS18W800 = blackS18.copyWith(fontWeight: FontWeight.w800);

  ///White
  static const white =
      TextStyle(color: Colors.white, fontFamily: AppConfigs.fontFamily);

  //s10
  static final whiteS10 = white.copyWith(fontSize: 10);
  static final whiteS10Bold = whiteS10.copyWith(fontWeight: FontWeight.bold);

  //s12
  static final whiteS12 = white.copyWith(fontSize: 12);
  static final whiteS12Bold = whiteS12.copyWith(fontWeight: FontWeight.bold);
  static final whiteS12W800 = whiteS12.copyWith(fontWeight: FontWeight.w800);

  //s14
  static final whiteS14 = white.copyWith(fontSize: 14);
  static final whiteS14Bold = whiteS14.copyWith(fontWeight: FontWeight.bold);
  static final whiteS14W800 = whiteS14.copyWith(fontWeight: FontWeight.w800);
  static final whiteS14Regular = whiteS14.copyWith(fontWeight: FontWeight.w400);
  static final whiteS14Medium = whiteS14.copyWith(fontWeight: FontWeight.w500);

  //s16
  static final whiteS16 = white.copyWith(fontSize: 16);
  static final whiteS16Bold = whiteS16.copyWith(fontWeight: FontWeight.bold);
  static final whiteS16W800 = whiteS16.copyWith(fontWeight: FontWeight.w800);
  static final whiteS16Regular = whiteS16.copyWith(fontWeight: FontWeight.w400);

  //s18
  static final whiteS18 = white.copyWith(fontSize: 18);
  static final whiteS18Bold = whiteS18.copyWith(fontWeight: FontWeight.bold);
  static final whiteS18W800 = whiteS18.copyWith(fontWeight: FontWeight.w800);

  //s24
  static final white24 = white.copyWith(fontSize: 24);
  static final white24Bold = white24.copyWith(fontWeight: FontWeight.bold);
  static final white24W800 = white24.copyWith(fontWeight: FontWeight.w800);

  //s24
  static final white36 = white.copyWith(fontSize: 36);
  static final white36Bold = white36.copyWith(fontWeight: FontWeight.bold);
  static final white36W800 = white36.copyWith(fontWeight: FontWeight.w800);

  ///Gray
  static const grey =
      TextStyle(color: AppColors.textGray, fontFamily: AppConfigs.fontFamily);

  //s12
  static final greyS12 = grey.copyWith(fontSize: 12);
  static final greyS12Bold = greyS12.copyWith(fontWeight: FontWeight.bold);
  static final greyS12W800 = greyS12.copyWith(fontWeight: FontWeight.w800);
  static final greyS12W400 = greyS12.copyWith(fontWeight: FontWeight.w400);
  static final greyS12W300 = greyS12.copyWith(fontWeight: FontWeight.w300);

  //s14
  static final greyS14 = grey.copyWith(fontSize: 14);
  static final greyS14Bold = greyS14.copyWith(fontWeight: FontWeight.bold);
  static final greyS14W800 = greyS14.copyWith(fontWeight: FontWeight.w800);
  static final greyS14W300 = greyS14.copyWith(fontWeight: FontWeight.w300);

  //s16
  static final greyS16 = grey.copyWith(fontSize: 16);
  static final greyS16Bold = greyS16.copyWith(fontWeight: FontWeight.bold);
  static final greyS16W300 = greyS16.copyWith(fontWeight: FontWeight.w300);
  static final greyS16W800 = greyS16.copyWith(fontWeight: FontWeight.w800);

  //s18
  static final greyS18 = grey.copyWith(fontSize: 18);
  static final greyS18Bold = greyS18.copyWith(fontWeight: FontWeight.bold);
  static final greyS18W800 = greyS18.copyWith(fontWeight: FontWeight.w800);

  ///Tint
  static final tint =
      TextStyle(color: Colors.blue, fontFamily: AppConfigs.fontFamily);

  //s12
  static final tintS12 = tint.copyWith(fontSize: 12);
  static final tintS12Bold = tintS12.copyWith(fontWeight: FontWeight.bold);
  static final tintS12W800 = tintS12.copyWith(fontWeight: FontWeight.w800);

  //s14
  static final tintS14 = tint.copyWith(fontSize: 14);
  static final tintS14Bold = tintS14.copyWith(fontWeight: FontWeight.bold);
  static final tintS14W800 = tintS14.copyWith(fontWeight: FontWeight.w800);
  static final tintS14BoldH14 =
      tintS14.copyWith(fontWeight: FontWeight.w400, height: 1.4);

  //s16
  static final tintS16 = tint.copyWith(fontSize: 16);
  static final tintS16Bold = tintS16.copyWith(fontWeight: FontWeight.bold);
  static final tintS16W800 = tintS16.copyWith(fontWeight: FontWeight.w800);

  //s18
  static final tintS18 = tint.copyWith(fontSize: 18);
  static final tintS18Bold = tintS18.copyWith(fontWeight: FontWeight.bold);
  static final tintS18W800 = tintS18.copyWith(fontWeight: FontWeight.w800);

  ///Orange
  static const orange =
      TextStyle(color: AppColors.textOrange, fontFamily: AppConfigs.fontFamily);

  //s12
  static final orangeS12 = orange.copyWith(fontSize: 12);
  static final orangeS12Bold = orangeS12.copyWith(fontWeight: FontWeight.bold);
  static final orangeS12W800 = orangeS12.copyWith(fontWeight: FontWeight.w800);

  //s14
  static final orangeS14 = orange.copyWith(fontSize: 14);
  static final orangeS14Bold = orangeS14.copyWith(fontWeight: FontWeight.bold);
  static final orangeS14W800 = orangeS14.copyWith(fontWeight: FontWeight.w800);

  //s16
  static final orangeS16 = orange.copyWith(fontSize: 16);
  static final orangeS16Bold = orangeS16.copyWith(fontWeight: FontWeight.bold);
  static final orangeS16W800 = orangeS16.copyWith(fontWeight: FontWeight.w800);

  //s18
  static final orangeS18 = orange.copyWith(fontSize: 18);
  static final orangeS18Bold = orangeS18.copyWith(fontWeight: FontWeight.bold);
  static final orangeS18W800 = orangeS18.copyWith(fontWeight: FontWeight.w800);

  ///primary
  static final primary =
      TextStyle(color: AppColors.primary, fontFamily: AppConfigs.fontFamily);

  //s12
  static final primaryS12 = primary.copyWith(fontSize: 12);
  static final primaryS12Bold =
      primaryS12.copyWith(fontWeight: FontWeight.bold);
  static final primaryS12W800 =
      primaryS12.copyWith(fontWeight: FontWeight.w800);
  static final primaryS12W300 =
      primaryS12.copyWith(fontWeight: FontWeight.w300);
  static final primaryS12Regular =
      primaryS12.copyWith(fontWeight: FontWeight.w400);

  //s14
  static final primaryS14 = primary.copyWith(fontSize: 14);
  static final primaryS14Bold =
      primaryS14.copyWith(fontWeight: FontWeight.bold);
  static final primaryS14W800 =
      primaryS14.copyWith(fontWeight: FontWeight.w800);
  static final primaryS14W300 =
      primaryS14.copyWith(fontWeight: FontWeight.w300);
  static final primaryS14Regular =
      primaryS14.copyWith(fontWeight: FontWeight.w400);
  static final primaryS14W300Underline =
      primaryS14.copyWith(fontWeight: FontWeight.w300);

  //s16
  static final primaryS16 = primary.copyWith(fontSize: 16);
  static final primaryS16Bold =
      primaryS16.copyWith(fontWeight: FontWeight.bold);
  static final primaryS16W800 =
      primaryS16.copyWith(fontWeight: FontWeight.w800);
  static final primaryS16Regular =
      primaryS16.copyWith(fontWeight: FontWeight.w400);

  //s18
  static final primaryS18 = primary.copyWith(fontSize: 18);
  static final primaryS18Bold =
      primaryS18.copyWith(fontWeight: FontWeight.bold);
  static final primaryS18W800 =
      primaryS18.copyWith(fontWeight: FontWeight.w800);

  ///secondary
  static final secondary =
      TextStyle(color: AppColors.secondary, fontFamily: AppConfigs.fontFamily);

  //s12
  static final secondaryS12 = secondary.copyWith(fontSize: 12);
  static final secondaryS12Bold =
      secondaryS12.copyWith(fontWeight: FontWeight.bold);
  static final secondaryS12W800 =
      secondaryS12.copyWith(fontWeight: FontWeight.w800);
  static final secondaryS12W300 =
      secondaryS12.copyWith(fontWeight: FontWeight.w300);
  static final secondaryS12Regular =
      secondaryS12.copyWith(fontWeight: FontWeight.w400);

  //s14
  static final secondaryS14 = secondary.copyWith(fontSize: 14);
  static final secondaryS14Bold =
      secondaryS14.copyWith(fontWeight: FontWeight.bold);
  static final secondaryS14W800 =
      secondaryS14.copyWith(fontWeight: FontWeight.w800);
  static final secondaryS14W300 =
      secondaryS14.copyWith(fontWeight: FontWeight.w300);
  static final secondaryS14Regular =
      secondaryS14.copyWith(fontWeight: FontWeight.w400);
  static final secondaryS14W300Underline =
      secondaryS14.copyWith(fontWeight: FontWeight.w300);

  //s16
  static final secondaryS16 = secondary.copyWith(fontSize: 16);
  static final secondaryS16Bold =
      secondaryS16.copyWith(fontWeight: FontWeight.bold);
  static final secondaryS16W800 =
      secondaryS16.copyWith(fontWeight: FontWeight.w800);
  static final secondaryS16Regular =
      secondaryS16.copyWith(fontWeight: FontWeight.w400);

  //s18
  static final secondaryS18 = secondary.copyWith(fontSize: 18);
  static final secondaryS18Bold =
      secondaryS18.copyWith(fontWeight: FontWeight.bold);
  static final secondaryS18W800 =
      secondaryS18.copyWith(fontWeight: FontWeight.w800);

  ///primary
  static const red =
      TextStyle(color: AppColors.textRed, fontFamily: AppConfigs.fontFamily);

  //s12
  static final redS12 = red.copyWith(fontSize: 12);
  static final redS12Bold = redS12.copyWith(fontWeight: FontWeight.bold);
  static final redS12W800 = redS12.copyWith(fontWeight: FontWeight.w800);
  static final redS12W300 = redS12.copyWith(fontWeight: FontWeight.w300);
  static final redS12Regular = redS12.copyWith(fontWeight: FontWeight.w400);

  //s14
  static final redS14 = red.copyWith(fontSize: 14);
  static final redS14Bold = redS14.copyWith(fontWeight: FontWeight.bold);
  static final redS14W800 = redS14.copyWith(fontWeight: FontWeight.w800);
  static final redS14W300 = redS14.copyWith(fontWeight: FontWeight.w300);
  static final redS14Regular = redS14.copyWith(fontWeight: FontWeight.w400);

  //s16
  static final redS16 = red.copyWith(fontSize: 16);
  static final redS16Bold = redS16.copyWith(fontWeight: FontWeight.bold);
  static final redS16W800 = redS16.copyWith(fontWeight: FontWeight.w800);
  static final redS16Regular = redS16.copyWith(fontWeight: FontWeight.w400);

  //s18
  static final redS18 = red.copyWith(fontSize: 18);
  static final redS18Bold = redS18.copyWith(fontWeight: FontWeight.bold);
  static final redS18W800 = redS18.copyWith(fontWeight: FontWeight.w800);

  //s22
  static final redS22 = red.copyWith(fontSize: 22);
  static final redS22Bold = redS22.copyWith(fontWeight: FontWeight.bold);
}
