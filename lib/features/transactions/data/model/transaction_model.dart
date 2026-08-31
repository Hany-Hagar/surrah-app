import 'package:hive/hive.dart';

import '../../../categories/data/database/default_categories.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String notes;

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
    required this.notes,
    required this.amount,
    required this.categoryId,
    required this.createdAt,
    required this.isIncome,
  });

  // New TransactionModel
  TransactionModel.newTransaction({
    required this.notes,
    required this.amount,
    required this.isIncome,
    required this.createdAt,
    required this.categoryId,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();
}

// Default Model
List<TransactionModel> defaultTransactions = [
  TransactionModel(
    id: '1',
    notes: 'Salary',
    amount: 5000.0,
    categoryId: DefaultCategories.income.first.id,
    createdAt: DateTime.now(),
    isIncome: true,
  ),
  TransactionModel(
    id: '2',
    notes: 'Groceries',
    amount: 150.0,
    categoryId: DefaultCategories.expense.first.id,
    createdAt: DateTime.now(),
    isIncome: false,
  ),
  TransactionModel(
    id: '3',
    notes: 'Freelance Project',
    amount: 1200.0,
    categoryId: DefaultCategories.income[1].id,
    createdAt: DateTime.now(),
    isIncome: true,
  ),
  TransactionModel(
    id: '4',
    notes: 'Electricity Bill',
    amount: 100.0,
    categoryId: DefaultCategories.expense[1].id,
    createdAt: DateTime.now(),
    isIncome: false,
  ),
];
