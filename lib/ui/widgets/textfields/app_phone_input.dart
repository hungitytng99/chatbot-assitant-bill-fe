import 'package:flutter/material.dart';
import 'package:ihz_bql/utils/utils.dart';
import 'package:ihz_bql/utils/validator_utils.dart';

import 'app_label_text_field.dart';

class AppPhoneInput extends AppLabelTextField {
  AppPhoneInput({
    Key? key,
    String? highlightText,
    String? labelText,
    TextStyle? labelStyle,
    TextEditingController? textEditingController,
    ValueChanged<String>? onChanged,
    bool enabled = true,
    bool isRequire = false,
    bool readOnly = false,
  }) : super(
          key: key,
          controller: textEditingController,
          onChanged: onChanged,
          labelText: labelText ?? "Số điện thoại",
          hintText: "",
          keyboardType: TextInputType.phone,
          isRequire: isRequire,
          readOnly: readOnly,
          validator: (text) {
            if (ValidatorUtils.validateVietnamesePhone(text ?? "") || (text ?? "").isEmpty) {
              return "";
            } else {
              return "Số điện thoại không hợp lệ";
            }
          },
        );
}
