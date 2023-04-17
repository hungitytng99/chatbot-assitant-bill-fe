import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

class AppInputWithLabel extends StatelessWidget {
  String? title;
  TextEditingController? controller;
  Widget? suffix;
  bool? readOnly;
  TextInputType? inputType;
  double? padding;
  String? errorText;

  AppInputWithLabel(
      {this.title,
      this.controller,
      this.suffix,
      this.readOnly,
      this.inputType,
      this.padding,
      this.errorText,
      Key? key})
      : super(
            key: key); // const AppInputWithLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 65,
      padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title ?? '', style: AppTextStyle.greyS12),
          const SizedBox(height: 8),
          SizedBox(
            height: 20,
            child: TextField(
              keyboardType: inputType,
              readOnly: readOnly ?? false,
              controller: controller,
              style: AppTextStyle.blackS14Regular,
              decoration: InputDecoration(
                suffixIcon: suffix ?? const SizedBox(),
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(
            color: AppColors.lineGray,
            thickness: 1,
            height: 1,
          ),
          Visibility(
            visible: errorText != null,
            child: Padding(
              padding: const EdgeInsets.only(top: AppDimens.paddingS4),
              child: Text(
                errorText ?? "",
                style: AppTextStyle.greyS12.copyWith(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
