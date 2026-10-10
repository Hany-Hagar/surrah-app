import 'balance_extension.dart';
import '../../features/transactions/data/model/transaction_model.dart';
import '../../features/transactions/data/model/transactions_data_model.dart';

extension TransactionsDataModelExtensions on TransactionsDataModel {
  List<TransactionModel> _insertSorted(
    List<TransactionModel> list,
    TransactionModel transaction,
  ) {
    final result = List<TransactionModel>.from(list);
    final index = result.indexWhere(
      (t) => t.createdAt.isBefore(transaction.createdAt),
    );
    if (index == -1) {
      result.add(transaction);
    } else {
      result.insert(index, transaction);
    }
    return result;
  }

  // Add Transaction
  TransactionsDataModel addTransaction({
    required TransactionModel transaction,
  }) {
    final updatedBalance = currentBalance.addTransaction(
      transaction: transaction,
    );
    final updatedTransactions = _insertSorted(transactions, transaction);
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
    final withoutOld = List<TransactionModel>.from(transactions)
      ..removeWhere((t) => t.id == oldTransaction.id);
    final updatedTransactions = _insertSorted(withoutOld, newTransaction);
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
      ..removeWhere((t) => t.id == transaction.id);
    return copyWith(
      currentBalance: updatedBalance,
      transactions: updatedTransactions,
    );
  }
}
