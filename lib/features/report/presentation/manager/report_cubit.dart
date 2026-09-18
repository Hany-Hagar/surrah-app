import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surrah/features/report/presentation/pages/widgets/top_expenses_view.dart';
import '../../data/repo/report_repo.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../transactions/data/model/transaction_model.dart';
import '../pages/widgets/expense_breakdown_view.dart';
import '../pages/widgets/expense_chart_view.dart';
import 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit({required this.reportRepo}) : super(ReportInitial()) {
    loadReport(DateTime.now());
  }

  final ReportRepo reportRepo;

  Future<void> selectMonth(DateTime month) async {
    await loadReport(month);
  }

  Future<void> refresh() async {
    final currentMonth = state is ReportMonthSelected
        ? (state as ReportMonthSelected).selectedMonth
        : DateTime.now();
    await loadReport(currentMonth);
  }

  Future<void> loadReport(DateTime month) async {
    final transactionsResult = await reportRepo.getTransactionsData();
    final categoriesResult = await reportRepo.getCategoriesData();

    transactionsResult.fold(
      (failure) => emit(ReportError(message: failure.message)),
      (data) {
        categoriesResult.fold(
          (failure) => emit(ReportError(message: failure.message)),
          (categories) => _emitReport(month, data.transactions, categories),
        );
      },
    );
  }

  void _emitReport(
    DateTime month,
    List<TransactionModel> allTransactions,
    List<CategoryModel> categories,
  ) {
    final monthTransactions = allTransactions.where((t) {
      return t.createdAt.year == month.year &&
          t.createdAt.month == month.month;
    }).toList();

    double salary = 0;
    double totalExpenses = 0;

    for (final t in monthTransactions) {
      if (t.isIncome) {
        salary += t.amount;
      } else {
        totalExpenses += t.amount;
      }
    }

    emit(ReportMonthSelected(
      selectedMonth: month,
      salary: salary,
      totalExpenses: totalExpenses,
      weeklyExpenses: _calculateWeeklyExpenses(monthTransactions),
      categoryExpenses: _calculateCategoryExpenses(
        monthTransactions,
        categories,
        totalExpenses,
      ),
      topExpenses: _calculateTopExpenses(monthTransactions, categories),
    ));
  }

  List<WeeklyExpense> _calculateWeeklyExpenses(
    List<TransactionModel> monthTransactions,
  ) {
    final weeks = [0.0, 0.0, 0.0, 0.0];

    for (final t in monthTransactions) {
      if (t.isIncome) continue;
      final weekIndex = ((t.createdAt.day - 1) ~/ 7).clamp(0, 3);
      weeks[weekIndex] += t.amount;
    }

    return [
      WeeklyExpense(label: 'Week 1', amount: weeks[0]),
      WeeklyExpense(label: 'Week 2', amount: weeks[1]),
      WeeklyExpense(label: 'Week 3', amount: weeks[2]),
      WeeklyExpense(label: 'Week 4', amount: weeks[3]),
    ];
  }

  List<CategoryExpense> _calculateCategoryExpenses(
    List<TransactionModel> monthTransactions,
    List<CategoryModel> categories,
    double totalExpenses,
  ) {
    final totalsByCategory = <String, double>{};

    for (final t in monthTransactions) {
      if (t.isIncome) continue;
      totalsByCategory[t.categoryId] =
          (totalsByCategory[t.categoryId] ?? 0) + t.amount;
    }

    final result = totalsByCategory.entries.map((entry) {
      final category = categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => CategoryModel(
          id: entry.key,
          name: 'Other',
          color: 0xFF8C96A8,
          iconId: 'other',
          isIncome: false,
        ),
      );

      final percentage =
          totalExpenses == 0 ? 0.0 : (entry.value / totalExpenses) * 100;

      return CategoryExpense(
        category: category,
        amount: entry.value,
        percentage: percentage,
      );
    }).toList();

    result.sort((a, b) => b.amount.compareTo(a.amount));
    return result;
  }

  List<TopExpenseItem> _calculateTopExpenses(
  List<TransactionModel> monthTransactions,
  List<CategoryModel> categories, {
  int limit = 4,
}) {
  final expenses = monthTransactions.where((t) => !t.isIncome).toList();

  expenses.sort((a, b) => b.amount.compareTo(a.amount));

  return expenses.take(limit).map((t) {
    final category = categories.firstWhere(
      (c) => c.id == t.categoryId,
      orElse: () => CategoryModel(
        id: t.categoryId,
        name: 'Other',
        color: 0xFF8C96A8,
        iconId: 'other',
        isIncome: false,
      ),
    );

    return TopExpenseItem(
      transaction: t,
      category: category,
    );
  }).toList();
}
}