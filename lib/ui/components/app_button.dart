import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_shadow.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/widgets/loading_indicator_widget.dart';

class _AppButton extends StatelessWidget {
  String? title;
  bool isLoading;
  bool? isEnable;
  VoidCallback? onPressed;
  double borderRadius;
  Color backgroundColor = Colors.white;
  TextStyle? textStyle = AppTextStyle.whiteS14Bold;
  BoxDecoration? buttonBoxDecoration;
  BoxBorder? border;

  _AppButton({
    this.title = '',
    this.isLoading = false,
    this.isEnable = true,
    this.onPressed,
    this.borderRadius = 8,
    this.textStyle,
    this.buttonBoxDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: double.infinity,
      child: ButtonTheme(
        minWidth: 0.0,
        height: 0.0,
        padding: const EdgeInsets.all(AppDimens.paddingNone),
        child: TextButton(
          child: _buildBodyWidget(),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ))),
          onPressed: isEnable! ? (isLoading ? null : onPressed) : null,
        ),
      ),
      decoration: buttonBoxDecoration ??
          BoxDecoration(
            color: isEnable! ? backgroundColor : const Color(0xFFCBCBCB),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            boxShadow: isEnable! ? AppShadow.boxShadow : [],
            border: border,
          ),
    );
  }

  Widget _buildBodyWidget() {
    if (isLoading) {
      return const LoadingIndicatorWidget(color: Colors.white);
    } else {
      return Text(
        title!,
        style: textStyle,
      );
    }
  }
}

class AppWhiteButton extends _AppButton {
  AppWhiteButton({
    String title = '',
    bool isEnable = true,
    bool isLoading = false,
    VoidCallback? onPressed,
    double borderRadius = 20,
    TextStyle? textStyle,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.onPressed = onPressed;
    //SetupUI
    this.textStyle = textStyle ?? AppTextStyle.blackS14Bold;
    backgroundColor = Colors.white;
    this.borderRadius = borderRadius;
    this.buttonBoxDecoration = BoxDecoration(
        color: isEnable ? backgroundColor : const Color(0xFFCBCBCB),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        border: Border.all(color: AppColors.gray, width: 1));
  }
}

class AppTintButton extends _AppButton {
  AppTintButton({
    String? title = '',
    bool isLoading = false,
    bool? isEnable = true,
    VoidCallback? onPressed,
    double? borderRadius,
    TextStyle? textStyle,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.isEnable = isEnable;
    this.onPressed = onPressed;
    //SetupUI
    this.textStyle = textStyle ?? AppTextStyle.whiteS14Bold;
    backgroundColor = AppColors.main;
    this.borderRadius = borderRadius ?? 20;
  }
}

class AppBlueButton extends _AppButton {
  AppBlueButton({
    String title = '',
    bool isLoading = false,
    bool isEnable = true,
    VoidCallback? onPressed,
    double? borderRadius,
    TextStyle? textStyle,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.isEnable = isEnable;
    this.onPressed = onPressed;
    //SetupUI
    this.textStyle = textStyle ?? AppTextStyle.whiteS14Bold;
    backgroundColor = AppColors.buttonTint;
    this.borderRadius = borderRadius ?? 20;
    this.borderRadius = borderRadius ?? 20;
  }
}

class AppGreyButton extends _AppButton {
  AppGreyButton({
    String title = '',
    bool isLoading = false,
    bool isEnable = true,
    VoidCallback? onPressed,
    double? borderRadius,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.isEnable = isEnable;
    this.onPressed = onPressed;
    //SetupUI
    textStyle = AppTextStyle.whiteS14Bold;
    backgroundColor = AppColors.buttonGrey;
    this.borderRadius = borderRadius ?? 20;
  }
}

class AppOrangeButton extends _AppButton {
  AppOrangeButton({
    String title = '',
    bool isLoading = false,
    bool isEnable = true,
    VoidCallback? onPressed,
    double? borderRadius,
    TextStyle? textStyle,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.isEnable = isEnable;
    this.onPressed = onPressed;
    //SetupUI
    this.textStyle = textStyle ?? AppTextStyle.whiteS14Bold;
    backgroundColor = AppColors.primary;
    this.borderRadius = borderRadius ?? 20;
  }
}

class AppButtonCustom extends _AppButton {
  AppButtonCustom({
    String title = '',
    bool isLoading = false,
    bool isEnable = true,
    VoidCallback? onPressed,
    double? borderRadius,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.isEnable = isEnable;
    this.onPressed = onPressed;
    //SetupUI
    this.textStyle = textStyle ?? AppTextStyle.whiteS14Bold;
    this.backgroundColor = backgroundColor ?? AppColors.orange;
    this.borderRadius = borderRadius ?? 20;
  }
}

class AppTintBorderButton extends _AppButton {
  AppTintBorderButton({
    String title = '',
    bool isLoading = false,
    bool isEnable = true,
    VoidCallback? onPressed,
    double? borderRadius,
    TextStyle? textStyle,
    BoxBorder? border,
  }) {
    this.title = title;
    this.isLoading = isLoading;
    this.isEnable = isEnable;
    this.onPressed = onPressed;
    //SetupUI
    this.textStyle = textStyle ?? AppTextStyle.tintS14;
    this.borderRadius = borderRadius ?? 20;
    this.border = border ?? Border.all(color: AppColors.main);
  }
}

class AppWhiteCustomButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final bool isEnable;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  AppWhiteCustomButton({
    required this.title,
    this.isLoading = false,
    this.onPressed,
    this.isEnable = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: double.infinity,
      child: ButtonTheme(
        minWidth: 0.0,
        height: 0.0,
        padding: const EdgeInsets.all(AppDimens.paddingNone),
        child: FlatButton(
          child: isLoading
              ? const LoadingIndicatorWidget(color: Colors.white)
              : Text(
                  title,
                  style: isEnable
                      ? textStyle ?? AppTextStyle.blackS14
                      : AppTextStyle.whiteS14Bold,
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: isEnable ? (isLoading ? null : onPressed) : null,
        ),
      ),
      decoration: BoxDecoration(
        color: isEnable ? Colors.white : const Color(0xFFCBCBCB),
        border:
            isEnable ? Border.all(width: 0.4, color: AppColors.lineGray) : null,
        borderRadius: const BorderRadius.all(const Radius.circular(20)),
      ),
    );
  }
}
