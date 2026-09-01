import 'balance_extension.dart';
import '../../features/transactions/data/model/transaction_model.dart';
import '../../features/transactions/data/model/transactions_data_model.dart';

extension TransactionsDataModelExtensions on TransactionsDataModel {
  // Add Transaction
  TransactionsDataModel addTransaction({
    required TransactionModel transaction,
  }) {
    final updatedBalance = currentBalance.addTransaction(
      transaction: transaction,
    );
    final updatedTransactions = List<TransactionModel>.from(transactions)
      ..add(transaction);
    return copyWith(
      currentBalance: updatedBalance,
      transactions: updatedTransactions,
    );
  }

  // Edit Transaction
  TransactionsDataModel editTransaction({
    required TransactionModel oldTransaction,
    required TransactionModel newTransaction,
  }) {
    final updatedBalance = currentBalance
        .removeTransaction(transaction: oldTransaction)
        .addTransaction(transaction: newTransaction);
    final updatedTransactions = List<TransactionModel>.from(transactions)
      ..remove(oldTransaction)
      ..add(newTransaction);
    return copyWith(
      currentBalance: updatedBalance,
      transactions: updatedTransactions,
    );
  }

  // Remove Transaction
  TransactionsDataModel removeTransaction({
    required TransactionModel transaction,
  }) {
    final updatedBalance = currentBalance.removeTransaction(
      transaction: transaction,
    );
    final updatedTransactions = List<TransactionModel>.from(transactions)
      ..remove(transaction);
    return copyWith(
      currentBalance: updatedBalance,
      transactions: updatedTransactions,
    );
  }
}
