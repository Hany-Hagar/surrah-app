import 'package:flutter/material.dart';
import '../widgets/transactions_body.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../manager/transactions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../manager/transactions_states.dart';
import '../../../../../core/widgets/filter_body.dart';
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
        bottomHeight: 60,
        bottom: const _Search(),
        title: s.transactionsTitle,
        trailingIcon: IconBroken.Filter,
        subtitle: s.transactionsSubtitle,
        onTrailingPressed: () => showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
          ),
          builder: (context) => const _Filter(),
        ),
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
          suffixTap: () => cubit.searchTransactions(query: null),
          onChanged: (value) => cubit.searchTransactions(query: value),
        );
      },
    );
  }
}

class _Filter extends StatelessWidget {
  const _Filter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsStates>(
      builder: (context, state) {
        var cubit = TransactionsCubit.get(context);
        return FilterBody(
          showAllCategoriesType: true,
          isFiltering: cubit.isFiltering,
          selectedType: cubit.selectedType,
          clearFilter: () => cubit.clearFilter(),
          applyFilter: () => cubit.filterCategories(),
          onTypeChanged: (value) => cubit.changeSelectedType(value),
        );
      },
    );
  }
}
