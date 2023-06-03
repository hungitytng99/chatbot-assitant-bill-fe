import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_confirm.dart';
import 'package:ihz_bql/common/confirm_allow_accessing_img.dart';
import 'package:ihz_bql/models/enums/file_source_type.dart';
import 'package:ihz_bql/utils/file_picker_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class DialogUtils {
  static Future<FileInfo?> pickFile(
    BuildContext context, {
    List<FileSourceType> sourceTypes = const [
      FileSourceType.camera,
      FileSourceType.library,
      FileSourceType.document
    ],
    String? title,
  }) async {
    FileInfo? file = await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (BuildContext context) => FilePickerDialog(
        sources: sourceTypes,
        title: title ?? "",
      ),
    );
    return file;
  }

  static Future<File?> pickImageFromCamera(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        return null;
      }
    } catch (e) {
      Navigator.of(context).pop();
      final result = await showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (BuildContext context) => ConfirmAllowAccessingImg(
          description: "Mở cài đặt cho phép ứng dụng truy cập camera của bạn",
          onConfirm: () async {
            await PhotoManager.openSetting();
          },
        ),
      );
    }
    return null;
  }

  static Future<File?> pickImageFromLibrary(BuildContext context) async {
    try {
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          themeColor: AppColors.main,
          requestType: RequestType.image,
          // specialPickerType: SpecialPickerType.
          textDelegate: const EnglishAssetPickerTextDelegate(),
        ),
      );
      return result?[0].file;
    } catch (e) {
      Navigator.of(context).pop();
      final result = await showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (BuildContext context) => ConfirmAllowAccessingImg(
          onConfirm: () async {
            await PhotoManager.openSetting();
          },
        ),
      );
    }
    return null;
  }


}
