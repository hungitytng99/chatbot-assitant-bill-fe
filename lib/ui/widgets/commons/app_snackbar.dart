import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/generated/l10n.dart';
import 'package:ihz_bql/networks/check_connect.dart';

class AppSnackbar {
  static void showInfo({String? title, String? message, VoidCallback? onTap}) {
    Get.snackbar(
      title ?? S.current.snackbar_infoTitle,
      message ?? '',
      backgroundColor: AppColors.greenC5EBB8,
      colorText: AppColors.greenRequest,
      onTap: onTap == null
          ? null
          : (getBar) {
              onTap.call();
            },
    );
  }

  static void showWarning({String? title, String? message}) {
    Get.snackbar(
      title ?? S.current.snackbar_warningTitle,
      message ?? '',
      backgroundColor: AppColors.bgWarningSnackBar,
      colorText: AppColors.textBlack,
    );
  }

  static void showError({String? title, String? message}) {
    CheckConnect.checkConnect().then((value) {
      if(value){
       message;
        Get.snackbar(
          title ?? S.current.snackbar_errorTitle,
          message ?? '',
          backgroundColor: AppColors.bgErrorSnackBar,
          colorText: AppColors.textRed,
        );
      }else{
        Get.snackbar(
          title ?? S.current.snackbar_errorTitle,
          'Lỗi không thể kết nối, xin vui lòng kiểm tra lại',
          backgroundColor: AppColors.bgErrorSnackBar,
          colorText: AppColors.textRed,
        );
      }
    });
  }
  static void showValidate({String? title, String? message}) {
    Get.snackbar(
      title ?? S.current.snackbar_errorTitle,
      message ?? '',
      backgroundColor: AppColors.bgErrorSnackBar,
      colorText: AppColors.textRed,
    );
  }
}
