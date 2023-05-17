import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/widgets/app_label_text.dart';

@Deprecated('Use TextFieldPickItemWidget')
class TextFieldDropDownController extends ValueNotifier<int?> {
  TextFieldDropDownController({int? value}) : super(value);

  int? get selectedIndex => value;

  set selectedIndex(int? selectedIndex) {
    value = selectedIndex;
  }
}

@Deprecated('Use TextFieldPickItemWidget to replace TextFieldDropDownWidget')
class TextFieldDropDownWidget extends StatelessWidget {
  final String title;
  final TextFieldDropDownController controller;

  final List<String> items;
  final ValueChanged<int?>? onChanged;
  final String hintText;

  const TextFieldDropDownWidget({
    Key? key,
    required this.title,
    required this.controller,
    required this.items,
    this.onChanged,
    this.hintText = 'Chọn thư mục',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLabelText(
          labelText: title,
          labelStyle: AppTextStyle.greyS12W400,
        ),
        _buildListDropDown()
      ],
    );
  }

  Widget _buildListDropDown() {
    return ValueListenableBuilder<int?>(
        valueListenable: controller,
        child: Container(),
        builder: (context, int? index, child) {
          return GestureDetector(
            child: SizedBox(
              height: 55,
              width: double.infinity,
              child: DropdownButton<String>(
                underline: const Divider(
                    height: 1, color: AppColors.buttonGrey, thickness: 0.9),
                value: index == null ? null : items[index],
                hint: Text(
                  hintText,
                  style: AppTextStyle.blackS14Regular,
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textBlack,
                  size: 25,
                ),
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
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: AppTextStyle.blackS14Regular),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}
