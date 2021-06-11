import 'package:intl/intl.dart';

extension AppDateTimeExtension on DateTime {
  String format(String pattern) => DateFormat(pattern).format(this);

  bool isSameDate(DateTime other) => this.year == other.year && this.month == other.month
           && this.day == other.day;
}
