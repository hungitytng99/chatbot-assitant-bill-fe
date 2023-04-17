import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/generated/l10n.dart';
import 'package:ihz_bql/ui/components/search_text_field.dart';

class MyAppSearchBar extends StatelessWidget {
  final String? title;
  final VoidCallback? onBackPressed;
  final TextEditingController? textEditingController;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onDelete;
  final String? hintText;

  MyAppSearchBar({
    this.title,
    this.onBackPressed,
    this.textEditingController,
    this.onSubmitted,
    this.onDelete,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          onBackPressed != null
              ? GestureDetector(
                  onTap: onBackPressed,
                  child: Container(
                    width: 36,
                    height: 44,
                    color: Colors.transparent,
                    child: Center(
                      child: Image.asset(AppImages.icBack),
                    ),
                  ),
                )
              : const SizedBox(width: 10),
          const SizedBox(width: 2),
          SizedBox(
            width: MediaQuery.of(context).size.width - 13 - 49,
            child: SearchTextField(
              textEditingController: textEditingController,
              hintText: hintText ?? S.current.search_request,
              onSubmitted: onSubmitted,
              onDelete: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
