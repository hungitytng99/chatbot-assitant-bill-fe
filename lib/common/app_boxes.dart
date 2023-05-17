import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_shadow.dart';

import 'app_colors.dart';

class AppBoxes {
  static final boxBorderTop = BoxDecoration(
    boxShadow: AppShadow.boxShadow,
    color: Colors.white,
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  );

  static final boxBorderItemGrey = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    border: Border.all(
      width: 1,
      color: AppColors.greyDBDBDB,
    ),
  );

  static final boxBorderItemOrange = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      width: 1,
      color: AppColors.orange,
    ),
  );
}

