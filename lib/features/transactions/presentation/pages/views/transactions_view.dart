import 'package:flutter/material.dart';
import '../widgets/transactions_body.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../manager/transactions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/transactions_states.dart';
import '../widgets/transaction_filter_body.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        bottom: const _Search(),
        title: s.transactionsTitle,
        subtitle: s.transactionsSubtitle,
        trailingIcon: IconBroken.Filter_2,
        onTrailingPressed: () {
          TransactionsCubit.get(context).initFilter();
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            builder: (context) => const TransactionFilterBody(),
          );
        },
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
          hintText: S.of(context).searchTransactionsHint,
          suffixIcon: cubit.isSearching ? Icons.clear : null,
          suffixTap: () => cubit.searchTransactions(query: null),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onChanged: (value) => cubit.searchTransactions(query: value),
        );
      },
    );
  }
}
