import 'package:surrah/features/report/presentation/pages/widgets/expense_chart_view.dart';
import 'package:surrah/features/report/presentation/pages/widgets/top_expenses_view.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../transactions/data/model/transaction_model.dart';
import '../pages/widgets/expense_breakdown_view.dart';
import '../../data/model/income_entry.dart';
import 'report_cubit.dart';

abstract class ReportStates {}

class ReportInitial extends ReportStates {}

// New state class

// Transaction states

class FetchTransactionsLoading extends ReportStates {}

class FetchTransactionsSuccess extends ReportStates {}

class FetchTransactionsFailure extends ReportStates {
  final String errorMessage;
  FetchTransactionsFailure({required this.errorMessage});
}

// Filter change state
class ChangeDateFilter extends ReportStates {}

// Old state class

class ReportMonthSelected extends ReportStates {
  final DateTime selectedMonth;
  final ReportPeriod selectedPeriod;
  final double salary;
  final double totalExpenses;
  final List<WeeklyExpense> weeklyExpenses;
  final List<CategoryExpense> categoryExpenses;
  final List<TopExpenseItem> topExpenses;
  final List<TransactionModel> monthTransactions;
  final List<TransactionModel> allTransactions; // ⬅️ جديد
  final List<CategoryModel> categories;
  final List<CategoryExpense> incomeBreakdown;
  final List<IncomeEntry> incomeEntries;

  ReportMonthSelected({
    required this.selectedMonth,
    required this.selectedPeriod,
    required this.salary,
    required this.totalExpenses,
    required this.weeklyExpenses,
    required this.categoryExpenses,
    required this.topExpenses,
    required this.monthTransactions,
    required this.allTransactions, // ⬅️ جديد
    required this.categories,
    this.incomeBreakdown = const [],
    this.incomeEntries = const [],
  });

  double get remaining => salary - totalExpenses;

  double get expensePercentage =>
      salary == 0 ? 0 : (totalExpenses / salary) * 100;

  double get savedPercentage => salary == 0 ? 0 : (remaining / salary) * 100;

  ReportStates copyWith({
    DateTime? selectedMonth,
    ReportPeriod? selectedPeriod,
    double? salary,
    double? totalExpenses,
    List<WeeklyExpense>? weeklyExpenses,
    List<CategoryExpense>? categoryExpenses,
    List<TopExpenseItem>? topExpenses,
    List<TransactionModel>? monthTransactions,
    List<TransactionModel>? allTransactions,
    List<CategoryModel>? categories,
    List<CategoryExpense>? incomeBreakdown,
    List<IncomeEntry>? incomeEntries,
  }) {
    return ReportMonthSelected(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      salary: salary ?? this.salary,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      weeklyExpenses: weeklyExpenses ?? this.weeklyExpenses,
      categoryExpenses: categoryExpenses ?? this.categoryExpenses,
      topExpenses: topExpenses ?? this.topExpenses,
      monthTransactions: monthTransactions ?? this.monthTransactions,
      allTransactions: allTransactions ?? this.allTransactions,
      categories: categories ?? this.categories,
      incomeBreakdown: incomeBreakdown ?? this.incomeBreakdown,
      incomeEntries: incomeEntries ?? this.incomeEntries,
    );
  }
}

class ReportError extends ReportStates {
  final String message;
  ReportError({required this.message});
}
