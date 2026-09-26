import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surrah/features/report/presentation/pages/widgets/top_expenses_view.dart';
import '../../data/repo/report_repo.dart';
import '../../data/model/income_entry.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../transactions/data/model/transaction_model.dart';
import '../pages/widgets/expense_breakdown_view.dart';
import '../pages/widgets/expense_chart_view.dart';
import 'report_state.dart';

enum ReportPeriod { day, week, month, year }

class ReportCubit extends Cubit<ReportState> {
  ReportCubit({required this.reportRepo}) : super(ReportInitial()) {
    loadReport(DateTime.now(), ReportPeriod.month);
  }

  final ReportRepo reportRepo;

  Future<void> selectMonth(DateTime date) async {
    final currentPeriod = state is ReportMonthSelected
        ? (state as ReportMonthSelected).selectedPeriod
        : ReportPeriod.month;
    await loadReport(date, currentPeriod);
  }

  Future<void> selectPeriod(ReportPeriod period) async {
    final currentAnchor = state is ReportMonthSelected
        ? (state as ReportMonthSelected).selectedMonth
        : DateTime.now();
    await loadReport(currentAnchor, period);
  }

  Future<void> shiftPeriod({required bool forward}) async {
    if (state is! ReportMonthSelected) return;
    final current = state as ReportMonthSelected;
    final newAnchor = _shift(current.selectedPeriod, current.selectedMonth, forward: forward);
    await loadReport(newAnchor, current.selectedPeriod);
  }

  Future<void> refresh() async {
    final currentAnchor = state is ReportMonthSelected
        ? (state as ReportMonthSelected).selectedMonth
        : DateTime.now();
    final currentPeriod = state is ReportMonthSelected
        ? (state as ReportMonthSelected).selectedPeriod
        : ReportPeriod.month;
    await loadReport(currentAnchor, currentPeriod);
  }

  Future<void> loadReport(DateTime anchor, ReportPeriod period) async {
    final transactionsResult = await reportRepo.getTransactionsData();
    final categoriesResult = await reportRepo.getCategoriesData();

    transactionsResult.fold(
      (failure) => emit(ReportError(message: failure.message)),
      (data) {
        categoriesResult.fold(
          (failure) => emit(ReportError(message: failure.message)),
          (categories) => _emitReport(anchor, period, data.transactions, categories),
        );
      },
    );
  }

  // ---------------- Period logic (private, lives here only) ----------------

  DateTime _startOf(ReportPeriod period, DateTime anchor) {
    switch (period) {
      case ReportPeriod.day:
        return DateTime(anchor.year, anchor.month, anchor.day);
      case ReportPeriod.week:
        return DateTime(anchor.year, anchor.month, anchor.day)
            .subtract(Duration(days: anchor.weekday - 1));
      case ReportPeriod.month:
        return DateTime(anchor.year, anchor.month, 1);
      case ReportPeriod.year:
        return DateTime(anchor.year, 1, 1);
    }
  }

  DateTime _endOf(ReportPeriod period, DateTime anchor) {
    switch (period) {
      case ReportPeriod.day:
        return _startOf(period, anchor).add(const Duration(days: 1));
      case ReportPeriod.week:
        return _startOf(period, anchor).add(const Duration(days: 7));
      case ReportPeriod.month:
        return DateTime(anchor.year, anchor.month + 1, 1);
      case ReportPeriod.year:
        return DateTime(anchor.year + 1, 1, 1);
    }
  }

  DateTime _shift(ReportPeriod period, DateTime anchor, {required bool forward}) {
    final d = forward ? 1 : -1;
    switch (period) {
      case ReportPeriod.day:
        return anchor.add(Duration(days: d));
      case ReportPeriod.week:
        return anchor.add(Duration(days: 7 * d));
      case ReportPeriod.month:
        return DateTime(anchor.year, anchor.month + d, anchor.day);
      case ReportPeriod.year:
        return DateTime(anchor.year + d, anchor.month, anchor.day);
    }
  }

  List<TransactionModel> _filterByPeriod(
    List<TransactionModel> transactions,
    ReportPeriod period,
    DateTime anchor,
  ) {
    final start = _startOf(period, anchor);
    final end = _endOf(period, anchor);

    return transactions.where((t) {
      return t.createdAt.isAfter(start) && t.createdAt.isBefore(end);
    }).toList();
  }

  // ---------------- Report building ----------------

  void _emitReport(
    DateTime anchor,
    ReportPeriod period,
    List<TransactionModel> allTransactions,
    List<CategoryModel> categories,
  ) {
    final periodTransactions = _filterByPeriod(allTransactions, period, anchor);

    double salary = 0;
    double totalExpenses = 0;

    for (final t in periodTransactions) {
      if (t.isIncome) {
        salary += t.amount;
      } else {
        totalExpenses += t.amount;
      }
    }

    emit(ReportMonthSelected(
      selectedMonth: anchor,
      selectedPeriod: period,
      salary: salary,
      totalExpenses: totalExpenses,
      weeklyExpenses: _calculateWeeklyExpenses(periodTransactions),
      categoryExpenses: _calculateCategoryExpenses(
        periodTransactions,
        categories,
        totalExpenses,
      ),
      topExpenses: _calculateTopExpenses(periodTransactions, categories),
      monthTransactions: periodTransactions,
      categories: categories,
      incomeBreakdown: _calculateIncomeBreakdown(
        periodTransactions,
        categories,
        salary,
      ),
      incomeEntries: _calculateIncomeEntries(periodTransactions, categories),
    ));
  }

  List<WeeklyExpense> _calculateWeeklyExpenses(
    List<TransactionModel> periodTransactions,
  ) {
    final weeks = [0.0, 0.0, 0.0, 0.0];

    for (final t in periodTransactions) {
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
    List<TransactionModel> periodTransactions,
    List<CategoryModel> categories,
    double totalExpenses,
  ) {
    final totalsByCategory = <String, double>{};

    for (final t in periodTransactions) {
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
    List<TransactionModel> periodTransactions,
    List<CategoryModel> categories, {
    int limit = 4,
  }) {
    final expenses = periodTransactions.where((t) => !t.isIncome).toList();

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

  List<CategoryExpense> _calculateIncomeBreakdown(
    List<TransactionModel> periodTransactions,
    List<CategoryModel> categories,
    double totalIncome,
  ) {
    final totalsBySource = <String, double>{};

    for (final t in periodTransactions) {
      if (!t.isIncome) continue;
      totalsBySource[t.categoryId] =
          (totalsBySource[t.categoryId] ?? 0) + t.amount;
    }

    final result = totalsBySource.entries.map((entry) {
      final category = categories.firstWhere(
        (c) => c.id == entry.key,
        orElse: () => CategoryModel(
          id: entry.key,
          name: 'Other',
          color: 0xFF8C96A8,
          iconId: 'other',
          isIncome: true,
        ),
      );

      final percentage =
          totalIncome == 0 ? 0.0 : (entry.value / totalIncome) * 100;

      return CategoryExpense(
        category: category,
        amount: entry.value,
        percentage: percentage,
      );
    }).toList();

    result.sort((a, b) => b.amount.compareTo(a.amount));
    return result;
  }

  List<IncomeEntry> _calculateIncomeEntries(
    List<TransactionModel> periodTransactions,
    List<CategoryModel> categories,
  ) {
    final incomeTransactions =
        periodTransactions.where((t) => t.isIncome).toList();

    incomeTransactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return incomeTransactions.map((t) {
      final category = categories.firstWhere(
        (c) => c.id == t.categoryId,
        orElse: () => CategoryModel(
          id: t.categoryId,
          name: 'Other',
          color: 0xFF8C96A8,
          iconId: 'other',
          isIncome: true,
        ),
      );

      return IncomeEntry(transaction: t, category: category);
    }).toList();
  }
}