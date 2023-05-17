import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_vectors.dart';
import 'package:ihz_bql/configs/app_configs.dart';
import 'package:ihz_bql/ui/widgets/app_label_text.dart';
import 'package:ihz_bql/utils/date_utils.dart';

class TimeRange {
  DateTime? timeStart;
  DateTime? timeEnd;

  TimeRange({
    this.timeStart,
    this.timeEnd,
  });
}

class TextFieldTimeRangePickerController extends ValueNotifier<DateTime?> {
  TextFieldTimeRangePickerController(DateTime? value) : super(value);

  DateTime? get date => value;

  set date(DateTime? newDate) {
    value = newDate;
  }
}

class TextFieldTimeRangePickerWidget extends StatefulWidget {
  final String title;
  final TextFieldTimeRangePickerController controller;
  final bool isRequire;
  final ValueChanged<TimeRange?>? onChangeTimeRange;

  const TextFieldTimeRangePickerWidget({
    Key? key,
    required this.controller,
    required this.title,
    this.isRequire = true,
    this.onChangeTimeRange,
  }) : super(key: key);

  @override
  State<TextFieldTimeRangePickerWidget> createState() =>
      _TextFieldTimeRangePickerWidgetState();
}

class _TextFieldTimeRangePickerWidgetState
    extends State<TextFieldTimeRangePickerWidget> {
  bool isShouldPick = false;
  bool isTimeStartPicked = false;
  bool isTimeEndPicked = false;
  String timeStart = '';
  String timeEnd = '';

  final TimeRange timeRange = TimeRange();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLabelText(
          labelText: widget.title,
          labelStyle: AppTextStyle.greyS12W400,
          requireStyle: AppTextStyle.greyS12W400.copyWith(color: Colors.red),
          isRequire: widget.isRequire,
        ),
        _buildTextField(context)
      ],
    );
  }

  Widget _buildTextField(context) {
    final textController = TextEditingController();
    return ValueListenableBuilder(
        valueListenable: widget.controller,
        child: Container(),
        builder: (context, DateTime? dateTime, child) {
          if (isShouldPick && timeStart.isEmpty) {
            timeRange.timeStart = dateTime;
            timeStart = dateTime != null
                ? AppDateUtils.toDateDisplayString(dateTime,
                    format: AppConfigs.timeFormat)
                : '';
            isTimeStartPicked = true;
            isShouldPick = false;
          }
          if (isShouldPick && timeEnd.isEmpty) {
            timeEnd = dateTime != null
                ? AppDateUtils.toDateDisplayString(dateTime,
                    format: AppConfigs.timeFormat)
                : '';
            isTimeEndPicked = true;
            isShouldPick = false;
            timeRange.timeEnd = dateTime;
            widget.onChangeTimeRange?.call(timeRange);
          }
          if (isTimeStartPicked && isTimeEndPicked && isShouldPick) {
            isTimeStartPicked = false;
            isTimeEndPicked = false;
            isShouldPick = false;
            timeStart = '';
            timeEnd = '';
            timeRange.timeStart = null;
            timeRange.timeEnd = null;
            widget.onChangeTimeRange?.call(TimeRange());
          }
          textController.text =
              '${timeStart.isEmpty ? 'Chọn bắt đầu' : timeStart} - ${timeEnd.isEmpty ? 'chọn kết thúc' : timeEnd}';
          return GestureDetector(
            onTap: () {
            },
            child: SizedBox(
                height: 55,
                width: double.infinity,
                child: Stack(
                  children: [
                    TextField(
                      style: AppTextStyle.blackS14Regular,
                      controller: textController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.textFieldBorder,width: 0.6),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.textFieldBorder,width: 0.6),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary,width: 0.8),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: SvgPicture.asset(AppVectors.icClock),
                    )
                  ],
                )),
          );
        });
  }
}
