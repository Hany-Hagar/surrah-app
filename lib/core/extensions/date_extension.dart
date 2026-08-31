import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  /// 05/07/2026
  String get short =>
      this == null ? '-' : DateFormat('dd/MM/yyyy', 'ar').format(this!);

  /// 05-07-2026
  String get shortDash =>
      this == null ? '-' : DateFormat('dd-MM-yyyy', 'ar').format(this!);

  /// 2026-07-05
  String get iso =>
      this == null ? '-' : DateFormat('yyyy-MM-dd', 'ar').format(this!);

  /// 5 July 2026 / 5 يوليو 2026
  String get long =>
      this == null ? '-' : DateFormat('d MMMM yyyy', 'ar').format(this!);

  /// Monday 5 July 2026 / الاثنين 5 يوليو 2026
  String get full =>
      this == null ? '-' : DateFormat('EEEE d MMMM yyyy', 'ar').format(this!);

  /// Monday 5-7-2026 / الاثنين 5-7-2026
  String get fullShort =>
      this == null ? '-' : DateFormat('EEEE d-M-yyyy', 'ar').format(this!);

  /// Monday 5 July 2026 7:30 AM / الاثنين 5 يوليو 2026 03:30 PM
  String get fullWithTime => this == null
      ? '-'
      : DateFormat('EEEE d MMMM hh:mm a', 'ar').format(this!);

  /// Monday / الاثنين1
  String get day => this == null ? '-' : DateFormat('EEEE', 'ar').format(this!);

  /// Mon
  String get dayShort =>
      this == null ? '-' : DateFormat('EEE', 'ar').format(this!);

  /// July / يوليو
  String get month =>
      this == null ? '-' : DateFormat('MMMM', 'ar').format(this!);

  /// Jul / يوليو
  String get monthShort =>
      this == null ? '-' : DateFormat('MMM', 'ar').format(this!);

  /// July 2026 / يوليو 2026
  String get monthYear =>
      this == null ? '-' : DateFormat('MMMM yyyy', 'ar').format(this!);

  /// 2026
  String get year =>
      this == null ? '-' : DateFormat('yyyy', 'ar').format(this!);

  /// 15:30
  String get time24 =>
      this == null ? '-' : DateFormat('HH:mm', 'ar').format(this!);

  /// 15:30:45
  String get time24Seconds =>
      this == null ? '-' : DateFormat('HH:mm:ss', 'ar').format(this!);

  /// 03:30 PM
  String get time12 =>
      this == null ? '-' : DateFormat('hh:mm a', 'ar').format(this!);

  /// 03:30:45 PM
  String get time12Seconds =>
      this == null ? '-' : DateFormat('hh:mm:ss a', 'ar').format(this!);

  /// 05/07/2026 15:30
  String get dateTime =>
      this == null ? '-' : DateFormat('dd/MM/yyyy HH:mm', 'ar').format(this!);

  /// 05/07/2026 03:30 PM
  String get dateTime12 =>
      this == null ? '-' : DateFormat('dd/MM/yyyy hh:mm a', 'ar').format(this!);

  /// 2026-07-05 15:30
  String get isoDateTime =>
      this == null ? '-' : DateFormat('yyyy-MM-dd HH:mm', 'ar').format(this!);

  String smartDate({
    required String locale,
    required String nowText,
    required String yesterdayText,
  }) {
    final value = this!;
    final currentDate = DateTime.now();

    final date = DateTime(value.year, value.month, value.day);
    final today = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );
    final yesterday = today.subtract(const Duration(days: 1));
    final isSameMinute =
        value.year == currentDate.year &&
        value.month == currentDate.month &&
        value.day == currentDate.day &&
        value.hour == currentDate.hour &&
        value.minute == currentDate.minute;

    if (isSameMinute) {
      return nowText;
    }
    if (date == today) {
      return DateFormat('hh:mm a', locale).format(value);
    }
    if (date == yesterday) {
      return yesterdayText;
    }
    if (value.year == currentDate.year) {
      return DateFormat('dd MMM', locale).format(value);
    }
    return DateFormat('dd MMM yyyy', locale).format(value);
  }
}
