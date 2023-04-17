import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:ihz_bql/utils/replacement_map.dart';

class Utils {
  ///Search
  static bool isTextContainKeyword({String text = "", String keyword = ""}) {
    final newText =
        String.fromCharCodes(replaceCodeUnits(text.codeUnits)).toLowerCase();
    final newKeyword =
        String.fromCharCodes(replaceCodeUnits(keyword.codeUnits)).toLowerCase();
    final isContain = newText.contains(newKeyword);
    return isContain;
  }

  // static launchPhoneCall({String phone}) async {
  //   try {
  //     await launch("tel:$phone");
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }
  //
  // static launchEmail({String email}) async {
  //   try {
  //     await launch(Uri(
  //       scheme: 'mailto',
  //       path: email,
  //     ).toString());
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }

  /// Checks if string is email.
  static bool isEmail(String email) => GetUtils.isEmail(email);

  /// Checks if string is phone number.
  static bool isPhoneNumber(String email) => GetUtils.isPhoneNumber(email);

  /// Checks if string is URL.
  static bool isURL(String url) => GetUtils.isURL(url);

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String? getNameFileFromPath(String? path) {
    if (path == null) return null;
    return path.split('/').last;
  }

  static String moneyToString(int? number, {String unit = "\u20AB"}) {
    final formatter = intl.NumberFormat("#,###,###$unit", "en_US");
    try {
      String result = formatter.format(number).replaceAll(",", ".");
      return result;
    } catch (e) {
      return "-";
    }
  }

  static String? getTextFromField(String? text) {
    return text?.isNotEmpty == true ? text : "#";
  }

  /// Checks if string is URL.
  static bool isURLHttps(String url) => url.contains('https://');

  static bool isVideo(String url) {
    return url.endsWith('.mp4') ||
        url.endsWith('.h264') ||
        url.endsWith('.h265') ||
        url.endsWith('.MOV');
  }

  static int parseWeekday(String weekday) {
    switch (weekday) {
      case 'Monday':
        return 0;
      case 'Tuesday':
        return 1;
      case 'Wednesday':
        return 2;
      case 'Thursday':
        return 3;
      case 'Friday':
        return 4;
      case 'Saturday':
        return 5;
      case 'Sunday':
        return 6;
      default:
        return 0;
    }
  }
}
