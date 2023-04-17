import 'package:flutter/material.dart';
import 'package:ihz_bql/generated/l10n.dart';

import 'app_label_text_field.dart';

class AppUsernameInput extends AppLabelTextField {
  AppUsernameInput({
    Key? key,
    TextEditingController? textEditingController,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          controller: textEditingController,
          onChanged: onChanged,
          labelText: S.current.common_account,
          hintText: '',
          keyboardType: TextInputType.emailAddress,
        );
}
