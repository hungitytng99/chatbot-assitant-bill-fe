import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_vectors.dart';
import 'package:ihz_bql/ui/widgets/app_label_text.dart';
import 'package:ihz_bql/utils/date_utils.dart';

class TextFieldDatePickerController extends ValueNotifier<DateTime?> {
  TextFieldDatePickerController(DateTime? value) : super(value);

  DateTime? get date => value;

  set date(DateTime? newDate) {
    value = newDate;
  }
}

class TextFieldDatePickerWidget extends StatelessWidget {
  final TextFieldDatePickerController controller;
  final ValueChanged<DateTime?>? onChange;
  final bool isRequire;
  final String hintText;
  final String? icon;

  const TextFieldDatePickerWidget({
    Key? key,
    required this.controller,
    required this.title,
    this.onChange,
    this.isRequire = true,
    this.hintText = '',
    this.icon = AppVectors.icCalendar,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isNotEmpty
            ? AppLabelText(
                labelText: title,
                labelStyle: AppTextStyle.greyS12W400,
                requireStyle:
                    AppTextStyle.greyS12W400.copyWith(color: Colors.red),
                isRequire: isRequire,
              )
            : const SizedBox(),
        _buildTextField(context)
      ],
    );
  }

  Widget _buildTextField(context) {
    final textController = TextEditingController();
    return ValueListenableBuilder(
        valueListenable: controller,
        child: Container(),
        builder: (context, DateTime? dateTime, child) {
          onChange?.call(dateTime);
          textController.text = dateTime != null
              ? AppDateUtils.toDateDisplayString(dateTime)
              : '';
          return GestureDetector(
            onTap: () {
            },
            child: SizedBox(
                height: 55,
                width: double.infinity,
                child: Stack(
                  children: [
                    TextField(
                      controller: textController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: AppTextStyle.blackS14Regular,
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldBorder, width: 0.6),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldBorder, width: 0.6),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primary, width: 0.8),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(icon ?? AppVectors.icCalendar),
                    )
                  ],
                )),
          );
        });
  }

}
