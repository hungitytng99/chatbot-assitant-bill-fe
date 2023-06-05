import 'package:intl/intl.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);

final firstDayOfMonth = DateTime(kToday.year, kToday.month, 1);
final lastDayOfMonth = DateTime(kToday.year, kToday.month + 1, 0);

String getStringFromDateTime({required DateTime dateTime}) {
  return DateFormat('yyyy-MM-dd').format(dateTime).toString();
}
