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
      case DateFilterType.custom:
        return s.custom;
    }
  }
}

