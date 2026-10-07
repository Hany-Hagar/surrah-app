import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:surrah/core/extensions/transaction_extension.dart';
import 'package:surrah/features/report/presentation/pages/widgets/top_expenses_view.dart';
import '../../../../core/enums/category_type.dart';
import '../../../../core/enums/date_filter_type.dart';
import '../../data/repo/report_repo.dart';
import '../../data/model/income_entry.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../transactions/data/model/transaction_model.dart';
import '../pages/widgets/expense_breakdown_view.dart';
import '../pages/widgets/expense_chart_view.dart';
import 'report_state.dart';

class ReportCubit extends Cubit<ReportStates> {
  final ReportRepo reportRepo;
  ReportCubit({required this.reportRepo}) : super(ReportInitial()) {
    loadReport(DateTime.now(), ReportPeriod.month);
  }
  static ReportCubit get(BuildContext context) => BlocProvider.of(context);

  // New
  bool isFiltered = false;
  List<TransactionModel> transactions = [];
  List<TransactionModel> filteredTransactions = [];
  DateFilterType dateFilter = DateFilterType.day;

  void getTransactions() async {
    emit(FetchTransactionsLoading());
    final transactionsResult = await reportRepo.getTransactionsData();
    transactionsResult.fold(
      (failure) =>
          emit(FetchTransactionsFailure(errorMessage: failure.message)),
      (data) {
        transactions = data.transactions;
        emit(FetchTransactionsSuccess());
      },
    );
  }

  void changeDateFilter(DateFilterType filter) {
    isFiltered = true;
    dateFilter = filter;
    filteredTransactions.clear();
    filteredTransactions.addAll(
      transactions.filter(type: CategoriesType.all, dateFilterType: filter),
    );
    emit(ChangeDateFilter());
  }

  // Old
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
    final newAnchor = current.selectedMonth.shiftPeriod(
      current.selectedPeriod,
      forward: forward,
    );
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
          (categories) =>
              _emitReport(anchor, period, data.transactions, categories),
        );
      },
    );
  }

  List<TransactionModel> _filterByPeriod(
    List<TransactionModel> transactions,
    ReportPeriod period,
    DateTime anchor,
  ) {
    return transactions
        .where((t) => t.createdAt.isWithinPeriod(period, anchor))
        .toList();
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

    emit(
      ReportMonthSelected(
        selectedMonth: anchor,
        selectedPeriod: period,
        salary: salary,
        totalExpenses: totalExpenses,
        weeklyExpenses: _calculateTrend(allTransactions, anchor, period),
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
        allTransactions: [],
      ),
    );
  }

  List<WeeklyExpense> _calculateTrend(
    List<TransactionModel> allTransactions,
    DateTime anchor,
    ReportPeriod period,
  ) {
    final expenses = allTransactions.where((t) => !t.isIncome).toList();

    double sumBetween(DateTime start, DateTime end) {
      var total = 0.0;
      for (final t in expenses) {
        if (!t.createdAt.isBefore(start) && t.createdAt.isBefore(end)) {
          total += t.amount;
        }
      }
      return total;
    }

    switch (period) {
      case ReportPeriod.day:
        final weekStart = anchor.startOfPeriod(ReportPeriod.week);
        return List.generate(7, (i) {
          final start = DateTime(
            weekStart.year,
            weekStart.month,
            weekStart.day + i,
          );
          final end = DateTime(start.year, start.month, start.day + 1);
          return WeeklyExpense(
            label: DateFormat('E').format(start),
            subLabel: '${start.day}',
            amount: sumBetween(start, end),
          );
        });

      case ReportPeriod.week:
        final lastDay = DateTime(anchor.year, anchor.month + 1, 0).day;
        return List.generate(4, (i) {
          final startDay = 1 + i * 7;
          final start = DateTime(anchor.year, anchor.month, startDay);
          final end = i == 3
              ? DateTime(anchor.year, anchor.month + 1, 1)
              : DateTime(anchor.year, anchor.month, startDay + 7);
          final endDay = i == 3 ? lastDay : startDay + 6;
          return WeeklyExpense(
            label: 'W${i + 1}',
            subLabel: '$startDay-$endDay',
            amount: sumBetween(start, end),
          );
        });

      case ReportPeriod.month:
        return List.generate(12, (i) {
          final start = DateTime(anchor.year, i + 1, 1);
          final end = DateTime(anchor.year, i + 2, 1);
          return WeeklyExpense(
            label: DateFormat('MMM').format(start),
            amount: sumBetween(start, end),
          );
        });

      case ReportPeriod.year:
        return List.generate(5, (i) {
          final year = anchor.year - 4 + i;
          return WeeklyExpense(
            label: '$year',
            amount: sumBetween(DateTime(year, 1, 1), DateTime(year + 1, 1, 1)),
          );
        });
    }
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

      final percentage = totalExpenses == 0
          ? 0.0
          : (entry.value / totalExpenses) * 100;

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

      return TopExpenseItem(transaction: t, category: category);
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

      final percentage = totalIncome == 0
          ? 0.0
          : (entry.value / totalIncome) * 100;

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
    final incomeTransactions = periodTransactions
        .where((t) => t.isIncome)
        .toList();

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

enum ReportPeriod { day, week, month, year }

// ---------------- Period logic (extension on DateTime, lives here only) ----------------

extension DateFilterExtension on DateTime {
  DateTime startOfPeriod(ReportPeriod period) {
    switch (period) {
      case ReportPeriod.day:
        return DateTime(year, month, day);
      case ReportPeriod.week:
        return DateTime(year, month, day - (weekday - 1));
      case ReportPeriod.month:
        return DateTime(year, month, 1);
      case ReportPeriod.year:
        return DateTime(year, 1, 1);
    }
  }

  DateTime endOfPeriod(ReportPeriod period) {
    final start = startOfPeriod(period);
    switch (period) {
      case ReportPeriod.day:
        return DateTime(start.year, start.month, start.day + 1);
      case ReportPeriod.week:
        return DateTime(start.year, start.month, start.day + 7);
      case ReportPeriod.month:
        return DateTime(year, month + 1, 1);
      case ReportPeriod.year:
        return DateTime(year + 1, 1, 1);
    }
  }

  DateTime shiftPeriod(ReportPeriod period, {required bool forward}) {
    final d = forward ? 1 : -1;
    switch (period) {
      case ReportPeriod.day:
        return DateTime(year, month, day + d);
      case ReportPeriod.week:
        return DateTime(year, month, day + 7 * d);
      case ReportPeriod.month:
        final lastDay = DateTime(year, month + d + 1, 0).day;
        return DateTime(year, month + d, math.min(day, lastDay));
      case ReportPeriod.year:
        final lastDay = DateTime(year + d, month + 1, 0).day;
        return DateTime(year + d, month, math.min(day, lastDay));
    }
  }

  bool isWithinPeriod(ReportPeriod period, DateTime anchor) {
    final start = anchor.startOfPeriod(period);
    final end = anchor.endOfPeriod(period);
    return !isBefore(start) && isBefore(end);
  }
}
