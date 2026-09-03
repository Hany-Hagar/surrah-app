import '../../transactions/data/model/transaction_model.dart';
class ReportModel {
  final double total;
  final double totalIncome;
  final double totalExpense;
  final List<TransactionModel> transactions;
  final List<TransactionModel> incomeTransactions;
  final List<TransactionModel> expenseTransactions;
  ReportModel({
    required this.total,
    required this.totalIncome,
    required this.totalExpense,
    required this.transactions,
    required this.incomeTransactions,
    required this.expenseTransactions,
  });

  // Empty report model
  factory ReportModel.empty() {
    return ReportModel(
      total: 0,
      totalIncome: 0,
      totalExpense: 0,
      transactions: [],
      incomeTransactions: [],
      expenseTransactions: [],
    );
  }
}
