import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/transactions_body.dart';
import '../../../../../core/widgets/custom_app_bar.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: s.transactionsTitle,
        subtitle: s.transactionsSubtitle,
      ),
      body: const TransactionsBody(),
    );
  }
}

