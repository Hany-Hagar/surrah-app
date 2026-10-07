import '../../../transactions/data/model/transaction_model.dart';

class ReportModel {
  final double totalIncome;
  final double totalExpense;
  final List<TransactionModel> incomes;
  final List<TransactionModel> expenses;

  ReportModel({
    required this.totalIncome,
    required this.totalExpense,
    required this.incomes,
    required this.expenses,
  });

  // Empty constructor
  ReportModel.empty()
      : totalIncome = 0.0,
        totalExpense = 0.0,
        incomes = [],
        expenses = [];
}
