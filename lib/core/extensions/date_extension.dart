import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  /// 5 July 2026 02:30 PM
  String get pdfFormat => this == null
      ? '-'
      : DateFormat('d MMMM yyyy hh:mm a', 'ar').format(this!);

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

  /// Monday / الاثنين
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

  /// Same minute as now.
  bool get isNow {
    final value = this;
    if (value == null) return false;
    final now = DateTime.now();
    return value.year == now.year &&
        value.month == now.month &&
        value.day == now.day &&
        value.hour == now.hour &&
        value.minute == now.minute;
  }

  /// Same day as today.
  bool get isToday {
    final value = this;
    if (value == null) return false;
    final now = DateTime.now();
    return value.year == now.year &&
        value.month == now.month &&
        value.day == now.day;
  }

  /// Same day as yesterday.
  bool get isPreviousDay {
    final value = this;
    if (value == null) return false;
    final now = DateTime.now();
    final previousDay = DateTime(now.year, now.month, now.day - 1);
    return value.year == previousDay.year &&
        value.month == previousDay.month &&
        value.day == previousDay.day;
  }

  /// Same day as the current Week.
  bool get isInCurrentWeek {
    final value = this;
    if (value == null) return false;
    final now = DateTime.now();
    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day - (now.weekday - DateTime.monday),
    );
    final endOfWeek = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day + 7,
    );
    return !value.isBefore(startOfWeek) && value.isBefore(endOfWeek);
  }

  /// Same day as the current Month.
  bool get isInCurrentMonth {
    final value = this;
    if (value == null) return false;
    final now = DateTime.now();
    return value.year == now.year && value.month == now.month;
  }

  /// Same year as the current year.
  bool get isInCurrentYear {
    final value = this;
    if (value == null) return false;
    return value.year == DateTime.now().year;
  }

  // Display date in a human-readable format based on the current date and time.
  String displayDate({required BuildContext context,required String nowTitle,}) {
    var locale = Localizations.localeOf(context).languageCode;
    final value = this;
    if (value == null) return '-';
    if (isNow) return nowTitle;
    if (isToday) return DateFormat('hh:mm a', locale).format(value);
    if (isInCurrentYear) {
      return DateFormat('d MMM hh:mm a', locale).format(value);
    }
    return DateFormat('d MMM yyyy hh:mm a', locale).format(value);
  }
}
