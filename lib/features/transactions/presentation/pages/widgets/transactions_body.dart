import 'transactions.dart';
import 'package:flutter/material.dart';
import '../../manager/transactions_cubit.dart';
import '../../manager/transactions_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TransactionsBody extends StatelessWidget {
  const TransactionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsStates>(
      builder: (context, state) {
        var cubit = TransactionsCubit.get(context);
        var transactions = cubit.isSearching
            ? cubit.searchResults
            : cubit.transactions;
        return Transactions(
          isLoading: state is GetTransactionsLoading,
          transactions: transactions,
        );
      },
    );
  }
}
