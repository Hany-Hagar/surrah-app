import 'balance_model.dart';
import 'package:hive/hive.dart';
import 'transaction_model.dart';
part 'transactions_data_model.g.dart';

@HiveType(typeId: 4)
class TransactionsDataModel {
  @HiveField(0)
  final BalanceModel currentBalance;

  @HiveField(1)
  final List<TransactionModel> transactions;

  TransactionsDataModel({
    required this.currentBalance,
    required this.transactions,
  });

  // CopyWith
  TransactionsDataModel copyWith({
    BalanceModel? currentBalance,
    List<TransactionModel>? transactions,
  }) {
    return TransactionsDataModel(
      currentBalance: currentBalance ?? this.currentBalance,
      transactions: transactions ?? this.transactions,
    );
  }

  // Empty TransactionsDataModel
  TransactionsDataModel.empty()
      : currentBalance = BalanceModel.empty(),
        transactions = [];


}
