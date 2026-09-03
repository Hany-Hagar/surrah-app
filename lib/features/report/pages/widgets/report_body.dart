import 'package:flutter/material.dart';
import '../../../../core/di/server_locator.dart';
import '../../../../core/extensions/transaction_extension.dart';
import '../../../../core/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../transactions/data/model/transaction_model.dart';
import '../../../transactions/presentation/manager/transactions_cubit.dart';
import '../../../transactions/presentation/pages/widgets/transactions.dart';

class ReportBody extends StatelessWidget {
  const ReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    var transactions = getIt<TransactionsCubit>().transactions;
    return Column(
      spacing: 12.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _List(
          title: "Income",
          transactions: transactions.incomeTransactions,
        ),
        _List(
          title: "Expense",
          transactions: transactions.expenseTransactions,
        ),
      ],
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
      spacing: 8.h,
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
