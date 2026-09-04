import '../../transactions/data/model/balance_model.dart';
import '../../transactions/data/model/transaction_model.dart';

class ReportModel {
  final BalanceModel balance;
  final List<TransactionModel> transactions;
  final List<TransactionModel> incomeTransactions;
  final List<TransactionModel> expenseTransactions;
  ReportModel({
    required this.balance,
    required this.transactions,
    required this.incomeTransactions,
    required this.expenseTransactions,
  });

  // Empty report model
  factory ReportModel.empty() {
    return ReportModel(
      transactions: [],
      incomeTransactions: [],
      expenseTransactions: [],
      balance: BalanceModel.empty(),
    );
  }
}
