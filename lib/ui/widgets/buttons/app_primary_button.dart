import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

import 'app_button.dart';

class AppPrimaryButton extends StatelessWidget {
  final String? title;
  final bool isLoading;
  final VoidCallback? onPressed;
  final double height;

  const AppPrimaryButton({
    Key? key,
    this.title,
    this.isLoading = false,
    this.onPressed,
    this.height = 52,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      title: title,
      isLoading: isLoading,
      onPressed: onPressed,
      textStyle: AppTextStyle.whiteS16Bold,
      backgroundColor: AppColors.primary,
      height: height,
    );
  }
}
