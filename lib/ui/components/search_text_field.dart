import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextStyle? textStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onDelete;
  final bool isEnable;
  final double? height;
  final bool? isShowDeleteIcon;

  const SearchTextField({
    this.textEditingController,
    this.textStyle,
    this.hintText,
    this.hintStyle,
    this.height,
    this.onChanged,
    this.onSubmitted,
    this.onDelete,
    this.isEnable = true,
    this.isShowDeleteIcon = false,
  });

  Widget _iconSearch() {
    return (textEditingController?.text ?? "").trim().isEmpty &&
            isShowDeleteIcon == false
        ? SizedBox(
            width: height ?? 32,
            height: height ?? 32,
            child: Image.asset(
              AppImages.icSearch,
              // size: 16,
              // color: Colors.black,
            ),
          )
        : GestureDetector(
            onTap: onDelete,
            child: SizedBox(
              width: 32,
              height: 32,
              child: Image.asset(AppImages.icSearchDelete),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 32,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: AppDimens.paddingNormal),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        enabled: isEnable,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        controller: textEditingController,
        style: textStyle ?? AppTextStyle.blackS12,
        maxLines: 1,
        autofocus: true,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          fillColor: Colors.white,
          hintStyle: hintStyle ?? AppTextStyle.greyS12,
          hintText: hintText ?? "",
          isDense: true,
          suffixIcon: GestureDetector(
            onTap: () {
              onSubmitted?.call(textEditingController?.text ?? "");
            },
            child: _iconSearch(),
          ),
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 32, maxWidth: 32),
        ),
        cursorColor: AppColors.gray,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
