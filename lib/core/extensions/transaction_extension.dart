import 'category_extension.dart';
import '../enums/category_type.dart';
import '../../features/transactions/data/model/transaction_model.dart';

// Search extension
extension SearchExtension on List<TransactionModel> {
  // Sort transactions by date
  List<TransactionModel> sortByDate() {
    sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return this;
  }

  // Search transactions
  List<TransactionModel> search({required String query}) {
    return where((transaction) {
      var categoryName = transaction.categoryId
          .getCategory()
          .name
          .toLowerCase();
      return transaction.notes.toLowerCase().contains(query.toLowerCase()) ||
          categoryName.contains(query.toLowerCase());
    }).toList();
  }

  // Filter transactions by category type
  List<TransactionModel> filter({required CategoriesType type}) {
    return where((transaction) {
      var categoryType = transaction.categoryId.getCategory().isIncome
          ? CategoriesType.income
          : CategoriesType.expense;
      return type == CategoriesType.all || categoryType == type;
    }).toList();
  }

  // Get Last transactions
  List<TransactionModel> getLastTransactions({int limit = 5}) {
    if (limit <= 0) {
      return this;
    }
    return take(limit).toList();
  }

  // Get today's transactions and limit to 5 items
  List<TransactionModel> getDailyTransactions({int limit = 5}) {
    var today = DateTime.now();
    final dailyTransactions = where((transaction) {
      return transaction.createdAt.year == today.year &&
          transaction.createdAt.month == today.month &&
          transaction.createdAt.day == today.day;
    }).toList();

    if (limit <= 0) {
      return dailyTransactions;
    }

    return dailyTransactions.take(limit).toList();
  }

  // Get income transactions
  List<TransactionModel> get incomeTransactions {
    return filter(type: CategoriesType.income);
  }

  // Get expense transactions
  List<TransactionModel> get expenseTransactions {
    return filter(type: CategoriesType.expense);
  }

  // AddNewTransaction
  List<TransactionModel> addNewTransaction({
    required TransactionModel transaction,
  }) {
    final updatedTransactions = List<TransactionModel>.from(this);
    updatedTransactions.add(transaction);
    return updatedTransactions.sortByDate();
  }

  // UpdateTransaction
  List<TransactionModel> updateTransaction({
    required TransactionModel updatedTransaction,
  }) {
    final updatedTransactions = map((transaction) {
      if (transaction.id == updatedTransaction.id) {
        return updatedTransaction;
      }
      return transaction;
    }).toList();
    return updatedTransactions.sortByDate();
  }
}
