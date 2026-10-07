import 'report_transaction_model.dart';
import '../../../transactions/data/model/transaction_model.dart';

class ReportModel {
  final double totalIncome;
  final double totalExpense;
  final List<TransactionModel> incomes;
  final List<TransactionModel> expenses;
  final List<ReportTransactionModel> groupedIncomes;
  final List<ReportTransactionModel> groupedExpenses;

  ReportModel({
    required this.totalIncome,
    required this.totalExpense,
    required this.incomes,
    required this.expenses,
    required this.groupedIncomes,
    required this.groupedExpenses,
  });

  // Empty constructor
  ReportModel.empty()
    : totalIncome = 0.0,
      totalExpense = 0.0,
      incomes = [],
      expenses = [],
      groupedIncomes = [],
      groupedExpenses = [];

  // Copy with
  ReportModel copyWith({
    double? totalIncome,
    double? totalExpense,
    List<TransactionModel>? incomes,
    List<TransactionModel>? expenses,
    List<ReportTransactionModel>? groupedIncomes,
    List<ReportTransactionModel>? groupedExpenses,
  }) {
    return ReportModel(
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      incomes: incomes ?? this.incomes,
      expenses: expenses ?? this.expenses,
      groupedIncomes: groupedIncomes ?? this.groupedIncomes,
      groupedExpenses: groupedExpenses ?? this.groupedExpenses,
    );
  }
}
