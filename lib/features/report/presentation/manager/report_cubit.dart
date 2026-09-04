import 'report_states.dart';
import 'package:flutter/material.dart';
import '../../models/report_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../transactions/data/model/balance_model.dart';
import '../../../../core/extensions/transaction_extension.dart';
import '../../../transactions/data/model/transaction_model.dart';

class ReportCubit extends Cubit<ReportStates> {
  ReportCubit() : super(ReportInitial());
  static ReportCubit get(BuildContext context) => BlocProvider.of(context);

  ReportModel reportModel = ReportModel.empty();

  void initReport({
    required List<TransactionModel> transactions,
    required BalanceModel currentBalance,
  }) {
    emit(ReportLoading());
    currentBalance = currentBalance;
    transactions = transactions.groupByCategory();
    reportModel = ReportModel(
      transactions: transactions,
      totalIncome: currentBalance.totalIncome,
      incomeTransactions: transactions.incomes,
      totalExpense: currentBalance.totalExpense,
      expenseTransactions: transactions.expense,
      total: currentBalance.totalIncome + currentBalance.totalExpense,
    );
    emit(ReportSuccess());
  }
}
