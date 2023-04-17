import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ihz_bql/generated/l10n.dart';

class ErrorUtils{
  static String errorToMessage(dynamic e,String key) {
    try {
      if (e is DioError) {
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          return "Kết nối quá hạn";
        }
        if (e.response?.data is Map<String, dynamic>) {
          if (e.response?.data['errors'] != null) {
            return e.response?.data['errors'][key];
          }
        }
        if (e.type == DioErrorType.other && e.error is SocketException) {
          return "Mất kết nối với máy chủ";
        }

        int? statusCode = e.response?.statusCode;
        if (statusCode != null && statusCode > 500) {
          return "Đã xảy ra lỗi";
        }
      }
    } catch (error) {
      return "Đã xảy ra lỗi";
    }
    return "Đã xảy ra lỗi";
  }
}