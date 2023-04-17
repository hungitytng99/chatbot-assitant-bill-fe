import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ihz_bql/utils/download_utils.dart';
import 'package:ihz_bql/utils/utils.dart';

import 'logger.dart';

class FileUtils {
  static double getFileSize(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  static Future<File?> downLoadFile(String url,
      {ValueChanged<double>? onProgressCallBack}) async {
    if (Platform.isAndroid) {
      String? basePath = await DownloadUtils.getPathDownload();
      logger.d("path download: $basePath}");
      try {
        String? basePath = await DownloadUtils.getPathDownload();
        logger.d("path download: $basePath}");
        if (basePath == null) return null;
        final file = File('$basePath/${Utils.getNameFileFromPath(url)}');
        final response = await Dio().get(url,
            options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                receiveTimeout: 0), onReceiveProgress: (int count, int total) {
          if (total != -1) {
            onProgressCallBack?.call(count / total * 100);
            }
        });
        var raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
        DownloadUtils.copyFileToDownload(file.path);
      } catch (e) {
        logger.e(e);
      }
    } else if (Platform.isIOS) {
       /// Show popup download
       await DownloadUtils.showPopupDownloadFile(url);
    }
  }

}
