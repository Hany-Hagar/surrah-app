// Add New Transaction
import '../../features/transactions/data/model/balance_model.dart';
import '../../features/transactions/data/model/transaction_model.dart';

extension BalanceExtension on BalanceModel {
  BalanceModel addTransaction({required TransactionModel transaction}) {
    if (transaction.isIncome) {
      final newBalance = balance + transaction.amount;
      final newTotalIncome = totalIncome + transaction.amount;
      final newPercentage = newBalance != 0
          ? (newBalance / newTotalIncome) * 100
          : 0.0;
      return copyWith(
        balance: newBalance,
        totalIncome: newTotalIncome,
        percentage: newPercentage,
      );
    } else {
      final newBalance = balance - transaction.amount;
      final newTotalExpense = totalExpense + transaction.amount;
      final newPercentage = newBalance != 0
          ? (newBalance / (totalIncome + newTotalExpense)) * 100
          : 0.0;
      return copyWith(
        balance: newBalance,
        totalExpense: newTotalExpense,
        percentage: newPercentage,
      );
    }
  }

  // Edit Transaction
  BalanceModel editTransaction({
    required TransactionModel oldTransaction,
    required TransactionModel newTransaction,
  }) {
    final balanceAfterRemovingOld = oldTransaction.isIncome
        ? balance - oldTransaction.amount
        : balance + oldTransaction.amount;
    final totalIncomeAfterRemovingOld = oldTransaction.isIncome
        ? totalIncome - oldTransaction.amount
        : totalIncome;
    final totalExpenseAfterRemovingOld = oldTransaction.isIncome
        ? totalExpense
        : totalExpense - oldTransaction.amount;

    if (newTransaction.isIncome) {
      final newBalance = balanceAfterRemovingOld + newTransaction.amount;
      final newTotalIncome =
          totalIncomeAfterRemovingOld + newTransaction.amount;
      final newPercentage = newBalance != 0
          ? (newBalance / newTotalIncome) * 100
          : 0.0;
      return copyWith(
        balance: newBalance,
        totalIncome: newTotalIncome,
        totalExpense: totalExpenseAfterRemovingOld,
        percentage: newPercentage,
      );
    } else {
      final newBalance = balanceAfterRemovingOld - newTransaction.amount;
      final newTotalExpense =
          totalExpenseAfterRemovingOld + newTransaction.amount;
      final newPercentage = newBalance != 0
          ? (newBalance / (totalIncomeAfterRemovingOld + newTotalExpense)) * 100
          : 0.0;
      return copyWith(
        balance: newBalance,
        totalIncome: totalIncomeAfterRemovingOld,
        totalExpense: newTotalExpense,
        percentage: newPercentage,
      );
    }
  }
}
