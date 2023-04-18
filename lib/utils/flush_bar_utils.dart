import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/app.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_text_styles.dart';

class FlushBarUtils {
  static void showSuccessDialog({
    required BuildContext context,
    required String? message,
    TextAlign? messageAlign,
    bool? showTop,
    double? topMargin,
  }) async {
    // Flushbar(
    //   shouldIconPulse: false,
    //   duration: const Duration(seconds: 3),
    //   borderWidth: 1.5,
    //   flushbarPosition:
    //       showTop == true ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    //   margin: EdgeInsets.fromLTRB(10, topMargin ?? 0, 10, 15),
    //   borderRadius: const BorderRadius.all(Radius.circular(10)),
    //   backgroundColor: AppColors.greenC5EBB8,
    //   borderColor: AppColors.greyDBDBDB,
    //   messageText: Center(
    //     child: Text(
    //       message ?? "",
    //       textAlign: messageAlign,
    //       style: AppTextStyle.white.copyWith(
    //         fontWeight: FontWeight.w500,
    //         fontSize: 16,
    //       ),
    //     ),
    //   ),
    //   padding: const EdgeInsets.all(14),
    // ).show(appNavigatorKey.currentContext!);
  }

  static void showErrorDialog({
    required BuildContext context,
    required String? message,
    // FlushbarPosition? position,
    double? topMargin,
  }) async {
    // Flushbar(
    //   shouldIconPulse: false,
    //   duration: const Duration(seconds: 3),
    //   flushbarPosition: position ?? FlushbarPosition.BOTTOM,
    //   margin: EdgeInsets.fromLTRB(10, topMargin ?? 0, 10, 15),
    //   borderRadius: const BorderRadius.all(const Radius.circular(10)),
    //   backgroundColor: AppColors.lightRed,
    //   borderColor: AppColors.buttonRed,
    //   borderWidth: 1.5,
    //   messageText: Center(
    //     child: Text(
    //       message ?? "",
    //       style: AppTextStyle.red.copyWith(
    //         fontWeight: FontWeight.w500,
    //         fontSize: 16,
    //       ),
    //     ),
    //   ),
    //   padding: const EdgeInsets.all(16),
    // ).show(appNavigatorKey.currentContext!);
  }
}
