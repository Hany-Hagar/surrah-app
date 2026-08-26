import '../model/transaction_model.dart';
import '../../../../const/hive_data.dart';
import '../../../../core/services/hive_service.dart';

class TransactionsData {
  final HiveService hiveService;
  TransactionsData({required this.hiveService});

  // Get all transactions
  List<TransactionModel> getAllTransactions() {
    final box = hiveService.box<TransactionModel>(HiveData.transactionsBox);
    return box.values.toList();
  }

  // Add a new transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    await hiveService.add<TransactionModel>(
      boxName: HiveData.transactionsBox,
      value: transaction,
    );
  }

  // Update an existing transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    await hiveService.put<TransactionModel>(
      boxName: HiveData.transactionsBox,
      key: transaction.id,
      value: transaction,
    );
  }

  // Delete a transaction
  Future<void> deleteTransaction(String transactionId) async {
    await hiveService.delete(
      boxName: HiveData.transactionsBox,
      key: transactionId,
    );
  }
}
