import '../widgets/report_body.dart';
import 'package:flutter/material.dart';
import '../../manager/report_cubit.dart';
import '../../manager/report_states.dart';
import '../../../../../generated/l10n.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/server_locator.dart';
import '../../../../../core/widgets/filter_body.dart';
import '../../../../../../core/widgets/custom_back.dart';
import 'package:surrah/core/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../transactions/data/model/balance_model.dart';
import '../../../../transactions/data/model/transaction_model.dart';

class ReportView extends StatelessWidget {
  final BalanceModel currentBalance;
  final List<TransactionModel> transactions;
  const ReportView({
    super.key,
    required this.currentBalance,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return BlocProvider.value(
      value: getIt<ReportCubit>()
        ..initReport(
          currentBalance: currentBalance,
          transactions: transactions,
        ),
      child: Scaffold(
        appBar: CustomAppBar(
          leading: CustomBack(),
          title: s.reportTitle,
          subtitle: s.reportSubtitle,
          trailingIcon: IconBroken.Filter_2,
          onTrailingPressed: () => showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            builder: (context) => const _Filter(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(12.w), child: ReportBody()),
        ),
      ),
    );
  }
}

class _Filter extends StatelessWidget {
  const _Filter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportStates>(
      builder: (context, state) {
        var cubit = ReportCubit.get(context);
        return FilterBody(
          showAllCategoriesType: true,
          isFiltering: cubit.isFiltering,
          applyFilter: () => cubit.filter(),
          clearFilter: () => cubit.clearFilter(),
          selectedType: cubit.selectedCategoryType,
          onTypeChanged: (type) => cubit.changeCategoryType(type),
        );
      },
    );
  }
}
