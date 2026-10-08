import 'category_extension.dart';
import 'transaction_extension.dart';
import '../enums/category_type.dart';
import '../enums/date_filter_type.dart';
import '../../features/report/data/model/report_model.dart';
import '../../features/transactions/data/model/transaction_model.dart';
import '../../features/report/data/model/report_transaction_model.dart';

extension ReportModelExtension on List<TransactionModel> {
  List<ReportTransactionModel> getReportTransactions() {
    final grouped = <ReportTransactionModel>[];
    for (final transaction in this) {
      final category = transaction.categoryId.getCategory();
      final index = grouped.indexWhere((item) => item.id == category.id);
      if (index == -1) {
        grouped.add(
          ReportTransactionModel(
            id: category.id,
            title: category.name,
            color: category.color,
            amount: transaction.amount,
          ),
        );
        continue;
      }
      final existing = grouped[index];
      grouped[index] = existing.copyWith(
        amount: existing.amount + transaction.amount,
      );
    }
    return grouped;
  }

  ReportModel getReportData({required DateFilterType dateFilterType}) {
    final incomes = filter(
      type: CategoriesType.income,
      dateFilterType: dateFilterType,
    );
    final expenses = filter(
      type: CategoriesType.expense,
      dateFilterType: dateFilterType,
    );
    final totalIncome = incomes.fold<double>(
      0.0,
      (sum, transaction) => sum + transaction.amount,
    );
    final totalExpense = expenses.fold<double>(
      0.0,
      (sum, transaction) => sum + transaction.amount,
    );

    return ReportModel(
      incomes: incomes,
      expenses: expenses,
      transactions: this,
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      groupedIncomes: incomes.getReportTransactions().sortReportTransactions(),
      groupedExpenses: expenses
          .getReportTransactions()
          .sortReportTransactions(),
    );
  }
}

extension ReportTransactionExtension on List<ReportTransactionModel> {
  List<ReportTransactionModel> sortReportTransactions() {
    final result = List<ReportTransactionModel>.from(this);

    result.sort((a, b) => b.amount.compareTo(a.amount));

    return result;
  }
}
