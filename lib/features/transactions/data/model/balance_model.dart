import 'package:hive/hive.dart';

part 'balance_model.g.dart';

@HiveType(typeId: 3)
class BalanceModel {
  @HiveField(0)
  final double balance;

  @HiveField(1)
  final double percentage;

  @HiveField(2)
  final double totalIncome;

  @HiveField(3)
  final double totalExpense;

  BalanceModel({
    required this.balance,
    required this.totalIncome,
    required this.totalExpense,
    this.percentage = 0.0,
  });

  // CopyWith
  BalanceModel copyWith({
    double? balance,
    double? percentage,
    double? totalIncome,
    double? totalExpense,
  }) {
    return BalanceModel(
      balance: balance ?? this.balance,
      percentage: percentage ?? this.percentage,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
    );
  }

  // Empty BalanceModel
  BalanceModel.empty()
      : balance = 0.0,
        percentage = 0.0,
        totalIncome = 0.0,
        totalExpense = 0.0;
}
