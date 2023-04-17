import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_theme.dart';
import 'package:ihz_bql/ui/widgets/app_label_text.dart';

import 'app_text_field.dart';

class AppLabelTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final bool? isRequire;
  final TextStyle? labelStyle;
  final int maxLines;
  final int minLines;
  final bool? readOnly;

  const AppLabelTextField({
    Key? key,
    this.labelText = '',
    this.hintText = '',
    this.controller,
    this.onChanged,
    this.readOnly,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSaved,
    this.isRequire,
    this.labelStyle,
    this.maxLines = 1,
    this.minLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLabelText(
          labelText: labelText,
          isRequire: isRequire,
          requireStyle: AppTextStyle.greyS14.copyWith(color: Colors.red),
          labelStyle: labelStyle ??
              AppTextStyle.blackS14Regular.copyWith(color: AppColors.textGray),
        ),
        // const SizedBox(height: 8),
        AppTextField(
          onSaved: onSaved,
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          hintText: hintText,
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readOnly ?? false,
        ),
        validator != null
            ? ValueListenableBuilder(
                valueListenable: controller!,
                builder: (context, TextEditingValue controller, child) {
                  final isValid = validator?.call(controller.text) ?? "";
                  return Container(
                    padding: const EdgeInsets.only(top: AppDimens.paddingS2, bottom: AppDimens.paddingS4),
                    child: Text(
                      isValid,
                      style: AppTextStyle.redS12,
                    ),
                  );
                },
              )
            : Container(),
      ],
    );
  }
}
