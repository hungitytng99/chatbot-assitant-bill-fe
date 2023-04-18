import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final FormFieldSetter<String>? onSaved;
  final bool obscureText;
  final String hintText;
  final int maxLines;
  final int minLines;
  final bool readOnly;
  final Widget? suffixIcon;

  const AppTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.onSaved,
    this.obscureText = false,
    this.readOnly = false,
    this.hintText = '',
    this.maxLines = 1,
    this.minLines = 1,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lineGray),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lineGray),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lineGray),
        ),
        isDense: true,
        filled: true,
        hintStyle: AppTextStyle.greyS16,
        suffixIcon: suffixIcon,
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 38, maxWidth: 38),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLines: maxLines,
      style: AppTextStyle.blackS16,
      onSaved: onSaved,
      obscureText: obscureText,
      readOnly: readOnly,
      minLines: minLines,
    );
  }
}
