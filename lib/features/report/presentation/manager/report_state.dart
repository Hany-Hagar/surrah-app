import 'package:surrah/features/report/presentation/pages/widgets/expense_chart_view.dart';
import 'package:surrah/features/report/presentation/pages/widgets/top_expenses_view.dart';

import '../pages/widgets/expense_breakdown_view.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportMonthSelected extends ReportState {
  final DateTime selectedMonth;
  final double salary;
  final double totalExpenses;
  final List<WeeklyExpense> weeklyExpenses;
  final List<CategoryExpense> categoryExpenses;
  final List<TopExpenseItem> topExpenses;



  ReportMonthSelected({
    required this.selectedMonth,
    required this.salary,
    required this.totalExpenses,
    required this.weeklyExpenses,
    required this.categoryExpenses,
     required this.topExpenses,

  });

  double get remaining => salary - totalExpenses;

  double get expensePercentage =>
      salary == 0 ? 0 : (totalExpenses / salary) * 100;

  double get savedPercentage => salary == 0 ? 0 : (remaining / salary) * 100;
  ReportState copyWith({
    DateTime? selectedMonth,
    double? salary,
    double? totalExpenses,
    List<WeeklyExpense>? weeklyExpenses,
    List<CategoryExpense>? categoryExpenses,
    List<TopExpenseItem>? topExpenses,
  }) {
    return ReportMonthSelected(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      salary: salary ?? this.salary,
      totalExpenses: totalExpenses ?? this.totalExpenses,
      weeklyExpenses: weeklyExpenses ?? this.weeklyExpenses,
      categoryExpenses: categoryExpenses ?? this.categoryExpenses,
      topExpenses: topExpenses ?? this.topExpenses,
    );
  }
}

class ReportError extends ReportState {
  final String message;
  ReportError({required this.message});
}