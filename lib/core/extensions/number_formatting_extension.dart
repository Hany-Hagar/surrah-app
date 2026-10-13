import 'package:intl/intl.dart';
import '../di/server_locator.dart';
import 'package:flutter/material.dart';
import '../../features/settings/presentation/manager/settings_cubit.dart';

extension NumberFormattingExtension on num {
  String appFormat({
    required BuildContext context,
    bool showSign = false,
    bool isIncome = false,
  }) {
    var sign = isIncome ? '+' : '-';
    var symbol = getIt.get<SettingsCubit>().state.currency.symbol;
    String localeCode = Localizations.localeOf(context).languageCode;
    if (localeCode == 'ar') {
      localeCode = 'ar_EG';
    }
    final num absoluteValue = abs();
    final formatter = NumberFormat.decimalPatternDigits(
      locale: localeCode,
      decimalDigits: absoluteValue is int || absoluteValue % 1 == 0 ? 0 : 2,
    );
    if (showSign) {
      return '$sign ${formatter.format(absoluteValue)} $symbol';
    }
    return '${formatter.format(absoluteValue)} $symbol';
  }

  // Percentage formatting
  String getPercentage({required double total}) {
    if (total == 0) return '0%';
    final percentage = (this / total) * 100;
    return '${percentage.toStringAsFixed(2)}%';
  }
}
