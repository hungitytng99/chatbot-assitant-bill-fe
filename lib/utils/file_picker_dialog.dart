import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/common/app_images.dart';
import 'package:ihz_bql/common/app_text_styles.dart';
import 'package:ihz_bql/configs/app_configs.dart';
import 'package:ihz_bql/models/enums/file_source_type.dart';
import 'package:ihz_bql/utils/dialog_utils.dart';
import 'package:ihz_bql/utils/file_utils.dart';
import 'package:ihz_bql/utils/flush_bar_utils.dart';

class FileInfo {
  final File? file;
  final FileSourceType? sourceType;

  FileInfo({
    this.file,
    this.sourceType,
  });
}

extension SourceTypeExtension on FileSourceType? {
  String get title {
    switch (this) {
      case FileSourceType.camera:
        return "Chụp ảnh";
      case FileSourceType.library:
        return "Thư viên ảnh";
      case FileSourceType.document:
        return "Chọn tệp";
      default:
        return "";
    }
  }

  Widget get icon {
    switch (this) {
      case FileSourceType.camera:
        return Image.asset(AppImages.icAttachCamera);
      case FileSourceType.library:
        return Image.asset(AppImages.icAttachImage);
      case FileSourceType.document:
        return Image.asset(AppImages.icAttachImage);
      default:
        return Container();
    }
  }
}

class FilePickerDialog extends StatelessWidget {
  final String title;
  final List<FileSourceType>? sources;

  FilePickerDialog({
    this.title = "Select image to upload",
    this.sources,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 56,
          padding: const EdgeInsets.only(left: 20, right: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.blackS16Bold.copyWith(fontSize: 20),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  child: Image.asset(AppImages.icCloseNoBg),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppColors.grey,
        ),
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 20),
            itemBuilder: (context, index) {
              return SourceItemWidget(
                sourceType: sources![index],
                onPressed: () {
                  _handlePickFile(context, sources![index]);
                },
              );
            },
            separatorBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 1,
                  width: double.infinity,
                  color: AppColors.greyE9,
                ),
            itemCount: sources?.length ?? 0),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }

  void _handlePickFile(BuildContext context, FileSourceType sourceType) async {
    File? file;
    String error = "";
    String typeError = "";
    switch (sourceType) {
      case FileSourceType.camera:
        file = await DialogUtils.pickImageFromCamera(context);
        if (file != null) {
          error = (FileUtils.getFileSize(file) > AppConfigs.FILE_SIZE_LIMITED)
              ? "Không được tải file có dung lượng lớn hơn ${AppConfigs.FILE_SIZE_LIMITED} MB"
              : "";
          String fileType = file.path.split('.').last;
          if (fileType == 'gif') {
            typeError = "Không cho phép tải file GIF";
          }
        }
        break;
      case FileSourceType.library:
        file = await DialogUtils.pickImageFromLibrary(context);
        if (file != null) {
          error = (FileUtils.getFileSize(file) > AppConfigs.FILE_SIZE_LIMITED)
              ? "Không được tải file có dung lượng lớn hơn ${AppConfigs.FILE_SIZE_LIMITED} MB"
              : "";
          String fileType = file.path.split('.').last;
          if (fileType == 'gif') {
            typeError = "Không cho phép tải file GIF";
          }
        }
        break;
      case FileSourceType.document:
        break;
      case FileSourceType.video:
        break;
    }
    if (file != null) {
      if ((error).isNotEmpty) {
        FlushBarUtils.showErrorDialog(context: context, message: error);
        return;
      } else {
        if (typeError.isNotEmpty) {
          FlushBarUtils.showErrorDialog(context: context, message: typeError);
          return;
        }
        Navigator.pop(context, FileInfo(file: file, sourceType: sourceType));
      }
    } else {
      Navigator.pop(context);
    }
  }
}

class SourceItemWidget extends StatelessWidget {
  final FileSourceType? sourceType;
  final VoidCallback? onPressed;

  SourceItemWidget({this.sourceType, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          child: Row(
            children: [
              sourceType.icon,
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  sourceType.title,
                  style: AppTextStyle.blackS16W500,
                ),
              ),
            ],
          ),
        ));
  }
}
