import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ihz_bql/common/app_colors.dart';
import 'package:ihz_bql/generated/l10n.dart';
import 'package:ihz_bql/globals/global_data.dart';
import 'package:ihz_bql/globals/global_event.dart';
import 'package:ihz_bql/utils/logger.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final method = options.method;
    final uri = options.uri;
    final data = options.data;
    if (GlobalData.instance.token?.accessToken != null) {
      options.headers['Authorization'] =
          'Bearer ${GlobalData.instance.token!.accessToken}';
    }
    // options.headers[AppConfigs.apiHeaderXClientCodeKey] =
    //     AppConfigs.apiHeaderXClientCode;
    // options.headers[AppConfigs.apiHeaderAppNameKey] =
    //     AppConfigs.apiHeaderAppName;
    logger.log(
        "\n\n--------------------------------------------------------------------------------------------------------");
    if (method == 'GET') {
      logger.log(
          "✈️ REQUEST[$method] => PATH: $uri \n Token: ${options.headers}",
          printFullText: true);
    } else {
      try {
        logger.log(
            "✈️ REQUEST[$method] => PATH: $uri \n Token: ${GlobalData.instance.token?.accessToken} \n DATA: ${jsonEncode(data)}",
            printFullText: true);
      } catch (e) {
        logger.log(
            "✈️ REQUEST[$method] => PATH: $uri \n Token: ${GlobalData.instance.token?.accessToken} \n DATA: $data",
            printFullText: true);
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    final data = jsonEncode(response.data);
    logger.log("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");
    //Handle section expired
    if (response.statusCode == 401) {
      GlobalEvent.instance.onTokenExpired.add(true);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final uri = err.requestOptions.path;
    var data = "";
    try {
      data = jsonEncode(err.response?.data);
    } catch (e, s) {
      logger.e(e, stackTrace: s);
    }
    if(err.type == DioErrorType.connectTimeout){
      Get.snackbar(
          S.current.snackbar_errorTitle,
          'Không có phản hồi, vui lòng thử lại sau.',
          backgroundColor: AppColors.bgErrorSnackBar,
          colorText: AppColors.textRed,
        );
    }
    logger.log("⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: $data");
    super.onError(err, handler);
  }
}
