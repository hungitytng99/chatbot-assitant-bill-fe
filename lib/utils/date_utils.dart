import 'package:ihz_bql/configs/app_configs.dart';
import 'package:intl/intl.dart';

class AppDateUtils {
  // static DateTime? fromString(String date, {String? format}) {
  //   return DateTimeExtension.fromString(date, format: format);
  // }

  /// For Date: default format = 'dd/MM/yyyy'
  static DateTime? fromDateAPIString(String? date,
      {String format = AppConfigs.dateAPIFormat}) {
    try {
      return DateFormat(format).parse(date!);
    } catch (e) {
      return null;
    }
  }

  static String toDateAPIString(DateTime? dateTime,
      {String format = AppConfigs.dateAPIFormat}) {
    try {
      return DateFormat(format).format(dateTime!.toLocal());
    } catch (e) {
      return '';
    }
  }

  static String getHourAndMinutes(DateTime? dateTime,
      {String seperator = ":"}) {
    String? hour = dateTime?.hour.toString() ?? "0";
    String? minute = dateTime?.minute.toString() ?? "0";
    if (int.parse(hour) < 10) hour = "0" + hour.toString();
    if (int.parse(minute) < 10) minute = "0" + minute.toString();
    return "$hour$seperator$minute";
  }

  static String getMonthAndyear(DateTime? dateTime, {String seperator = "/"}) {
    String? month = dateTime?.month.toString() ?? "0";
    String? year = dateTime?.year.toString() ?? "0";
    if (int.parse(month) < 10) month = "0" + month.toString();
    return "$month$seperator$year";
  }

  static String toDateDisplayString(DateTime? dateTime,
      {String format = AppConfigs.dateDisplayFormat}) {
    try {
      return DateFormat(format).format(dateTime!.toLocal());
    } catch (e) {
      return '';
    }
  }

  /// For DateTime: default format = 'dd/MM/yyyy'
  static DateTime? fromDateTimeAPIString(String? dateTime,
      {String format = AppConfigs.dateTimeAPIFormat}) {
    try {
      return DateFormat(format).parse(dateTime!);
    } catch (e) {
      return null;
    }
  }

  static String toDateTimeAPIString(DateTime? dateTime,
      {String format = AppConfigs.dateTimeAPIFormat}) {
    try {
      return DateFormat(format).format(dateTime!.toLocal());
    } catch (e) {
      return '';
    }
  }

  ///For Birthday

  static DateTime? fromBirthdayAPIString(String? date) {
    try {
      return DateFormat(AppConfigs.dateAPIFormat).parse(date ?? '');
    } catch (e) {
      return null;
    }
  }

  static String? toBirthdayAPIString(DateTime? dateTime) {
    try {
      return DateFormat(AppConfigs.dateAPIFormat).format(dateTime!);
    } catch (e) {
      return null;
    }
  }

  static String? toBirthdayDisplay(DateTime? dateTime) {
    try {
      return DateFormat(AppConfigs.dateDisplayFormat).format(dateTime!);
    } catch (e) {
      return null;
    }
  }

  /// Other

  static DateTime startOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
  }

  static DateTime endOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
  }

  static DateTime firstDayOfMonth(DateTime ofDate) {
    final date = DateTime.utc(ofDate.year, ofDate.month, 1);
    return date;
  }

  static DateTime lastDayOfMonth(DateTime ofDate) {
    final date = DateTime.utc(ofDate.year, ofDate.month + 1, 0);
    return date;
  }

  static String? formatISOTime(DateTime? date,
      {String format = AppConfigs.dateTimeAPIFormatParam}) {
    try {
      var duration = date!.timeZoneOffset;
      if (duration.isNegative) {
        return (DateFormat(format).format(date) +
            "-${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
      } else {
        return (DateFormat(format).format(date) +
            "+${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
      }
    } catch (e) {
      return '';
    }
  }

  static String? getDateTimeWorkCreate(DateTime? timeWork, DateTime? date) {
    try {
      String dateTime =
          toDateTimeAPIString(date, format: AppConfigs.dateAPIFormatParam);
      String? time =
          formatISOTime(timeWork, format: AppConfigs.timeAPIFormatParam);
      if (time == null) return '';
      return dateTime + time;
    } catch (e) {
      return '';
    }
  }

  static bool isValidDateTimeWorkCreate(DateTime? date) {
    if (date == null) return false;
    DateTime now = DateTime.now();
    DateTime dateNow = DateTime(now.year, now.month, now.day);
    DateTime datePicker = DateTime(date.year, date.month, date.day);
    return datePicker.millisecondsSinceEpoch >= dateNow.millisecondsSinceEpoch;
  }

  static int getQuarter(DateTime date) {
    if (date.month >= 1 && date.month <= 3) {
      return 1;
    } else if (date.month >= 4 && date.month <= 6) {
      return 2;
    } else if (date.month >= 7 && date.month <= 9) {
      return 3;
    } else {
      return 4;
    }
  }

  static String? dateTimeMonthFormat(DateTime dateTime) {
    try {
      return DateFormat("MM/yyyy").format(dateTime.toLocal());
    } catch (e) {
      return null;
    }
  }

  static String? dateTimeYearFormat(DateTime dateTime) {
    try {
      return DateFormat("yyyy").format(dateTime.toLocal());
    } catch (e) {
      return null;
    }
  }

  static String intToTimeLeft(int value) {
    int h, m, s;

    h = value ~/ 3600;

    m = ((value - h * 3600)) ~/ 60;

    s = value - (h * 3600) - (m * 60);

    String hourLeft =
        h.toString().length < 2 ? "0" + h.toString() : h.toString();

    String minuteLeft =
        m.toString().length < 2 ? "0" + m.toString() : m.toString();

    String secondsLeft =
        s.toString().length < 2 ? "0" + s.toString() : s.toString();

    String result = "$hourLeft:$minuteLeft:$secondsLeft";

    return result;
  }
}
