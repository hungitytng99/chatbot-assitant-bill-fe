import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';

class AppButtonClose extends StatelessWidget {
  const AppButtonClose({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.background,
                border: Border.all(
                  color: AppColors.textGray,
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: const Icon(
              Icons.close,
              size: 17,
              color: AppColors.textGray,
            )),
      ),
    );
  }
}
