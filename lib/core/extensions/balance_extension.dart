import '../../features/transactions/data/model/balance_model.dart';
import '../../features/transactions/data/model/transaction_model.dart';

extension BalanceExtension on BalanceModel {
  BalanceModel addTransaction({required TransactionModel transaction}) {
    return _applyTransaction(transaction: transaction, multiplier: 1);
  }

  BalanceModel removeTransaction({required TransactionModel transaction}) {
    return _applyTransaction(transaction: transaction, multiplier: -1);
  }

  BalanceModel editTransaction({
    required TransactionModel oldTransaction,
    required TransactionModel newTransaction,
  }) {
    return removeTransaction(
      transaction: oldTransaction,
    ).addTransaction(transaction: newTransaction);
  }

  BalanceModel _applyTransaction({
    required TransactionModel transaction,
    required int multiplier,
  }) {
    final amount = transaction.amount * multiplier;

    final newTotalIncome = transaction.isIncome
        ? totalIncome + amount
        : totalIncome;

    final newTotalExpense = transaction.isIncome
        ? totalExpense
        : totalExpense + amount;

    final newBalance = newTotalIncome - newTotalExpense;

    return copyWith(
      balance: newBalance,
      totalIncome: newTotalIncome,
      totalExpense: newTotalExpense,
      percentage: _calculatePercentage(
        income: newTotalIncome,
        expense: newTotalExpense,
      ),
    );
  }

  double _calculatePercentage({
    required double income,
    required double expense,
  }) {
    if (income <= 0) return 0.0;

    return (expense / income).clamp(0.0, 1.0);
  }
}
