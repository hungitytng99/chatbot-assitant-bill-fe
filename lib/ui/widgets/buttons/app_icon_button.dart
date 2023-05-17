import 'package:flutter/material.dart';

import 'app_button.dart';

class AppIconButton extends AppButton {
  const AppIconButton({
    String? title,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool isLoading = false,
    TextStyle? textStyle,
    Color? backgroundColor,
    VoidCallback? onPressed,
    double? width,
  }) : super(
          title: title,
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon,
          isLoading: isLoading,
          onPressed: onPressed,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          width: width ?? double.infinity,
        );
}
