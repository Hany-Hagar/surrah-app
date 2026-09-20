import 'package:surrah/features/categories/data/models/category_model.dart';
import 'package:surrah/features/transactions/data/model/transaction_model.dart';

class IncomeEntry {
  final TransactionModel transaction;
  final CategoryModel category;

  const IncomeEntry({
    required this.transaction,
    required this.category,
  });
}