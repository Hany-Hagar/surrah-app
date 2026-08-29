import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/transactions_cubit.dart';
import '../../manager/transactions_states.dart';
import '../widgets/transactions_body.dart';
import '../../../../../core/widgets/custom_app_bar.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        bottomHeight: 60,
        bottom: const _Search(),
        title: s.transactionsTitle,
        subtitle: s.transactionsSubtitle,
      ),
      body: const TransactionsBody(),
    );
  }
}


class _Search extends StatelessWidget {
  const _Search();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsStates>(
      builder: (context, state) {
        var cubit = TransactionsCubit.get(context);
        return CustomTextFormField(
          prefixIcon: IconBroken.Search,
          controller: cubit.searchController,
          hintText: S.of(context).searchCategoriesHint,
          suffixIcon: cubit.isSearching ? Icons.clear : null,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          suffixTap: () => cubit.searchTransactions(context: context, query: null),
          onChanged: (value) => cubit.searchTransactions(context: context, query: value),
        );
      },
    );
  }
}