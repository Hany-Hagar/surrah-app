import '../../generated/l10n.dart';
import 'package:flutter/material.dart';
import '../enums/date_filter_type.dart';

extension DateFilterTypeExtensions on DateFilterType {
  String label({required BuildContext context}) {
    var s = S.of(context);
    switch (this) {
      case DateFilterType.day:
        return s.today;
      case DateFilterType.yesterday:
        return s.yesterday;
      case DateFilterType.week:
        return s.thisWeek;
      case DateFilterType.month:
        return s.thisMonth;
      case DateFilterType.year:
        return s.thisYear;
    }
  }

  String reportLabel({required BuildContext context}) {
    var s = S.of(context);
    switch (this) {
      case DateFilterType.day:
        return s.reportDay;
      case DateFilterType.yesterday:
        return s.yesterday;
      case DateFilterType.week:
        return s.reportWeek;
      case DateFilterType.month:
        return s.reportMonth;
      case DateFilterType.year:
        return s.reportYear;
    }
  }

  List<DateFilterType> get reportValues => [
    DateFilterType.day,
    DateFilterType.week,
    DateFilterType.month,
    DateFilterType.year,
  ];
}

// Return All Report Values

extension DateFilterTypeListExtensions on List<DateFilterType> {
  List<DateFilterType> get reportValues => [
    DateFilterType.day,
    DateFilterType.week,
    DateFilterType.month,
    DateFilterType.year,
  ];
}
