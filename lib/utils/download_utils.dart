import 'package:flutter/services.dart';

class DownloadUtils {
  static const MethodChannel _channel =
      MethodChannel('path_folder_download_plugin_flutter');

  static getPathDownload() async {
    return await _channel.invokeMethod('getPathFolderDownload');
  }

  static copyFileToDownload(String path) async {
    return await _channel
        .invokeMethod('copyFileToDownload', {'documentPath': path});
  }

  static showPopupDownloadFile(String url) async {
    return await _channel.invokeMethod('downLoadFile', {"url": url});
  }
}
