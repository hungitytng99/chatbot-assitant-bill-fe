import 'package:flutter/material.dart';
import 'package:ihz_bql/utils/utils.dart';

import 'app_label_text_field.dart';

class AppEmailInput extends AppLabelTextField {
  AppEmailInput({
    Key? key,
    String? labelText,
    TextEditingController? textEditingController,
    ValueChanged<String>? onChanged,
    bool isRequire = false,
    bool readOnly = false,
  }) : super(
          key: key,
          controller: textEditingController,
          onChanged: onChanged,
          labelText: labelText ?? 'Địa chỉ email',
          hintText: "",
          keyboardType: TextInputType.emailAddress,
          isRequire: isRequire,
          readOnly: readOnly,
          validator: (text) {
            if (Utils.isEmail(text ?? "") || (text ?? "").isEmpty) {
              return "";
            } else {
              return "Email không hợp lệ";
            }
          },
        );
}
