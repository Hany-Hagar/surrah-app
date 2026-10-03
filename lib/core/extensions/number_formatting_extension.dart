import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension NumberFormattingExtension on num {
  String moneyFormat({required BuildContext context}) {
    String localeCode = Localizations.localeOf(context).languageCode;
    bool isArabic = localeCode == 'ar';
    if (isArabic) localeCode = 'ar_EG';
    final num absoluteValue = abs();
    final formatter = NumberFormat.decimalPatternDigits(
      locale: localeCode,
      decimalDigits: absoluteValue is int || absoluteValue % 1 == 0 ? 0 : 2,
    );
    return formatter.format(absoluteValue);
  }

  String moneyFormatWithSign({
    required BuildContext context,
    required bool isIncome,
  }) {
    String localeCode = Localizations.localeOf(context).languageCode;
    bool isArabic = localeCode == 'ar';
    if (isArabic) localeCode = 'ar_EG';
    final num absoluteValue = abs();
    final formatter = NumberFormat.decimalPatternDigits(
      locale: localeCode,
      decimalDigits: absoluteValue is int || absoluteValue % 1 == 0 ? 0 : 2,
    );
    final String formattedNumber = formatter.format(absoluteValue);
    final String sign = isIncome ? '+' : '-';
    final String currencySymbol = isArabic ? 'ج.م' : '\$';
    if (isArabic) {
      return '$formattedNumber $currencySymbol $sign';
    } else {
      return '$sign $currencySymbol$formattedNumber';
    }
  }
}
