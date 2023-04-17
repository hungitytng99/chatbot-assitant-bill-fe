import 'package:flutter/material.dart';
import 'package:ihz_bql/utils/validator_utils.dart';

import 'app_label_text_field.dart';

class AppIdentityNumberInput extends AppLabelTextField {
  AppIdentityNumberInput({
    Key? key,
    String? highlightText,
    String? labelText,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    TextEditingController? textEditingController,
    ValueChanged<String>? onChanged,
    bool enabled = true,
    bool isShowValidator = true,
    bool readOnly = true,
  }) : super(
          key: key,
          controller: textEditingController,
          labelText: labelText ?? "Số CMND/ CCCD",
          labelStyle: labelStyle,
          hintText: "",
          readOnly: readOnly,
          validator:isShowValidator ? (text) {
            if (ValidatorUtils.validateIdentityCode(text ?? "")) {
              return "";
            } else if (text!.isEmpty) {
              return '';
            } else {
              return "${labelText ?? "Số CMND/ CCCD"} không hợp lệ";
            }
          } : null,
          onChanged: onChanged,
        );
}
