import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_vectors.dart';

enum DialogType { info, success, error }

class AppStatusDialog {
  final BuildContext context;
  final DialogType type;
  final String? title;
  final String? description;
  final String okText;
  final VoidCallback? onOkPressed;
  final String cancelText;
  final VoidCallback? onCancelPressed;
  final bool dismissible;
  final VoidCallback? onDismissed;
  final bool autoDismiss;
  final VoidCallback? overrideDismiss;

  AppStatusDialog( {
    required this.context,
    this.type = DialogType.info,
    this.title,
    this.description,
    this.okText = '',
    this.onOkPressed,
    this.cancelText = '',
    this.onCancelPressed,
    this.onDismissed,
    this.dismissible = false,
    this.autoDismiss = false,
    this.overrideDismiss,
  });

  void show() {
    //Auto dismiss after 2 seconds
    if (autoDismiss) {
      Future.delayed(const Duration(seconds: 2), () {
        dismiss();
      });
    }
    showDialog(
        useRootNavigator: true,
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return buildDialog;
        });
  }

  Widget get buildDialog {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppDimens.marginExtra),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.only(
                    top: AppDimens.paddingSmall,
                    left: AppDimens.paddingS5,
                    right: AppDimens.paddingS5,
                  ),
                  child: Column(
                    children: [
                      _buildHeaderIcon,
                      _buildTitleText,
                      _buildDescriptionText,
                      _buildActions,
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
    switch (type) {
      case DialogType.info:
        return Container();
      case DialogType.success:
        return Container(
          margin: const EdgeInsets.only(top: AppDimens.marginSmall),
          child: SvgPicture.asset(
            AppVectors.icDialogSuccess,
            color: AppColors.main,
          ),
        );
      case DialogType.error:
        return SvgPicture.asset(
          AppVectors.icDialogError,
        );
    }
  }

  Widget get _buildTitleText {
    if ((title ?? '').isEmpty) return Container();
    return Container(
      margin: const EdgeInsets.only(top: AppDimens.marginSmall),
      child: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: AppTextStyle.blackS16Bold.copyWith(color: AppColors.main),
      ),
    );
  }

  Widget get _buildDescriptionText {
    if ((description ?? '').isEmpty) return Container();
    return Container(
      margin: const EdgeInsets.only(top: AppDimens.marginSmall),
      child: Text(
        description ?? '',
        textAlign: TextAlign.center,
        style: AppTextStyle.blackS14,
      ),
    );
  }

  Widget get _buildActions {
    bool showOkButton = (okText).isNotEmpty;
    bool showCancelButton = (cancelText).isNotEmpty;

    return Row(
      children: [
        showOkButton
            ? Expanded(
            child: Container(
              child: _buildOkButton,
            ))

        /// check xem nút cancel có còn dùng ko? nếu ko dùng thì padding button 1 đoạn
            : showCancelButton
            ? Container()
            : Container(
          height: 15,
        ),
        showCancelButton
            ? Expanded(
            child: Container(
              child: _buildCancelButton,
            ))

        /// check xem nút ok có còn dùng ko? nếu ko dùng thì padding button 1 đoạn
            : showOkButton
            ? Container()
            : Container(
          height: 15,
        ),
      ],
    );
  }

  Widget get _buildOkButton {
    return FlatButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        dismiss();
        onOkPressed?.call();
      },
      child: Text(
        okText,
        style: AppTextStyle.blackS14Bold.copyWith(color: AppColors.main),
      ),
    );
  }

  Widget get _buildCancelButton => FlatButton(
    onPressed: () {
      dismiss();
      onCancelPressed?.call();
    },
    child: Text(
        cancelText,
        style: AppTextStyle.blackS14Bold.copyWith(color: AppColors.main)
    ),
    color: Colors.transparent,
  );

  dismiss() {
    if(overrideDismiss == null) {
      Navigator.of(context).pop();
    } else {
      overrideDismiss?.call();
    }
    onDismissed?.call();
  }

  Future<bool> _onWillPop() async {
    return (dismissible == null);
  }
}
