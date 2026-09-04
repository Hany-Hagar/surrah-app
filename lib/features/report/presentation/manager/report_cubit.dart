import 'report_states.dart';
import 'package:flutter/material.dart';
import '../../models/report_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/category_type.dart';
import '../../../transactions/data/model/balance_model.dart';
import '../../../../core/extensions/transaction_extension.dart';
import '../../../transactions/data/model/transaction_model.dart';

class ReportCubit extends Cubit<ReportStates> {
  ReportCubit() : super(ReportInitial());
  static ReportCubit get(BuildContext context) => BlocProvider.of(context);

  bool isFiltering = false;
  ReportModel reportModel = ReportModel.empty();
  List<TransactionModel> filterTransactions = [];
  CategoriesType selectedCategoryType = CategoriesType.all;

  void initReport({
    required List<TransactionModel> transactions,
    required BalanceModel currentBalance,
  }) {
    emit(ReportLoading());
    currentBalance = currentBalance;
    transactions = transactions.groupByCategory();
    reportModel = ReportModel(
      balance: currentBalance,
      transactions: transactions,
      incomeTransactions: transactions.incomes,
      expenseTransactions: transactions.expense,
    );
    emit(ReportSuccess());
  }

  void changeCategoryType(CategoriesType type) {
    selectedCategoryType = type;
    emit(ChangeCategoryType());
  }

  void filter() {
    isFiltering = true;
    emit(FilterTransactionsLoading());
    switch (selectedCategoryType) {
      case CategoriesType.all:
        filterTransactions = reportModel.transactions;
        break;
      case CategoriesType.income:
        filterTransactions = reportModel.incomeTransactions;
        break;
      case CategoriesType.expense:
        filterTransactions = reportModel.expenseTransactions;
        break;
    }
    emit(FilterTransactionsSuccess());
  }

  void clearFilter() {
    isFiltering = false;
    filterTransactions.clear();
    emit(FilterTransactionsSuccess());
  }
}
