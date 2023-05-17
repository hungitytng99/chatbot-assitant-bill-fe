import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

class HotlineBQLWidget extends StatefulWidget {
  final String? hotline;
  final String? numberPress;
  final String? hotlineManager;
  final Color? bgColor;
  final Color? borderColor;
  final double? horPadding;
  final double? verPadding;
  final double? borderRadius;
  final bool showSuffixWidget;
  final bool isCheck;
  final Widget? widgetSuffix;
  final VoidCallback? onPress;

  const HotlineBQLWidget({
    Key? key,
    this.hotline,
    this.numberPress,
    this.hotlineManager,
    this.bgColor,
    this.borderColor,
    this.horPadding,
    this.verPadding,
    this.borderRadius,
    this.showSuffixWidget = false,
    this.widgetSuffix,
    this.isCheck = false,
    this.onPress,
  }) : super(key: key);

  @override
  _HotlineBQLWidgetState createState() => _HotlineBQLWidgetState();
}

class _HotlineBQLWidgetState extends State<HotlineBQLWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 65,
      padding: EdgeInsets.symmetric(
          horizontal: widget.horPadding ?? 20,
          vertical: widget.verPadding ?? 12
      ),
      decoration: widget.borderColor != null
          ? BoxDecoration(
              color: widget.bgColor ?? const Color(0xffF4F4F4),
              border: Border(
                bottom: BorderSide(
                    width: 1.0,
                    color: widget.borderColor ?? Colors.transparent),
              ),
            )
          : BoxDecoration(
              color: widget.bgColor ?? const Color(0xffF4F4F4),
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius ?? 5)),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.hotline ?? '',
                      style: AppTextStyle.blackS14Bold,
                    ),
                    const SizedBox(width: 8),
                    (widget.numberPress ?? '').isNotEmpty
                        ? Container(
                            height: 18,
                            padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingS12),
                            decoration: BoxDecoration(
                                color: AppColors.primaryLighter,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(11))),
                            child: Text(
                              widget.numberPress ?? "",
                              style: AppTextStyle.blackS12Regular,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.hotlineManager ?? '',
                  style: AppTextStyle.greyS12,
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.showSuffixWidget,
            child: InkWell(
              onTap: widget.onPress,
              child: widget.isCheck
                  ? (widget.widgetSuffix ?? const SizedBox())
                  : Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.borderColor, width: 1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
