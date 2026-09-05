import 'category_extension.dart';
import '../enums/category_type.dart';
import '../../features/categories/data/models/category_model.dart';
import '../../features/transactions/data/model/transaction_model.dart';

extension SearchExtension on List<TransactionModel> {
  /// Returns transactions sorted by newest date first.
  List<TransactionModel> sortByDate() {
    final result = List<TransactionModel>.from(this);

    result.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return result;
  }

  /// Searches transactions by notes or category name.
  List<TransactionModel> search({required String query}) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return List<TransactionModel>.from(this);
    }

    return where((transaction) {
      final notes = transaction.notes.toLowerCase();
      final categoryName = transaction.categoryId
          .getCategory()
          .name
          .toLowerCase();

      return notes.contains(normalizedQuery) ||
          categoryName.contains(normalizedQuery);
    }).toList();
  }

  /// Filters transactions by category type and selected categories.
  List<TransactionModel> filter({
    required CategoriesType type,
    List<CategoryModel> categories = const [],
  }) {
    return where((transaction) {
      final category = transaction.categoryId.getCategory();

      final matchesType = switch (type) {
        CategoriesType.all => true,
        CategoriesType.income => category.isIncome,
        CategoriesType.expense => !category.isIncome,
      };

      final matchesCategory =
          categories.isEmpty || categories.contains(category);

      return matchesType && matchesCategory;
    }).toList();
  }

  /// Returns the latest transactions.
  List<TransactionModel> getLastTransactions({int limit = 5}) {
    if (limit <= 0) {
      return [];
    }

    return take(limit).toList();
  }

  /// Returns today's transactions.
  List<TransactionModel> getDailyTransactions({int limit = 5}) {
    final now = DateTime.now();

    final dailyTransactions = where((transaction) {
      final date = transaction.createdAt;

      return date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;
    });

    if (limit <= 0) {
      return dailyTransactions.toList();
    }

    return dailyTransactions.take(limit).toList();
  }

  /// Adds a new transaction and returns the list sorted by date.
  List<TransactionModel> addNewTransaction({
    required TransactionModel transaction,
  }) {
    return [...this, transaction].sortByDate();
  }

  /// Updates an existing transaction by ID.
  List<TransactionModel> updateTransaction({
    required TransactionModel updatedTransaction,
  }) {
    return map((transaction) {
      return transaction.id == updatedTransaction.id
          ? updatedTransaction
          : transaction;
    }).toList().sortByDate();
  }

  List<CategoryModel> getCategories({
    CategoriesType type = CategoriesType.all,
  }) {
    final categories = map(
      (transaction) => transaction.categoryId.getCategory(),
    ).toSet();

    return categories.where((category) {
      return switch (type) {
        CategoriesType.all => true,
        CategoriesType.income => category.isIncome,
        CategoriesType.expense => !category.isIncome,
      };
    }).toList();
  }
}
