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
        return _Body(isLoading: state is GetTransactionsLoading);
      },
    );
  }
}

class _Body extends StatelessWidget {
  final bool isLoading;
  const _Body({required this.isLoading});

  @override
  Widget build(BuildContext context) {
    var cubit = TransactionsCubit.get(context);
    var transactions = cubit.isSearching
        ? cubit.searchResults
        : cubit.isFiltering
        ? cubit.filteredTransactions
        : cubit.transactions;
    return Transactions(isLoading: isLoading, transactions: transactions);
  }
}
