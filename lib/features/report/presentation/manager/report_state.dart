abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportMonthSelected extends ReportState {
  final DateTime selectedMonth;
  final double salary;
  final double totalExpenses;

  ReportMonthSelected({
    required this.selectedMonth,
    required this.salary,
    required this.totalExpenses,
  });

  double get remaining => salary - totalExpenses;
  double get expensePercentage => salary == 0 ? 0 : (totalExpenses / salary) * 100;
  double get savedPercentage => salary == 0 ? 0 : (remaining / salary) * 100;

  ReportState copyWith({
    DateTime? selectedMonth,
    double? salary,
    double? totalExpenses,
  }) {
    return ReportMonthSelected(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      salary: salary ?? this.salary,
      totalExpenses: totalExpenses ?? this.totalExpenses,
    );
  }
}

class ReportError extends ReportState {
  final String message;
  ReportError({required this.message});
}