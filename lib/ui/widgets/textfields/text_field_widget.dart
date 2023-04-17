import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/widgets/app_label_text.dart';

class TextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final int maxLines;
  final String? hintText;
  final bool isFieldContent;
  final bool isRequire;
  final ValueChanged<String>? onChange;

  const TextFieldWidget({
    Key? key,
    required this.title,
    this.controller,
    this.maxLines = 1,
    this.isFieldContent = false,
    this.hintText = '',
    this.isRequire = false,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLabelText(
          labelText: title,
          labelStyle: AppTextStyle.greyS12W400,
          isRequire: isRequire,
          requireStyle: AppTextStyle.greyS12W400.copyWith(color: Colors.red),
        ),
        TextField(
          controller: controller,
          style: AppTextStyle.blackS14Regular,
          decoration: InputDecoration(
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder,width: 0.6),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.textFieldBorder,width: 0.6),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary,width: 0.8),
              ),
              hintText: hintText,
              hintStyle: AppTextStyle.blackS14Regular),
          maxLength: null,
          maxLines: isFieldContent ? null : maxLines,
          onChanged: onChange,
        )
      ],
    );
  }
}
