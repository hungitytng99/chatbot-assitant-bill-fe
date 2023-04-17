import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

class AppDropdownController extends ValueNotifier<int?> {
  AppDropdownController({int? value}) : super(value);

  int? get selectedIndex => value;

  set date(int? selectedIndex) {
    value = selectedIndex;
  }
}

class AppDropdownPicker extends StatelessWidget {
  final AppDropdownController controller;
  final List<String> items;
  final String? title;
  final ValueChanged<int?>? onChanged;

  const AppDropdownPicker({
    Key? key,
    required this.controller,
    this.title,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((title ?? '').isNotEmpty)
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              title ?? '',
              style: AppTextStyle.blackS14,
            ),
          ),
        ValueListenableBuilder<int?>(
            valueListenable: controller,
            child: Container(),
            builder: (context, int? index, child) {
              return GestureDetector(
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.paddingSmall),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: index == null
                          ? AppColors.borderColor
                          : AppColors.textBlack,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: index == null ? null : items[index],
                      hint: Text(
                        'Click to select a data',
                        style: AppTextStyle.blackS14,
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColors.textGray,
                      ),
                      style: AppTextStyle.blackS14,
                      underline: null,
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.value = items.indexOf(newValue);
                          onChanged?.call(items.indexOf(newValue));
                        } else {
                          controller.value = null;
                          onChanged?.call(null);
                        }
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: AppTextStyle.blackS14,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
