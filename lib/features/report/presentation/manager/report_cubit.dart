import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/report_repo.dart';
import '../../../transactions/data/model/transaction_model.dart';
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
    final result = await reportRepo.getTransactionsData();

    result.fold(
      (failure) {
        emit(ReportError(message: failure.message));
      },
      (data) {
        final monthTransactions = data.transactions.where((t) {
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

        final weeklyExpenses = _calculateWeeklyExpenses(monthTransactions);

        emit(ReportMonthSelected(
          selectedMonth: month,
          salary: salary,
          totalExpenses: totalExpenses,
          weeklyExpenses: weeklyExpenses,
        ));
      },
    );
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
}