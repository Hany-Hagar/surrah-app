import 'package:flutter_bloc/flutter_bloc.dart';

import '../../transactions/presentation/manager/transactions_cubit.dart';
import '../../transactions/presentation/manager/transactions_states.dart';
import 'home_balance_card.dart';
import 'home_quick_actions.dart';
import 'home_daily_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.w,
      children: [
        _Balance(),
        HomeQuickActions(),
        HomeDailyTransactions(),
      ],
    );
  }
}

class _Balance extends StatelessWidget {
  const _Balance();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsStates>(
      builder: (context, state) {
        final cubit = TransactionsCubit.get(context);
        return HomeBalanceCard(currentBalance: cubit.currentBalance);
      },
    );
  }
}
