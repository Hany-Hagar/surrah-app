import 'package:intl/intl.dart';
import '../di/server_locator.dart';
import 'package:flutter/material.dart';
import '../../features/settings/presentation/manager/settings_cubit.dart';

extension NumberFormattingExtension on num {
  // Money formatting with currency symbol
  String moneyFormat({required BuildContext context}) {
    var symbol = getIt.get<SettingsCubit>().state.currency.symbol;
    String localeCode = Localizations.localeOf(context).languageCode;
    if (localeCode == 'ar') localeCode = 'ar_EG';
    final num absoluteValue = abs();
    final formatter = NumberFormat.decimalPatternDigits(
      locale: localeCode,
      decimalDigits: absoluteValue is int || absoluteValue % 1 == 0 ? 0 : 2,
    );
    return '${formatter.format(absoluteValue)} $symbol';
  }

  // App-specific formatting
  String appFormat({
    required BuildContext context,
    bool showSign = false,
    bool isIncome = false,
  }) {
    var sign = isIncome ? '+' : '-';
    String moneyString = moneyFormat(context: context);
    if (showSign) {
      return '$sign $moneyString';
    }
    return moneyString;
  }

  // Percentage formatting
  String getPercentage({required double total}) {
    if (total == 0) return '0%';
    final percentage = (this / total) * 100;
    return '${percentage.toStringAsFixed(2)}%';
  }

  // Secure formatting for sensitive data
  String homeWidgetFormat({
    required bool showBalance,
    required BuildContext context,
  }) {
    return showBalance ? appFormat(context: context) : '*******';
  }
}
