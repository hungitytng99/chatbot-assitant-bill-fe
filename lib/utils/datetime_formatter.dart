import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toStringWith(String format) {
    String formattedDate = DateFormat(format).format(toLocal());
    return formattedDate;
  }

  String onlyDate({String format = 'dd-MM-yyyy'}) {
    return toStringWith(format);
  }

  String fullDateTime({String format = 'dd-MM-yyyy HH:mm:ss'}) {
    return toStringWith(format);
  }
}

extension StringExtension on String {
  DateTime? toDate(String format) {
    try {
      final date = DateFormat(format).parse(this);
      return date;
    } catch (e) {
      return null;
    }
  }

  DateTime? toDateLocal() {
    try {
      final date = DateTime.parse(this).toLocal();
      return date;
    } catch (e) {
      return null;
    }
  }


}

class DateTimeFormater {
  /// Dùng để hiển thị
  static String dateFormatVi = "dd/MM/yyyy";
  static String dateTimeFormatVi = "dd/MM/yyyy HH:mm:ss";
  static String cartDateTimeFormat = "HH:mm:ss, dd/MM/yyyy";

  /// Format date from server và to server;
  static String dateTimeFormat = "yyyy-MM-dd";
  static String fullDateTimeFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSZ";
}

extension ConcurrencyFormatter on int {
  String get displayConcurrency {
    if (this == null || this == 0) {
      return "0";
    }
    final String str = NumberFormat.simpleCurrency(locale: "vi", name: '', decimalDigits: 0).format(this);
    return str.trim();
  }
}

extension ConcurrencyDoubleFormatter on double {
  String get displayConcurrency {
    if (this == null || this == 0) {
      return "0";
    }
    final String str = NumberFormat.simpleCurrency(locale: "vi", name: '', decimalDigits: 0).format(this);
    return str.trim();
  }

  String get roundDisplay {
    try {
      final _formatter = NumberFormat("#,###.##");
      return "${_formatter.format(this)}";
    } catch (_) {
      return this.toString();
    }
  }
}

