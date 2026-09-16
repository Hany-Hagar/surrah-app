import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/report_repo.dart';
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
  final result = await reportRepo.getTransactionsData();

  result.fold(
    (failure) {
      emit(ReportError(message: failure.message)); 
    },
    (data) {
      final monthTransactions = data.transactions.where((t) {
        return t.createdAt.year == month.year && t.createdAt.month == month.month;
      });

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
      ));
    },
  );
}
}