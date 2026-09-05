import 'report_analysis_chart.dart';
import 'package:flutter/material.dart';
import '../../../models/report_model.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../transactions/data/model/transaction_model.dart';
import '../../../../transactions/presentation/pages/widgets/transactions.dart';

class ReportOverviewBody extends StatelessWidget {
  final ReportModel data;
  const ReportOverviewBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        spacing: 12.h,
        children: [
          ReportAnalysisCard(
            totalValue: data.balance.totalIncome,
            transactions: data.incomeTransactions,
          ),
          _List(title: s.income, transactions: data.incomeTransactions),
          _List(title: s.expense, transactions: data.expenseTransactions),
        ],
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
      spacing: 7.h,
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
