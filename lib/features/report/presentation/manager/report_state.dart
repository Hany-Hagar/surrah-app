abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportMonthSelected extends ReportState {
  final DateTime selectedMonth;
  ReportMonthSelected({required this.selectedMonth});
  ReportState copyWith({DateTime? selectedMonth}) {
    return ReportMonthSelected(
      selectedMonth: selectedMonth ?? this.selectedMonth,
    );
  }

}