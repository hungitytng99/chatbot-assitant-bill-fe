import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_vectors.dart';

enum DialogType { INFO, SUCCESS, ERROR }

class CustomDialog {
  final BuildContext context;
  final DialogType type;
  final Widget? icon;
  final String? title;
  final String? description;
  final String? okText;
  final VoidCallback? onOkPressed;
  final String? cancelText;
  final VoidCallback? onCancelPressed;
  final bool dismissible;
  final VoidCallback? onDismissed;
  final bool autoDismiss;
  final bool showCloseButton;
  final TextStyle? titleStyle;
  final double? marginHorizontal;
  final double? iconPosition;

  CustomDialog({
    required this.context,
    this.type = DialogType.INFO,
    this.icon,
    this.titleStyle,
    this.title,
    this.description,
    this.okText = '',
    this.onOkPressed,
    this.cancelText = '',
    this.onCancelPressed,
    this.onDismissed,
    this.dismissible = false,
    this.autoDismiss = false,
    this.showCloseButton = false,
    this.marginHorizontal = 40,
    this.iconPosition = 20,
  });

  Timer? t;
  void show() {
    //Auto dismiss after 3 seconds
    if (autoDismiss) {
      t = Timer(const Duration(seconds: 3), () {
        dismiss();
      });
    }
    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return _buildDialog;
        });
  }

  Widget get _buildDialog {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: GestureDetector(
          onTap: () {
            if (dismissible == true) {
              dismiss();
            }
          },
          child: Container(
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    marginHorizontal ?? AppDimens.marginExtra,
                                vertical: AppDimens.marginNormal),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppDimens.paddingS12, vertical: 4),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                _buildHeaderIcon,
                                const SizedBox(height: 6),
                                _buildTitleText,
                                const SizedBox(height: 6),
                                _buildActions,
                                const SizedBox(height: 2),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: iconPosition ?? 20,
                            child: Visibility(
                              visible: showCloseButton,
                              child: GestureDetector(
                                onTap: dismiss,
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                    child: Image.asset(AppImages.icCircleClose),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildHeaderIcon {
    if (icon != null) {
      return Container(child: icon);
    }
    switch (type) {
      case DialogType.INFO:
        return Container();
      case DialogType.SUCCESS:
        return Container(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: SvgPicture.asset(
            AppVectors.icDialogSuccess,
            color: AppColors.primary,
          ),
        );
      case DialogType.ERROR:
        return Container(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: SvgPicture.asset(
            AppVectors.icDialogError,
            color: AppColors.primary,
          ),
        );
    }
  }

  Widget get _buildTitleText {
    if ((title ?? '').isEmpty) return Container();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: titleStyle ?? AppTextStyle.blackS14.copyWith(height: 1.4),
      ),
    );
  }

  Widget get _buildActions {
    bool showOkButton = (okText ?? '').isNotEmpty;
    bool showCancelButton = (cancelText)?.isNotEmpty ?? true;
    List<Widget> buttons = [];
    if (showCancelButton) {
      buttons.add(_buildCancelButton);
    }
    if (showOkButton) {
      buttons.add(_buildOkButton);
    }
    if (buttons.isEmpty) {
      return Container(height: 14);
    }
    return SizedBox(
      // color: Colors.red,
      height: 36,
      // padding: EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: buttons,
      ),
    );
  }

  Widget get _buildOkButton {
    return Row(
      children: [
        const SizedBox(
          width: 15,
        ),
        TextButton(
          onPressed: () {
            dismiss();
            onOkPressed?.call();
          },
          child: Text(
            okText!,
            style: AppTextStyle.tintS14
                .copyWith(height: 1.4, color: AppColors.primary),
          ),
        )
      ],
    );
  }

  Widget get _buildCancelButton => Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          TextButton(
            onPressed: () {
              dismiss();
              onCancelPressed?.call();
            },
            child: Text(
              cancelText ?? "",
              style: AppTextStyle.tintS14BoldH14,
            ),
          ),
        ],
      );

  dismiss() {
    t?.cancel();
    Get.back();
    onDismissed?.call();
  }

  Future<bool> _onWillPop() async {
    return dismissible;
  }
}
