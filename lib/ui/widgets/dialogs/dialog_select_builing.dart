import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

class ShowDialogBuilding {
  static Future<void> showSelectDialogBuilding({
    required BuildContext context,
  }) async {
    return showDialog (
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () => Get.back(),
                      child: SizedBox(
                        height: 30,
                        child: Image.asset(AppImages.icClose),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Chọn Toà nhà/ Dự án quản lý',
                  style: AppTextStyle.blackS16Bold,
                ),
              ],
            ),
          )
        );
      },
    );
  }
}