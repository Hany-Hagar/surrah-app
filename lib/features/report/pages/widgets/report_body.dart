import 'report_analysis_card.dart';
import 'package:flutter/material.dart';
import '../../../../core/di/server_locator.dart';
import '../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../transactions/data/model/balance_model.dart';
import '../../../../core/extensions/transaction_extension.dart';
import '../../../transactions/data/model/transaction_model.dart';
import '../../../transactions/presentation/pages/widgets/transactions.dart';
import '../../../transactions/presentation/manager/transactions_cubit.dart';

class ReportBody extends StatelessWidget {
  const ReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = getIt<TransactionsCubit>();
    var transactions = cubit.transactions;
    var currentBalance = cubit.currentBalance;
    return Column(
      spacing: 12.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Card(currentBalance: currentBalance, transactions: transactions),
        _List(title: "Income", transactions: transactions.incomes),
        _List(title: "Expense", transactions: transactions.expense),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final BalanceModel currentBalance;
  final List<TransactionModel> transactions;
  const _Card({required this.currentBalance, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 200.h,
        child: ReportAnalysisCard(
          transactions: transactions,
          totalValue: currentBalance.totalIncome + currentBalance.totalExpense,
        ),
      ),
    );
  }
}

class _List extends StatelessWidget {
  final String title;
  final List<TransactionModel> transactions;
  const _List({required this.title, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, size: 18.sp, type: Type.header),
        Transactions(
          isLoading: false,
          padding: EdgeInsets.zero,
          transactions: transactions,
          scrollPhysics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}
