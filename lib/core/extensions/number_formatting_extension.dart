import 'package:intl/intl.dart';

extension NumberFormattingExtension on num {
  String get moneyFormat {
    return NumberFormat('#,##0.##').format(this);
  }
}