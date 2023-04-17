import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/ui/pages/common/item_picker/item_picker_page.dart';
import 'package:ihz_bql/ui/widgets/app_label_text.dart';

class TextFieldPickItemWidget extends StatelessWidget {
  final String title;
  final List<String> items;
  final ValueChanged<int?>? onChanged;
  final TextEditingController textEditingController;
  final String hintText;
  final bool isRequire;

  const TextFieldPickItemWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.textEditingController,
    this.onChanged,
    this.hintText = '',
    this.isRequire = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLabelText(
          labelText: title,
          labelStyle: AppTextStyle.greyS12W400,
          isRequire: true,
          requireStyle: AppTextStyle.greyS14.copyWith(color: Colors.red),
        ),
        _buildTextFieldPickItem(context)
      ],
    );
  }

  Widget _buildTextFieldPickItem(BuildContext context) {
    return Stack(
      children: [
        TextField(
            controller: textEditingController,
            readOnly: true,
            style: AppTextStyle.blackS14Regular,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyle.blackS14Regular,
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
            onTap: () {
              selectItem(context);
            }),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              selectItem(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.textBlack,
              size: 25,
            ),
          ),
        )
      ],
    );
  }

  void selectItem(BuildContext context) async {
    final index = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        builder: (BuildContext context) {
          return ItemPickerPage(
            titlePage: title,
            data: items,
          );
        },
        context: context);
    if (index == null) return;
    onChanged?.call(index);
    textEditingController.text = items[index];
  }

}
