import 'category_extension.dart';
import 'package:flutter/material.dart';
import '../../features/transactions/data/model/transaction_model.dart';
import '../../features/categories/presentation/manager/categories_cubit.dart';

// Search extension
extension SearchExtension on List<TransactionModel> {
  List<TransactionModel> search({
    required String query,
    required BuildContext context,
  }) {
    var category = CategoriesCubit.get(context).allCategories;
    return where((transaction) {
      var categoryName = category
          .getCategory(id: transaction.categoryId)
          .name
          .toLowerCase();
      return transaction.title.toLowerCase().contains(query.toLowerCase()) ||
          categoryName.contains(query.toLowerCase());
    }).toList();
  }
}
