import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String smartDate({
    required String locale,
    required String nowText,
    required String yesterdayText,
  }) {
    final currentDate = DateTime.now();

    final date = DateTime(year, month, day);
    final today = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );

    final yesterday = today.subtract(const Duration(days: 1));

    // Now
    final isSameMinute =
        year == currentDate.year &&
        month == currentDate.month &&
        day == currentDate.day &&
        hour == currentDate.hour &&
        minute == currentDate.minute;

    if (isSameMinute) {
      return nowText;
    }

    // Today
    if (date == today) {
      return DateFormat('hh:mm a', locale).format(this);
    }

    // Yesterday
    if (date == yesterday) {
      return yesterdayText;
    }

    // Same year
    if (year == currentDate.year) {
      return DateFormat('dd MMM', locale).format(this);
    }

    // Different year
    return DateFormat('dd MMM yyyy', locale).format(this);
  }
}