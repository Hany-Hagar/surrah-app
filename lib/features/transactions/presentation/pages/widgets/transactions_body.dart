import 'transactions.dart';
import 'package:flutter/material.dart';
import '../../../data/model/transaction_model.dart';

class TransactionsBody extends StatelessWidget {
  const TransactionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Transactions(isLoading: false, transactions: defaultTransactions);
  }
}
