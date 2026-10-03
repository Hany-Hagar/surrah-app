import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/extensions/transaction_extension.dart';
import '../../transactions/presentation/manager/transactions_cubit.dart';
import '../../transactions/presentation/pages/widgets/transactions.dart';
import '../../transactions/presentation/manager/transactions_states.dart';

class HomeLastTransactions extends StatelessWidget {
  const HomeLastTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: double.infinity, height: 8.h),
        CustomText(
          text: S.of(context).lastTransactions,
          size: 18.sp,
          type: Type.overMedium,
        ),
        SizedBox(width: double.infinity, height: 10.h),
        BlocBuilder<TransactionsCubit, TransactionsStates>(
          builder: (context, state) {
            var cubit = TransactionsCubit.get(context);
            return Transactions(
              padding: EdgeInsets.zero,
              isLoading: state is GetTransactionsLoading,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              transactions: cubit.transactions.getLastTransactions(),
            );
          },
        ),
      ],
    );
  }
}
