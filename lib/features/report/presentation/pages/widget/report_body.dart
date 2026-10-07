import 'package:flutter/material.dart';
import '../../manager/report_cubit.dart';
import '../../manager/report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../transactions/presentation/pages/widgets/transactions.dart';

class ReportBody extends StatelessWidget {
  const ReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportStates>(
      builder: (context, state) {
        var cubit = ReportCubit.get(context);
        return Transactions(
          
          isLoading: state is FetchTransactionsLoading,
          transactions: cubit.isFiltered
              ? cubit.filteredTransactions
              : cubit.transactions,
        );
      },
    );
  }
}
