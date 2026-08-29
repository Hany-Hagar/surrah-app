import 'package:hive/hive.dart';

import '../../../categories/data/database/default_categories.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final String categoryId;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final bool isIncome;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.categoryId,
    required this.createdAt,
    required this.isIncome,
  });
}

// Default Model
List<TransactionModel> defaultTransactions = [
  TransactionModel(
    id: '1',
    title: 'Salary',
    amount: 5000.0,
    categoryId: DefaultCategories.income.first.id,
    createdAt: DateTime.now(),
    isIncome: true,
  ),
  TransactionModel(
    id: '2',
    title: 'Groceries',
    amount: 150.0,
    categoryId: DefaultCategories.expense.first.id,
    createdAt: DateTime.now(),
    isIncome: false,
  ),
  TransactionModel(
    id: '3',
    title: 'Freelance Project',
    amount: 1200.0,
    categoryId: DefaultCategories.income[1].id,
    createdAt: DateTime.now(),
    isIncome: true,
  ),
  TransactionModel(
    id: '4',
    title: 'Electricity Bill',
    amount: 100.0,
    categoryId: DefaultCategories.expense[1].id,
    createdAt: DateTime.now(),
    isIncome: false,
  ),
];
