import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

import '../app_circular_progress_indicator.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  final bool isLoading;
  final bool isEnable;

  final double height;
  final double width;

  final double borderWidth;
  final double cornerRadius;

  final Color? backgroundColor;
  final Color disableBackgroundColor;
  final Color borderColor;

  final TextStyle? textStyle;

  final VoidCallback? onPressed;

  const AppButton({
    Key? key,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.isEnable = true,
    this.isLoading = false,
    this.height = 52,
    this.width = double.infinity,
    this.borderWidth = 0,
    this.cornerRadius = 30,
    this.backgroundColor,
    this.disableBackgroundColor = Colors.grey,
    this.borderColor = Colors.transparent,
    this.textStyle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        child: _buildChildWidget(),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
          primary: isEnable ? backgroundColor : disableBackgroundColor,
          padding: const EdgeInsets.all(AppDimens.paddingNone),
          onSurface: isEnable ? backgroundColor : disableBackgroundColor,
          onPrimary: isEnable ? backgroundColor : disableBackgroundColor,
        ),
        onPressed: isEnable ? (isLoading ? null : onPressed) : null,
      ),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return const AppCircularProgressIndicator(color: Colors.white);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leadingIcon ?? Container(),
          Text(
            title ?? '',
            style: textStyle ?? AppTextStyle.whiteS14W800,
          ),
          trailingIcon ?? Container(),
        ],
      );
    }
  }
}
