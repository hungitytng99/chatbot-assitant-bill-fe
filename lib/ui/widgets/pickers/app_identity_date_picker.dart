import 'package:flutter/cupertino.dart';
import 'package:ihz_bql/configs/app_configs.dart';
import 'package:ihz_bql/generated/l10n.dart';

import 'app_date_picker.dart';

class AppIdentifyDatePicker extends AppDatePicker {
  AppIdentifyDatePicker({
    Key? key,
    String? label,
    String? highlightText,
    TextStyle? textStyle,
    required DatePickerController controller,
    ValueChanged<DateTime>? onChanged,
    bool enabled = true,
    bool readOnly = false,
  }) : super(
          key: key,
          controller: controller,
          labelText: label ?? S.current.common_identifyDate,
          onChanged: onChanged,
          textStyle: textStyle,
          readOnly: readOnly,
          minTime: AppConfigs.identityMinDate,
          maxTime: AppConfigs.identityMaxDate,
          enabled: enabled,
        );
}
