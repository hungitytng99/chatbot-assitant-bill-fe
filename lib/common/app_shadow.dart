import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadow {
  static final boxShadow = [
    const BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 3,
      offset: Offset(0, 0),
    ),
  ];

  static final pageBoxShadow = [
    const BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 6,
      offset: Offset(0, 0),
    ),
  ];

  static final boxShadowLarge = [
    const BoxShadow(
      color: AppColors.shadowColor,
      spreadRadius: 20,
      blurRadius: 100,
      offset: Offset(0, 0),
    )
  ];
}
