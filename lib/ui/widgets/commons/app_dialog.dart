import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_dimens.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/common/app_vectors.dart';
import 'package:ihz_bql/ui/widgets/app_button_close.dart';
import 'package:ihz_bql/ui/widgets/commons/custom_dialog.dart';
import 'package:ihz_bql/utils/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';

class AppDialog {
  AppDialog._();

  static List<Asset> images = <Asset>[];

  static void defaultDialog({
    String title = "Thông báo",
    String message = "",
    String? textConfirm,
    String? textCancel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool? dismiss,
  }) {
    Get.defaultDialog(
      title: title,
      onConfirm: onConfirm == null
          ? null
          : () {
              Get.back();
              onConfirm.call();
            },
      onCancel: onCancel == null
          ? null
          : () {
              Get.back();
              onCancel.call();
            },
      textConfirm: textConfirm,
      textCancel: textCancel,
      titleStyle: AppTextStyle.blackS14Bold,
      middleText: message,
      middleTextStyle: AppTextStyle.blackS14,
      buttonColor: AppColors.primary,
      barrierDismissible: dismiss ?? true,
    );
  }

  static void showSuccessDialog(
    BuildContext context, {
    Widget? icon,
    required String title,
    String? okText,
    bool autoDismiss = false,
    bool showCloseButton = false,
    VoidCallback? onOkPressed,
    VoidCallback? onDismissed,
    bool dismissible = false,
    double? marginHorizontal,
    double? iconPosition,
  }) {
    CustomDialog(
      context: context,
      icon: icon ?? Image.asset(AppImages.icSuccess),
      title: title,
      okText: okText,
      onOkPressed: onOkPressed,
      autoDismiss: autoDismiss,
      showCloseButton: showCloseButton,
      onDismissed: onDismissed,
      dismissible: dismissible,
      marginHorizontal: marginHorizontal,
      iconPosition: iconPosition,
    ).show();
  }

  static void showUpdateSuccessDialog(
    BuildContext context, {
    Widget? icon,
    required String title,
    String? okText,
    bool autoDismiss = false,
    bool showCloseButton = false,
    VoidCallback? onOkPressed,
    VoidCallback? onDismissed,
    bool dismissible = false,
    double? marginHorizontal,
    double? iconPosition,
  }) {
    CustomDialog(
      context: context,
      icon: icon ?? Image.asset(AppImages.icSuccessDialog),
      title: title,
      okText: okText,
      onOkPressed: onOkPressed,
      autoDismiss: autoDismiss,
      showCloseButton: showCloseButton,
      onDismissed: onDismissed,
      dismissible: dismissible,
      marginHorizontal: marginHorizontal,
      iconPosition: iconPosition,
    ).show();
  }

  static void showDatePicker(
    BuildContext context, {
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onConfirm,
    LocaleType? localeType,
    DateTime? currentTime,
  }) {
    DatePicker.showDatePicker(
      context,
      minTime: minTime,
      maxTime: maxTime,
      onConfirm: onConfirm,
      locale: localeType ?? LocaleType.vi,
      currentTime: currentTime,
      theme: const DatePickerTheme(),
    );
  }

  static void showDateTimePicker(
    BuildContext context, {
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onConfirm,
    LocaleType? localeType,
    DateTime? currentTime,
  }) {
    DatePicker.showDateTimePicker(
      context,
      minTime: minTime,
      maxTime: maxTime,
      onConfirm: onConfirm,
      locale: LocaleType,
      currentTime: currentTime,
      theme: const DatePickerTheme(),
    );
  }

  static void showTimePicker(
    BuildContext context, {
    DateChangedCallback? onConfirm,
    LocaleType? localeType,
    DateTime? currentTime,
  }) {
    DatePicker.showTimePicker(
      context,
      onConfirm: onConfirm,
      locale: localeType ?? LocaleType.vi,
      currentTime: currentTime,
      showSecondsColumn: false,
      theme: const DatePickerTheme(),
    );
  }

  static Future<int?> showBottomSheetMenus({
    required List<String> menus,
  }) async {
    final result = await Get.bottomSheet(
      Container(
        color: AppColors.white,
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index < menus.length) {
              return ListTile(
                title: Text(menus[index], style: AppTextStyle.blackS14),
                onTap: () {
                  Get.back(result: index);
                },
                tileColor: AppColors.textBlack,
              );
            } else {
              return ListTile(
                title: Text(
                  'Hủy',
                  style: AppTextStyle.blackS14.copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  Get.back(result: index);
                },
                tileColor: AppColors.textBlack,
              );
            }
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              color: AppColors.divider,
            );
          },
          itemCount: menus.length + 1,
        ),
      ),
    );
    if (result is int) {
      return result;
    } else {
      return null;
    }
  }

  static Future<File?> pickImageFromGallery(BuildContext context) async {
    List<Asset> resultList = <Asset>[];
    try {
      PermissionStatus status = await Permission.photos.status;
      if (status.isGranted) {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 1,
          enableCamera: false,
          selectedAssets: images,
          cupertinoOptions: const CupertinoOptions(
            takePhotoIcon: "chat",
            doneButtonTitle: "Xong",
          ),
          materialOptions: const MaterialOptions(
            actionBarColor: "#005CF7",
            actionBarTitle: "Cuộn camera",
            allViewTitle: "Tất cả ảnh",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ),
        );
      } else if (status.isLimited) {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 1,
          enableCamera: false,
          selectedAssets: images,
          cupertinoOptions: const CupertinoOptions(
            takePhotoIcon: "chat",
            doneButtonTitle: "Xong",
          ),
          materialOptions: const MaterialOptions(
            actionBarColor: "#005CF7",
            actionBarTitle: "Cuộn camera",
            allViewTitle: "Tất cả ảnh",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ),
        );
      } else {
        showDialogRequest(content: 'Truy cập vào Settings để cho phép chọn ảnh!', context: context, title: '');
      }
      // TODO
      String fileImage = "";
          // await FlutterAbsolutePath.getAbsolutePath(resultList[0].identifier ?? "") ?? "";
      return File(fileImage);
    } catch (e) {
      logger.d(e);
    }
  }

  static Future<int?> _showBottomSheetSelectImage(context) async {
    final result = await Get.bottomSheet(Container(
      padding: const EdgeInsets.only(
        top: 15,
        left: 16,
        right: 16,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: AppDimens.paddingNormal,
                left: AppDimens.paddingLarge,
                right: AppDimens.paddingLarge),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back(result: 0);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          minRadius: 30,
                          backgroundColor: AppColors.primaryLighter,
                          child: SvgPicture.asset(
                            AppVectors.icCameraLarge,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text('Chụp ảnh', style: AppTextStyle.blackS14),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back(result: 1);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          minRadius: 30,
                          backgroundColor: AppColors.primaryLighter,
                          child: SvgPicture.asset(
                            AppVectors.icGallery,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text('Thư viện', style: AppTextStyle.blackS14),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            right: 0,
            child: AppButtonClose(),
          )
        ],
      ),
    ));
    if (result is int) {
      return result;
    }
    return null;
  }

  static Future<int?> _showRoundedBottomSheetSelectImage(context) async {
    final result = await Get.bottomSheet(Container(
      padding: const EdgeInsets.only(
        top: 15,
        left: 16,
        right: 16,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: AppDimens.paddingNormal,
                left: AppDimens.paddingLarge,
                right: AppDimens.paddingLarge),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        minRadius: 30,
                        backgroundColor: AppColors.primaryLighter,
                        child: SvgPicture.asset(
                          AppVectors.icCameraLarge,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text('Chụp ảnh', style: AppTextStyle.blackS14),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        minRadius: 30,
                        backgroundColor: AppColors.primaryLighter,
                        child: SvgPicture.asset(
                          AppVectors.icGallery,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text('Thư viện', style: AppTextStyle.blackS14),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            right: 0,
            child: AppButtonClose(),
          )
        ],
      ),
    ));
    if (result is int) {
      return result;
    }
    return null;
  }

  static Future<File?> pickImageFromCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    late XFile? image;
    PermissionStatus status = await Permission.camera.status;
    if (status.isGranted) {
      image = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1024,
        maxWidth: 1024,
      );
    } else if (status.isLimited) {
      image = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1024,
        maxWidth: 1024,
      );
    } else {
      showDialogRequest(content: 'Truy cập vào Settings để cho phép Camera!', context: context, title: '');
    }

    final path = image?.path;
    if (path != null) {
      return File(path);
    } else {
      return null;
    }
  }

  static Future<List<File>?> pickMultiMediaFromGallery(BuildContext context) async {
    FilePickerResult? result;
    PermissionStatus status = await Permission.photos.status;
    if (status.isGranted) {
      result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.media,
      );
    } else if (status.isLimited) {
      result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.media,
      );
    } else {
      showDialogRequest(content: 'Truy cập vào Settings để cho phép chọn ảnh và video!', context: context, title:'');
    }

    if (result != null) {
      return result.paths.map((path) => File(path!)).toList();
    } else {
      return null;
    }
  }

  static Future<List<File>?> pickImageMedia(context, isImage,
      {roundedBottomSheetType = false}) async {
    final int? type;
    if (roundedBottomSheetType) {
      type = await _showRoundedBottomSheetSelectImage(context);
    } else {
      type = await _showBottomSheetSelectImage(context);
    }
    if (type == 0) {
      final file = await pickImageFromCamera(context);
      if (file != null) {
        List<File>? list = [];
        list.add(file);
        return list;
      }
      return null;
    } else if (type == 1) {
      if (isImage) {
        File? file = await pickImageFromGallery(context);
        if (file != null) {
          List<File>? list = [];
          list.add(file);
          return list;
        }
      }else {
        return await pickMultiMediaFromGallery(context);
      }
    }
  }

  static Future<List<File>?> pickMultiFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        return result.files.map((e) => File(e.path!)).toList();
      }
    } catch (e) {
      debugPrint('handlePickFiles $e');
    }
    return null;
  }

  static void showDialogRequest(
      {required BuildContext context, required String title, required String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Truy cập bị từ chối'),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Deny'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: const Text('Settings'),
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
