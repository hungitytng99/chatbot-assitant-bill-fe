import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_vectors.dart';
import 'package:ihz_bql/ui/widgets/commons/app_dialog.dart';
import 'package:intl/intl.dart';
import 'package:ihz_bql/ui/widgets/app_label_text.dart';

class DatePickerController extends ValueNotifier<DateTime?> {
  DatePickerController({
    DateTime? dateTime,
  }) : super(dateTime);

  DateTime? get date => value;

  set date(DateTime? newDate) {
    value = newDate;
  }
}

class AppDatePicker extends StatelessWidget {
  final DatePickerController controller;
  final String dateFormat;
  final DateTime? minTime;
  final DateTime? maxTime;
  final ValueChanged<DateTime>? onChanged;

  final String labelText;
  final TextStyle? labelStyle;
  final bool? isRequire;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final String hintText;
  final TextStyle? hintStyle;
  final bool enabled;
  final bool readOnly;

  const AppDatePicker({
    Key? key,
    this.dateFormat = "dd/MM/yyyy",
    this.minTime,
    this.maxTime,
    required this.controller,
    this.labelText = "",
    this.labelStyle,
    this.isRequire,
    this.readOnly = false,
    this.suffixIcon,
    this.textStyle,
    this.hintText = "",
    this.hintStyle,
    this.onChanged,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText.isNotEmpty) ...[
          AppLabelText(
            labelText: labelText,
            labelStyle: labelStyle,
            isRequire: isRequire,
          ),
          const SizedBox(height: 8),
        ],
        ValueListenableBuilder(
          valueListenable: controller,
          child: Container(),
          builder: (context, dynamic dateTime, child) {
            var dateString = "";
            if (dateTime != null) {
              dateString = DateFormat(dateFormat).format(dateTime);
            }
            return GestureDetector(
              onTap:readOnly ? null : () {
              },
              child: TextField(
                enabled: false,
                textInputAction: TextInputAction.search,
                controller: TextEditingController(text: dateString),
                style: enabled ? textStyle ?? AppTextStyle.blackS16 : (textStyle ??AppTextStyle.greyS16).copyWith(color: AppColors.gray),
                maxLines: 1,
                readOnly: readOnly,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lineGray),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lineGray),
                  ),
                  disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lineGray),
                  ),
                  fillColor: Colors.white,
                  hintStyle: hintStyle ?? AppTextStyle.greyS16,
                  hintText: hintText,
                  isDense: true,
                  contentPadding: const EdgeInsets.only(top: AppDimens.paddingS8, bottom: AppDimens.paddingS12),
                  suffixIcon: suffixIcon ?? SvgPicture.asset(AppVectors.icCalendar),
                  suffixIconConstraints: const BoxConstraints(maxHeight: 32, maxWidth: 32),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

}
