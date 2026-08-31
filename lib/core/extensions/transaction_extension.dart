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
}
