import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

class AppLabelText extends StatelessWidget {
  final String labelText;
  final TextStyle? labelStyle;
  final TextStyle? requireStyle;
  final bool? isRequire;
  final TextAlign? textAlign;

  const AppLabelText({
    Key? key,
    required this.labelText,
    this.textAlign,
    this.labelStyle,
    this.requireStyle,
    this.isRequire = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      text: TextSpan(
        text: labelText,
        style: labelStyle ?? AppTextStyle.blackS14,
        children: <TextSpan>[
          TextSpan(
            text: (isRequire ?? false) ? '*' : '',
            style: (requireStyle ?? labelStyle) ??
                AppTextStyle.blackS14.copyWith(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
